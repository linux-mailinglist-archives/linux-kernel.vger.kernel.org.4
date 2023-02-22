Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A00F69FD99
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 22:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjBVVPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 16:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjBVVPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 16:15:09 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D235323850;
        Wed, 22 Feb 2023 13:15:07 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id cq23so35592019edb.1;
        Wed, 22 Feb 2023 13:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hpkcdj31Kp+64I0H+8QjpzTiuX76hZTeMvrWdpVOt4=;
        b=Y95tEBQTvJnja0wiaBFlONHEPFFpg4E5Aidd7Wxu88GO6+Efw9s32CSm6Qrv+mXXKE
         i5+x1nQprf7tfF0IcJzKPjG26LQSm8lVS+CQndNmsIeuLxTz3Zws+u23ldaG3K54+WIL
         IKeo6NJCJ7WchtpfymyIpeNWai8L7kAy3lwcxu51e9DNdYZrZ0f3D1Sw8ivAk+CfDKS3
         Ek4oq62+5hOyx3h0ySU4oZmDiESIURoGhUvHFCUOXpdaqhWIldAEFOJmG9Rfku2zdt2S
         XHD98cqCLTBp5a+c55IWJPbpd06egfIFbD37YQMjJACS4ZlT8leLyYR4DAvtMaXLTN/X
         IY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hpkcdj31Kp+64I0H+8QjpzTiuX76hZTeMvrWdpVOt4=;
        b=zFAf1yRH4XcebMdO9ryebkSDBWBEnFLHAGJsQXXMzZ133pTbyCRE+RRTEc7uHdcwvO
         vUuVP33X3rljzPYGO7RcGZAWaobL6CkaY/WYw4bEELP47iMydj/ZdoeUSkHIzHNaKago
         IVLgAdMneJncMvj6BbkCCLt0LCzKNNwYvnUgLMKk0PbqFy7K3YPm+AKobU0nE7IqJfHD
         j9QDZZwPRNEvAssNPHrzeTPfOjiher8+XFaqZyMbWAezF+/Yt8eEzwe8LiDXtdWtG+/n
         8mg4oveXCADSSceWWB9tME0p0Z8U/xZtel+9/7GgB0EPSq9i4KoA9K+XC4TYmHKVn+Oy
         205w==
X-Gm-Message-State: AO0yUKXexSyQcXdjIuftF4wC2Pr6hFgZ0YiIr+J/uCocFL5FC5fsF2P6
        JNo9NoJEHSscsXNCoFqoAFR4BfXb9sTgbMYBSXg=
X-Google-Smtp-Source: AK7set8TXb46bTmDPfzW/xczn6QfGU7MdMXPRf/CaO6cyWdNx+3X84yvibHTXzLWWA/EAH5iiZY+OShEAAHjsEGwRMc=
X-Received: by 2002:a50:f611:0:b0:4ac:b7c1:9109 with SMTP id
 c17-20020a50f611000000b004acb7c19109mr4476929edn.6.1677100506156; Wed, 22 Feb
 2023 13:15:06 -0800 (PST)
MIME-Version: 1.0
References: <20230221145021.31993-1-zajec5@gmail.com> <CAFBinCDxB=xtz9mtZupBC7J5oxknN1ENHzJ-cFxX4FTDSgZeFQ@mail.gmail.com>
 <101a5bdf-870a-a1bb-954d-1d675ecad5a7@gmail.com>
In-Reply-To: <101a5bdf-870a-a1bb-954d-1d675ecad5a7@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 22 Feb 2023 22:14:55 +0100
Message-ID: <CAFBinCDcDYtdOdikc2ieXjRUkrjgwNKaPYvYZb_v84gh66q=bw@mail.gmail.com>
Subject: Re: [PATCH] nvmem: add explicit config option to read OF fixed cells
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
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
        linux-sunxi@lists.linux.dev, linux-rtc@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rafa=C5=82,

On Tue, Feb 21, 2023 at 11:29 PM Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com>=
 wrote:
[...]
> > I am not familiar with the recent changes around dynamic cells.
> > Is there any discussion/summary that I can read to get up to speed?
>
> Some NVMEM devices don't store specific data at hardcoded offsets. For
> such devices we have drivers (to become: layouts) that parse their magic
> content. They discover cells and register them and provide matching with
> proper DT nodes.
>
> For bindings see:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D084973e944bec21804f8afb0515b25434438699a
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Da607a850ba1fa966cbb035544c1588e24a6307df
>
> For example driver see:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D6e977eaa8280e957b87904b536661550f2a6b3e8
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D207775f7e17b8fd0426a2ac4a5b81e4e1d71849e
>
> For usage see:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Dc8442f0fb09ca3d842b9b23d1d0650f649fd10f8
Thanks, that makes things clearer for me!

> > My main thought is: if there are many "fixed OF cells" implementations
> > and only a few "dynamic" ones - does it make sense to flip the logic
> > and introduce a new "use_dynamic_of_cells" flag instead?
>
> The problem is that there are more cases than just two. We can have:
> 1. No cells at all
> 2. Fixed cells in DT
> 3. Dynamic cells with references in DT
> 4. Driver specified cells (specified within config)
> 5. Cells defined in a global table
>
> So we need to reference DT cells explicitly (we can't just confirm /
> deny *dynamic* cells).
>
> Another solution would be to have "no_fixed_of_cells" but:
>
> 1. Personally I think negation is less clear / easy to follow
>
> 2. There may be actually more drivers with no fixed cells.
> I think I modified 18 drivers. It seems devm_nvmem_register() is
> referenced in 44 places. Few of them may be not actual users but it
> still seems to be about equal.
Thanks for this overview of all the special cases. Please add my:
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
for the following two drivers:
- drivers/nvmem/meson-efuse.c
- drivers/nvmem/meson-mx-efuse.c


Best regards,
Martin
