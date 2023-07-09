Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D51A74C064
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 04:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjGICVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 22:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGICVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 22:21:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E64D3;
        Sat,  8 Jul 2023 19:21:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C9B360B6D;
        Sun,  9 Jul 2023 02:21:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC758C433C7;
        Sun,  9 Jul 2023 02:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688869308;
        bh=UmrFF+XDF6SC1pFdHEgExTSMmKr5o6ffllbQ1WUEbj0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MTLmIcBa5l+iltAZ7P7YoQ/4lMJO8LNT1IMQ57sKDHmWwWl8t7yVBOgJzUPwUug1B
         YLElHbknzVX0D/MlIhZzykoeRyGOxRjkc1Bgq8QQnE8wD83OlNUROBIm1gBu2SWCAO
         bH44BjE9+zvPR05Sst5A3UbAcZAKptv6qf/slv0UDVsTvnY072BCL6BTtdzWvJWm1y
         f+cYbz/hAtBLDUy5CAv/kGeoKqHzNDBrc7xbF+o9XiE4FPrvwtLH2Fp50ruejqlMAB
         RLopefSRM4/hs+mb/E4iEmK74+0NirZkjIBdY6O99JAFj5zHSInEEDJ+ztz62LuiTe
         ZN2n3IS0qGQMQ==
Date:   Sat, 8 Jul 2023 19:25:25 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     neil.armstrong@linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 03/18] soc: amlogic: Move power-domain drivers to the
 genpd dir
Message-ID: <deyyt5r2wkxo7ily434gl3wudls2sbinkmnehssqshwnbzmlwf@lmqskj6zwfu2>
References: <20230707140434.723349-1-ulf.hansson@linaro.org>
 <20230707140434.723349-4-ulf.hansson@linaro.org>
 <0c8938a9-7a26-bf97-51ee-0c271901ec21@linaro.org>
 <CAPDyKFrOye96GyHS0tiTQ02Ve5S6Crtk8=bMsRS9Ljj=h5-nWQ@mail.gmail.com>
 <1496b9c1-289a-c354-f0ae-e14fd4c9bcfa@linaro.org>
 <CAPDyKFr7Mqy5bisLcxcA_iEGWqL8SFt2mDDng7zYEaTD1vNisA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFr7Mqy5bisLcxcA_iEGWqL8SFt2mDDng7zYEaTD1vNisA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 05:27:39PM +0200, Ulf Hansson wrote:
> On Fri, 7 Jul 2023 at 17:12, <neil.armstrong@linaro.org> wrote:
> >
> > On 07/07/2023 16:54, Ulf Hansson wrote:
> > > On Fri, 7 Jul 2023 at 16:42, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> > >>
> > >> Hi,
> > >>
> > >> On 07/07/2023 16:04, Ulf Hansson wrote:
> > >>> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> > >>> Cc: Kevin Hilman <khilman@baylibre.com>
> > >>> Cc: Jerome Brunet <jbrunet@baylibre.com>
> > >>> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > >>> Cc: <linux-amlogic@lists.infradead.org>
> > >>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > >>> ---
> > >>>    MAINTAINERS                                        | 1 +
> > >>>    drivers/genpd/Makefile                             | 1 +
> > >>>    drivers/genpd/amlogic/Makefile                     | 4 ++++
> > >>>    drivers/{soc => genpd}/amlogic/meson-ee-pwrc.c     | 0
> > >>>    drivers/{soc => genpd}/amlogic/meson-gx-pwrc-vpu.c | 0
> > >>>    drivers/{soc => genpd}/amlogic/meson-secure-pwrc.c | 0
> > >>>    drivers/soc/Makefile                               | 1 -
> > >>>    drivers/soc/amlogic/Makefile                       | 3 ---
> > >>>    8 files changed, 6 insertions(+), 4 deletions(-)
> > >>>    create mode 100644 drivers/genpd/amlogic/Makefile
> > >>>    rename drivers/{soc => genpd}/amlogic/meson-ee-pwrc.c (100%)
> > >>>    rename drivers/{soc => genpd}/amlogic/meson-gx-pwrc-vpu.c (100%)
> > >>>    rename drivers/{soc => genpd}/amlogic/meson-secure-pwrc.c (100%)
> > >>>
> > >>> diff --git a/MAINTAINERS b/MAINTAINERS
> > >>> index 588769fab516..9b8c9ae2375d 100644
> > >>> --- a/MAINTAINERS
> > >>> +++ b/MAINTAINERS
> > >>> @@ -1843,6 +1843,7 @@ F:      Documentation/devicetree/bindings/phy/amlogic*
> > >>>    F:  arch/arm/boot/dts/amlogic/
> > >>>    F:  arch/arm/mach-meson/
> > >>>    F:  arch/arm64/boot/dts/amlogic/
> > >>> +F:   drivers/genpd/amlogic/
> > >>>    F:  drivers/mmc/host/meson*
> > >>>    F:  drivers/phy/amlogic/
> > >>>    F:  drivers/pinctrl/meson/
> > >>> diff --git a/drivers/genpd/Makefile b/drivers/genpd/Makefile
> > >>> index a2d5b2095915..cdba3b9f0c75 100644
> > >>> --- a/drivers/genpd/Makefile
> > >>> +++ b/drivers/genpd/Makefile
> > >>> @@ -1,2 +1,3 @@
> > >>>    # SPDX-License-Identifier: GPL-2.0-only
> > >>>    obj-y                                       += actions/
> > >>> +obj-y                                        += amlogic/
> > >>> diff --git a/drivers/genpd/amlogic/Makefile b/drivers/genpd/amlogic/Makefile
> > >>> new file mode 100644
> > >>> index 000000000000..3d58abd574f9
> > >>> --- /dev/null
> > >>> +++ b/drivers/genpd/amlogic/Makefile
> > >>> @@ -0,0 +1,4 @@
> > >>> +# SPDX-License-Identifier: GPL-2.0-only
> > >>> +obj-$(CONFIG_MESON_GX_PM_DOMAINS) += meson-gx-pwrc-vpu.o
> > >>> +obj-$(CONFIG_MESON_EE_PM_DOMAINS) += meson-ee-pwrc.o
> > >>> +obj-$(CONFIG_MESON_SECURE_PM_DOMAINS) += meson-secure-pwrc.o
> > >>> diff --git a/drivers/soc/amlogic/meson-ee-pwrc.c b/drivers/genpd/amlogic/meson-ee-pwrc.c
> > >>> similarity index 100%
> > >>> rename from drivers/soc/amlogic/meson-ee-pwrc.c
> > >>> rename to drivers/genpd/amlogic/meson-ee-pwrc.c
> > >>> diff --git a/drivers/soc/amlogic/meson-gx-pwrc-vpu.c b/drivers/genpd/amlogic/meson-gx-pwrc-vpu.c
> > >>> similarity index 100%
> > >>> rename from drivers/soc/amlogic/meson-gx-pwrc-vpu.c
> > >>> rename to drivers/genpd/amlogic/meson-gx-pwrc-vpu.c
> > >>> diff --git a/drivers/soc/amlogic/meson-secure-pwrc.c b/drivers/genpd/amlogic/meson-secure-pwrc.c
> > >>> similarity index 100%
> > >>> rename from drivers/soc/amlogic/meson-secure-pwrc.c
> > >>> rename to drivers/genpd/amlogic/meson-secure-pwrc.c
> > >>> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> > >>> index 3b0f9fb3b5c8..dc93e1762ca7 100644
> > >>> --- a/drivers/soc/Makefile
> > >>> +++ b/drivers/soc/Makefile
> > >>> @@ -23,7 +23,6 @@ obj-y                               += mediatek/
> > >>>    obj-y                               += microchip/
> > >>>    obj-y                               += nuvoton/
> > >>>    obj-y                               += pxa/
> > >>> -obj-y                                += amlogic/
> > >>>    obj-y                               += qcom/
> > >>>    obj-y                               += renesas/
> > >>>    obj-y                               += rockchip/
> > >>> diff --git a/drivers/soc/amlogic/Makefile b/drivers/soc/amlogic/Makefile
> > >>> index 7b8c5d323f5c..c25f835e6a26 100644
> > >>> --- a/drivers/soc/amlogic/Makefile
> > >>> +++ b/drivers/soc/amlogic/Makefile
> > >>> @@ -2,7 +2,4 @@
> > >>>    obj-$(CONFIG_MESON_CANVAS) += meson-canvas.o
> > >>>    obj-$(CONFIG_MESON_CLK_MEASURE) += meson-clk-measure.o
> > >>>    obj-$(CONFIG_MESON_GX_SOCINFO) += meson-gx-socinfo.o
> > >>> -obj-$(CONFIG_MESON_GX_PM_DOMAINS) += meson-gx-pwrc-vpu.o
> > >>>    obj-$(CONFIG_MESON_MX_SOCINFO) += meson-mx-socinfo.o
> > >>> -obj-$(CONFIG_MESON_EE_PM_DOMAINS) += meson-ee-pwrc.o
> > >>> -obj-$(CONFIG_MESON_SECURE_PM_DOMAINS) += meson-secure-pwrc.o
> > >>
> > >> I've a few changes for v6.6, how shall we handle that ?
> > >
> > > I think we should continue to use the soc tree until v6.6-rc1 (or if
> > > Arnd have some other ideas), there are some more thoughts around this
> > > in the cover letter.
> > >
> > > Beyond v6.6-rc1 I plan to help with maintenance in practice  and run
> > > my own separate git tree.
> >
> > If it helps I can send you a PR with only the pwrc changes you can merge
> > before applying this serie.
> 
> Right, that could be a good idea, but let's defer to Arnd before we
> agree on the way forward.
> 

How about sharing an immutable branch/tag with patch 1, then each one of
us can merge that together with the soc-specific change, followed by any
subsequent patches - leading up to the next merge window.

Stephen will have a merge conflict in drivers/genpd/Makefile as each
soc-specific addition comes in, and Arnd will see this conflict too. But
this is going to be extremely trivial. But apart from this, there will
not be any conflicts or additional branching constraints for us...

Regards,
Bjorn

> Kind regards
> Uffe
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
