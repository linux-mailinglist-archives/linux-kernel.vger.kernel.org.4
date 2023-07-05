Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6134D747E95
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 09:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbjGEHvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 03:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjGEHvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 03:51:37 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3367EE6B
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 00:51:34 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vmfr.S0_1688543490;
Received: from 30.97.48.243(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vmfr.S0_1688543490)
          by smtp.aliyun-inc.com;
          Wed, 05 Jul 2023 15:51:31 +0800
Message-ID: <22894dd5-a74c-a459-ea45-63bae7b5a295@linux.alibaba.com>
Date:   Wed, 5 Jul 2023 15:51:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/2] erofs: update on-disk format for xattr name filter
To:     Alexander Larsson <alexl@redhat.com>
Cc:     Jingbo Xu <jefflexu@linux.alibaba.com>, chao@kernel.org,
        huyue2@coolpad.com, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20230705070427.92579-1-jefflexu@linux.alibaba.com>
 <20230705070427.92579-2-jefflexu@linux.alibaba.com>
 <2eda59f2-a302-04a5-08de-c4ab7cf2e744@linux.alibaba.com>
 <CAL7ro1GayuYup4V0arhEWZDztFN1Gxx5jwdL3uFaGfQZ4hw41g@mail.gmail.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAL7ro1GayuYup4V0arhEWZDztFN1Gxx5jwdL3uFaGfQZ4hw41g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 2023/7/5 15:43, Alexander Larsson wrote:
> On Wed, Jul 5, 2023 at 9:25 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
>>
>>
>> On 2023/7/5 15:04, Jingbo Xu wrote:
>>> The xattr name bloom filter feature is going to be introduced to speed
>>> up the negative xattr lookup, e.g. system.posix_acl_[access|default]
>>> lookup when running "ls -lR" workload.
>>>
>>> The number of common used extended attributes (n) is approximately 30.
>>
>> There are some commonly used extended attributes (n) and the total number
>> of these is 31:
>>
>>>
>>>        trusted.overlay.opaque
>>>        trusted.overlay.redirect
>>>        trusted.overlay.origin
>>>        trusted.overlay.impure
>>>        trusted.overlay.nlink
>>>        trusted.overlay.upper
>>>        trusted.overlay.metacopy
>>>        trusted.overlay.protattr
>>>        user.overlay.opaque
>>>        user.overlay.redirect
>>>        user.overlay.origin
>>>        user.overlay.impure
>>>        user.overlay.nlink
>>>        user.overlay.upper
>>>        user.overlay.metacopy
>>>        user.overlay.protattr
>>>        security.evm
>>>        security.ima
>>>        security.selinux
>>>        security.SMACK64
>>>        security.SMACK64IPIN
>>>        security.SMACK64IPOUT
>>>        security.SMACK64EXEC
>>>        security.SMACK64TRANSMUTE
>>>        security.SMACK64MMAP
>>>        security.apparmor
>>>        security.capability
>>>        system.posix_acl_access
>>>        system.posix_acl_default
>>>        user.mime_type
>>>
>>> Given the number of bits of the bloom filter (m) is 32, the optimal
>>> value for the number of the hash functions (k) is 1 (ln2 * m/n = 0.74).
>>>
>>> The single hash function is implemented as:
>>>
>>>        xxh32(name, strlen(name), EROFS_XATTR_FILTER_SEED + index)
>>>
>>> where index represents the index of corresponding predefined short name
>>
>> where `index`...
>>
>>
>>
>>> prefix, while name represents the name string after stripping the above
>>> predefined name prefix.
>>>
>>> The constant magic number EROFS_XATTR_FILTER_SEED, i.e. 0x25BBE08F, is
>>> used to give a better spread when mapping these 30 extended attributes
>>> into 32-bit bloom filter as:
>>>
>>>        bit  0: security.ima
>>>        bit  1:
>>>        bit  2: trusted.overlay.nlink
>>>        bit  3:
>>>        bit  4: user.overlay.nlink
>>>        bit  5: trusted.overlay.upper
>>>        bit  6: user.overlay.origin
>>>        bit  7: trusted.overlay.protattr
>>>        bit  8: security.apparmor
>>>        bit  9: user.overlay.protattr
>>>        bit 10: user.overlay.opaque
>>>        bit 11: security.selinux
>>>        bit 12: security.SMACK64TRANSMUTE
>>>        bit 13: security.SMACK64
>>>        bit 14: security.SMACK64MMAP
>>>        bit 15: user.overlay.impure
>>>        bit 16: security.SMACK64IPIN
>>>        bit 17: trusted.overlay.redirect
>>>        bit 18: trusted.overlay.origin
>>>        bit 19: security.SMACK64IPOUT
>>>        bit 20: trusted.overlay.opaque
>>>        bit 21: system.posix_acl_default
>>>        bit 22:
>>>        bit 23: user.mime_type
>>>        bit 24: trusted.overlay.impure
>>>        bit 25: security.SMACK64EXEC
>>>        bit 26: user.overlay.redirect
>>>        bit 27: user.overlay.upper
>>>        bit 28: security.evm
>>>        bit 29: security.capability
>>>        bit 30: system.posix_acl_access
>>>        bit 31: trusted.overlay.metacopy, user.overlay.metacopy
>>>
>>> The h_name_filter field is introduced to the on-disk per-inode xattr
>>> header to place the corresponding xattr name filter, where bit value 1
>>> indicates non-existence for compatibility.
>>>
>>> This feature is indicated by EROFS_FEATURE_COMPAT_XATTR_FILTER
>>> compatible feature bit.
>>>
>>> Suggested-by: Alexander Larsson <alexl@redhat.com>
>>> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
>>> ---
>>>    fs/erofs/erofs_fs.h | 8 +++++++-
>>>    1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
>>> index 2c7b16e340fe..b4b6235fd720 100644
>>> --- a/fs/erofs/erofs_fs.h
>>> +++ b/fs/erofs/erofs_fs.h
>>> @@ -13,6 +13,7 @@
>>>
>>>    #define EROFS_FEATURE_COMPAT_SB_CHKSUM          0x00000001
>>>    #define EROFS_FEATURE_COMPAT_MTIME              0x00000002
>>> +#define EROFS_FEATURE_COMPAT_XATTR_FILTER    0x00000004
>>
>> I'd suggest that if we could leave one reserved byte in the
>> superblock for now (and checking if it's 0) since
>>     1) xattr filter feature is a compatible feature;
>>     2) I'm not sure if the implementation could be changed.
>>
>> so that later implementation changes won't bother compat bits
>> again.
> 
> I would very much like to generate these bloom filters in composefs
> right now, before the composefs v1 format is completely locked down,
> and this should be fully possible given that this is a backwards
> compat change. But this is only possible if it doesn't require a
> feature flag like this that makes old erofs versions not mount the
> image.

EROFS has two types of feature bits:

  1) compat flags, which doesn't block mounting on old kernels;
  2) incompat flags, which will block mounting on old kernels.

here bloom filter use a new compat flag, so old kernels will just
ignore this and mount.  compat flags just indicates that "an image
with a feature, and you could use it or not".

Here I just meant the bloom filter internals are fixed for now,
so that we might reserve a byte in the on-disk super block for
later potential changes (if any).  And don't need to bother another
new compat flag.

Thanks,
Gao Xiang
