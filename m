Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5C37443BE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 23:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbjF3VDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 17:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbjF3VDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 17:03:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2661A4224
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 14:03:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF50C617FF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 21:03:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 263F6C433C9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 21:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688158987;
        bh=GbigMdFJ1gzcE+bU8P8CZ5URxsvoZ5dfHvZ0M6ibtMM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=I9oR/QSMCaWc+Y4yeKUiG7CSAi+7AkoOEJu8C2gwZGwlfZc1yMCw/cvmu69X2erwY
         LENNmZj8kOvXfp9sCbDSnVLB+c0TvHs0Q8ySk7GtY0lk/xMB4NzpqFtJHgBYP5eTOJ
         koAg7uNd2XOxIPGNhn+hbUy1wWUfyko7BDOHPkkXN0lCn1NYMgRgQI7CBwCNL5IY7W
         W7pibjq6E6cTlPFNHD6+7TqEwbmGTSOxpg/QYywW3F3ToHVvJRqD0C0dfD1YKM/mwW
         6t2ik4NDvTSy5SejzK+dkZc7Qesr1tSYEwzs7WpUffn2WfV7sSPf/OICaO2oXK0UKC
         pALYd5MDQJktw==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2b6a152a933so36841581fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 14:03:07 -0700 (PDT)
X-Gm-Message-State: ABy/qLabx2/lYwFCXiSiwwWRmjO167lRdYo4nfuqPzENDKIrKQWOd2vx
        arpPjvRvcrRDE0E0fZd4qF6rUBEVf3fRjwi2Qw==
X-Google-Smtp-Source: APBJJlHKU/y3Hydryo1gEqB+hgkapodjXTtcVwuLvGL97mmWcIK8NK2WZ/A2myqHn1MzIpVHXvorjRmwug36+hhkpzg=
X-Received: by 2002:a2e:3508:0:b0:2b6:98c3:7a70 with SMTP id
 z8-20020a2e3508000000b002b698c37a70mr2838320ljz.41.1688158985189; Fri, 30 Jun
 2023 14:03:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230609183056.1765183-1-robh@kernel.org>
In-Reply-To: <20230609183056.1765183-1-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 30 Jun 2023 15:02:52 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLTc_9Yujp=wJjjn7P5YwAFZ9fn2SU6ey1q_gY3MFp9TA@mail.gmail.com>
Message-ID: <CAL_JsqLTc_9Yujp=wJjjn7P5YwAFZ9fn2SU6ey1q_gY3MFp9TA@mail.gmail.com>
Subject: Re: [PATCH] fsi: Use of_property_read_reg() to parse "reg"
To:     Jeremy Kerr <jk@ozlabs.org>, Joel Stanley <joel@jms.id.au>,
        Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>
Cc:     linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 9, 2023 at 12:31=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> Use the recently added of_property_read_reg() helper to get the
> untranslated "reg" address value.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/fsi/fsi-core.c | 39 +++++++++------------------------------
>  1 file changed, 9 insertions(+), 30 deletions(-)

Ping!

>
> diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
> index 0b927c9f4267..19c4d5b3bde9 100644
> --- a/drivers/fsi/fsi-core.c
> +++ b/drivers/fsi/fsi-core.c
> @@ -16,6 +16,7 @@
>  #include <linux/idr.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_address.h>
>  #include <linux/slab.h>
>  #include <linux/bitops.h>
>  #include <linux/cdev.h>
> @@ -415,28 +416,18 @@ EXPORT_SYMBOL_GPL(fsi_slave_release_range);
>  static bool fsi_device_node_matches(struct device *dev, struct device_no=
de *np,
>                 uint32_t addr, uint32_t size)
>  {
> -       unsigned int len, na, ns;
> -       const __be32 *prop;
> -       uint32_t psize;
> +       u64 paddr, psize;
>
> -       na =3D of_n_addr_cells(np);
> -       ns =3D of_n_size_cells(np);
> -
> -       if (na !=3D 1 || ns !=3D 1)
> -               return false;
> -
> -       prop =3D of_get_property(np, "reg", &len);
> -       if (!prop || len !=3D 8)
> +       if (of_property_read_reg(np, 0, &paddr, &psize))
>                 return false;
>
> -       if (of_read_number(prop, 1) !=3D addr)
> +       if (paddr !=3D addr)
>                 return false;
>
> -       psize =3D of_read_number(prop + 1, 1);
>         if (psize !=3D size) {
>                 dev_warn(dev,
> -                       "node %s matches probed address, but not size (go=
t 0x%x, expected 0x%x)",
> -                       of_node_full_name(np), psize, size);
> +                       "node %pOF matches probed address, but not size (=
got 0x%llx, expected 0x%x)",
> +                       np, psize, size);
>         }
>
>         return true;
> @@ -653,24 +644,12 @@ static void fsi_slave_release(struct device *dev)
>  static bool fsi_slave_node_matches(struct device_node *np,
>                 int link, uint8_t id)
>  {
> -       unsigned int len, na, ns;
> -       const __be32 *prop;
> -
> -       na =3D of_n_addr_cells(np);
> -       ns =3D of_n_size_cells(np);
> -
> -       /* Ensure we have the correct format for addresses and sizes in
> -        * reg properties
> -        */
> -       if (na !=3D 2 || ns !=3D 0)
> -               return false;
> +       u64 addr;
>
> -       prop =3D of_get_property(np, "reg", &len);
> -       if (!prop || len !=3D 8)
> +       if (of_property_read_reg(np, 0, &addr, NULL))
>                 return false;
>
> -       return (of_read_number(prop, 1) =3D=3D link) &&
> -               (of_read_number(prop + 1, 1) =3D=3D id);
> +       return addr =3D=3D (((u64)link << 32) | id);
>  }
>
>  /* Find a matching node for the slave at (link, id). Returns NULL if non=
e
> --
> 2.39.2
>
