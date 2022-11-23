Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9340C635CC1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 13:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236363AbiKWMYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 07:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236200AbiKWMYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 07:24:46 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6872B5D690;
        Wed, 23 Nov 2022 04:24:43 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 126D11BF20D;
        Wed, 23 Nov 2022 12:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1669206282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ksbDEwcn/WqCNdDfPl3SmDsE2JgqCGm9D5ujjgA+pLo=;
        b=I2i9I40oOzfLu6LGIFSJp7PZaZmahCUT1aegRH828jqh1t2TZ9HANsFJwxmuaU2AOIQVqS
        nx47WK9AHt8yqWE7aOlm+jJFupAmRyfJ74XGxBfru3TC5ghEllraJiJSspBpcsSjJpQBcj
        +UVNhva1N95KiTtbm9rH8fwDWcyJ154AA4r5KY3IFYwWHmbbWr+K1lJtDqmCSaIMl5xJUB
        dfKrQpph48LUHP1S/cqs4/hUxGqwODgnTWhM/HRDnmfNGOv09OgBEidIjCYfuKizl6KFtA
        0IBU7tCAdIk/NZpXa1m8S/InrE1n3hWHc+5g4txPYVlvqLdEJrQ3sbODQXZMPw==
Date:   Wed, 23 Nov 2022 13:24:40 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Michael Walle <michael@walle.cc>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] of: property: special #nvmem-cell-cells handling
Message-ID: <20221123132440.7ec3f7f5@xps-13>
In-Reply-To: <CAL_Jsq+CT00AHOK8Nxe_kUa6F_OcgxW4BL10iWWwKCJNwbTsAw@mail.gmail.com>
References: <8b976cf546bad3aa159a6f05cd3c15d1@walle.cc>
        <20221118214036.1269005-1-michael@walle.cc>
        <CAL_JsqKnuycUSHfxxcZMcidELA-ttZUv5NhV5ApkpUQMsc-aQQ@mail.gmail.com>
        <fc101fbe1d8c94587a22d24a96e4dfb7@walle.cc>
        <CAL_Jsq+CT00AHOK8Nxe_kUa6F_OcgxW4BL10iWWwKCJNwbTsAw@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob, Michael,

robh+dt@kernel.org wrote on Tue, 22 Nov 2022 17:44:26 -0600:

> On Fri, Nov 18, 2022 at 4:03 PM Michael Walle <michael@walle.cc> wrote:
> >
> > Am 2022-11-18 22:52, schrieb Rob Herring: =20
> > > On Fri, Nov 18, 2022 at 3:40 PM Michael Walle <michael@walle.cc> wrot=
e: =20
> > >>
> > >> Since recently, there is a new #nvmem-cell-cells. To be backwards
> > >> compatible this is optional. Therefore, we need special handling and
> > >> cannot use DEFINE_SIMPLE_PROP() anymore.
> > >>
> > >> Signed-off-by: Michael Walle <michael@walle.cc>
> > >> ---
> > >> This patch will be part of the following series:
> > >> https://lore.kernel.org/linux-arm-kernel/20221118185118.1190044-1-mi=
chael@walle.cc/
> > >>
> > >>  drivers/of/property.c | 17 ++++++++++++++++-
> > >>  1 file changed, 16 insertions(+), 1 deletion(-)
> > >>
> > >> diff --git a/drivers/of/property.c b/drivers/of/property.c
> > >> index 967f79b59016..93c0ea662336 100644
> > >> --- a/drivers/of/property.c
> > >> +++ b/drivers/of/property.c
> > >> @@ -1305,7 +1305,6 @@ DEFINE_SIMPLE_PROP(dmas, "dmas", "#dma-cells")
> > >>  DEFINE_SIMPLE_PROP(power_domains, "power-domains",
> > >> "#power-domain-cells")
> > >>  DEFINE_SIMPLE_PROP(hwlocks, "hwlocks", "#hwlock-cells")
> > >>  DEFINE_SIMPLE_PROP(extcon, "extcon", NULL)
> > >> -DEFINE_SIMPLE_PROP(nvmem_cells, "nvmem-cells", NULL)
> > >>  DEFINE_SIMPLE_PROP(phys, "phys", "#phy-cells")
> > >>  DEFINE_SIMPLE_PROP(wakeup_parent, "wakeup-parent", NULL)
> > >>  DEFINE_SIMPLE_PROP(pinctrl0, "pinctrl-0", NULL)
> > >> @@ -1381,6 +1380,22 @@ static struct device_node
> > >> *parse_interrupts(struct device_node *np,
> > >>         return of_irq_parse_one(np, index, &sup_args) ? NULL :
> > >> sup_args.np;
> > >>  }
> > >>
> > >> +static struct device_node *parse_nvmem_cells(struct device_node *np,
> > >> +                                            const char *prop_name,
> > >> int index)
> > >> +{
> > >> +       struct of_phandle_args sup_args;
> > >> +
> > >> +       if (strcmp(prop_name, "nvmem-cells"))
> > >> +               return NULL;
> > >> +
> > >> +       if (of_parse_phandle_with_optional_args(np, prop_name,
> > >> +                                               "#nvmem-cell-cells",
> > >> index,
> > >> +                                               &sup_args))
> > >> +               return NULL;
> > >> +
> > >> +       return sup_args.np;
> > >> +} =20
> > >
> > > There's a couple of other cases like that (MSI IIRC), so can we
> > > generalize this to work in more than 1 case? =20
> >
> > You mean addding a new DEFINE_SIMPLE_PROP_OPTIONAL_ARGS()? =20
>=20
> Actually, I think you can just do something like the below. I don't
> think we need to separately handle an optional #.*-cells and a
> required one. It's really just validation which we do already both
> with the tools and when the subsystems parse these bindings. Of
> course, if we need to handle cases other than 0 default cells, we'll
> have to restructure the define some to pass the default cells.
>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 967f79b59016..198f56633eb0 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1254,7 +1254,7 @@ static struct device_node
> *parse_suffix_prop_cells(struct device_node *np,
>         if (strcmp_suffix(prop_name, suffix))
>                 return NULL;
>=20
> -       if (of_parse_phandle_with_args(np, prop_name, cells_name, index,
> +       if (__of_parse_phandle_with_args(np, prop_name, cells_name, 0, in=
dex,
>                                        &sup_args))
>                 return NULL;

Excellent, this small change aside with

	-DEFINE_SIMPLE_PROP(nvmem_cells, "nvmem-cells", NULL)
	+DEFINE_SIMPLE_PROP(nvmem_cells, "nvmem-cells", "#nvmem-cell-cells")

look much simpler and work perfectly.

Tested-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
