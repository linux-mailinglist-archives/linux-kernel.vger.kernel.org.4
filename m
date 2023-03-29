Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDE06CD72D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 12:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjC2KBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 06:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbjC2KB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 06:01:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0764449B;
        Wed, 29 Mar 2023 03:01:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F8FAB81E4A;
        Wed, 29 Mar 2023 10:01:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5973DC433EF;
        Wed, 29 Mar 2023 10:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680084077;
        bh=HLgUKelU0wpZXUmK9lUbFUaWqOLrW4Tre5ECAbWgGJs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UZq9A7FpRZWqSyrkBy8OBMtflA3ixgYLdTgfHrGZZfWwqr5d9l6pBnxNu+qFHzKIF
         mH5Gnof2s3Y/wcFmK2z9PQenmstJuQ05mGZkRmyzZPrU7FTwv+poMxyravZZqbrFGv
         YhvFyH9hDOUNVl34SDCd9B8kKqLTOH3yQcxZ6F0M=
Date:   Wed, 29 Mar 2023 12:01:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Vaibhaav Ram T.L" <vaibhaavram.tl@microchip.com>
Cc:     arnd@arndb.de, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kumaravel.thiagarajan@microchip.com,
        tharunkumar.pasumarthi@microchip.com, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v8 char-misc-next 2/5] misc: microchip: pci1xxxx: Add OTP
 Functionality to read and write into OTP bin sysfs
Message-ID: <ZCQMawjj03rlmUxK@kroah.com>
References: <20230328144008.4113-1-vaibhaavram.tl@microchip.com>
 <20230328144008.4113-3-vaibhaavram.tl@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328144008.4113-3-vaibhaavram.tl@microchip.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 08:10:05PM +0530, Vaibhaav Ram T.L wrote:
> From: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
> 
> Microchip's pci1xxxx is an unmanaged PCIe3.1a switch for consumer,
> industrial, and automotive applications. This switch integrates OTP 
> and EEPROM to enable customization of the part in the field. 
> This patch adds the OTP functionality to support the same.

Why not just use the in-kernel eeprom api instead of creating your own
custom user/kernel api?  Why is this so special to deserve that?

> 
> Co-developed-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
> Signed-off-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
> Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
> Signed-off-by: Vaibhaav Ram T.L <vaibhaavram.tl@microchip.com>
> ---
>  drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c | 198 ++++++++++++++++++
>  drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.h |   7 +-
>  2 files changed, 204 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c
> index 64302fdfbefc..bf175e22090e 100644
> --- a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c
> +++ b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c
> @@ -3,13 +3,210 @@
>  
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
> +#include <linux/iopoll.h>
>  #include <linux/pci.h>
>  #include <linux/idr.h>
>  #include <linux/io.h>
>  #include "mchp_pci1xxxx_gp.h"
>  
> +#define OTP_NAME			"pci1xxxx_otp"
>  #define PCI_DRIVER_NAME			"PCI1xxxxGP"
>  
> +#define MMAP_CFG_OFFSET(x)		(CONFIG_REG_ADDR_BASE + x)
> +#define MMAP_OTP_OFFSET(x)		(OTP_REG_ADDR_BASE + x)
> +
> +#define OTP_SIZE_BYTES			8192
> +
> +#define CONFIG_REG_ADDR_BASE		0
> +#define OTP_REG_ADDR_BASE		0x1000
> +
> +#define OTP_ADDR_HIGH_OFFSET		0x04
> +#define OTP_ADDR_LOW_OFFSET		0x08
> +#define OTP_PRGM_DATA_OFFSET		0x10
> +#define OTP_PRGM_MODE_OFFSET		0x14
> +#define OTP_RD_DATA_OFFSET		0x18
> +#define OTP_FUNC_CMD_OFFSET		0x20
> +#define OTP_CMD_GO_OFFSET		0x28
> +#define OTP_PASS_FAIL_OFFSET		0x2C
> +#define OTP_STATUS_OFFSET		0x30
> +
> +#define OTP_FUNC_RD_BIT			BIT(0)
> +#define OTP_FUNC_PGM_BIT		BIT(1)
> +#define OTP_CMD_GO_BIT			BIT(0)
> +#define OTP_STATUS_BUSY_BIT		BIT(0)
> +#define OTP_PGM_MODE_BYTE_BIT		BIT(0)
> +#define OTP_FAIL_BIT			BIT(0)
> +
> +#define STATUS_READ_DELAY_US		1
> +#define STATUS_READ_TIMEOUT_US		20000
> +
> +#define CFG_SYS_LOCK_OFFSET		0xA0
> +#define CFG_SYS_LOCK_PF3		BIT(5)
> +
> +#define BYTE_LOW			(GENMASK(7, 0))
> +#define BYTE_HIGH			(GENMASK(12, 8))
> +
> +static int set_sys_lock(struct pci1xxxx_otp_eeprom_device *priv)
> +{
> +	void __iomem *sys_lock = priv->reg_base +
> +				 MMAP_CFG_OFFSET(CFG_SYS_LOCK_OFFSET);
> +	u8 data;
> +
> +	writel(CFG_SYS_LOCK_PF3, sys_lock);
> +	data = readl(sys_lock);
> +	if (data != CFG_SYS_LOCK_PF3)
> +		return -EPERM;
> +
> +	return 0;
> +}
> +
> +static void release_sys_lock(struct pci1xxxx_otp_eeprom_device *priv)
> +{
> +	void __iomem *sys_lock = priv->reg_base +
> +				 MMAP_CFG_OFFSET(CFG_SYS_LOCK_OFFSET);
> +	writel(0, sys_lock);
> +}
> +
> +static void otp_device_set_address(struct pci1xxxx_otp_eeprom_device *priv,
> +				   u16 address)
> +{
> +	u16 lo, hi;
> +
> +	lo = address & BYTE_LOW;
> +	hi = (address & BYTE_HIGH) >> 8;
> +	writew(lo, priv->reg_base + MMAP_OTP_OFFSET(OTP_ADDR_LOW_OFFSET));
> +	writew(hi, priv->reg_base + MMAP_OTP_OFFSET(OTP_ADDR_HIGH_OFFSET));
> +}
> +
> +static ssize_t pci1xxxx_otp_read(struct file *filp, struct kobject *kobj,
> +				 struct bin_attribute *bin_attr,
> +				 char *buf, loff_t off, size_t count)
> +{
> +	struct pci1xxxx_otp_eeprom_device *priv;
> +	struct device *dev;
> +	void __iomem *rb;
> +	u32 regval;
> +	u32 byte;
> +	int ret;
> +	u8 data;
> +
> +	dev = container_of(kobj, struct device, kobj);
> +	priv = dev_get_drvdata(dev);
> +	if (priv != NULL)
> +		rb = priv->reg_base;
> +	else
> +		return -ENODEV;
> +
> +	ret = set_sys_lock(priv);
> +	if (ret)
> +		return ret;
> +
> +	for (byte = 0; byte < count; byte++) {
> +		otp_device_set_address(priv, (u16)(off + byte));
> +		data = readl(rb + MMAP_OTP_OFFSET(OTP_FUNC_CMD_OFFSET));
> +		writel(data | OTP_FUNC_RD_BIT,
> +		       rb + MMAP_OTP_OFFSET(OTP_FUNC_CMD_OFFSET));
> +		data = readl(rb + MMAP_OTP_OFFSET(OTP_CMD_GO_OFFSET));
> +		writel(data | OTP_CMD_GO_BIT,
> +		       rb + MMAP_OTP_OFFSET(OTP_CMD_GO_OFFSET));
> +
> +		ret = read_poll_timeout(readl, regval,
> +					!(regval & OTP_STATUS_BUSY_BIT),
> +					STATUS_READ_DELAY_US,
> +					STATUS_READ_TIMEOUT_US, true,
> +					rb + MMAP_OTP_OFFSET(OTP_STATUS_OFFSET));
> +
> +		data = readl(rb + MMAP_OTP_OFFSET(OTP_PASS_FAIL_OFFSET));
> +		if (ret < 0 || data & OTP_FAIL_BIT)
> +			break;
> +
> +		buf[byte] = readl(rb + MMAP_OTP_OFFSET(OTP_RD_DATA_OFFSET));
> +	}
> +	release_sys_lock(priv);
> +
> +	return byte;
> +}
> +
> +static ssize_t pci1xxxx_otp_write(struct file *filp, struct kobject *kobj,
> +				  struct bin_attribute *bin_attr,
> +				  char *value, loff_t off, size_t count)
> +{
> +	struct pci1xxxx_otp_eeprom_device *priv;
> +	struct device *dev;
> +	void __iomem *rb;
> +	u32 regval;
> +	u32 byte;
> +	int ret;
> +	u8 data;
> +
> +	dev = container_of(kobj, struct device, kobj);
> +	priv = dev_get_drvdata(dev);
> +	if (priv != NULL)
> +		rb = priv->reg_base;
> +	else
> +		return -ENODEV;
> +
> +	ret = set_sys_lock(priv);
> +	if (ret)
> +		return ret;
> +
> +	for (byte = 0; byte < count; byte++) {
> +		otp_device_set_address(priv, (u16)(off + byte));
> +
> +		/*
> +		 * Set OTP_PGM_MODE_BYTE command bit in OTP_PRGM_MODE register
> +		 * to enable Byte programming
> +		 */
> +		data = readl(rb + MMAP_OTP_OFFSET(OTP_PRGM_MODE_OFFSET));
> +		writel(data | OTP_PGM_MODE_BYTE_BIT,
> +		       rb + MMAP_OTP_OFFSET(OTP_PRGM_MODE_OFFSET));
> +		writel(*(value + byte), rb + MMAP_OTP_OFFSET(OTP_PRGM_DATA_OFFSET));
> +		data = readl(rb + MMAP_OTP_OFFSET(OTP_FUNC_CMD_OFFSET));
> +		writel(data | OTP_FUNC_PGM_BIT,
> +		       rb + MMAP_OTP_OFFSET(OTP_FUNC_CMD_OFFSET));
> +		data = readl(rb + MMAP_OTP_OFFSET(OTP_CMD_GO_OFFSET));
> +		writel(data | OTP_CMD_GO_BIT,
> +		       rb + MMAP_OTP_OFFSET(OTP_CMD_GO_OFFSET));
> +
> +		ret = read_poll_timeout(readl, regval,
> +					!(regval & OTP_STATUS_BUSY_BIT),
> +					STATUS_READ_DELAY_US,
> +					STATUS_READ_TIMEOUT_US, true,
> +					rb + MMAP_OTP_OFFSET(OTP_STATUS_OFFSET));
> +
> +		data = readl(rb + MMAP_OTP_OFFSET(OTP_PASS_FAIL_OFFSET));
> +		if (ret < 0 || data & OTP_FAIL_BIT)
> +			break;
> +	}
> +	release_sys_lock(priv);
> +
> +	return byte;
> +}
> +
> +static struct bin_attribute pci1xxxx_otp_attr = {
> +	.attr = {
> +		.name = OTP_NAME,
> +		.mode = 0600,
> +	},
> +	.size = OTP_SIZE_BYTES,
> +	.read = pci1xxxx_otp_read,
> +	.write = pci1xxxx_otp_write,
> +};
> +
> +static struct bin_attribute *pci1xxxx_bin_attributes[] = {
> +	&pci1xxxx_otp_attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group pci1xxxx_bin_attributes_group = {
> +	.bin_attrs = pci1xxxx_bin_attributes,
> +};
> +
> +static const struct attribute_group *pci1xxxx_bin_attributes_groups[] = {
> +	&pci1xxxx_bin_attributes_group,
> +	NULL
> +};
> +
>  struct aux_bus_device {
>  	struct auxiliary_device_wrapper *aux_device_wrapper[2];
>  };
> @@ -55,6 +252,7 @@ static int gp_aux_bus_probe(struct pci_dev *pdev, const struct pci_device_id *id
>  	otp_eeprom_wrapper->aux_dev.name = aux_dev_otp_e2p_name;
>  	otp_eeprom_wrapper->aux_dev.dev.parent = &pdev->dev;
>  	otp_eeprom_wrapper->aux_dev.dev.release = gp_auxiliary_device_release;
> +	otp_eeprom_wrapper->aux_dev.dev.groups = pci1xxxx_bin_attributes_groups;
>  	otp_eeprom_wrapper->aux_dev.id = retval;
>  
>  	otp_eeprom_wrapper->gp_aux_data.region_start = pci_resource_start(pdev, 0);
> diff --git a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.h b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.h
> index 37eec73b20d7..c6238a817dc6 100644
> --- a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.h
> +++ b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.h
> @@ -1,5 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -/* Copyright (C) 2022 Microchip Technology Inc. */
> +/* Copyright (C) 2022-2023 Microchip Technology Inc. */
>  
>  #ifndef _GPIO_PCI1XXXX_H
>  #define _GPIO_PCI1XXXX_H
> @@ -25,4 +25,9 @@ struct auxiliary_device_wrapper {
>  	struct gp_aux_data_type gp_aux_data;
>  };
>  
> +struct pci1xxxx_otp_eeprom_device {
> +	struct auxiliary_device *pdev;
> +	void __iomem *reg_base;
> +	bool is_eeprom_present;

This field is never used, why have it?

> +};

Why does this need to be in the .h file and not in the .c file?

thanks,

greg k-h
