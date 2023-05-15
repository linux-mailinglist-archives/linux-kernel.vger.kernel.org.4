Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6172770304E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 16:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240485AbjEOOnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 10:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241859AbjEOOnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 10:43:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BC3173E
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 07:43:10 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <pza@pengutronix.de>)
        id 1pyZPU-0001LS-4g; Mon, 15 May 2023 16:42:48 +0200
Received: from pza by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <pza@pengutronix.de>)
        id 1pyZPR-0007uO-70; Mon, 15 May 2023 16:42:45 +0200
Date:   Mon, 15 May 2023 16:42:45 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Jack Zhu <jack.zhu@starfivetech.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, changhuang.liang@starfivetech.com
Subject: Re: [PATCH v1 3/5] media: cadence: Add operation on reset
Message-ID: <20230515144245.GA29284@pengutronix.de>
References: <20230512102637.50917-1-jack.zhu@starfivetech.com>
 <20230512102637.50917-4-jack.zhu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512102637.50917-4-jack.zhu@starfivetech.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: pza@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jack,

On Fri, May 12, 2023 at 06:26:35PM +0800, Jack Zhu wrote:
[...]
> @@ -299,6 +312,16 @@ static int csi2rx_get_resources(struct csi2rx_priv *csi2rx,
>  		return PTR_ERR(csi2rx->p_clk);
>  	}
>  
> +	csi2rx->sys_rst = devm_reset_control_get_optional_exclusive(&pdev->dev,
> +								    "sys_rst");

This doesn't match the bindings documented in patch 2.
Should this be "sys"?

> +	if (IS_ERR(csi2rx->sys_rst))
> +		return PTR_ERR(csi2rx->sys_rst);
> +
> +	csi2rx->p_rst = devm_reset_control_get_optional_exclusive(&pdev->dev,
> +								  "p_rst");

This doesn't match the bindings documented in patch 2.
Should this be "reg_bank"?

> +	if (IS_ERR(csi2rx->p_rst))
> +		return PTR_ERR(csi2rx->p_rst);
> +
>  	csi2rx->dphy = devm_phy_optional_get(&pdev->dev, "dphy");
>  	if (IS_ERR(csi2rx->dphy)) {
>  		dev_err(&pdev->dev, "Couldn't get external D-PHY\n");
> @@ -349,14 +372,21 @@ static int csi2rx_get_resources(struct csi2rx_priv *csi2rx,
>  	}
>  
>  	for (i = 0; i < csi2rx->max_streams; i++) {
> -		char clk_name[16];
> +		char name[16];
>  
> -		snprintf(clk_name, sizeof(clk_name), "pixel_if%u_clk", i);
> -		csi2rx->pixel_clk[i] = devm_clk_get(&pdev->dev, clk_name);
> +		snprintf(name, sizeof(name), "pixel_if%u_clk", i);
> +		csi2rx->pixel_clk[i] = devm_clk_get(&pdev->dev, name);
>  		if (IS_ERR(csi2rx->pixel_clk[i])) {
> -			dev_err(&pdev->dev, "Couldn't get clock %s\n", clk_name);
> +			dev_err(&pdev->dev, "Couldn't get clock %s\n", name);
>  			return PTR_ERR(csi2rx->pixel_clk[i]);
>  		}
> +
> +		snprintf(name, sizeof(name), "pixel_if%u_rst", i);

This doesn't match the bindings documented in patch 2.
Should this be "pixel_if%u"?

regards
Philipp
