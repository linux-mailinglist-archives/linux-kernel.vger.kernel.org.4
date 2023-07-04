Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19A1746B7E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 10:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbjGDIHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 04:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbjGDIG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 04:06:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE03E52
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 01:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688457967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+HLEhyMz8craTsn3to7RUK9ThuIC3AHRSWlUj4z7344=;
        b=QOZlBm5nQ1ELENzzj98yrI9WeTUu4blKV9qYDEt+6ItWYW8V3zz2Mg9XuieFrjl6WPXxS6
        LGEKUNZgwChvougSux4cHS6IVxZxjiN/waEcnFL3FWXDH/Y1u/QkGjax6eul6Wf0pXR36+
        CuZHLv6dkJuILn8JpzSoCnMFOt85tXE=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-9unCqCBPNYCjeygbu0XE7g-1; Tue, 04 Jul 2023 04:06:06 -0400
X-MC-Unique: 9unCqCBPNYCjeygbu0XE7g-1
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-345e7434a79so26020355ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 01:06:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688457965; x=1691049965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+HLEhyMz8craTsn3to7RUK9ThuIC3AHRSWlUj4z7344=;
        b=CHHIYytuEqrZo87Q86DSBiZRHgzxTp7hk2/vPQtGy2UYUSWc7/yn9AboodJ5a/l72Y
         7mCswQ0dOr+jkeiZeTd9dvn0CHXAdzuKmwD/on/+6nBixtMnojc6uguQs/BwI/I4z4TO
         0Qwe7DHjK3RBIZAmqy8ewLbZa+9QaI/rRrIgferjnXSW+ROLcoN3F3JFCCXA7TCXyTMY
         /0uj/oegiCFYojUF6LvwgSISO+CWcAqqqy2gv+VxZ/a6bADUP5wGoWmv1yf8HO2+LGXE
         DuT5AW7m/2LdSx82ek23ahNnaFp64W9sdC96zPyw2yi+3Li/m7ex7ux3wWLkds7Wwl6Q
         UtSw==
X-Gm-Message-State: ABy/qLa4C7pXAlR2HARdGR+HwatgDJ1Zpfh2Zz0s6CyxyFnsbeGKnSQd
        5UzJneMw3cD0J1sl8GmQj4HslqvX66o2SoLCnQA858euipmSRuy391lrlBekyYt4ui1p1T162mD
        4rNSh1rSQU4qvokNVKA12HZXWSEyy4nAeiJ5ZrYjFLLya4f20w78=
X-Received: by 2002:a92:ce84:0:b0:345:83d6:6020 with SMTP id r4-20020a92ce84000000b0034583d66020mr12999348ilo.21.1688457965098;
        Tue, 04 Jul 2023 01:06:05 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFLDeGDk/zYVzoKn96RZTkAhnesrVyPUXni/0BVg+Vo4e1ny43N+7wGy6hBmGg+VFFp4ff/SHA9Unfdzfbe/I0=
X-Received: by 2002:a92:ce84:0:b0:345:83d6:6020 with SMTP id
 r4-20020a92ce84000000b0034583d66020mr12999343ilo.21.1688457964852; Tue, 04
 Jul 2023 01:06:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230621083209.116024-1-jefflexu@linux.alibaba.com>
 <c316bc55-cc4d-f05a-8936-2cde217b8dd2@linux.alibaba.com> <CAL7ro1FjnO52tawLeu-wNtk+upN1ShxeFYE1AiFUh1JN2oo0hA@mail.gmail.com>
 <74a8a369-c3b0-b338-fa8f-fdd7c252efaf@linux.alibaba.com>
In-Reply-To: <74a8a369-c3b0-b338-fa8f-fdd7c252efaf@linux.alibaba.com>
From:   Alexander Larsson <alexl@redhat.com>
Date:   Tue, 4 Jul 2023 10:05:53 +0200
Message-ID: <CAL7ro1Hhiq=qofFLgxjMDZnrwJ6E=tvcECqqbP8vQ_CeJLtSKQ@mail.gmail.com>
Subject: Re: [RFC 0/2] erofs: introduce bloom filter for xattr
To:     Jingbo Xu <jefflexu@linux.alibaba.com>
Cc:     hsiangkao@linux.alibaba.com, chao@kernel.org, huyue2@coolpad.com,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 4, 2023 at 7:56=E2=80=AFAM Jingbo Xu <jefflexu@linux.alibaba.co=
m> wrote:
>
>
>
> On 7/3/23 3:25 PM, Alexander Larsson wrote:
>
> >
> > Can't you just add a magic constant to the seed? Then we can come up
> > with one that gives a good spread and hardcode that.
> >
>
> I tried Alex's proposal of making a constant magic as part of the seed li=
ke:
>
> ```
> xxh32(name, strlen(name), SEED_MAGIC + index)
> ```
>
> >> where `index` represents the index of corresponding predefined name
> >> prefix (e.g. EROFS_XATTR_INDEX_USER), while `name` represents the name
> >> after stripping the above predefined name prefix (e.g.
> >> "overlay.metacopy" for "user.overlay.metacopy")
>
>
> I tried SEED_MAGIC in range [0, UINT32_MAX], trying to find a constant
> magic giving a best spread.
>
> There are totally 30 commonly used xattrs and 32 bits could be mapped
> into.  I failed to find the most perfect constant magic which maps these
> 30 xattrs to exactly 30 bits with no conflict.
>
> Later I can only select a magic from those that 1) maps 30 xattrs into
> 29 bits (with one conflict) and 2) at least xattrs like selinux, ima,
> evm, apparmor are unconflicted to each other.  Following are all
> candidates and the conflicted xattrs:
>
> ```
> seed: 745a51e
> bit 29: user.overlay.opaque, security.selinux,
>
> seed: fb08ad9
> bit 10: user.overlay.impure, system.posix_acl_access,
>
> seed: 11aa6c32
> bit 19: user.overlay.redirect, security.SMACK64MMAP,
>
> seed: 1438d503
> bit 10: trusted.overlay.protattr, security.ima,
>
> seed: 14ccea75
> bit 30: user.overlay.upper, security.ima,
>
> seed: 1d6a0d15
> bit 31: trusted.overlay.upper, user.overlay.metacopy,
>
> seed: 25bbe08f
> bit 31: trusted.overlay.metacopy, user.overlay.metacopy,
>
> seed: 2649da2a
> bit  6: user.overlay.nlink, security.SMACK64TRANSMUTE,
>
> seed: 2b9180b2
> bit 29: user.overlay.impure, security.evm,
>
> seed: 2c5d7862
> bit 16: user.overlay.upper, system.posix_acl_default,
>
> seed: 322040a6
> bit 17: trusted.overlay.impure, user.overlay.metacopy,
>
> seed: 328bcb8c
> bit 30: user.overlay.opaque, security.evm,
>
> seed: 35afc469
> bit  3: trusted.overlay.opaque, user.overlay.origin,
>
> seed: 435bed25
> bit  4: trusted.overlay.upper, security.SMACK64MMAP,
>
> seed: 43a853af
> bit  3: trusted.overlay.protattr, security.selinux,
>
> seed: 4930f511
> bit 22: trusted.overlay.origin, security.SMACK64,
>
> seed: 4acdce1d
> bit 21: user.overlay.opaque, security.selinux,
>
> seed: 4fc5f2b0
> bit 24: user.overlay.redirect, system.posix_acl_default,
>
> seed: 50632396
> bit  6: security.SMACK64, system.posix_acl_access,
>
> seed: 535f6351
> bit  3: system.posix_acl_access, user.mime_type,
>
> seed: 56f4306e
> bit  9: user.overlay.redirect, security.SMACK64MMAP,
>
> seed: 637e2bd9
> bit 22: trusted.overlay.upper, security.evm,
>
> seed: 6ab57b38
> bit  9: trusted.overlay.upper, user.overlay.metacopy,
>
> seed: 7113bd57
> bit 19: trusted.overlay.redirect, security.SMACK64,
>
> seed: 753e3f24
> bit  6: user.overlay.redirect, security.SMACK64EXEC,
>
> seed: 81883030
> bit  0: trusted.overlay.upper, security.SMACK64IPOUT,
>
> seed: 835f9f14
> bit 27: security.SMACK64EXEC, system.posix_acl_access,
>
> seed: 938fbb78
> bit 28: user.overlay.upper, security.apparmor,
>
> seed: 953bb3e9
> bit 30: user.overlay.protattr, system.posix_acl_access,
>
> seed: 962ccd7f
> bit 29: trusted.overlay.nlink, security.SMACK64IPOUT,
>
> seed: 9fff798e
> bit  3: user.overlay.nlink, user.mime_type,
>
> seed: a2e324eb
> bit 28: trusted.overlay.nlink, user.overlay.impure,
>
> seed: a6e00cef
> bit 26: user.overlay.opaque, security.SMACK64TRANSMUTE,
>
> seed: ae26aaa9
> bit  0: trusted.overlay.metacopy, user.overlay.impure,
>
> seed: b2172573
> bit 14: trusted.overlay.upper, security.ima,
>
> seed: b5917739
> bit  8: trusted.overlay.protattr, user.overlay.impure,
>
> seed: c01a4919
> bit 22: trusted.overlay.nlink, user.overlay.upper,
>
> seed: c1fa0c0a
> bit 19: security.SMACK64TRANSMUTE, user.mime_type,
>
> seed: cbd314d7
> bit  6: trusted.overlay.upper, security.SMACK64IPOUT,
>
> seed: cc6dd8ee
> bit  2: trusted.overlay.nlink, user.overlay.upper,
>
> seed: cc922efd
> bit  3: trusted.overlay.opaque, user.overlay.opaque,
>
> seed: cd478c17
> bit  6: trusted.overlay.metacopy, user.overlay.metacopy,
>
> seed: d35be1c8
> bit  9: trusted.overlay.protattr, security.SMACK64MMAP,
>
> seed: d3914458
> bit  1: trusted.overlay.redirect, security.SMACK64IPIN,
>
> seed: f3251337
> bit  7: user.overlay.opaque, security.SMACK64IPOUT,
>
> seed: f37d8900
> bit  9: trusted.overlay.impure, user.overlay.protattr,
>
> seed: fafd6c93
> bit  0: security.SMACK64, user.mime_type,
>
> seed: fcd35cbb
> bit  3: trusted.overlay.upper, user.overlay.redirect,
>
> seed: fe2e058a
> bit 14: user.overlay.impure, user.mime_type,
> ```
>
>
> Among all these candidates, I would prefer the following three
> candidates as for each inode the same xattr of overlayfs family xattrs,
> e.g. "overlay.metacopy", can not be prefixed with "trusted." and "user."
> at the same time.

Well, they *can* be the same at the same time, it just doesn't make
much sense, so it seems very unlikely. I agree that these make sense,
if the kernel is looking for user.overlay.metacopy, it would be in an
userxattr mounted overlayfs layer, and it would be very unlikely that
it had a trusted metacopy xattr, so there won't be any false negatives
causing us to do a full look up.

> ```
> seed: 25bbe08f
> bit 31: trusted.overlay.metacopy, user.overlay.metacopy,
>
> seed: cc922efd
> bit  3: trusted.overlay.opaque, user.overlay.opaque,
>
> seed: cd478c17
> bit  6: trusted.overlay.metacopy, user.overlay.metacopy,
> ```
>
>
> Any other idea?

Any of these three is good to me. I don't have any ideas directly
related to this. However,  semi-related, it would be really cool if
fuse supported the same approach for xattr lookup. I.e. if lookup
could add a bloom filter value as part of the inode data, then we
could avoid a kernel<->fusefs-d transition for negative xattrs
lookups.

--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D
 Alexander Larsson                                Red Hat, Inc
       alexl@redhat.com         alexander.larsson@gmail.com

