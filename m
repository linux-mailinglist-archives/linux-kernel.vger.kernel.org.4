Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23071747E73
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 09:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbjGEHpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 03:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjGEHpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 03:45:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4502FE59
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 00:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688543096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xhqSMESVuEfcbYSiCIUoig5V/WvTsij8RzmIN+JFlXI=;
        b=LXrqwoyhy4gOGIHJsSQBKCvaCfTgHjAxfHUFAZsUSlVKR/I8qb2gY0JzeI30k5Vsf/Jxt3
        wh/kVXuCA39pj6a8Gc7Kyjzgizm3dA2J/KC5zCr0pxkkvaxhn5UB3yYfXYBJS/vtfN9ZjR
        Q3PSndXVpfVpUcxgW+5tdHKN7Pq3//8=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-64Ltnt_XPnGVNYZhQp2CJQ-1; Wed, 05 Jul 2023 03:44:55 -0400
X-MC-Unique: 64Ltnt_XPnGVNYZhQp2CJQ-1
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-345fe8d0a30so15168975ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 00:44:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688543094; x=1691135094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xhqSMESVuEfcbYSiCIUoig5V/WvTsij8RzmIN+JFlXI=;
        b=PTWlaFRwEa4VWgxRl1675i43a3ekboYRXULgXWZX+V3VKUNMkX5aRCWMXy7MBFLDL7
         Z1wu0BflQrxTA+YwIYGFlBDTR+3h2pEPbhErbsTf8ps8YM35v0/Ec7WFCvHa0nlUSjVE
         KS/aTvHq7RXVKM5Yhk9r1bzSHM6xXPB4UzOaJslXdqbDk0e5kWNmEhRS49PLjxKsKCF0
         hgQF4MEsuGmx3bj88SzM2wbr5PknVYjZERx3pNEcxSsoWZ/EBWNBA4fwpSxM03Wj6s5e
         GeoAuPTQxjYZbEpKtRNGdbeQ+g0TtWIWMEsDClDOEhTFrklGqbZL05OBCCLdWK+f3GHt
         kPaA==
X-Gm-Message-State: ABy/qLYTuhzWn1n/PYMBbBQADz+z2e8105ZG8t14LOnJi5ZPAZj2/fFx
        UupzT0PdooRb8Avh+1IjuMuwl0qk32iRZMTciclH+ilpzUZiRTrp+xhkbeqk8g6gSSOVO43+omy
        pJkDZvxjgaU4B/fU4T3dYm/xdIxmwVcgnEm5tqXJueSw+sKZq
X-Received: by 2002:a05:6e02:549:b0:345:baef:842b with SMTP id i9-20020a056e02054900b00345baef842bmr14200080ils.25.1688543094491;
        Wed, 05 Jul 2023 00:44:54 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGNIYLOK2akZqWKGP7b3X3MwsItf7MK568KWs0SIYlJKsXPb6PqP0sY6tuV5P0aUcze0VULeHSI/Fu9IbiQXo0=
X-Received: by 2002:a05:6e02:549:b0:345:baef:842b with SMTP id
 i9-20020a056e02054900b00345baef842bmr14200070ils.25.1688543094240; Wed, 05
 Jul 2023 00:44:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230705070427.92579-1-jefflexu@linux.alibaba.com> <20230705070427.92579-3-jefflexu@linux.alibaba.com>
In-Reply-To: <20230705070427.92579-3-jefflexu@linux.alibaba.com>
From:   Alexander Larsson <alexl@redhat.com>
Date:   Wed, 5 Jul 2023 09:44:43 +0200
Message-ID: <CAL7ro1GuPZE8ek=uvfHEqGFrbbt=NO1=oO8_B-dVBF9go=StSg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] erofs: boost negative xattr lookup with bloom filter
To:     Jingbo Xu <jefflexu@linux.alibaba.com>
Cc:     hsiangkao@linux.alibaba.com, chao@kernel.org, huyue2@coolpad.com,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 5, 2023 at 9:04=E2=80=AFAM Jingbo Xu <jefflexu@linux.alibaba.co=
m> wrote:
>
> The bit value for the bloom filter map has a reverse semantics for
> compatibility.  That is, the bit value of 0 indicates existence, while
> the bit value of 1 indicates the absence of corresponding xattr.
>
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/erofs/internal.h |  2 ++
>  fs/erofs/xattr.c    | 12 ++++++++++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 36e32fa542f0..7e447b48a46b 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -251,6 +251,7 @@ EROFS_FEATURE_FUNCS(fragments, incompat, INCOMPAT_FRA=
GMENTS)
>  EROFS_FEATURE_FUNCS(dedupe, incompat, INCOMPAT_DEDUPE)
>  EROFS_FEATURE_FUNCS(xattr_prefixes, incompat, INCOMPAT_XATTR_PREFIXES)
>  EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
> +EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
>
>  /* atomic flag definitions */
>  #define EROFS_I_EA_INITED_BIT  0
> @@ -270,6 +271,7 @@ struct erofs_inode {
>         unsigned char inode_isize;
>         unsigned int xattr_isize;
>
> +       unsigned long xattr_name_filter;
>         unsigned int xattr_shared_count;
>         unsigned int *xattr_shared_xattrs;
>
> diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
> index 40178b6e0688..1137723303d3 100644
> --- a/fs/erofs/xattr.c
> +++ b/fs/erofs/xattr.c
> @@ -5,6 +5,7 @@
>   * Copyright (C) 2021-2022, Alibaba Cloud
>   */
>  #include <linux/security.h>
> +#include <linux/xxhash.h>
>  #include "xattr.h"
>
>  struct erofs_xattr_iter {
> @@ -87,6 +88,7 @@ static int erofs_init_inode_xattrs(struct inode *inode)
>         }
>
>         ih =3D it.kaddr + erofs_blkoff(sb, it.pos);
> +       vi->xattr_name_filter =3D le32_to_cpu(ih->h_name_filter);
>         vi->xattr_shared_count =3D ih->h_shared_count;
>         vi->xattr_shared_xattrs =3D kmalloc_array(vi->xattr_shared_count,
>                                                 sizeof(uint), GFP_KERNEL)=
;
> @@ -392,7 +394,10 @@ int erofs_getxattr(struct inode *inode, int index, c=
onst char *name,
>                    void *buffer, size_t buffer_size)
>  {
>         int ret;
> +       uint32_t bit;
>         struct erofs_xattr_iter it;
> +       struct erofs_inode *vi =3D EROFS_I(inode);
> +       struct erofs_sb_info *sbi =3D EROFS_SB(inode->i_sb);
>
>         if (!name)
>                 return -EINVAL;
> @@ -401,6 +406,13 @@ int erofs_getxattr(struct inode *inode, int index, c=
onst char *name,
>         if (ret)
>                 return ret;
>
> +       if (erofs_sb_has_xattr_filter(sbi)) {

As I said in my other mail. I would really like this to just always do
the filter check. It should be safe as older fs:es have zero in place
here, and doing this allows me to create composefs images with the
bloom filters that also work with older kernels.

> +               bit =3D xxh32(name, strlen(name), EROFS_XATTR_FILTER_SEED=
 + index);
> +               bit &=3D EROFS_XATTR_FILTER_MASK;
> +               if (test_bit(bit, &vi->xattr_name_filter))
> +                       return -ENOATTR;
> +       }
> +
>         it.index =3D index;
>         it.name =3D (struct qstr)QSTR_INIT(name, strlen(name));
>         if (it.name.len > EROFS_NAME_LEN)
> --
> 2.19.1.6.gb485710b
>


--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D
 Alexander Larsson                                Red Hat, Inc
       alexl@redhat.com         alexander.larsson@gmail.com

