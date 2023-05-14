Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF1F701D80
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 14:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234380AbjENM5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 08:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbjENM5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 08:57:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514671FCB;
        Sun, 14 May 2023 05:57:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1C9E6102D;
        Sun, 14 May 2023 12:57:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC890C433D2;
        Sun, 14 May 2023 12:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684069026;
        bh=tCIsBqE/jabmr9JVhkOmWR23Auw/USKx+9K/MgeiEwI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AAzQY/915rpGBXmYc/TAAp3QFqRrz80QlH5fWk1ycuq6mYFYmy9Jy7deRlUknkimK
         OWmN0V48sGkhhgDY+B7zXAKQERApvheVpw0rD+WbBPJFLS+JL3Rf/C2Eq8BSxy12DZ
         lA1ry5RYdH3u0JmlICNCTn48KYAEjyhBgYTIpYM9P+VtELOkN3bE8sltCYN4qLgKnj
         bpOqL2fndtgIqhAzYW+2midJ1EAemyfFc2zAX6X8sl05me0n11M3xdQSFwmz7aWlbl
         pVlGoP8EWXnm1MAZ0BAEZ44R3rovsFZ1NIpzJLVXlxYK9Y7IR4usATSaMFsvaS90ch
         6KQd4llR94HNg==
Date:   Sun, 14 May 2023 20:56:52 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: imx8mn-var-som: fix PHY detection bug by
 adding deassert delay
Message-ID: <20230514125652.GU727834@dragon>
References: <20230501170531.2961459-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230501170531.2961459-1-hugo@hugovil.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2023 at 01:05:32PM -0400, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> While testing the ethernet interface on a Variscite symphony carrier
> board using an imx8mn SOM with an onboard ADIN1300 PHY (EC hardware
> configuration), the ethernet PHY is not detected.
> 
> The ADIN1300 datasheet indicate that the "Management interface
> active (t4)" state is reached at most 5ms after the reset signal is
> deasserted.
> 
> The device tree in Variscite custom git repository uses the following
> property:
> 
>     phy-reset-post-delay = <20>;
> 
> Add a new MDIO property 'reset-deassert-us' of 20ms to have the same
> delay inside the ethphy node. Adding this property fixes the problem
> with the PHY detection.
> 
> Note that this SOM can also have an Atheros AR8033 PHY. In this case,
> a 1ms deassert delay is sufficient. Add a comment to that effect.
> 
> Fixes: ade0176dd8a0 ("arm64: dts: imx8mn-var-som: Add Variscite
> VAR-SOM-MX8MN System on Module")
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Applied, thanks!
