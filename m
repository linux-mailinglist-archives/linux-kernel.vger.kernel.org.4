Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D84C702CE0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 14:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241963AbjEOMjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 08:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241917AbjEOMhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 08:37:32 -0400
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A471FC1;
        Mon, 15 May 2023 05:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1684154031; bh=0yXiPXLG1mE9Cp0QFJsDToPAJuYXk6I4juqB/x64HMM=;
        h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
        b=NmbH2EXdkDST+t545oWgvXbyEH2Wd6r/DrYWrzyAsN23XGFDWHKA7pxlCAsCS6+IV
         Zw+JPcfhIAFVp67PipJyizpQpACFp9LNF4bnbYreZrVNqlz02nBiCkBYFv+73twX9R
         qh9CbPY8WSaaQofjqHpNE6BAzwhfwJoJElQbnlD4=
Date:   Mon, 15 May 2023 14:33:51 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2] thermal/drivers/sun8i: Fix some error handling paths
 in sun8i_ths_probe()
Message-ID: <u7mmywm63bm5q4zlsbnooeplscn4rrd3qnslkfq2xnquxgnkkd@n3tsnrutmfjp>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
        Maxime Ripard <maxime@cerno.tech>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
        Vasily Khoruzhick <anarsoul@gmail.com>, Yangtao Li <tiny.windzz@gmail.com>, 
        "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
        Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Chen-Yu Tsai <wens@csie.org>, 
        Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
        Philipp Zabel <p.zabel@pengutronix.de>, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
        linux-sunxi@lists.linux.dev
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <a8ae84bd2dc4b55fe428f8e20f31438bf8bb6762.1684089931.git.christophe.jaillet@wanadoo.fr>
 <ucnnixemxbpkjlbyenboydicslozt5jpyjjfbd4gjk4oye52et@fgyd3zqdqsh2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ucnnixemxbpkjlbyenboydicslozt5jpyjjfbd4gjk4oye52et@fgyd3zqdqsh2>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Mon, May 15, 2023 at 01:54:41PM +0200, Maxime Ripard wrote:
> Hi,
> 
> On Sun, May 14, 2023 at 08:46:05PM +0200, Christophe JAILLET wrote:
> > Should an error occur after calling sun8i_ths_resource_init() in the probe
> > function, some resources need to be released, as already done in the
> > .remove() function.
> > 
> > Switch to the devm_clk_get_enabled() helper and add a new devm_action to
> > turn sun8i_ths_resource_init() into a fully managed function.
> > 
> > Move the place where reset_control_deassert() is called so that the
> > recommended order of reset release/clock enable steps is kept.
> > A64 manual states that:
> > 
> > 	3.3.6.4. Gating and reset
> > 
> > 	Make sure that the reset signal has been released before the release of
> > 	module clock gating;
> > 
> > This fixes the issue and removes some LoC at the same time.
> 
> It should really be three different patches:
>  - One to fix the resource release, that can be backported to stable
>    releases
>  - One to switch to devm_clk_get_enabled
>  - and one to change the order of clock enable vs reset deassertion

The order was correct before this patch. I don't think an incorrect order
should be intorduced, even if temporarily between two patches.

regards,
	o.

> Maxime


