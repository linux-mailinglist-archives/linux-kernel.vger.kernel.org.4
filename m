Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F2367C4EC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 08:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjAZHct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 02:32:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjAZHcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 02:32:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A4510C5;
        Wed, 25 Jan 2023 23:32:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE89A616E8;
        Thu, 26 Jan 2023 07:32:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C726C433EF;
        Thu, 26 Jan 2023 07:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674718364;
        bh=uJex7Agm+AtQyHaWdclWSJ1h9HW1dSHugJEqVU/QF5I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bgTvrhPiOZTU1IGYW325iwByxCRk3IW1x4zTic5wg/b8nP+Na0XmPahlFKUG/nVtR
         LyHYWWLbwiYm0SEynmb8eoe318tgfEQ7UpAUgRhQPAEvwTJo39KJFwn1f8eZUVaxOr
         vZNyvJCg/FrNwjOMEHZvIqjoc+3RPTJ5oLBTzCSIIAK4tjY/vUGxvkD+SXtyIrW+C0
         R3u9Yb+A3JHm14ALSD5D/p7k1x10CoV0ivHvsprWFrclE9dL3iK1koaPm/hoTNmSIe
         GiSSil4yjvt125YQ/uTrHaZ5SMTZl4R25CdVYI5JFryJrpHZe+q8GUPJpzsRpgTO9S
         Yv4Mled7swbgA==
Date:   Thu, 26 Jan 2023 15:32:36 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Philippe Schenker <dev@pschenker.ch>
Cc:     devicetree@vger.kernel.org,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mm-verdin: Do not power down eth-phy
Message-ID: <20230126073235.GU20713@T480>
References: <20230116140153.23938-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116140153.23938-1-dev@pschenker.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 03:01:52PM +0100, Philippe Schenker wrote:
> From: Philippe Schenker <philippe.schenker@toradex.com>
> 
> Currently if suspending using either freeze or memory state, the fec
> driver tries to power down the phy which leads to crash of the kernel
> and non-responsible kernel with the following call trace:
> 
> [   24.839889 ] Call trace:
> [   24.839892 ]  phy_error+0x18/0x60
> [   24.839898 ]  kszphy_handle_interrupt+0x6c/0x80
> [   24.839903 ]  phy_interrupt+0x20/0x2c
> [   24.839909 ]  irq_thread_fn+0x30/0xa0
> [   24.839919 ]  irq_thread+0x178/0x2c0
> [   24.839925 ]  kthread+0x154/0x160
> [   24.839932 ]  ret_from_fork+0x10/0x20
> 
> Since there is currently no functionality in the phy subsystem to power
> down phys let's just disable the feature of powering-down the ethernet
> phy.
> 
> Fixes: 6a57f224f734 ("arm64: dts: freescale: add initial support for verdin imx8m mini")
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

Applied, thanks!
