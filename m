Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A480C623021
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 17:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiKIQZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 11:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbiKIQZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 11:25:44 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D5C1A048;
        Wed,  9 Nov 2022 08:25:42 -0800 (PST)
Received: from booty (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 05DEBC000B;
        Wed,  9 Nov 2022 16:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668011141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=md+3BvVMOqhbT4Mg1/eofVo42NnM0QIADOtucHcIgg4=;
        b=gF6sAue/cSpFVYdCzn6XaeoAMUvRAr/BsmC8fZpflEJ6rq4f51Dmw+AsyA3tEdtFLjGgrj
        tPnOphPVGbtNot0izJb5ZAo1Sf1hW3VhIwbn2e/cZQKg79XWffb6+IGIaejZo/roXifsR2
        Gjcp0vNbtMLQFSNeprS5gc5f0fD+0+RuzrqzJQn92RUAf30+elKjORYPND6L7fiZz8xNmE
        iwEFgC5dbi+ZqX6ppxaEOT6gN6skuFspwDI90hy2rGq2TvbFBAOGIpwJ0IxDUIU8yj4WoX
        U83Zl2D9Gv0tfnRoCaCjtAuSDgllp61yxa8WXAOTDfpRlVrHqOiPCR9CApmHPg==
Date:   Wed, 9 Nov 2022 17:25:37 +0100
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Richard Leitner <richard.leitner@skidata.com>
Subject: Re: [PATCH 23/23] staging: media: tegra-video: add tegra20 variant
Message-ID: <20221109172537.0c48f66c@booty>
In-Reply-To: <20221109141852.729246-24-luca.ceresoli@bootlin.com>
References: <20221109141852.729246-1-luca.ceresoli@bootlin.com>
        <20221109141852.729246-24-luca.ceresoli@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  9 Nov 2022 15:18:52 +0100
luca.ceresoli@bootlin.com wrote:

> +static int tegra20_vi_enable(struct tegra_vi *vi, bool on)
> +{
> +	/* from arch/arm/mach-tegra/iomap.h */
> +	const phys_addr_t TEGRA_APB_MISC_BASE = 0x70000000;
> +	const unsigned long reg_offset = 0x42c;
> +	void __iomem *apb_misc;
> +	u32 val;
> +
> +	apb_misc = ioremap(TEGRA_APB_MISC_BASE, PAGE_SIZE);
> +	if (!apb_misc)
> +		apb_misc = ERR_PTR(-ENOENT);
> +	if (IS_ERR(apb_misc))
> +		return dev_err_probe(vi->dev, PTR_ERR(apb_misc), "cannot access APB_MISC");
> +
> +	val = readl(apb_misc + reg_offset);
> +	writel(val | (!!on), apb_misc + reg_offset);

Sorry, there is a mistake here, the bit should be set to 0 when
on==false, but this code does not do that. This will be fixed in v2.

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
