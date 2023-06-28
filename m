Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A777408FC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 05:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbjF1DiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 23:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjF1DiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 23:38:18 -0400
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466322D74
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 20:38:16 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vm85EE4_1687923491;
Received: from 30.221.149.82(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vm85EE4_1687923491)
          by smtp.aliyun-inc.com;
          Wed, 28 Jun 2023 11:38:12 +0800
Message-ID: <c316bc55-cc4d-f05a-8936-2cde217b8dd2@linux.alibaba.com>
Date:   Wed, 28 Jun 2023 11:38:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [RFC 0/2] erofs: introduce bloom filter for xattr
Content-Language: en-US
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     hsiangkao@linux.alibaba.com, chao@kernel.org, huyue2@coolpad.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, alexl@redhat.com
References: <20230621083209.116024-1-jefflexu@linux.alibaba.com>
In-Reply-To: <20230621083209.116024-1-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Sorry for the late reply as I was on vacation these days.

I test the hash bit for all xattrs given by Alex[1], to see if each
xattr could be mapped into one unique bit in the 32-bit bloom filter.

[1]
https://lore.kernel.org/all/CAL7ro1HhYUDrOX7A-13p7rLBZSWHTQWGOdOzVcYkddkU_LArUw@mail.gmail.com/


On 6/21/23 4:32 PM, Jingbo Xu wrote:
> 
> 3.2. input of hash function
> -------------------------
> As previously described, each hash function will map the given data into
> one bit of the bloom filter map.  In our use case, xattr name serves as
> the key of hash function.
> 
> When .getxattr() gets called, only index (e.g. EROFS_XATTR_INDEX_USER)
> and the remaining name apart from the prefix are handy.  To avoid
> constructing the full xattr name, the above index and name are fed into
> the hash function directly in the following way:
> 
> ```
> bit = xxh32(name, strlen(name), index + i);
> ```
> 
> where index serves as part of seed, so that it gets involved in the
> calculation for the hash.


All xattrs are hashed with one single hash function.

I first tested with the following hash function:

```
xxh32(name, strlen(name), index)
```

where `index` represents the index of corresponding predefined name
prefix (e.g. EROFS_XATTR_INDEX_USER), while `name` represents the name
after stripping the above predefined name prefix (e.g.
"overlay.metacopy" for "user.overlay.metacopy")


The mapping results are:

bit  0: security.SMACK64EXEC
bit  1:
bit  2: user.overlay.protattr
bit  3: trusted.overlay.impure, user.overlay.opaque, user.mime_type
bit  4:
bit  5: user.overlay.origin
bit  6: user.overlay.metacopy, security.evm
bit  8: trusted.overlay.opaque
bit  9: trusted.overlay.origin
bit 10: trusted.overlay.upper, trusted.overlay.protattr
bit 11: security.apparmor, security.capability
bit 12: security.SMACK64
bit 13: user.overlay.redirect, security.ima
bit 14: user.overlay.upper
bit 15: trusted.overlay.redirect
bit 16: security.SMACK64IPOUT
bit 17:
bit 18: system.posix_acl_access
bit 19: security.selinux
bit 20:
bit 21:
bit 22: system.posix_acl_default
bit 23: security.SMACK64MMAP
bit 24: user.overlay.impure, user.overlay.nlink, security.SMACK64TRANSMUTE
bit 25: trusted.overlay.metacopy
bit 26:
bit 27: security.SMACK64IPIN
bit 28:
bit 29:
bit 30: trusted.overlay.nlink
bit 31:

Here 30 xattrs are mapped into 22 bits.  There are two potential
conflicts, i.e. bit 10 (trusted.overlay.upper, trusted.overlay.protattr)
and bit 24 (user.overlay.impure, user.overlay.nlink).


> 
> An alternative way is to calculate the hash from the full xattr name by
> feeding the prefix string and the remaining name string separately in
> the following way:
> 
> ```
> xxh32_reset()
> xxh32_update(prefix string, ...)
> xxh32_update(remaining name, ...)
> xxh32_digest()
> ```
> 
> But I doubt if it really deserves to call multiple APIs instead of one
> single xxh32().


I also tested with the following hash function, where the full name of
the xattr, e.g. "user.overlay.metacopy", is fed into the hash function.

```
xxh32(name, strlen(name), 0)
```


Following are the mapping results:

bit  0: trusted.overlay.impure, user.overlay.protattr
bit  1: security.SMACK64IPOUT
bit  2:
bit  3: security.capability
bit  4: security.selinux
bit  5: security.ima
bit  6: user.overlay.metacopy
bit  8:
bit  9: trusted.overlay.redirect, security.SMACK64EXEC
bit 10: system.posix_acl_access
bit 11: trusted.overlay.nlink
bit 12: trusted.overlay.opaque
bit 13:
bit 14:
bit 15:
bit 16:
bit 17: user.overlay.impure
bit 18: security.apparmor
bit 19:
bit 20: user.overlay.origin, user.overlay.nlink, security.SMACK64TRANSMUTE
bit 21:
bit 22: trusted.overlay.metacopy, trusted.overlay.protattr
bit 23: user.overlay.upper, security.evm
bit 24: user.overlay.redirect, security.SMACK64IPIN,
system.posix_acl_default
bit 25: security.SMACK64
bit 26:
bit 27: trusted.overlay.upper, security.SMACK64MMAP
bit 28: trusted.overlay.origin, user.mime_type
bit 29:
bit 30:
bit 31: user.overlay.opaque

30 xattrs are mapped into 20 bits.  Similarly there are two potential
conflicts, i.e. bit 20 (user.overlay.origin, user.overlay.nlink) and bit
22 (trusted.overlay.metacopy, trusted.overlay.protattr).


Summary
=======

Personally I would prefer the former, as it maps xattrs into the bloom
filter more evenly (22 bits vs 20 bits) and can better cooperate with
the kernel routine (index and the remaining name string, rather than the
full name string, are handy).

-- 
Thanks,
Jingbo
