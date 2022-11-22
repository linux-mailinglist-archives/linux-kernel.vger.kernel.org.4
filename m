Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1DF0634B52
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 00:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234937AbiKVXon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 18:44:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbiKVXok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 18:44:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED389C723E;
        Tue, 22 Nov 2022 15:44:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95FDFB81CEF;
        Tue, 22 Nov 2022 23:44:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50CF7C433D7;
        Tue, 22 Nov 2022 23:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669160675;
        bh=s223SP/RFpQY9lN8EX5vF1WrFIPun8dMRy1bOsGbAoc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qYSBPvDPItWGMvlA77rGvB7+sa4DKveQ/aAPrBMFC1HzImpQ75hrlOXVBO/RTWRsZ
         PMKB5MHlU4iaOJXk9F9VxHM6o9r73VLgf9ZpYYbcnMvFMS/CjlTjt2ScbCekeO8q7L
         Q5+y4FhxGZWdO6GbbPj53V35FEkqWAbUdptnYc1JZ/99YVwE18D/DB6b8tWI3dGvoq
         qoq3BrR3FdGuciro3kB9MczF0chyIEkxaM24CkwNwdEMriKGEGRTKO5+SZC9c8u+8Q
         9Hk3ZT65eImsO0WbWaNmZJOucDW6amjs8vWO9zbeWMEMOcyO/SId9XTaZ4zCmEtzKY
         ByyoviCE0dXDg==
Received: by mail-vs1-f48.google.com with SMTP id 124so2726319vsv.4;
        Tue, 22 Nov 2022 15:44:35 -0800 (PST)
X-Gm-Message-State: ANoB5plEIr2/zUwS5+hhDv2Qh0Dz8Y6N9PHZ86kh6+ldt5CsWDqcSyED
        tmJcb5p1Ty7KaD1p9ELyGROFLti8Tg9Cv2Wlug==
X-Google-Smtp-Source: AA0mqf6P+opwsUO66iJ1El9JrVnB1tLV47UN9xEcWQO0bvTAgyfeeZBhMkAXsXAjF0Exc1LyI6sR9OTxKeZqP4PgXwM=
X-Received: by 2002:a05:6102:3003:b0:3aa:2ac7:5956 with SMTP id
 s3-20020a056102300300b003aa2ac75956mr6359328vsa.6.1669160674196; Tue, 22 Nov
 2022 15:44:34 -0800 (PST)
MIME-Version: 1.0
References: <8b976cf546bad3aa159a6f05cd3c15d1@walle.cc> <20221118214036.1269005-1-michael@walle.cc>
 <CAL_JsqKnuycUSHfxxcZMcidELA-ttZUv5NhV5ApkpUQMsc-aQQ@mail.gmail.com> <fc101fbe1d8c94587a22d24a96e4dfb7@walle.cc>
In-Reply-To: <fc101fbe1d8c94587a22d24a96e4dfb7@walle.cc>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 22 Nov 2022 17:44:26 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+CT00AHOK8Nxe_kUa6F_OcgxW4BL10iWWwKCJNwbTsAw@mail.gmail.com>
Message-ID: <CAL_Jsq+CT00AHOK8Nxe_kUa6F_OcgxW4BL10iWWwKCJNwbTsAw@mail.gmail.com>
Subject: Re: [PATCH] of: property: special #nvmem-cell-cells handling
To:     Michael Walle <michael@walle.cc>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 4:03 PM Michael Walle <michael@walle.cc> wrote:
>
> Am 2022-11-18 22:52, schrieb Rob Herring:
> > On Fri, Nov 18, 2022 at 3:40 PM Michael Walle <michael@walle.cc> wrote:
> >>
> >> Since recently, there is a new #nvmem-cell-cells. To be backwards
> >> compatible this is optional. Therefore, we need special handling and
> >> cannot use DEFINE_SIMPLE_PROP() anymore.
> >>
> >> Signed-off-by: Michael Walle <michael@walle.cc>
> >> ---
> >> This patch will be part of the following series:
> >> https://lore.kernel.org/linux-arm-kernel/20221118185118.1190044-1-michael@walle.cc/
> >>
> >>  drivers/of/property.c | 17 ++++++++++++++++-
> >>  1 file changed, 16 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/of/property.c b/drivers/of/property.c
> >> index 967f79b59016..93c0ea662336 100644
> >> --- a/drivers/of/property.c
> >> +++ b/drivers/of/property.c
> >> @@ -1305,7 +1305,6 @@ DEFINE_SIMPLE_PROP(dmas, "dmas", "#dma-cells")
> >>  DEFINE_SIMPLE_PROP(power_domains, "power-domains",
> >> "#power-domain-cells")
> >>  DEFINE_SIMPLE_PROP(hwlocks, "hwlocks", "#hwlock-cells")
> >>  DEFINE_SIMPLE_PROP(extcon, "extcon", NULL)
> >> -DEFINE_SIMPLE_PROP(nvmem_cells, "nvmem-cells", NULL)
> >>  DEFINE_SIMPLE_PROP(phys, "phys", "#phy-cells")
> >>  DEFINE_SIMPLE_PROP(wakeup_parent, "wakeup-parent", NULL)
> >>  DEFINE_SIMPLE_PROP(pinctrl0, "pinctrl-0", NULL)
> >> @@ -1381,6 +1380,22 @@ static struct device_node
> >> *parse_interrupts(struct device_node *np,
> >>         return of_irq_parse_one(np, index, &sup_args) ? NULL :
> >> sup_args.np;
> >>  }
> >>
> >> +static struct device_node *parse_nvmem_cells(struct device_node *np,
> >> +                                            const char *prop_name,
> >> int index)
> >> +{
> >> +       struct of_phandle_args sup_args;
> >> +
> >> +       if (strcmp(prop_name, "nvmem-cells"))
> >> +               return NULL;
> >> +
> >> +       if (of_parse_phandle_with_optional_args(np, prop_name,
> >> +                                               "#nvmem-cell-cells",
> >> index,
> >> +                                               &sup_args))
> >> +               return NULL;
> >> +
> >> +       return sup_args.np;
> >> +}
> >
> > There's a couple of other cases like that (MSI IIRC), so can we
> > generalize this to work in more than 1 case?
>
> You mean addding a new DEFINE_SIMPLE_PROP_OPTIONAL_ARGS()?

Actually, I think you can just do something like the below. I don't
think we need to separately handle an optional #.*-cells and a
required one. It's really just validation which we do already both
with the tools and when the subsystems parse these bindings. Of
course, if we need to handle cases other than 0 default cells, we'll
have to restructure the define some to pass the default cells.

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 967f79b59016..198f56633eb0 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1254,7 +1254,7 @@ static struct device_node
*parse_suffix_prop_cells(struct device_node *np,
        if (strcmp_suffix(prop_name, suffix))
                return NULL;

-       if (of_parse_phandle_with_args(np, prop_name, cells_name, index,
+       if (__of_parse_phandle_with_args(np, prop_name, cells_name, 0, index,
                                       &sup_args))
                return NULL;
