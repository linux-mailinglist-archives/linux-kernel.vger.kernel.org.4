Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B209C745605
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 09:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjGCH0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 03:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbjGCH0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 03:26:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED1CE6D
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 00:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688369134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X8K7BQdTCFcPMOKT0p8Mp9q5MKPmEZzCzLNkquYu4m0=;
        b=BJ2aJlamNwqURqHQoP6hmrtSiGxk/zRaSXV+b0Tj79l4evhN028EEcFqJgweTeuyGPpHId
        003fghRxeoffa3ehxVHs9nT0udAGlTovU61h4VmzkJNtmcAtn4IxKSZ6X7cjBDAmbYVjvd
        9RUe9jMOtgkuglafdewEyH2sGF7O7y0=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-Gi9CAdhdOGKbiTGl3dJflQ-1; Mon, 03 Jul 2023 03:25:33 -0400
X-MC-Unique: Gi9CAdhdOGKbiTGl3dJflQ-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-345c29495c9so18356555ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 00:25:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688369132; x=1690961132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8K7BQdTCFcPMOKT0p8Mp9q5MKPmEZzCzLNkquYu4m0=;
        b=bQ1mRHETdOubGOxszPZTDQ3I0vN9gGH4/sicoO4hlNomcU8S3bLfOZOVaX0tBfpFA2
         BPmIQtC0zsaRrfxkBlFUviRUiU1KoV4FfRwn7saW4psiRhRKxuA5Z/oIjBVDF/UN8BGg
         /hvVmNdVk2atmMsyGv6acB60bUKRFsayBnjPCSKSSwfxB0CXciha+Nzywk6yIgMVXKcT
         6TqgMAqr+bCK03Pk/a5nkT1PUZ/5eJjyp4hEw8iNVxp8RFvWNxRz8OpuQJRBu+AX4lJk
         mTH/ldv7WNBxYUoQGjmBCKQlYnG8o8KmHuqpIVdj4Vtlw64/M0cxVMmjligxHj9OgGn0
         33UQ==
X-Gm-Message-State: ABy/qLZy8KAWa3aZMKsWGSrvPAqpvdniFLlU2UdEPTChlpg20bYfxwup
        EDpHIqxiG1HOsD5/6K1aZXOZanB68H/9qkRb0MUyO7ri8eDrnfT4ATCd18mQkSq2xyLbrIA3YRH
        JgNOWJ4pG2F3YNyj4dCBivEpGUnByIxcj4XpY41kk
X-Received: by 2002:a92:7304:0:b0:345:d277:18eb with SMTP id o4-20020a927304000000b00345d27718ebmr7747437ilc.30.1688369132635;
        Mon, 03 Jul 2023 00:25:32 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHxAGjG5dGftIWqldWWYnIv5mQYfMJ0B2jptkgu7YvlMJjeSzqyGrFcUlTo77pTsoU5o6WVwk2Lg7iaLQnlteQ=
X-Received: by 2002:a92:7304:0:b0:345:d277:18eb with SMTP id
 o4-20020a927304000000b00345d27718ebmr7747429ilc.30.1688369132335; Mon, 03 Jul
 2023 00:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230621083209.116024-1-jefflexu@linux.alibaba.com> <c316bc55-cc4d-f05a-8936-2cde217b8dd2@linux.alibaba.com>
In-Reply-To: <c316bc55-cc4d-f05a-8936-2cde217b8dd2@linux.alibaba.com>
From:   Alexander Larsson <alexl@redhat.com>
Date:   Mon, 3 Jul 2023 09:25:21 +0200
Message-ID: <CAL7ro1FjnO52tawLeu-wNtk+upN1ShxeFYE1AiFUh1JN2oo0hA@mail.gmail.com>
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

On Wed, Jun 28, 2023 at 5:38=E2=80=AFAM Jingbo Xu <jefflexu@linux.alibaba.c=
om> wrote:
>
> Hi all,
>
> Sorry for the late reply as I was on vacation these days.
>
> I test the hash bit for all xattrs given by Alex[1], to see if each
> xattr could be mapped into one unique bit in the 32-bit bloom filter.
>
> [1]
> https://lore.kernel.org/all/CAL7ro1HhYUDrOX7A-13p7rLBZSWHTQWGOdOzVcYkddkU=
_LArUw@mail.gmail.com/
>
>
> On 6/21/23 4:32 PM, Jingbo Xu wrote:
> >
> > 3.2. input of hash function
> > -------------------------
> > As previously described, each hash function will map the given data int=
o
> > one bit of the bloom filter map.  In our use case, xattr name serves as
> > the key of hash function.
> >
> > When .getxattr() gets called, only index (e.g. EROFS_XATTR_INDEX_USER)
> > and the remaining name apart from the prefix are handy.  To avoid
> > constructing the full xattr name, the above index and name are fed into
> > the hash function directly in the following way:
> >
> > ```
> > bit =3D xxh32(name, strlen(name), index + i);
> > ```
> >
> > where index serves as part of seed, so that it gets involved in the
> > calculation for the hash.
>
>
> All xattrs are hashed with one single hash function.
>
> I first tested with the following hash function:
>
> ```
> xxh32(name, strlen(name), index)
> ```
>
> where `index` represents the index of corresponding predefined name
> prefix (e.g. EROFS_XATTR_INDEX_USER), while `name` represents the name
> after stripping the above predefined name prefix (e.g.
> "overlay.metacopy" for "user.overlay.metacopy")
>
>
> The mapping results are:
>
> bit  0: security.SMACK64EXEC
> bit  1:
> bit  2: user.overlay.protattr
> bit  3: trusted.overlay.impure, user.overlay.opaque, user.mime_type
> bit  4:
> bit  5: user.overlay.origin
> bit  6: user.overlay.metacopy, security.evm
> bit  8: trusted.overlay.opaque
> bit  9: trusted.overlay.origin
> bit 10: trusted.overlay.upper, trusted.overlay.protattr
> bit 11: security.apparmor, security.capability
> bit 12: security.SMACK64
> bit 13: user.overlay.redirect, security.ima
> bit 14: user.overlay.upper
> bit 15: trusted.overlay.redirect
> bit 16: security.SMACK64IPOUT
> bit 17:
> bit 18: system.posix_acl_access
> bit 19: security.selinux
> bit 20:
> bit 21:
> bit 22: system.posix_acl_default
> bit 23: security.SMACK64MMAP
> bit 24: user.overlay.impure, user.overlay.nlink, security.SMACK64TRANSMUT=
E
> bit 25: trusted.overlay.metacopy
> bit 26:
> bit 27: security.SMACK64IPIN
> bit 28:
> bit 29:
> bit 30: trusted.overlay.nlink
> bit 31:
>
> Here 30 xattrs are mapped into 22 bits.  There are two potential
> conflicts, i.e. bit 10 (trusted.overlay.upper, trusted.overlay.protattr)
> and bit 24 (user.overlay.impure, user.overlay.nlink).

Bit 11 (apparmor and capabilities) seems like the most likely thing to
run into. I.e. on an apparmor-using system, many files would have
apparmor xattr set, so looking up security.capabilities on it would
cause a false negative and we'd unnecessarily read the xattrs.

> > An alternative way is to calculate the hash from the full xattr name by
> > feeding the prefix string and the remaining name string separately in
> > the following way:
> >
> > ```
> > xxh32_reset()
> > xxh32_update(prefix string, ...)
> > xxh32_update(remaining name, ...)
> > xxh32_digest()
> > ```
> >
> > But I doubt if it really deserves to call multiple APIs instead of one
> > single xxh32().
>
>
> I also tested with the following hash function, where the full name of
> the xattr, e.g. "user.overlay.metacopy", is fed into the hash function.
>
> ```
> xxh32(name, strlen(name), 0)
> ```
>
>
> Following are the mapping results:
>
> bit  0: trusted.overlay.impure, user.overlay.protattr
> bit  1: security.SMACK64IPOUT
> bit  2:
> bit  3: security.capability
> bit  4: security.selinux
> bit  5: security.ima
> bit  6: user.overlay.metacopy
> bit  8:
> bit  9: trusted.overlay.redirect, security.SMACK64EXEC
> bit 10: system.posix_acl_access
> bit 11: trusted.overlay.nlink
> bit 12: trusted.overlay.opaque
> bit 13:
> bit 14:
> bit 15:
> bit 16:
> bit 17: user.overlay.impure
> bit 18: security.apparmor
> bit 19:
> bit 20: user.overlay.origin, user.overlay.nlink, security.SMACK64TRANSMUT=
E
> bit 21:
> bit 22: trusted.overlay.metacopy, trusted.overlay.protattr
> bit 23: user.overlay.upper, security.evm
> bit 24: user.overlay.redirect, security.SMACK64IPIN,
> system.posix_acl_default
> bit 25: security.SMACK64
> bit 26:
> bit 27: trusted.overlay.upper, security.SMACK64MMAP
> bit 28: trusted.overlay.origin, user.mime_type
> bit 29:
> bit 30:
> bit 31: user.overlay.opaque
>
> 30 xattrs are mapped into 20 bits.  Similarly there are two potential
> conflicts, i.e. bit 20 (user.overlay.origin, user.overlay.nlink) and bit
> 22 (trusted.overlay.metacopy, trusted.overlay.protattr).
>
>
> Summary
> =3D=3D=3D=3D=3D=3D=3D
>
> Personally I would prefer the former, as it maps xattrs into the bloom
> filter more evenly (22 bits vs 20 bits) and can better cooperate with
> the kernel routine (index and the remaining name string, rather than the
> full name string, are handy).

I agree that we want the approach with better cooperation with the
kernel function. However, I would much prefer if all the xattrs that
are commonly set on many files are unconflicted. This would be at
least: selinux, ima, evm, apparmor.

Can't you just add a magic constant to the seed? Then we can come up
with one that gives a good spread and hardcode that.

--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D
 Alexander Larsson                                Red Hat, Inc
       alexl@redhat.com         alexander.larsson@gmail.com

