Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307386B110B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 19:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjCHSbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 13:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjCHSbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 13:31:39 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8B594F54;
        Wed,  8 Mar 2023 10:31:36 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9E339240005;
        Wed,  8 Mar 2023 18:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678300295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IE2mAjvNqXWB2ZmmfkBzebNZ3UKFN3Q87ghm1dunraM=;
        b=W9bpmY3/KK4H8XkPR5AErqDMuVx7gx1E72W3ekylox5c6Sb1rEoaG0nwEeCbQsUc6fByxS
        3PZpBawbq5O55tiA1JKMB5WB+fl+xGlvZNIIkCxD0BVegUIaYhJ86Z7HDmbu6JgNt7O36Q
        KczTEKWoIBBtiUPEE1mzlJ8L3xWUVUHSuQq9Fv2DewrgLpVSiS05S/U+XBCe5KjNrcLjrq
        zJjci2YlnX3uHUsv5p9FYMGHzDICiiJZDFiKjvNvjG0iu7BTOTVKX/AFVZKghFBpWyCpwD
        wYIXSzk/QdQeStQWTRLDE6ufZtwkm0Ub+sRPvLPoXU1/cVvB2P656eC6WpRDow==
Date:   Wed, 8 Mar 2023 19:31:21 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Vincent Shih <vincent.sunplus@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-sunxi@lists.linux.dev, linux-rtc@vger.kernel.org
Subject: Re: [PATCH V2] nvmem: add explicit config option to read OF fixed
 cells
Message-ID: <20230308193121.7f5b3d02@xps-13>
In-Reply-To: <5974d28426057975e701c4a8454b5a13@milecki.pl>
References: <20230224072903.20945-1-zajec5@gmail.com>
        <20230308173256.3837b87b@xps-13>
        <91ff425b4c901648b1faf34c784f20ad@milecki.pl>
        <20230308190636.7fabab9c@xps-13>
        <5974d28426057975e701c4a8454b5a13@milecki.pl>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafa=C5=82,

rafal@milecki.pl wrote on Wed, 08 Mar 2023 19:12:32 +0100:

> On 2023-03-08 19:06, Miquel Raynal wrote:
> > Hi Rafa=C5=82,
> >=20
> > rafal@milecki.pl wrote on Wed, 08 Mar 2023 17:55:46 +0100:
> >  =20
> >> On 2023-03-08 17:34, Miquel Raynal wrote: =20
> >> > Hi Rafa=C5=82,
> >> >
> >> > zajec5@gmail.com wrote on Fri, 24 Feb 2023 08:29:03 +0100:
> >> > =20
> >> >> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl> =20
> >> >> >> NVMEM subsystem looks for fixed NVMEM cells (specified in DT) by=
 =20
> >> >> default. This behaviour made sense in early days before adding supp=
ort
> >> >> for dynamic cells. =20
> >> >> >> With every new supported NVMEM device with dynamic cells current=
 =20
> >> >> behaviour becomes non-optimal. It results in unneeded iterating ove=
r >> DT
> >> >> nodes and may result in false discovery of cells (depending on used=
 DT
> >> >> properties). =20
> >> >> >> This behaviour has actually caused a problem already with the MT=
D =20
> >> >> subsystem. MTD subpartitions were incorrectly treated as NVMEM cell=
s. =20
> >> >
> >> > That's true, but I expect this to be really MTD specific.
> >> >
> >> > A concrete proposal below.
> >> > =20
> >> >> Also with upcoming support for NVMEM layouts no new binding or driv=
er
> >> >> should support fixed cells defined in device node. =20
> >> >
> >> > I'm not sure I agree with this statement. We are not preventing new
> >> > binding/driver to use fixed cells, or...? We offer a new way to expo=
se
> >> > nvmem cells with another way than "fixed-offset" and "fixed-size" OF
> >> > nodes. =20
> >> >>  From what I understood all new NVMEM bindings should have cells >>=
 defined =20
> >> in the nvmem-layout { } node. That's what I mean by saying they should
> >> not be defined in device node (but its "nvmem-layout" instead). =20
> >=20
> > Layouts are just another possibility, either you user the nvmem-cells
> > compatible and produce nvmem cells with fixed OF nodes, or you use the
> > nvmem-layout container. I don't think all new bindings should have
> > cells in layouts. It depends if the content is static or not.
> >  =20
> >> >> Solve this by modifying drivers for bindings that support specifying
> >> >> fixed NVMEM cells in DT. Make them explicitly tell NVMEM subsystem =
to
> >> >> read cells from DT. =20
> >> >> >> It wasn't clear (to me) if rtc and w1 code actually uses fixed c=
ells. >> I =20
> >> >> enabled them to don't risk any breakage. =20
> >> >> >> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl> =20
> >> >> [for drivers/nvmem/meson-{efuse,mx-efuse}.c]
> >> >> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> >> >> ---
> >> >> V2: Fix stm32-romem.c typo breaking its compilation
> >> >>     Pick Martin's Acked-by
> >> >>     Add paragraph about layouts deprecating use_fixed_of_cells
> >> >> ---
> >> >>  drivers/mtd/mtdcore.c          | 2 ++
> >> >>  drivers/nvmem/apple-efuses.c   | 1 +
> >> >>  drivers/nvmem/core.c           | 8 +++++---
> >> >>  drivers/nvmem/imx-ocotp-scu.c  | 1 +
> >> >>  drivers/nvmem/imx-ocotp.c      | 1 +
> >> >>  drivers/nvmem/meson-efuse.c    | 1 +
> >> >>  drivers/nvmem/meson-mx-efuse.c | 1 +
> >> >>  drivers/nvmem/microchip-otpc.c | 1 +
> >> >>  drivers/nvmem/mtk-efuse.c      | 1 +
> >> >>  drivers/nvmem/qcom-spmi-sdam.c | 1 +
> >> >>  drivers/nvmem/qfprom.c         | 1 +
> >> >>  drivers/nvmem/rave-sp-eeprom.c | 1 +
> >> >>  drivers/nvmem/rockchip-efuse.c | 1 +
> >> >>  drivers/nvmem/sc27xx-efuse.c   | 1 +
> >> >>  drivers/nvmem/sprd-efuse.c     | 1 +
> >> >>  drivers/nvmem/stm32-romem.c    | 1 +
> >> >>  drivers/nvmem/sunplus-ocotp.c  | 1 +
> >> >>  drivers/nvmem/sunxi_sid.c      | 1 +
> >> >>  drivers/nvmem/uniphier-efuse.c | 1 +
> >> >>  drivers/nvmem/zynqmp_nvmem.c   | 1 +
> >> >>  drivers/rtc/nvmem.c            | 1 +
> >> >>  drivers/w1/slaves/w1_ds250x.c  | 1 +
> >> >>  include/linux/nvmem-provider.h | 2 ++
> >> >>  23 files changed, 29 insertions(+), 3 deletions(-) =20
> >> >> >> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c =20
> >> >> index 0feacb9fbdac..1bb479c0f758 100644
> >> >> --- a/drivers/mtd/mtdcore.c
> >> >> +++ b/drivers/mtd/mtdcore.c
> >> >> @@ -523,6 +523,7 @@ static int mtd_nvmem_add(struct mtd_info *mtd)
> >> >>  	config.dev =3D &mtd->dev;
> >> >>  	config.name =3D dev_name(&mtd->dev);
> >> >>  	config.owner =3D THIS_MODULE;
> >> >> +	config.use_fixed_of_cells =3D of_device_is_compatible(node, >> "n=
vmem-cells"); =20
> >> >
> >> > I am wondering how mtd specific this is? For me all OF nodes contain=
ing
> >> > the nvmem-cells compatible should be treated as cells providers and
> >> > populate nvmem cells as for each children.
> >> >
> >> > Why don't we just check for this compatible to be present? in
> >> > nvmem_add_cells_from_of() ? And if not we just skip the operation.
> >> >
> >> > This way we still follow the bindings (even though using nvmem-cells=
 in
> >> > the compatible property to require cells population was a mistake in
> >> > the first place, as discussed in the devlink thread recently) but th=
ere
> >> > is no need for a per-driver config option? =20
> >> >> This isn't mtd specific. Please check this patch for all occurrence=
s >> of =20
> >> the:
> >> use_fixed_of_cells =3D true =20
> >> >> The very first one: drivers/nvmem/apple-efuses.c driver for the =20
> >> "apple,efuses" binding. That binding supports fixed OF cells, see:
> >> Documentation/devicetree/bindings/nvmem/apple,efuses.yaml =20
> >=20
> > I'm saying: based on what has been enforced so far, I would expect all
> > fixed cell providers to come with nvmem-cells as compatible, no?
> >=20
> > If that's the case we could use that as a common denominator? =20
>=20
> Sorry, I don't get it. Have you checked
> Documentation/devicetree/bindings/nvmem/apple,efuses.yaml
> ?
>=20
> It's a NVMEM provied binding with fixed cells that doesn't use
> nvmem-cells as compatible. There are many more.

Oh yeah you're right, I'm mixing things. Well I guess you're right
then, it's such a mess, we have to tell the core the parsing method.

So maybe another question: do we have other situations than mtd which
sometimes expect the nvmem core to parse the OF nodes to populate cells,
and sometimes not?

Also, what about "of_children_are_cells" ? Because actually in most
cases it's a "fixed of cell", so I don't find the current naming
descriptive enough for something so touchy.

Thanks, Miqu=C3=A8l
