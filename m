Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCA2701D64
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 14:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjENMe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 08:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233374AbjENMeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 08:34:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E911720;
        Sun, 14 May 2023 05:33:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6961760C36;
        Sun, 14 May 2023 12:33:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A210AC433D2;
        Sun, 14 May 2023 12:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684067587;
        bh=AzG1oDP2QNpE56f3L42i0CWCxEUo48upCnG8OUaznxg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D5i29ks6e+H0ILOuikkiPY0jO9lKuAsJzC8/EuHMSnoEVRDABYkJmc9bd8NAOKb5W
         1Q83PXjNUh9hnHSgJq6jCq02DDX4RGJGgc5k68GjomV3riJryGP3vBz3RM56sx9cY+
         CYmjZYxO8Ko9r2TMDZQsM7AQA+WSiwzIigaSx2fVw8yCjEWt1XgRR89X0C9nT6PcQM
         grc5iFohzHFBNcGOay8Gj6R8n3GDbHmn2d6n33LJx6O0OtUxwQ/Yw8HzxDpX20I79D
         hbebp/CdAGq2Fqcd4XXWwxCBrFyNWF5KkGkdsZsVIPNrMOVgz9i3qG3qfjKykjqbJA
         7WY7o/vh4FYDw==
Date:   Sun, 14 May 2023 20:32:53 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] arm64: dts: imx8mn: Fix video clock parents
Message-ID: <20230514123253.GS727834@dragon>
References: <20230423123513.1346323-1-aford173@gmail.com>
 <20230514035806.GR727834@dragon>
 <CAHCN7x+evo1mJaBUdx5pe5rnG2A8dkmf4myXJcK7mas7nZMwxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHCN7x+evo1mJaBUdx5pe5rnG2A8dkmf4myXJcK7mas7nZMwxg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 13, 2023 at 11:23:04PM -0500, Adam Ford wrote:
> On Sat, May 13, 2023 at 10:58 PM Shawn Guo <shawnguo@kernel.org> wrote:
> >
> > On Sun, Apr 23, 2023 at 07:35:13AM -0500, Adam Ford wrote:
> > > There are a few clocks whose parents are set in mipi_dsi
> > > and mxsfb nodes, but these clocks are used by the disp_blk_ctrl
> > > power domain which may cause an issue when re-parenting, resuling
> > > in a disp_pixel clock having the wrong parent and wrong rate.
> > >
> > > Fix this by moving the assigned-clock-parents as associate clock
> > > assignments to the power-domain node to setup these clocks before
> > > they are enabled.
> > >
> > > Fixes: d825fb6455d5 ("arm64: dts: imx8mn: Add display pipeline components")
> > > Signed-off-by: Adam Ford <aford173@gmail.com>
> >
> > Is it a fix for v6.4-rc or material for -next?
> 
> The Samsung DSI driver for Nano is in 6.4, and an attempt was made to
> setup the device tree in 6.4.  While I don't think there are users of
> this yet, if people try to add DT entries in their boards, they might
> struggle getting the video working if this isn't applied since the
> disp1_pix clock may be stuck at 24MHz which likely won't sync much if
> any displays.

Ok, applied for v6.4-rc, thanks!
