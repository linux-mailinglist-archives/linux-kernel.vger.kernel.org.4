Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB0367E8FC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 16:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234159AbjA0PKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 10:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234130AbjA0PKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 10:10:00 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4BB80F85;
        Fri, 27 Jan 2023 07:09:57 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 431181BF20F;
        Fri, 27 Jan 2023 15:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1674832196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fvf8wuWvKt1lKaISiLsHIlmZzW1JuoS4Fofh2rHqKJ0=;
        b=ZXaZ53lAeIa389azTklh0u4Ti0eLyChXWOSc4i32n7GaO4OtoU9LEEyZT9GZT8mEajkP58
        jSW2/c2XJcBXzkqb68coSVEuSM2Tde14sVlFBn73y10RrjAIkXoyL/BmopT4/J5Mb7i4d0
        8WR1A5R+Z3T4fAt0SqVDr+WDjllet1WJQin+ft+JhBZS176dSVVA19w/9FUwNinNLYzGeh
        fZoW+U70uX8mrLvDvZ8Mwgn9WclfZD/QXqEHmGm0+fXKQnawUXyb8vQhuVIFQ/eOm6qqsj
        1hdHZDH0Pb4HKCeTsLoG5FsPLuJmHH0rx8gOiUIxfRwSacHhVoVnyorTtXkYqg==
Date:   Fri, 27 Jan 2023 16:09:54 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/24] rtc: pm8xxx: add support for nvmem offset
Message-ID: <Y9PpQkW3Rtm+bi2V@mail.local>
References: <20230126142057.25715-1-johan+linaro@kernel.org>
 <20230126142057.25715-17-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126142057.25715-17-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/2023 15:20:49+0100, Johan Hovold wrote:
> On many Qualcomm platforms the PMIC RTC control and time registers are
> read-only so that the RTC time can not be updated. Instead an offset
> needs be stored in some machine-specific non-volatile memory, which the
> driver can take into account.
> 
> Add support for storing a 32-bit offset from the Epoch in an nvmem cell
> so that the RTC time can be set on such platforms.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/rtc/rtc-pm8xxx.c | 134 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 123 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
> index 922aef0f0241..09816b9f6282 100644
> --- a/drivers/rtc/rtc-pm8xxx.c
> +++ b/drivers/rtc/rtc-pm8xxx.c
> @@ -3,6 +3,7 @@
>   */
>  #include <linux/of.h>
>  #include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
>  #include <linux/init.h>
>  #include <linux/rtc.h>
>  #include <linux/platform_device.h>
> @@ -49,6 +50,8 @@ struct pm8xxx_rtc_regs {
>   * @alarm_irq:		alarm irq number
>   * @regs:		register description
>   * @dev:		device structure
> + * @nvmem_cell:		nvmem cell for offset
> + * @offset:		offset from epoch in seconds
>   */
>  struct pm8xxx_rtc {
>  	struct rtc_device *rtc;
> @@ -57,8 +60,60 @@ struct pm8xxx_rtc {
>  	int alarm_irq;
>  	const struct pm8xxx_rtc_regs *regs;
>  	struct device *dev;
> +	struct nvmem_cell *nvmem_cell;
> +	u32 offset;
>  };
>  
> +static int pm8xxx_rtc_read_nvmem_offset(struct pm8xxx_rtc *rtc_dd)
> +{
> +	size_t len;
> +	void *buf;
> +	int rc;
> +
> +	buf = nvmem_cell_read(rtc_dd->nvmem_cell, &len);
> +	if (IS_ERR(buf)) {
> +		rc = PTR_ERR(buf);
> +		dev_err(rtc_dd->dev, "failed to read nvmem offset: %d\n", rc);

You removed many dev_err strings in your previous patch and now this is
verbose. Honestly, there is not much to do apart from reying the
operation so I don't think the strings are worth it.

> +		return rc;
> +	}
> +
> +	if (len != sizeof(u32)) {
> +		dev_err(rtc_dd->dev, "unexpected nvmem cell size %zu\n", len);
> +		kfree(buf);
> +		return -EINVAL;
> +	}
> +
> +	rtc_dd->offset = get_unaligned_le32(buf);
> +
> +	kfree(buf);
> +
> +	return 0;
> +}
> +
> +static int pm8xxx_rtc_write_nvmem_offset(struct pm8xxx_rtc *rtc_dd, u32 offset)
> +{
> +	u8 buf[sizeof(u32)];
> +	int rc;
> +
> +	put_unaligned_le32(offset, buf);
> +
> +	rc = nvmem_cell_write(rtc_dd->nvmem_cell, buf, sizeof(buf));
> +	if (rc < 0) {
> +		dev_err(rtc_dd->dev, "failed to write nvmem offset: %d\n", rc);
> +		return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +static int pm8xxx_rtc_read_offset(struct pm8xxx_rtc *rtc_dd)
> +{
> +	if (!rtc_dd->nvmem_cell)
> +		return 0;
> +
> +	return pm8xxx_rtc_read_nvmem_offset(rtc_dd);
> +}
> +
>  static int pm8xxx_rtc_read_raw(struct pm8xxx_rtc *rtc_dd, u32 *secs)
>  {
>  	const struct pm8xxx_rtc_regs *regs = rtc_dd->regs;
> @@ -90,6 +145,33 @@ static int pm8xxx_rtc_read_raw(struct pm8xxx_rtc *rtc_dd, u32 *secs)
>  	return 0;
>  }
>  
> +static int pm8xxx_rtc_update_offset(struct pm8xxx_rtc *rtc_dd, u32 secs)
> +{
> +	u32 raw_secs;
> +	u32 offset;
> +	int rc;
> +
> +	if (!rtc_dd->nvmem_cell)
> +		return -ENODEV;
> +
> +	rc = pm8xxx_rtc_read_raw(rtc_dd, &raw_secs);
> +	if (rc)
> +		return rc;
> +
> +	offset = secs - raw_secs;
> +
> +	if (offset == rtc_dd->offset)
> +		return 0;
> +
> +	rc = pm8xxx_rtc_write_nvmem_offset(rtc_dd, offset);
> +	if (rc)
> +		return rc;
> +
> +	rtc_dd->offset = offset;
> +
> +	return 0;
> +}
> +
>  /*
>   * Steps to write the RTC registers.
>   * 1. Disable alarm if enabled.
> @@ -99,23 +181,15 @@ static int pm8xxx_rtc_read_raw(struct pm8xxx_rtc *rtc_dd, u32 *secs)
>   * 5. Enable rtc if disabled in step 2.
>   * 6. Enable alarm if disabled in step 1.
>   */
> -static int pm8xxx_rtc_set_time(struct device *dev, struct rtc_time *tm)
> +static int __pm8xxx_rtc_set_time(struct pm8xxx_rtc *rtc_dd, u32 secs)
>  {
> -	struct pm8xxx_rtc *rtc_dd = dev_get_drvdata(dev);
>  	const struct pm8xxx_rtc_regs *regs = rtc_dd->regs;
>  	u8 value[NUM_8_BIT_RTC_REGS];
>  	bool alarm_enabled;
> -	u32 secs;
>  	int rc;
>  
> -	if (!rtc_dd->allow_set_time)
> -		return -ENODEV;
> -
> -	secs = rtc_tm_to_time64(tm);
>  	put_unaligned_le32(secs, value);
>  
> -	dev_dbg(dev, "set time: %ptRd %ptRt (%u)\n", tm, tm, secs);
> -
>  	rc = regmap_update_bits_check(rtc_dd->regmap, regs->alarm_ctrl,
>  				      regs->alarm_en, 0, &alarm_enabled);
>  	if (rc)
> @@ -158,6 +232,27 @@ static int pm8xxx_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  	return 0;
>  }
>  
> +static int pm8xxx_rtc_set_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct pm8xxx_rtc *rtc_dd = dev_get_drvdata(dev);
> +	u32 secs;
> +	int rc;
> +
> +	secs = rtc_tm_to_time64(tm);
> +
> +	if (rtc_dd->allow_set_time)
> +		rc = __pm8xxx_rtc_set_time(rtc_dd, secs);
> +	else
> +		rc = pm8xxx_rtc_update_offset(rtc_dd, secs);
> +
> +	if (rc)
> +		return rc;
> +
> +	dev_dbg(dev, "set time: %ptRd %ptRt (%u + %u)\n", tm, tm,
> +			secs - rtc_dd->offset, rtc_dd->offset);
> +	return 0;
> +}
> +
>  static int pm8xxx_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  {
>  	struct pm8xxx_rtc *rtc_dd = dev_get_drvdata(dev);
> @@ -168,10 +263,11 @@ static int pm8xxx_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  	if (rc)
>  		return rc;
>  
> +	secs += rtc_dd->offset;
>  	rtc_time64_to_tm(secs, tm);
>  
> -	dev_dbg(dev, "read time: %ptRd %ptRt (%u)\n", tm, tm, secs);
> -
> +	dev_dbg(dev, "read time: %ptRd %ptRt (%u + %u)\n", tm, tm,
> +			secs - rtc_dd->offset, rtc_dd->offset);
>  	return 0;
>  }
>  
> @@ -184,6 +280,7 @@ static int pm8xxx_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
>  	int rc;
>  
>  	secs = rtc_tm_to_time64(&alarm->time);
> +	secs -= rtc_dd->offset;
>  	put_unaligned_le32(secs, value);
>  
>  	rc = regmap_update_bits(rtc_dd->regmap, regs->alarm_ctrl,
> @@ -223,6 +320,7 @@ static int pm8xxx_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
>  		return rc;
>  
>  	secs = get_unaligned_le32(value);
> +	secs += rtc_dd->offset;
>  	rtc_time64_to_tm(secs, &alarm->time);
>  
>  	rc = regmap_read(rtc_dd->regmap, regs->alarm_ctrl, &ctrl_reg);
> @@ -380,9 +478,23 @@ static int pm8xxx_rtc_probe(struct platform_device *pdev)
>  	rtc_dd->allow_set_time = of_property_read_bool(pdev->dev.of_node,
>  						      "allow-set-time");
>  
> +	rtc_dd->nvmem_cell = devm_nvmem_cell_get(&pdev->dev, "offset");

Maybe we should get something more specific than just "offset" so this
could be parsed in the RTC core at some point (this is the second RTC to
behave like this)

> +	if (IS_ERR(rtc_dd->nvmem_cell)) {
> +		rc = PTR_ERR(rtc_dd->nvmem_cell);
> +		if (rc != -ENOENT)
> +			return rc;
> +		rtc_dd->nvmem_cell = NULL;
> +	}
> +
>  	rtc_dd->regs = match->data;
>  	rtc_dd->dev = &pdev->dev;
>  
> +	if (!rtc_dd->allow_set_time) {
> +		rc = pm8xxx_rtc_read_offset(rtc_dd);
> +		if (rc)
> +			return rc;
> +	}
> +
>  	rc = pm8xxx_rtc_enable(rtc_dd);
>  	if (rc)
>  		return rc;
> -- 
> 2.39.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
