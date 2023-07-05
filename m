Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0ADB747E6F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 09:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbjGEHoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 03:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbjGEHoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 03:44:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B18E59
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 00:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688542996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GKZLTnkLqcKqaST+ccHAre8EUSS+fXNkgS5OJVWD5Oo=;
        b=HhHCjKZp3y8/+HX6nAfknUcmZe/FtRnKItN+K+/9JBU3RkAna0aJXvsnZCf+lZPBuevfGE
        XX9paWRVkdKmJLz7wJW/DcShc9afrn401Z9nc2K/nEwi0KnnSegk3uQak4M4IXt4zdnDAG
        PxZC6F+J78cNSXhJmL6j4f1lMAWkVnM=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-x_-6oLbtNxy0KnHGjlHZCQ-1; Wed, 05 Jul 2023 03:43:12 -0400
X-MC-Unique: x_-6oLbtNxy0KnHGjlHZCQ-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-34614e84616so9751805ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 00:43:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688542991; x=1691134991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GKZLTnkLqcKqaST+ccHAre8EUSS+fXNkgS5OJVWD5Oo=;
        b=d61LvGfiTp+JU1F/ArIC4+yx2wEo9I0vPffcWxWHCC8YYFYajp3X6h2G6iDB1xJe94
         XkRXUcxLt/5p/Stub2/c6G3Ey2059KCnFK/tDjMhsFEJZAweUx4rmwUwEhCsrAknXLkV
         TZ0v9J7HNVWfTa5w7TJKIzmyaleZiIsno46OlLCTELPamaqTkGxqo302lpk95PwejOMf
         n+wWb3jX8GgytM9CTzupuBCwikNZHLxWzrzBbBe/KjR6S8tJMZ7gZPqCuC6ILR08UmEc
         mGt+c/9I28/kx9YrnPCSZYkRSAdU5HCEJuGDuSgkGVk4g4HRs41HpgbvHxtt4bdDYcb5
         FXFQ==
X-Gm-Message-State: ABy/qLZwG+TlFzsB6xW71ZaTfw7fcEEO8JXiv4XwCoW2A6Gaew/bsz3p
        0sOGZ2iHFkNn2dTrb7efkTslCgu60jP3yaHRJgtiWRWDLeYkrj3jb6NuU7EhWs7II2Prl1W/ADc
        YbDfQlmm5OdLkFPTckHUvfxV0n84VuWSprAemc9zDvCVA8/Cs
X-Received: by 2002:a92:c841:0:b0:345:968b:a147 with SMTP id b1-20020a92c841000000b00345968ba147mr14782752ilq.14.1688542991549;
        Wed, 05 Jul 2023 00:43:11 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGtfy/xAZixl1ClSishhtHJk4LSH8tlURUodcX+AX6bJXxTnD8w23VWDLTUJFB6SvB1JtVDB0L0NCLy35u2PV4=
X-Received: by 2002:a92:c841:0:b0:345:968b:a147 with SMTP id
 b1-20020a92c841000000b00345968ba147mr14782742ilq.14.1688542991315; Wed, 05
 Jul 2023 00:43:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230705070427.92579-1-jefflexu@linux.alibaba.com>
 <20230705070427.92579-2-jefflexu@linux.alibaba.com> <2eda59f2-a302-04a5-08de-c4ab7cf2e744@linux.alibaba.com>
In-Reply-To: <2eda59f2-a302-04a5-08de-c4ab7cf2e744@linux.alibaba.com>
From:   Alexander Larsson <alexl@redhat.com>
Date:   Wed, 5 Jul 2023 09:43:00 +0200
Message-ID: <CAL7ro1GayuYup4V0arhEWZDztFN1Gxx5jwdL3uFaGfQZ4hw41g@mail.gmail.com>
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

On Wed, Jul 5, 2023 at 9:25=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba.c=
om> wrote:
>
>
>
> On 2023/7/5 15:04, Jingbo Xu wrote:
> > The xattr name bloom filter feature is going to be introduced to speed
> > up the negative xattr lookup, e.g. system.posix_acl_[access|default]
> > lookup when running "ls -lR" workload.
> >
> > The number of common used extended attributes (n) is approximately 30.
>
> There are some commonly used extended attributes (n) and the total number
> of these is 31:
>
> >
> >       trusted.overlay.opaque
> >       trusted.overlay.redirect
> >       trusted.overlay.origin
> >       trusted.overlay.impure
> >       trusted.overlay.nlink
> >       trusted.overlay.upper
> >       trusted.overlay.metacopy
> >       trusted.overlay.protattr
> >       user.overlay.opaque
> >       user.overlay.redirect
> >       user.overlay.origin
> >       user.overlay.impure
> >       user.overlay.nlink
> >       user.overlay.upper
> >       user.overlay.metacopy
> >       user.overlay.protattr
> >       security.evm
> >       security.ima
> >       security.selinux
> >       security.SMACK64
> >       security.SMACK64IPIN
> >       security.SMACK64IPOUT
> >       security.SMACK64EXEC
> >       security.SMACK64TRANSMUTE
> >       security.SMACK64MMAP
> >       security.apparmor
> >       security.capability
> >       system.posix_acl_access
> >       system.posix_acl_default
> >       user.mime_type
> >
> > Given the number of bits of the bloom filter (m) is 32, the optimal
> > value for the number of the hash functions (k) is 1 (ln2 * m/n =3D 0.74=
).
> >
> > The single hash function is implemented as:
> >
> >       xxh32(name, strlen(name), EROFS_XATTR_FILTER_SEED + index)
> >
> > where index represents the index of corresponding predefined short name
>
> where `index`...
>
>
>
> > prefix, while name represents the name string after stripping the above
> > predefined name prefix.
> >
> > The constant magic number EROFS_XATTR_FILTER_SEED, i.e. 0x25BBE08F, is
> > used to give a better spread when mapping these 30 extended attributes
> > into 32-bit bloom filter as:
> >
> >       bit  0: security.ima
> >       bit  1:
> >       bit  2: trusted.overlay.nlink
> >       bit  3:
> >       bit  4: user.overlay.nlink
> >       bit  5: trusted.overlay.upper
> >       bit  6: user.overlay.origin
> >       bit  7: trusted.overlay.protattr
> >       bit  8: security.apparmor
> >       bit  9: user.overlay.protattr
> >       bit 10: user.overlay.opaque
> >       bit 11: security.selinux
> >       bit 12: security.SMACK64TRANSMUTE
> >       bit 13: security.SMACK64
> >       bit 14: security.SMACK64MMAP
> >       bit 15: user.overlay.impure
> >       bit 16: security.SMACK64IPIN
> >       bit 17: trusted.overlay.redirect
> >       bit 18: trusted.overlay.origin
> >       bit 19: security.SMACK64IPOUT
> >       bit 20: trusted.overlay.opaque
> >       bit 21: system.posix_acl_default
> >       bit 22:
> >       bit 23: user.mime_type
> >       bit 24: trusted.overlay.impure
> >       bit 25: security.SMACK64EXEC
> >       bit 26: user.overlay.redirect
> >       bit 27: user.overlay.upper
> >       bit 28: security.evm
> >       bit 29: security.capability
> >       bit 30: system.posix_acl_access
> >       bit 31: trusted.overlay.metacopy, user.overlay.metacopy
> >
> > The h_name_filter field is introduced to the on-disk per-inode xattr
> > header to place the corresponding xattr name filter, where bit value 1
> > indicates non-existence for compatibility.
> >
> > This feature is indicated by EROFS_FEATURE_COMPAT_XATTR_FILTER
> > compatible feature bit.
> >
> > Suggested-by: Alexander Larsson <alexl@redhat.com>
> > Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> > ---
> >   fs/erofs/erofs_fs.h | 8 +++++++-
> >   1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
> > index 2c7b16e340fe..b4b6235fd720 100644
> > --- a/fs/erofs/erofs_fs.h
> > +++ b/fs/erofs/erofs_fs.h
> > @@ -13,6 +13,7 @@
> >
> >   #define EROFS_FEATURE_COMPAT_SB_CHKSUM          0x00000001
> >   #define EROFS_FEATURE_COMPAT_MTIME              0x00000002
> > +#define EROFS_FEATURE_COMPAT_XATTR_FILTER    0x00000004
>
> I'd suggest that if we could leave one reserved byte in the
> superblock for now (and checking if it's 0) since
>    1) xattr filter feature is a compatible feature;
>    2) I'm not sure if the implementation could be changed.
>
> so that later implementation changes won't bother compat bits
> again.

I would very much like to generate these bloom filters in composefs
right now, before the composefs v1 format is completely locked down,
and this should be fully possible given that this is a backwards
compat change. But this is only possible if it doesn't require a
feature flag like this that makes old erofs versions not mount the
image.


--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D
 Alexander Larsson                                Red Hat, Inc
       alexl@redhat.com         alexander.larsson@gmail.com

