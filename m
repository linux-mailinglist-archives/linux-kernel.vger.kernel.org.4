Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FD274693C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 07:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjGDF4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 01:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjGDF4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 01:56:13 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2060B130
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 22:56:11 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VmbECYU_1688450166;
Received: from 30.221.145.16(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VmbECYU_1688450166)
          by smtp.aliyun-inc.com;
          Tue, 04 Jul 2023 13:56:07 +0800
Message-ID: <74a8a369-c3b0-b338-fa8f-fdd7c252efaf@linux.alibaba.com>
Date:   Tue, 4 Jul 2023 13:56:05 +0800
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



On 7/3/23 3:25 PM, Alexander Larsson wrote:

> 
> Can't you just add a magic constant to the seed? Then we can come up
> with one that gives a good spread and hardcode that.
> 

I tried Alex's proposal of making a constant magic as part of the seed like:

```
xxh32(name, strlen(name), SEED_MAGIC + index)
```

>> where `index` represents the index of corresponding predefined name
>> prefix (e.g. EROFS_XATTR_INDEX_USER), while `name` represents the name
>> after stripping the above predefined name prefix (e.g.
>> "overlay.metacopy" for "user.overlay.metacopy")


I tried SEED_MAGIC in range [0, UINT32_MAX], trying to find a constant
magic giving a best spread.

There are totally 30 commonly used xattrs and 32 bits could be mapped
into.  I failed to find the most perfect constant magic which maps these
30 xattrs to exactly 30 bits with no conflict.

Later I can only select a magic from those that 1) maps 30 xattrs into
29 bits (with one conflict) and 2) at least xattrs like selinux, ima,
evm, apparmor are unconflicted to each other.  Following are all
candidates and the conflicted xattrs:

```
seed: 745a51e
bit 29: user.overlay.opaque, security.selinux,

seed: fb08ad9
bit 10: user.overlay.impure, system.posix_acl_access,

seed: 11aa6c32
bit 19: user.overlay.redirect, security.SMACK64MMAP,

seed: 1438d503
bit 10: trusted.overlay.protattr, security.ima,

seed: 14ccea75
bit 30: user.overlay.upper, security.ima,

seed: 1d6a0d15
bit 31: trusted.overlay.upper, user.overlay.metacopy,

seed: 25bbe08f
bit 31: trusted.overlay.metacopy, user.overlay.metacopy,

seed: 2649da2a
bit  6: user.overlay.nlink, security.SMACK64TRANSMUTE,

seed: 2b9180b2
bit 29: user.overlay.impure, security.evm,

seed: 2c5d7862
bit 16: user.overlay.upper, system.posix_acl_default,

seed: 322040a6
bit 17: trusted.overlay.impure, user.overlay.metacopy,

seed: 328bcb8c
bit 30: user.overlay.opaque, security.evm,

seed: 35afc469
bit  3: trusted.overlay.opaque, user.overlay.origin,

seed: 435bed25
bit  4: trusted.overlay.upper, security.SMACK64MMAP,

seed: 43a853af
bit  3: trusted.overlay.protattr, security.selinux,

seed: 4930f511
bit 22: trusted.overlay.origin, security.SMACK64,

seed: 4acdce1d
bit 21: user.overlay.opaque, security.selinux,

seed: 4fc5f2b0
bit 24: user.overlay.redirect, system.posix_acl_default,

seed: 50632396
bit  6: security.SMACK64, system.posix_acl_access,

seed: 535f6351
bit  3: system.posix_acl_access, user.mime_type,

seed: 56f4306e
bit  9: user.overlay.redirect, security.SMACK64MMAP,

seed: 637e2bd9
bit 22: trusted.overlay.upper, security.evm,

seed: 6ab57b38
bit  9: trusted.overlay.upper, user.overlay.metacopy,

seed: 7113bd57
bit 19: trusted.overlay.redirect, security.SMACK64,

seed: 753e3f24
bit  6: user.overlay.redirect, security.SMACK64EXEC,

seed: 81883030
bit  0: trusted.overlay.upper, security.SMACK64IPOUT,

seed: 835f9f14
bit 27: security.SMACK64EXEC, system.posix_acl_access,

seed: 938fbb78
bit 28: user.overlay.upper, security.apparmor,

seed: 953bb3e9
bit 30: user.overlay.protattr, system.posix_acl_access,

seed: 962ccd7f
bit 29: trusted.overlay.nlink, security.SMACK64IPOUT,

seed: 9fff798e
bit  3: user.overlay.nlink, user.mime_type,

seed: a2e324eb
bit 28: trusted.overlay.nlink, user.overlay.impure,

seed: a6e00cef
bit 26: user.overlay.opaque, security.SMACK64TRANSMUTE,

seed: ae26aaa9
bit  0: trusted.overlay.metacopy, user.overlay.impure,

seed: b2172573
bit 14: trusted.overlay.upper, security.ima,

seed: b5917739
bit  8: trusted.overlay.protattr, user.overlay.impure,

seed: c01a4919
bit 22: trusted.overlay.nlink, user.overlay.upper,

seed: c1fa0c0a
bit 19: security.SMACK64TRANSMUTE, user.mime_type,

seed: cbd314d7
bit  6: trusted.overlay.upper, security.SMACK64IPOUT,

seed: cc6dd8ee
bit  2: trusted.overlay.nlink, user.overlay.upper,

seed: cc922efd
bit  3: trusted.overlay.opaque, user.overlay.opaque,

seed: cd478c17
bit  6: trusted.overlay.metacopy, user.overlay.metacopy,

seed: d35be1c8
bit  9: trusted.overlay.protattr, security.SMACK64MMAP,

seed: d3914458
bit  1: trusted.overlay.redirect, security.SMACK64IPIN,

seed: f3251337
bit  7: user.overlay.opaque, security.SMACK64IPOUT,

seed: f37d8900
bit  9: trusted.overlay.impure, user.overlay.protattr,

seed: fafd6c93
bit  0: security.SMACK64, user.mime_type,

seed: fcd35cbb
bit  3: trusted.overlay.upper, user.overlay.redirect,

seed: fe2e058a
bit 14: user.overlay.impure, user.mime_type,
```


Among all these candidates, I would prefer the following three
candidates as for each inode the same xattr of overlayfs family xattrs,
e.g. "overlay.metacopy", can not be prefixed with "trusted." and "user."
at the same time.

```
seed: 25bbe08f
bit 31: trusted.overlay.metacopy, user.overlay.metacopy,

seed: cc922efd
bit  3: trusted.overlay.opaque, user.overlay.opaque,

seed: cd478c17
bit  6: trusted.overlay.metacopy, user.overlay.metacopy,
```


Any other idea?


-- 
Thanks,
Jingbo
