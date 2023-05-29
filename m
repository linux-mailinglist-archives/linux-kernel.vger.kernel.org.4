Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3597151FF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 00:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjE2Wks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 18:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjE2Wkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 18:40:47 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9646CDC;
        Mon, 29 May 2023 15:40:43 -0700 (PDT)
X-GND-Sasl: alexandre.belloni@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685400041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=egb4L+VNYQdcctQ3RYBg4Q3hflaDjVWsXarPSsnVIYs=;
        b=M562hNm36anb9Cab6H+unTLT20Dppcb2/F37ifys1sGHGM8fdtI7yoB8laolniMuvviCSJ
        olHs5BTN/wabe3oq8a+ODU8qSPzoiVEwHA9cP8RQreyg/5NAav2AggnHVlSSFfRKmrVxs6
        l1tRBIH3FMR5ZoAcBtwiNcrJGC818IzhjFRGyXAb541cOH2Z9h3T3Vm/IfAhaEGcehkj+X
        rBDwrcdEock1PVXL3uN2VppWlXrRBw0vgj0ZmcajrPaPKu0iMikkt3gqITjiuBEbFS043B
        vd6IohyelalvAgbXm9OuoyolKkSjxwhkG2QBjJ0nOsudr3rSMoLa8Xn/4jjgrw==
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C02AF20004;
        Mon, 29 May 2023 22:40:39 +0000 (UTC)
Date:   Tue, 30 May 2023 00:40:39 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Romain Perier <romain.perier@gmail.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Daniel Palmer <daniel@0x0f.com>,
        Rob Herring <robh+dt@kernel.org>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] rtc: Add support for the SSD20xD RTC
Message-ID: <20230529224039a7f270b9@mail.local>
References: <20230517144144.365631-1-romain.perier@gmail.com>
 <20230517144144.365631-2-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517144144.365631-2-romain.perier@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 17/05/2023 16:41:42+0200, Romain Perier wrote:
> Newer SigmaStar SSD20xD SoCs contain a really low power RTC (300uA claimed),

The low power RTCs are more on the side of a few tenth of nA. RV3028
consumes 40nA, including the crystal. AB1805 consumes 14nA with an RC
oscillator. It is funny how SoC vendors think they are low power ;)

> +static int ssd20xd_rtc_isoctrl(struct ssd20xd_rtc *priv)
> +{
> +	static const unsigned int sequence[] = { 0x0, 0x1, 0x3, 0x7, 0x5, 0x1, 0x0 };
> +	unsigned int val;
> +	struct device *dev = &priv->rtc_dev->dev;
> +	int i, ret;
> +
> +	/*
> +	 * This gates iso_en by writing a special sequence of bytes to iso_ctrl
> +	 * and ensuring that it has been correctly applied by reading iso_ctrl_ack
> +	 */
> +	for (i = 0; i < ARRAY_SIZE(sequence); i++) {
> +		writeb(sequence[i] & ISO_CTRL_MASK, priv->base +  REG_ISO_CTRL);
> +
> +		ret = read_poll_timeout(read_iso_ctrl_ack, val, val == (i % 2), 100,
> +					20 * 100, true, priv->base);
> +		if (ret) {
> +			dev_err(dev, "Timeout waiting for ack byte %i (%x) of sequence\n", i,
> +				sequence[i]);

This is a user visible message but there is no action for the user to
take apart from retrying. You should drop this.

> +			return ret;
> +		}
> +	}
> +
> +	/*
> +	 * At this point iso_en should be raised for 1ms
> +	 */
> +	ret = read_poll_timeout(read_iso_en, val, val, 100, 22 * 100, true, priv->base);
> +	if (ret)
> +		dev_err(dev, "Timeout waiting for iso_en\n");

Ditto.

> +	mdelay(2);
> +	return 0;
> +}
> +

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
