Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A490640E7E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 20:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbiLBTaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 14:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233679AbiLBTaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 14:30:19 -0500
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044B4EC80E;
        Fri,  2 Dec 2022 11:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
        Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
        Subject:Content-ID:Content-Description:X-Debbugs-Cc;
        bh=QeityKeWX9SH19NfeKIppN2I0iFKaIHoIc1Zkqq/E6k=; b=nOXshjpnQjf5mZxj6cFVHdAk9h
        mLpBsfcpsow8dQYvO9/n9gm9O2xfktkDZJKMivAnd/LFuSFifh0wgQPFW9A7Qkk58fafdAkQG0zRI
        hy9hov2mll82bo3A465yPE/vpjH0x7fq3VBzHw9/UIDgZU6GVhey83YDczWtYtIAcj2sop3e2n9Ke
        YsWbaVmg7FAOYXlKDU0Rxy5VCHxKpIy2ll/rabony7mUTO4o3ySDgqto7PVzA5kMI9YldodwGlmyM
        5l6Dl6b9XpjgNN6ayskbZf8yioFtpLsZ16JM7xoxeW2e9DtA+eHxolMZbV8Vuv/cL47R78SJPkNf1
        ip5A3ZoQ==;
Received: from [2a01:e34:ec5d:a741:8a4c:7c4e:dc4c:1787] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <aurelien@aurel32.net>)
        id 1p1Bjb-0098bq-Hu; Fri, 02 Dec 2022 20:30:07 +0100
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.96)
        (envelope-from <aurelien@aurel32.net>)
        id 1p1Bja-00ExHt-30;
        Fri, 02 Dec 2022 20:30:06 +0100
Date:   Fri, 2 Dec 2022 20:30:06 +0100
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lin Jinhan <troy.lin@rock-chips.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] hwrng: add Rockchip SoC hwrng driver
Message-ID: <Y4pSPrIHPL8yH6cq@aurel32.net>
Mail-Followup-To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lin Jinhan <troy.lin@rock-chips.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20221128184718.1963353-1-aurelien@aurel32.net>
 <20221128184718.1963353-3-aurelien@aurel32.net>
 <76091207-d81c-e737-34a2-884153251925@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76091207-d81c-e737-34a2-884153251925@linaro.org>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for your feedback.

On 2022-11-29 10:33, Krzysztof Kozlowski wrote:
> On 28/11/2022 19:47, Aurelien Jarno wrote:
> > diff --git a/drivers/char/hw_random/rockchip-rng.c b/drivers/char/hw_random/rockchip-rng.c
> > new file mode 100644
> > index 000000000000..18cdd91ad8c3
> > --- /dev/null
> > +++ b/drivers/char/hw_random/rockchip-rng.c
> > @@ -0,0 +1,250 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * rockchip-rng.c True Random Number Generator driver for Rockchip SoCs
> > + *
> > + * Copyright (c) 2018, Fuzhou Rockchip Electronics Co., Ltd.
> > + * Copyright (c) 2022, Aurelien Jarno
> > + * Authors:
> > + *  Lin Jinhan <troy.lin@rock-chips.com>
> > + *  Aurelien Jarno <aurelien@aurel32.net>
> > + */
> > +#include <linux/clk.h>
> > +#include <linux/hw_random.h>
> > +#include <linux/io.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/reset.h>
> > +#include <linux/slab.h>
> > +
> > +#define RK_RNG_AUTOSUSPEND_DELAY	100
> > +#define RK_RNG_MAX_BYTE			32
> > +#define RK_RNG_POLL_PERIOD_US		100
> > +#define RK_RNG_POLL_TIMEOUT_US		10000
> > +
> > +/*
> > + * TRNG collects osc ring output bit every RK_RNG_SAMPLE_CNT time. The value is
> > + * a tradeoff between speed and quality and has been adjusted to get a quality
> > + * of ~900 (~90% of FIPS 140-2 successes).
> > + */
> > +#define RK_RNG_SAMPLE_CNT		1000
> > +
> > +/* TRNG registers from RK3568 TRM-Part2, section 5.4.1 */
> > +#define TRNG_RST_CTL			0x0004
> > +#define TRNG_RNG_CTL			0x0400
> > +#define TRNG_RNG_CTL_LEN_64_BIT		(0x00 << 4)
> > +#define TRNG_RNG_CTL_LEN_128_BIT	(0x01 << 4)
> > +#define TRNG_RNG_CTL_LEN_192_BIT	(0x02 << 4)
> > +#define TRNG_RNG_CTL_LEN_256_BIT	(0x03 << 4)
> > +#define TRNG_RNG_CTL_OSC_RING_SPEED_0	(0x00 << 2)
> > +#define TRNG_RNG_CTL_OSC_RING_SPEED_1	(0x01 << 2)
> > +#define TRNG_RNG_CTL_OSC_RING_SPEED_2	(0x02 << 2)
> > +#define TRNG_RNG_CTL_OSC_RING_SPEED_3	(0x03 << 2)
> > +#define TRNG_RNG_CTL_ENABLE		BIT(1)
> > +#define TRNG_RNG_CTL_START		BIT(0)
> > +#define TRNG_RNG_SAMPLE_CNT		0x0404
> > +#define TRNG_RNG_DOUT_0			0x0410
> > +#define TRNG_RNG_DOUT_1			0x0414
> > +#define TRNG_RNG_DOUT_2			0x0418
> > +#define TRNG_RNG_DOUT_3			0x041c
> > +#define TRNG_RNG_DOUT_4			0x0420
> > +#define TRNG_RNG_DOUT_5			0x0424
> > +#define TRNG_RNG_DOUT_6			0x0428
> > +#define TRNG_RNG_DOUT_7			0x042c
> > +
> > +struct rk_rng {
> > +	struct hwrng rng;
> > +	void __iomem *base;
> > +	struct reset_control *rst;
> > +	int clk_num;
> > +	struct clk_bulk_data *clk_bulks;
> > +};
> > +
> > +/* The mask determine the bits that are updated */
> > +static void rk_rng_write_ctl(struct rk_rng *rng, u32 val, u32 mask)
> > +{
> > +	writel_relaxed((mask << 16) | val, rng->base + TRNG_RNG_CTL);
> > +}
> > +
> > +static int rk_rng_init(struct hwrng *rng)
> > +{
> > +	struct rk_rng *rk_rng = container_of(rng, struct rk_rng, rng);
> > +	u32 reg;
> > +	int ret;
> > +
> > +	/* start clocks */
> > +	ret = clk_bulk_prepare_enable(rk_rng->clk_num, rk_rng->clk_bulks);
> > +	if (ret < 0) {
> > +		dev_err((struct device *) rk_rng->rng.priv,
> > +			"Failed to enable clks %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	/* set the sample period */
> > +	writel(RK_RNG_SAMPLE_CNT, rk_rng->base + TRNG_RNG_SAMPLE_CNT);
> > +
> > +	/* set osc ring speed and enable it */
> > +	reg = TRNG_RNG_CTL_LEN_256_BIT |
> 
> It's not reg. It's val.

Ok, I'll fix that.

> > +		   TRNG_RNG_CTL_OSC_RING_SPEED_0 |
> > +		   TRNG_RNG_CTL_ENABLE;
> > +	rk_rng_write_ctl(rk_rng, reg, 0xffff);
> > +
> > +	return 0;
> > +}
> > +
> > +static void rk_rng_cleanup(struct hwrng *rng)
> > +{
> > +	struct rk_rng *rk_rng = container_of(rng, struct rk_rng, rng);
> > +	u32 reg;
> > +
> > +	/* stop TRNG */
> > +	reg = 0;
> 
> It's not reg. It's val.

I'll also fix that one.

> > +	rk_rng_write_ctl(rk_rng, reg, 0xffff);
> > +
> > +	/* stop clocks */
> > +	clk_bulk_disable_unprepare(rk_rng->clk_num, rk_rng->clk_bulks);
> > +}
> > +
> > +static int rk_rng_read(struct hwrng *rng, void *buf, size_t max, bool wait)
> > +{
> > +	struct rk_rng *rk_rng = container_of(rng, struct rk_rng, rng);
> > +	u32 reg;
> > +	int ret = 0;
> > +	int i;
> > +
> > +	pm_runtime_get_sync((struct device *) rk_rng->rng.priv);
> 
> Missing error handling.

I'll fix that.
 
> > +
> > +	/* Start collecting random data */
> > +	reg = TRNG_RNG_CTL_START;
> 
> This is not usefull. Just use it directly in write call. Actually this
> is heavy confusing, as reg suggests address. This would be val instead...

This was to avoid passing the value twice, as it is used for both the
mask and the value. But I can pass it directly if it's better.

> > +	rk_rng_write_ctl(rk_rng, reg, reg);
> > +
> > +	ret = readl_poll_timeout(rk_rng->base + TRNG_RNG_CTL, reg,
> > +				 !(reg & TRNG_RNG_CTL_START),
> > +				 RK_RNG_POLL_PERIOD_US,
> > +				 RK_RNG_POLL_TIMEOUT_US);
> > +	if (ret < 0)
> > +		goto out;
> > +
> > +	/* Read random data stored in the registers */
> > +	ret = min_t(size_t, max, RK_RNG_MAX_BYTE);
> > +	for (i = 0; i < ret; i += 4) {
> > +		*(u32 *)(buf + i) = readl_relaxed(rk_rng->base + TRNG_RNG_DOUT_0 + i);
> > +	}
> 
> This cannot be just memcpy_fromio?

According to the TRM, we should ensure 32-bit accesses, so I am not sure
memcpy_fromio will work. However it seems __ioread32_copy could be a
good replacement.

> > +
> > +out:
> > +	pm_runtime_mark_last_busy((struct device *) rk_rng->rng.priv);
> > +	pm_runtime_put_sync_autosuspend((struct device *) rk_rng->rng.priv);
> > +
> > +	return ret;
> > +}
> > +
> > +static int rk_rng_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct rk_rng *rk_rng;
> > +	int ret;
> > +
> > +	rk_rng = devm_kzalloc(dev, sizeof(struct rk_rng), GFP_KERNEL);
> 
> sizeof(*rk_rng)

I'll fix that.

> > +	if (!rk_rng)
> > +		return -ENOMEM;
> > +

Regards
Aurelien


-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
