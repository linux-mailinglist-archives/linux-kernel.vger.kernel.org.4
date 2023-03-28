Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05F76CBB1F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbjC1JcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbjC1Jbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:31:43 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A486A57;
        Tue, 28 Mar 2023 02:29:54 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 80912240007;
        Tue, 28 Mar 2023 09:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1679995785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MXIXyiuWj2nuAHjHZSD/W6jzs2smj+U2E3/xI+F1x2k=;
        b=bU/bOYcqf4yCt1TvrquKTGjWFnCQb75N/Snq+PPxPTF2fBTfO0dCd1xyHthOQD3uOhAFRd
        m8ybsBviaEctOMnjTt8N3rXWJ92jDC40knuX0SfUS5uZv5jiMswV/zXW89bw06liD8CnFZ
        61Kd1ebzCXOynngSaBRhTA8EnVPsRp9Ltg3CS0o1ftV+Y0Q5jEJnK/coRIz3M+b07b6F6f
        SLZf4ygEi5Ri5sHyYw9eAjAu3FWMdmONFzRcpGXYi87ekl1dckaPn/+tGEwa45EWJEXmay
        hIBUfYHP36nZn/gcKxkbqftBr8yGT7eHyXY6Hb1ikLzZKaANd9XQbb0wWmAtgg==
Date:   Tue, 28 Mar 2023 11:29:44 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Esteban Blanc <eblanc@baylibre.com>
Cc:     linus.walleij@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        a.zummo@towertech.it, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        jpanis@baylibre.com, jneanne@baylibre.com, sterzik@ti.com,
        u-kumar1@ti.com
Subject: Re: [PATCH v2 1/3] rtc: tps6594: add driver for TPS6594 PMIC RTC
Message-ID: <202303280929448e41808d@mail.local>
References: <20230328091448.648452-1-eblanc@baylibre.com>
 <20230328091448.648452-2-eblanc@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328091448.648452-2-eblanc@baylibre.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 28/03/2023 11:14:46+0200, Esteban Blanc wrote:
> +	/* Start rtc */
> +	ret = regmap_set_bits(tps->regmap, TPS6594_REG_RTC_CTRL_1,
> +			      TPS6594_BIT_STOP_RTC);
> +	if (ret < 0)
> +		return ret;
> +
> +	mdelay(100);
> +
> +	/*
> +	 * RTC should be running now. Check if this is the case.
> +	 * If not it might be a missing oscillator.
> +	 */
> +	ret = regmap_test_bits(tps->regmap, TPS6594_REG_RTC_STATUS,
> +			       TPS6594_BIT_RUN);
> +	if (ret < 0)
> +		return ret;
> +	if (ret == 0)
> +		return -ENODEV;
> +
> +	/* Stop RTC until first call to `tps6594_rtc_set_time */
> +	ret = regmap_clear_bits(tps->regmap, TPS6594_REG_RTC_CTRL_1,
> +				TPS6594_BIT_STOP_RTC);
> +	if (ret < 0)
> +		return ret;
> +

This whole block must not be executed when the RTC is already running,
else, you are stopping a perfectly running RTC.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
