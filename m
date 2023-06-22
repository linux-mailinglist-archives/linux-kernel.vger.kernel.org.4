Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE42673977F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 08:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjFVGhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 02:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjFVGhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 02:37:08 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2860D132
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 23:37:05 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VliIWD4_1687415818;
Received: from 192.168.31.58(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VliIWD4_1687415818)
          by smtp.aliyun-inc.com;
          Thu, 22 Jun 2023 14:37:00 +0800
Message-ID: <3730215c-d59d-8b8e-fe36-7754f7782d15@linux.alibaba.com>
Date:   Thu, 22 Jun 2023 14:36:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [RFC 0/2] erofs: introduce bloom filter for xattr
To:     Alexander Larsson <alexl@redhat.com>
Cc:     hsiangkao@linux.alibaba.com, chao@kernel.org, huyue2@coolpad.com,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230621083209.116024-1-jefflexu@linux.alibaba.com>
 <CAL7ro1EmCcienVMY7Pi_mEFbUiLZq24EGOyFovexmpJMGbfjcA@mail.gmail.com>
Content-Language: en-US
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <CAL7ro1EmCcienVMY7Pi_mEFbUiLZq24EGOyFovexmpJMGbfjcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/21/23 7:50 PM, Alexander Larsson wrote:
> On Wed, Jun 21, 2023 at 10:32 AM Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>
>> Background
>> ==========
>> Filesystems with ACL enabled generally need to read
>> "system.posix_acl_access"/"system.posix_acl_default" xattr to get the
>> access and default ACL.  When filesystem is mounted with ACL enabled
>> while files in the system have not set access/default ACL, the getattr()
>> will run in vain while the round trip can decrease the performance in
>> workload like "ls -lR".
>>
>> For example, there's a 12% performance boost if erofs is mounted with
>> "noacl" when running "ls -lR" workload on dataset [1] (given in [2]).
>>
>> We'd better offer a fastpath to boost the above workload, as well as
>> other negative xattr lookup.
>>
>>
>> Proposal
>> ========
>> Introduce a per-inode bloom filter for xattrs to boost the negative
>> xattr queries.
>>
>> As following shows, a 32-bit bloom filter is introduced for each inode,
>> describing if a xattr with specific name exists on this inode.
>>
>> ```
>>  struct erofs_xattr_ibody_header {
>> -       __le32 h_reserved;
>> +       __le32 h_map; /* bloom filter */
>>         ...
>> }
>> ```
>>
>> Following are some implementation details for bloom filter.
>>
>> 1. Reverse bit value
>> --------------------
>> The bloom filter structure describes if a given data is inside the set.
>> It will map the given data into several bits of the bloom filter map.
>> The data must not exist inside the set if any mapped bit is 0, while the
>> data may be not inside the set even if all mapped bits is 1.
>>
>> While in our use case, as erofs_xattr_ibody_header.h_map is previously a
>> (all zero) reserved field, the bit value for the bloom filter has a
>> reverse semantics in consideration for compatibility.  That is, for a
>> given data, the mapped bits will be cleared to 0.  Thus for a previously
>> built image without support for bloom filter, the bloom filter is all
>> zero and when it's mounted by the new kernel with support for bloom
>> filter, it can not determine if the queried xattr exists on the inode and
>> thus will fallback to the original routine of iterating all on-disk
>> xattrs to determine if the queried xattr exists.
>>
>>
>> 2. The number of hash functions
>> -------------------------------
>> The optimal value for the number of the hash functions (k) is (ln2 *
>> m/n), where m stands the number of bits of the bloom filter map, while n
>> stands the number of all candidates may be inside the set.
>>
>> In our use case, the number of common used xattr (n) is approximately 8,
>> including system.[posix_acl_access|posix_acl_default],
>> security.[capability|selinux] and
>> security.[SMACK64|SMACK64TRANSMUTE|SMACK64EXEC|SMACK64MMAP].
>>
>> Given the number of bits of the bloom filter (m) is 32, the optimal value
>> for the number of the hash functions (k) is 2 (ln2 * m/n = 2.7).
> 
> This is indeed the optimal value in a traditional use of bloom
> filters. However, I think it is based on a much larger set of values.
> For this usecase it may be better to choose a different value.
> 
> I did some research a while ago on this, and I thought about the
> counts too. Having more than one hash function is useful because it
> allows you to avoid problems if two values happen to hash to the same
> bucket, but this happens at the cost of there being less "unique
> buckets".  I spent some time looking for common xattr values
> (including some from userspace) and ended up with a list of about 30.

Yeah, if the number of common used xattr (n) is 30, then the optimal
value for the number of the hash functions (k) is 1 (ln2 * m/n = 0.74).
The optimal value in theory also matches our intuition.


> If we can choose a single hash function that maps all (or most) of
> these to a unique bucket (mod 32),

Excellent research!  Would you mind sharing the list of these
approximately 30 commonly used xattrs, so that I could check if they are
mapped to unique bucket with the single hash function we proposed?


-- 
Thanks,
Jingbo
