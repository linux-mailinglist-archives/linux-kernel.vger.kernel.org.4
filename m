Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D316747F22
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 10:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbjGEINS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 04:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjGEINR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 04:13:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468C818B
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 01:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688544749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pFpzjAjBqHsfg4Tayn2E33Ze4nxP21SY6xBntcV4KQk=;
        b=JK8FUAhfzXZR5Pdx4faQEE6iNxI+v6iQHTlEpJ7yiCAXOvdTIKnGM95A4TaDgMiEpfXQXr
        dmjZ1O2aZsTc7hU/DDKxIeVjaQ5TaMQYLT2/V7lMy7o+jnGwlVLe/8R4aioKOzjaUm+3DU
        eX2jx6ZruCvRomwO3WDWniz3vXxPHdo=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-AIwqyQPzN7G18vFf4CCRWg-1; Wed, 05 Jul 2023 04:12:28 -0400
X-MC-Unique: AIwqyQPzN7G18vFf4CCRWg-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-77e3208a8cbso255017539f.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 01:12:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688544747; x=1691136747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pFpzjAjBqHsfg4Tayn2E33Ze4nxP21SY6xBntcV4KQk=;
        b=gvwBEOO5lEsVxROGescRxGpfvyW5nXVHbJJUxuSHhK+Ut0ViwO01K5yx0r0iFD/D1E
         pIojJ2awSF3rak4Yh+JNqRAx5b6dic/4CluQa+ygPmUmpbJDVAqrm2ie1dTUjsS8N85v
         97vibJATN7GLBvwmOc+h3zYb5DkBw1ETdOhnWW3pPqVevvEuI/hMAfEtoHHk8q2Hza56
         UW+v1PBySSqjrH7+wA3Dsz+enZyZB4PGkMFohAwGKtH3+FHyW1WrcpfCuzOKvT1owY41
         Nwad2m7M8n9FKekW/8vFaTKkLaJ7GfhsXgmpz5qNqlT1UkB6ID5KsmMZ27uzkSUydLSu
         d6UA==
X-Gm-Message-State: ABy/qLbztUGRwfwZNGEkE8DaD7sz0u0RQYFJfv2183Iyi95KHKIw4mvt
        M2KTJC2c15v5wiYyg8Ob8tdlIS/peeCO6D1DcSdSyo7cYtjEFxYC6qp53I/lYOBpJm98UM5pCOz
        W+CE6gwWvsvtNeAz1l7njviIi7ojlCvxdrX/BavA4vPmM/EoV
X-Received: by 2002:a92:da8b:0:b0:346:2b9f:1fb with SMTP id u11-20020a92da8b000000b003462b9f01fbmr1437779iln.22.1688544747692;
        Wed, 05 Jul 2023 01:12:27 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEBzbud3HpvOvR4Umf+eU7B665lAOEnBNzLN/n1qIr7xR2iaICbciuwEbfzud4ws84u7WItv0e524vc4YBLkf4=
X-Received: by 2002:a92:da8b:0:b0:346:2b9f:1fb with SMTP id
 u11-20020a92da8b000000b003462b9f01fbmr1437770iln.22.1688544747420; Wed, 05
 Jul 2023 01:12:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230705070427.92579-1-jefflexu@linux.alibaba.com>
 <20230705070427.92579-2-jefflexu@linux.alibaba.com> <2eda59f2-a302-04a5-08de-c4ab7cf2e744@linux.alibaba.com>
 <CAL7ro1GayuYup4V0arhEWZDztFN1Gxx5jwdL3uFaGfQZ4hw41g@mail.gmail.com> <22894dd5-a74c-a459-ea45-63bae7b5a295@linux.alibaba.com>
In-Reply-To: <22894dd5-a74c-a459-ea45-63bae7b5a295@linux.alibaba.com>
From:   Alexander Larsson <alexl@redhat.com>
Date:   Wed, 5 Jul 2023 10:12:16 +0200
Message-ID: <CAL7ro1GULoAwTfxcvSZo=exqhJppqPBPtKqr=kdYCatkvGyPGQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] erofs: update on-disk format for xattr name filter
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     Jingbo Xu <jefflexu@linux.alibaba.com>, chao@kernel.org,
        huyue2@coolpad.com, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
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

On Wed, Jul 5, 2023 at 9:51=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba.c=
om> wrote:
>
>
>
> On 2023/7/5 15:43, Alexander Larsson wrote:
> > On Wed, Jul 5, 2023 at 9:25=E2=80=AFAM Gao Xiang <hsiangkao@linux.aliba=
ba.com> wrote:
> >>
> >>
> >>
> >> On 2023/7/5 15:04, Jingbo Xu wrote:
> >>> The xattr name bloom filter feature is going to be introduced to spee=
d
> >>> up the negative xattr lookup, e.g. system.posix_acl_[access|default]
> >>> lookup when running "ls -lR" workload.
> >>>
> >>> The number of common used extended attributes (n) is approximately 30=
.
> >>
> >> There are some commonly used extended attributes (n) and the total num=
ber
> >> of these is 31:
> >>
> >>>
> >>>        trusted.overlay.opaque
> >>>        trusted.overlay.redirect
> >>>        trusted.overlay.origin
> >>>        trusted.overlay.impure
> >>>        trusted.overlay.nlink
> >>>        trusted.overlay.upper
> >>>        trusted.overlay.metacopy
> >>>        trusted.overlay.protattr
> >>>        user.overlay.opaque
> >>>        user.overlay.redirect
> >>>        user.overlay.origin
> >>>        user.overlay.impure
> >>>        user.overlay.nlink
> >>>        user.overlay.upper
> >>>        user.overlay.metacopy
> >>>        user.overlay.protattr
> >>>        security.evm
> >>>        security.ima
> >>>        security.selinux
> >>>        security.SMACK64
> >>>        security.SMACK64IPIN
> >>>        security.SMACK64IPOUT
> >>>        security.SMACK64EXEC
> >>>        security.SMACK64TRANSMUTE
> >>>        security.SMACK64MMAP
> >>>        security.apparmor
> >>>        security.capability
> >>>        system.posix_acl_access
> >>>        system.posix_acl_default
> >>>        user.mime_type
> >>>
> >>> Given the number of bits of the bloom filter (m) is 32, the optimal
> >>> value for the number of the hash functions (k) is 1 (ln2 * m/n =3D 0.=
74).
> >>>
> >>> The single hash function is implemented as:
> >>>
> >>>        xxh32(name, strlen(name), EROFS_XATTR_FILTER_SEED + index)
> >>>
> >>> where index represents the index of corresponding predefined short na=
me
> >>
> >> where `index`...
> >>
> >>
> >>
> >>> prefix, while name represents the name string after stripping the abo=
ve
> >>> predefined name prefix.
> >>>
> >>> The constant magic number EROFS_XATTR_FILTER_SEED, i.e. 0x25BBE08F, i=
s
> >>> used to give a better spread when mapping these 30 extended attribute=
s
> >>> into 32-bit bloom filter as:
> >>>
> >>>        bit  0: security.ima
> >>>        bit  1:
> >>>        bit  2: trusted.overlay.nlink
> >>>        bit  3:
> >>>        bit  4: user.overlay.nlink
> >>>        bit  5: trusted.overlay.upper
> >>>        bit  6: user.overlay.origin
> >>>        bit  7: trusted.overlay.protattr
> >>>        bit  8: security.apparmor
> >>>        bit  9: user.overlay.protattr
> >>>        bit 10: user.overlay.opaque
> >>>        bit 11: security.selinux
> >>>        bit 12: security.SMACK64TRANSMUTE
> >>>        bit 13: security.SMACK64
> >>>        bit 14: security.SMACK64MMAP
> >>>        bit 15: user.overlay.impure
> >>>        bit 16: security.SMACK64IPIN
> >>>        bit 17: trusted.overlay.redirect
> >>>        bit 18: trusted.overlay.origin
> >>>        bit 19: security.SMACK64IPOUT
> >>>        bit 20: trusted.overlay.opaque
> >>>        bit 21: system.posix_acl_default
> >>>        bit 22:
> >>>        bit 23: user.mime_type
> >>>        bit 24: trusted.overlay.impure
> >>>        bit 25: security.SMACK64EXEC
> >>>        bit 26: user.overlay.redirect
> >>>        bit 27: user.overlay.upper
> >>>        bit 28: security.evm
> >>>        bit 29: security.capability
> >>>        bit 30: system.posix_acl_access
> >>>        bit 31: trusted.overlay.metacopy, user.overlay.metacopy
> >>>
> >>> The h_name_filter field is introduced to the on-disk per-inode xattr
> >>> header to place the corresponding xattr name filter, where bit value =
1
> >>> indicates non-existence for compatibility.
> >>>
> >>> This feature is indicated by EROFS_FEATURE_COMPAT_XATTR_FILTER
> >>> compatible feature bit.
> >>>
> >>> Suggested-by: Alexander Larsson <alexl@redhat.com>
> >>> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> >>> ---
> >>>    fs/erofs/erofs_fs.h | 8 +++++++-
> >>>    1 file changed, 7 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
> >>> index 2c7b16e340fe..b4b6235fd720 100644
> >>> --- a/fs/erofs/erofs_fs.h
> >>> +++ b/fs/erofs/erofs_fs.h
> >>> @@ -13,6 +13,7 @@
> >>>
> >>>    #define EROFS_FEATURE_COMPAT_SB_CHKSUM          0x00000001
> >>>    #define EROFS_FEATURE_COMPAT_MTIME              0x00000002
> >>> +#define EROFS_FEATURE_COMPAT_XATTR_FILTER    0x00000004
> >>
> >> I'd suggest that if we could leave one reserved byte in the
> >> superblock for now (and checking if it's 0) since
> >>     1) xattr filter feature is a compatible feature;
> >>     2) I'm not sure if the implementation could be changed.
> >>
> >> so that later implementation changes won't bother compat bits
> >> again.
> >
> > I would very much like to generate these bloom filters in composefs
> > right now, before the composefs v1 format is completely locked down,
> > and this should be fully possible given that this is a backwards
> > compat change. But this is only possible if it doesn't require a
> > feature flag like this that makes old erofs versions not mount the
> > image.
>
> EROFS has two types of feature bits:
>
>   1) compat flags, which doesn't block mounting on old kernels;
>   2) incompat flags, which will block mounting on old kernels.
>
> here bloom filter use a new compat flag, so old kernels will just
> ignore this and mount.  compat flags just indicates that "an image
> with a feature, and you could use it or not".
>
> Here I just meant the bloom filter internals are fixed for now,
> so that we might reserve a byte in the on-disk super block for
> later potential changes (if any).  And don't need to bother another
> new compat flag.

Cool. Then we're all good!

--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D
 Alexander Larsson                                Red Hat, Inc
       alexl@redhat.com         alexander.larsson@gmail.com

