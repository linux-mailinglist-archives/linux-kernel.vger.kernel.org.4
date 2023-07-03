Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD47C745812
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 11:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjGCJHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 05:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjGCJHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:07:31 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E45718D
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 02:07:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VmWwOlU_1688375245;
Received: from 30.0.148.65(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VmWwOlU_1688375245)
          by smtp.aliyun-inc.com;
          Mon, 03 Jul 2023 17:07:26 +0800
Message-ID: <5df1b66b-622e-657e-f024-ce8d1a7e2476@linux.alibaba.com>
Date:   Mon, 3 Jul 2023 17:07:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [RFC 0/2] erofs: introduce bloom filter for xattr
Content-Language: en-US
To:     Alexander Larsson <alexl@redhat.com>
Cc:     hsiangkao@linux.alibaba.com, chao@kernel.org, huyue2@coolpad.com,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230621083209.116024-1-jefflexu@linux.alibaba.com>
 <c316bc55-cc4d-f05a-8936-2cde217b8dd2@linux.alibaba.com>
 <CAL7ro1FjnO52tawLeu-wNtk+upN1ShxeFYE1AiFUh1JN2oo0hA@mail.gmail.com>
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <CAL7ro1FjnO52tawLeu-wNtk+upN1ShxeFYE1AiFUh1JN2oo0hA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/3/23 3:25 PM, Alexander Larsson wrote:
> On Wed, Jun 28, 2023 at 5:38 AM Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>
>> Hi all,
>>
>> Sorry for the late reply as I was on vacation these days.
>>
>> I test the hash bit for all xattrs given by Alex[1], to see if each
>> xattr could be mapped into one unique bit in the 32-bit bloom filter.
>>
>> [1]
>> https://lore.kernel.org/all/CAL7ro1HhYUDrOX7A-13p7rLBZSWHTQWGOdOzVcYkddkU_LArUw@mail.gmail.com/
>>
>>
>> On 6/21/23 4:32 PM, Jingbo Xu wrote:
>>>
>>> 3.2. input of hash function
>>> -------------------------
>>> As previously described, each hash function will map the given data into
>>> one bit of the bloom filter map.  In our use case, xattr name serves as
>>> the key of hash function.
>>>
>>> When .getxattr() gets called, only index (e.g. EROFS_XATTR_INDEX_USER)
>>> and the remaining name apart from the prefix are handy.  To avoid
>>> constructing the full xattr name, the above index and name are fed into
>>> the hash function directly in the following way:
>>>
>>> ```
>>> bit = xxh32(name, strlen(name), index + i);
>>> ```
>>>
>>> where index serves as part of seed, so that it gets involved in the
>>> calculation for the hash.
>>
>>
>> All xattrs are hashed with one single hash function.
>>
>> I first tested with the following hash function:
>>
>> ```
>> xxh32(name, strlen(name), index)
>> ```
>>
>> where `index` represents the index of corresponding predefined name
>> prefix (e.g. EROFS_XATTR_INDEX_USER), while `name` represents the name
>> after stripping the above predefined name prefix (e.g.
>> "overlay.metacopy" for "user.overlay.metacopy")
>>
>>
>> The mapping results are:
>>
>> bit  0: security.SMACK64EXEC
>> bit  1:
>> bit  2: user.overlay.protattr
>> bit  3: trusted.overlay.impure, user.overlay.opaque, user.mime_type
>> bit  4:
>> bit  5: user.overlay.origin
>> bit  6: user.overlay.metacopy, security.evm
>> bit  8: trusted.overlay.opaque
>> bit  9: trusted.overlay.origin
>> bit 10: trusted.overlay.upper, trusted.overlay.protattr
>> bit 11: security.apparmor, security.capability
>> bit 12: security.SMACK64
>> bit 13: user.overlay.redirect, security.ima
>> bit 14: user.overlay.upper
>> bit 15: trusted.overlay.redirect
>> bit 16: security.SMACK64IPOUT
>> bit 17:
>> bit 18: system.posix_acl_access
>> bit 19: security.selinux
>> bit 20:
>> bit 21:
>> bit 22: system.posix_acl_default
>> bit 23: security.SMACK64MMAP
>> bit 24: user.overlay.impure, user.overlay.nlink, security.SMACK64TRANSMUTE
>> bit 25: trusted.overlay.metacopy
>> bit 26:
>> bit 27: security.SMACK64IPIN
>> bit 28:
>> bit 29:
>> bit 30: trusted.overlay.nlink
>> bit 31:
>>
>> Here 30 xattrs are mapped into 22 bits.  There are two potential
>> conflicts, i.e. bit 10 (trusted.overlay.upper, trusted.overlay.protattr)
>> and bit 24 (user.overlay.impure, user.overlay.nlink).
> 
> Bit 11 (apparmor and capabilities) seems like the most likely thing to
> run into. I.e. on an apparmor-using system, many files would have
> apparmor xattr set, so looking up security.capabilities on it would
> cause a false negative and we'd unnecessarily read the xattrs.
> 
>>> An alternative way is to calculate the hash from the full xattr name by
>>> feeding the prefix string and the remaining name string separately in
>>> the following way:
>>>
>>> ```
>>> xxh32_reset()
>>> xxh32_update(prefix string, ...)
>>> xxh32_update(remaining name, ...)
>>> xxh32_digest()
>>> ```
>>>
>>> But I doubt if it really deserves to call multiple APIs instead of one
>>> single xxh32().
>>
>>
>> I also tested with the following hash function, where the full name of
>> the xattr, e.g. "user.overlay.metacopy", is fed into the hash function.
>>
>> ```
>> xxh32(name, strlen(name), 0)
>> ```
>>
>>
>> Following are the mapping results:
>>
>> bit  0: trusted.overlay.impure, user.overlay.protattr
>> bit  1: security.SMACK64IPOUT
>> bit  2:
>> bit  3: security.capability
>> bit  4: security.selinux
>> bit  5: security.ima
>> bit  6: user.overlay.metacopy
>> bit  8:
>> bit  9: trusted.overlay.redirect, security.SMACK64EXEC
>> bit 10: system.posix_acl_access
>> bit 11: trusted.overlay.nlink
>> bit 12: trusted.overlay.opaque
>> bit 13:
>> bit 14:
>> bit 15:
>> bit 16:
>> bit 17: user.overlay.impure
>> bit 18: security.apparmor
>> bit 19:
>> bit 20: user.overlay.origin, user.overlay.nlink, security.SMACK64TRANSMUTE
>> bit 21:
>> bit 22: trusted.overlay.metacopy, trusted.overlay.protattr
>> bit 23: user.overlay.upper, security.evm
>> bit 24: user.overlay.redirect, security.SMACK64IPIN,
>> system.posix_acl_default
>> bit 25: security.SMACK64
>> bit 26:
>> bit 27: trusted.overlay.upper, security.SMACK64MMAP
>> bit 28: trusted.overlay.origin, user.mime_type
>> bit 29:
>> bit 30:
>> bit 31: user.overlay.opaque
>>
>> 30 xattrs are mapped into 20 bits.  Similarly there are two potential
>> conflicts, i.e. bit 20 (user.overlay.origin, user.overlay.nlink) and bit
>> 22 (trusted.overlay.metacopy, trusted.overlay.protattr).
>>
>>
>> Summary
>> =======
>>
>> Personally I would prefer the former, as it maps xattrs into the bloom
>> filter more evenly (22 bits vs 20 bits) and can better cooperate with
>> the kernel routine (index and the remaining name string, rather than the
>> full name string, are handy).
> 
> I agree that we want the approach with better cooperation with the
> kernel function. However, I would much prefer if all the xattrs that
> are commonly set on many files are unconflicted. This would be at
> least: selinux, ima, evm, apparmor.
> 
> Can't you just add a magic constant to the seed? Then we can come up
> with one that gives a good spread and hardcode that.

Brilliant idea!  I would try to see if it works.

-- 
Thanks,
Jingbo
