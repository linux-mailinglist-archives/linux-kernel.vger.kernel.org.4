Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C2367E957
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 16:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234393AbjA0PTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 10:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbjA0PTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 10:19:23 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5366583D9;
        Fri, 27 Jan 2023 07:19:21 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id EAAD2FF804;
        Fri, 27 Jan 2023 15:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1674832760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=75L9daZQQraiKiPUQbo7VpXC3b/EbE0gKH7qGhFhOsI=;
        b=esMado+MfG4dtcsh2nEE9uGO5HBsWdN2dck43xL3s8b7qt8PUZi8iMVeo8C0DS3L4i2hUI
        TeAvnXidnutVL5l1qFSQyC4d3CE672gtgCCtqaRpHSQt24ZtmZqk+mlCUMlAdH5TkSu1jo
        /64w4yxbsthwYn9LfgZwD8fk+noht0UsaqjmWzE/nCTCYAgSPVM5aXVp1E/cIDhmJs2XB9
        fcdiXYWHFImk/SySl+/hgUarHZEkfK+6T0rOUpDuMt1qNJiDsOr7MrA66GeABpy+LqLVby
        37yXbe4UznivtE4wYEy1Rp2llUrKygEmH2aZrrXDllQOJD1neT96Vjg55ecbCw==
Date:   Fri, 27 Jan 2023 16:19:18 +0100
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
Subject: Re: [PATCH 19/24] rtc: pm8xxx: add support for uefi offset
Message-ID: <Y9PrdqLHZpZrdGJ4@mail.local>
References: <20230126142057.25715-1-johan+linaro@kernel.org>
 <20230126142057.25715-20-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126142057.25715-20-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/2023 15:20:52+0100, Johan Hovold wrote:
> On many Qualcomm platforms the PMIC RTC control and time registers are
> read-only so that the RTC time can not be updated. Instead an offset
> needs be stored in some machine-specific non-volatile memory, which the
> driver can take into account.
> 
> Add support for storing a 32-bit offset from the GPS time epoch in a
> UEFI variable so that the RTC time can be set on such platforms.
> 

Why are you using the GPS epoch? This seems pretty random.

> The UEFI variable is
> 
>             882f8c2b-9646-435f-8de5-f208ff80c1bd-RTCInfo
> 
> and holds a 12-byte structure where the first four bytes is a GPS time
> offset in little-endian byte order.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/rtc/rtc-pm8xxx.c | 122 +++++++++++++++++++++++++++++++++++++--
>  include/linux/rtc.h      |   1 +
>  2 files changed, 119 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
> index 25bdd804b4d2..6c2324baeec6 100644
> --- a/drivers/rtc/rtc-pm8xxx.c
> +++ b/drivers/rtc/rtc-pm8xxx.c
> @@ -5,6 +5,7 @@
>   * Copyright (c) 2010-2011, Code Aurora Forum. All rights reserved.
>   * Copyright (c) 2023, Linaro Limited
>   */
> +#include <linux/efi.h>
>  #include <linux/of.h>
>  #include <linux/module.h>
>  #include <linux/nvmem-consumer.h>
> @@ -17,6 +18,7 @@
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>  
> +#include <asm/byteorder.h>
>  #include <asm/unaligned.h>
>  
>  /* RTC_CTRL register bit fields */
> @@ -46,6 +48,11 @@ struct pm8xxx_rtc_regs {
>  	unsigned int alarm_en;
>  };
>  
> +struct qcom_uefi_rtc_info {
> +	__le32	offset_gps;
> +	u8	reserved[8];
> +} __packed;
> +
>  /**
>   * struct pm8xxx_rtc -  RTC driver internal structure
>   * @rtc:		RTC device
> @@ -54,6 +61,7 @@ struct pm8xxx_rtc_regs {
>   * @alarm_irq:		alarm irq number
>   * @regs:		register description
>   * @dev:		device structure
> + * @rtc_info:		qcom uefi rtc-info structure
>   * @nvmem_cell:		nvmem cell for offset
>   * @offset:		offset from epoch in seconds
>   */
> @@ -61,13 +69,101 @@ struct pm8xxx_rtc {
>  	struct rtc_device *rtc;
>  	struct regmap *regmap;
>  	bool allow_set_time;
> +	bool use_uefi;
>  	int alarm_irq;
>  	const struct pm8xxx_rtc_regs *regs;
>  	struct device *dev;
> +	struct qcom_uefi_rtc_info rtc_info;
>  	struct nvmem_cell *nvmem_cell;
>  	u32 offset;
>  };
>  
> +#ifdef CONFIG_EFI
> +
> +MODULE_IMPORT_NS(EFIVAR);
> +
> +#define QCOM_UEFI_NAME	L"RTCInfo"
> +#define QCOM_UEFI_GUID	EFI_GUID(0x882f8c2b, 0x9646, 0x435f, \
> +				 0x8d, 0xe5, 0xf2, 0x08, 0xff, 0x80, 0xc1, 0xbd)
> +#define QCOM_UEFI_ATTRS	(EFI_VARIABLE_NON_VOLATILE | \
> +			 EFI_VARIABLE_BOOTSERVICE_ACCESS | \
> +			 EFI_VARIABLE_RUNTIME_ACCESS)
> +
> +static int pm8xxx_rtc_read_uefi_offset(struct pm8xxx_rtc *rtc_dd)
> +{
> +	struct qcom_uefi_rtc_info *rtc_info = &rtc_dd->rtc_info;
> +	unsigned long size = sizeof(*rtc_info);
> +	struct device *dev = rtc_dd->dev;
> +	efi_status_t status;
> +	u32 offset_gps;
> +	int rc;
> +
> +	rc = efivar_lock();
> +	if (rc)
> +		return rc;
> +
> +	status = efivar_get_variable(QCOM_UEFI_NAME, &QCOM_UEFI_GUID, NULL,
> +				     &size, rtc_info);
> +	efivar_unlock();
> +
> +	if (status != EFI_SUCCESS) {
> +		dev_err(dev, "failed to read UEFI offset: %lu\n", status);
> +		return efi_status_to_err(status);
> +	}
> +
> +	if (size != sizeof(*rtc_info)) {
> +		dev_err(dev, "unexpected UEFI structure size %lu\n", size);
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(dev, "uefi_rtc_info = %*ph\n", (int)size, rtc_info);
> +
> +	/* Convert from GPS to Unix time offset */
> +	offset_gps = le32_to_cpu(rtc_info->offset_gps);
> +	rtc_dd->offset = offset_gps + (u32)RTC_TIMESTAMP_BEGIN_GPS;
> +
> +	return 0;
> +}
> +
> +static int pm8xxx_rtc_write_uefi_offset(struct pm8xxx_rtc *rtc_dd, u32 offset)
> +{
> +	struct qcom_uefi_rtc_info *rtc_info = &rtc_dd->rtc_info;
> +	unsigned long size = sizeof(*rtc_info);
> +	struct device *dev = rtc_dd->dev;
> +	efi_status_t status;
> +	u32 offset_gps;
> +
> +	/* Convert from Unix to GPS time offset */
> +	offset_gps = offset - (u32)RTC_TIMESTAMP_BEGIN_GPS;
> +
> +	rtc_info->offset_gps = cpu_to_le32(offset_gps);
> +
> +	dev_dbg(dev, "efi_rtc_info = %*ph\n", (int)size, rtc_info);
> +
> +	status = efivar_set_variable(QCOM_UEFI_NAME, &QCOM_UEFI_GUID,
> +				     QCOM_UEFI_ATTRS, size, rtc_info);
> +	if (status != EFI_SUCCESS) {
> +		dev_err(dev, "failed to write UEFI offset: %lx\n", status);
> +		return efi_status_to_err(status);
> +	}
> +
> +	return 0;
> +}
> +
> +#else	/* CONFIG_EFI */
> +
> +static int pm8xxx_rtc_read_uefi_offset(struct pm8xxx_rtc *rtc_dd)
> +{
> +	return -ENODEV;
> +}
> +
> +static int pm8xxx_rtc_write_uefi_offset(struct pm8xxx_rtc *rtc_dd, u32 offset)
> +{
> +	return -ENODEV;
> +}
> +
> +#endif	/* CONFIG_EFI */
> +
>  static int pm8xxx_rtc_read_nvmem_offset(struct pm8xxx_rtc *rtc_dd)
>  {
>  	size_t len;
> @@ -112,10 +208,13 @@ static int pm8xxx_rtc_write_nvmem_offset(struct pm8xxx_rtc *rtc_dd, u32 offset)
>  
>  static int pm8xxx_rtc_read_offset(struct pm8xxx_rtc *rtc_dd)
>  {
> -	if (!rtc_dd->nvmem_cell)
> +	if (!rtc_dd->nvmem_cell && !rtc_dd->use_uefi)
>  		return 0;
>  
> -	return pm8xxx_rtc_read_nvmem_offset(rtc_dd);
> +	if (rtc_dd->nvmem_cell)
> +		return pm8xxx_rtc_read_nvmem_offset(rtc_dd);
> +	else
> +		return pm8xxx_rtc_read_uefi_offset(rtc_dd);
>  }
>  
>  static int pm8xxx_rtc_read_raw(struct pm8xxx_rtc *rtc_dd, u32 *secs)
> @@ -155,7 +254,7 @@ static int pm8xxx_rtc_update_offset(struct pm8xxx_rtc *rtc_dd, u32 secs)
>  	u32 offset;
>  	int rc;
>  
> -	if (!rtc_dd->nvmem_cell)
> +	if (!rtc_dd->nvmem_cell && !rtc_dd->use_uefi)
>  		return -ENODEV;
>  
>  	rc = pm8xxx_rtc_read_raw(rtc_dd, &raw_secs);
> @@ -167,7 +266,11 @@ static int pm8xxx_rtc_update_offset(struct pm8xxx_rtc *rtc_dd, u32 secs)
>  	if (offset == rtc_dd->offset)
>  		return 0;
>  
> -	rc = pm8xxx_rtc_write_nvmem_offset(rtc_dd, offset);
> +	if (rtc_dd->nvmem_cell)
> +		rc = pm8xxx_rtc_write_nvmem_offset(rtc_dd, offset);
> +	else
> +		rc = pm8xxx_rtc_write_uefi_offset(rtc_dd, offset);
> +
>  	if (rc)
>  		return rc;
>  
> @@ -488,6 +591,17 @@ static int pm8xxx_rtc_probe(struct platform_device *pdev)
>  		if (rc != -ENOENT)
>  			return rc;
>  		rtc_dd->nvmem_cell = NULL;
> +
> +		/* Use UEFI storage as fallback if available */
> +		rtc_dd->use_uefi = of_property_read_bool(pdev->dev.of_node,
> +							 "qcom,uefi-rtc-info");
> +	}
> +
> +	if (rtc_dd->use_uefi && !efivar_is_available()) {
> +		if (IS_ENABLED(CONFIG_EFI))
> +			return -EPROBE_DEFER;
> +		dev_warn(&pdev->dev, "efivars not available\n");
> +		rtc_dd->use_uefi = false;
>  	}
>  
>  	rtc_dd->regs = match->data;
> diff --git a/include/linux/rtc.h b/include/linux/rtc.h
> index 1fd9c6a21ebe..1ecee2fe4214 100644
> --- a/include/linux/rtc.h
> +++ b/include/linux/rtc.h
> @@ -169,6 +169,7 @@ struct rtc_device {
>  /* useful timestamps */
>  #define RTC_TIMESTAMP_BEGIN_0000	-62167219200ULL /* 0000-01-01 00:00:00 */
>  #define RTC_TIMESTAMP_BEGIN_1900	-2208988800LL /* 1900-01-01 00:00:00 */
> +#define RTC_TIMESTAMP_BEGIN_GPS		315964800LL /* 1980-01-06 00:00:00 */

I'd use RTC_TIMESTAMP_EPOCH_GPS but really, I would prefer the UNIX epoch
to be used

>  #define RTC_TIMESTAMP_BEGIN_2000	946684800LL /* 2000-01-01 00:00:00 */
>  #define RTC_TIMESTAMP_END_2063		2966371199LL /* 2063-12-31 23:59:59 */
>  #define RTC_TIMESTAMP_END_2079		3471292799LL /* 2079-12-31 23:59:59 */
> -- 
> 2.39.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
