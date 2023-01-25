Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA44867BDCC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 22:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234783AbjAYVMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 16:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjAYVLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 16:11:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53CD62D09;
        Wed, 25 Jan 2023 13:11:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A001B81BA0;
        Wed, 25 Jan 2023 21:10:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F165C433D2;
        Wed, 25 Jan 2023 21:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674681058;
        bh=2xyucpV9NpzkKbccAToDq9c1AviJ3RxxcHz01+de8rA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Bd+EjrsqXmDWNSNrE4qIujUMCUyTzxw827dCbOyzsSOQMcDHBSZgdNyuge1lAzrel
         hIItPItgM19jakg7qWSPRIjuqG34/AhwpMwfpWYsc0f9U7TAVFMrNVTj2qPSsmHFBF
         Uy26IGdshltegEK3z2zGnkwZSTCM+RmzQAbQ+gmWwK2mWTikz4Krie9nTTB5oMxRgH
         Xkd6OVr39DAniOWMUydZqXg6q6AKG1iVqdttXwFKbNWTS/2gFlCBQ2i5URTFhgvXZT
         CT1p0/GfInT3jDKQJfTwF5ZMgvOsihiP5aBBqw5aH5JzAjPVs8M8Nh5zhuyBQ8/bU4
         hGEBOqpgyRbIw==
Message-ID: <1fc8686b0b66c3b3ff80c044ecf1add6.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230101175740.1010258-1-dario.binacchi@amarulasolutions.com>
References: <20230101175740.1010258-1-dario.binacchi@amarulasolutions.com>
Subject: Re: [RFC PATCH v2 00/11] clk: imx8mn: setup clocks from the device tree
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     angelo@amarulasolutions.com, michael@amarulasolutions.com,
        tommaso.merciai@amarulasolutions.com,
        Chen-Yu Tsai <wenst@chromium.org>,
        linux-amarula@amarulasolutions.com, anthony@amarulasolutions.com,
        jagan@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Adam Ford <aford173@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Jun <jun.li@nxp.com>, Lucas Stach <l.stach@pengutronix.de>,
        Marek Vasut <marex@denx.de>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        linux-kernel@vger.kernel.org
Date:   Wed, 25 Jan 2023 13:10:55 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dario Binacchi (2023-01-01 09:57:29)
> The idea for this series was born back from Dublin (ELCE 2022) after
> having attended the talk entitled "Updating and Modernizing Clock
> Drivers" held by Chen-Yu Tsai and the availability of a board with
> imx8mn SOC.

Interesting. I didn't see any mention of putting clks into DT in that
presentation.

>=20
> This series aims to setup all imx8mn's clocks from the device tree and
> remove the legacy setup code with hardwired parameters.

Please, no! We don't want one node per clk style of bindings.
