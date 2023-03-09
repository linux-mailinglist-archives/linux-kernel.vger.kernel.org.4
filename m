Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACAA6B2208
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 11:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjCIK67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 05:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjCIK60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 05:58:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26483E9CC8
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 02:56:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFBA861B03
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 10:56:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 416FDC433EF;
        Thu,  9 Mar 2023 10:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678359366;
        bh=0oDrPDiWkMDtNERrQf6U9AWZF+RQxD7E3XpXFfctvaY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=grslmYf0Pbiml0j4raBXDMvWt8Gj68htjk3AqHU7Lh22+ezOUr2ORtVLTVb7iZdEg
         AsBdBr/LqOojkiZqmoVMHp77yn1XnNnJppyxlmgVn/affquGQnIGxMVT6FLRok4/vU
         noxsVZfotk1JCppOQWXnUXLiYWaov5A48iNtc1eQ=
Date:   Thu, 9 Mar 2023 11:55:56 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Vaibhaav Ram T.L" <vaibhaavram.tl@microchip.com>
Cc:     arnd@arndb.de, kumaravel.thiagarajan@microchip.com,
        linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Subject: Re: [PATCH v7 char-misc-next] misc: microchip: pci1xxxx: Add
 OTP/EEPROM driver for the pci1xxxx switch
Message-ID: <ZAm7PDSIUN5HMxUu@kroah.com>
References: <20230303170426.353-1-vaibhaavram.tl@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303170426.353-1-vaibhaavram.tl@microchip.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 10:34:26PM +0530, Vaibhaav Ram T.L wrote:
> +#define MMAP_EEPROM_OFFSET(x)		(EEPROM_REG_ADDR_BASE + x)
> +#define MMAP_CFG_OFFSET(x)		(CONFIG_REG_ADDR_BASE + x)
> +#define MMAP_OTP_OFFSET(x)              (OTP_REG_ADDR_BASE + x)

No tabs?

> +#define EEPROM_SIZE_BYTES		8192
> +#define OTP_SIZE_BYTES			8192
> +
> +#define PERI_PF3_SYSTEM_REG_ADDR_BASE	0x2000
> +#define PERI_PF3_SYSTEM_REG_LENGTH	0x4000
> +
> +#define CONFIG_REG_ADDR_BASE		0
> +#define EEPROM_REG_ADDR_BASE		0x0E00
> +#define OTP_REG_ADDR_BASE               0x1000
> +
> +#define OTP_PWR_DN_OFFSET		0x00
> +#define OTP_ADDR_HIGH_OFFSET            0x04
> +#define OTP_ADDR_LOW_OFFSET             0x08
> +#define OTP_PRGM_DATA_OFFSET		0x10
> +#define OTP_PRGM_MODE_OFFSET		0x14
> +#define OTP_RD_DATA_OFFSET		0x18
> +#define OTP_FUNC_CMD_OFFSET             0x20
> +#define OTP_CMD_GO_OFFSET               0x28
> +#define OTP_PASS_FAIL_OFFSET		0x2C
> +#define OTP_STATUS_OFFSET               0x30
> +
> +#define OTP_PWR_DN_BIT			BIT(0)
> +#define OTP_FUNC_RD_BIT                 BIT(0)
> +#define OTP_FUNC_PGM_BIT		BIT(1)
> +#define OTP_CMD_GO_BIT                  BIT(0)
> +#define OTP_STATUS_BUSY_BIT             BIT(0)
> +#define OTP_PGM_MODE_BYTE_BIT		BIT(0)
> +#define OTP_FAIL_BIT			BIT(0)
> +
> +#define EEPROM_CMD_REG			0x00
> +#define EEPROM_DATA_REG			0x04
> +#define EEPROM_CFG_REG			0x08
> +
> +#define EEPROM_CFG_BAUD_RATE_100KHZ     BIT(9)
> +#define EEPROM_CFG_SIZE_SEL             BIT(12)
> +#define EEPROM_CFG_PULSE_WIDTH_100KHZ   (BIT(17) | BIT(16))
> +
> +#define EEPROM_CMD_EPC_WRITE		(BIT(29) | BIT(28))
> +#define EEPROM_CMD_EPC_BUSY_BIT		BIT(31)
> +#define EEPROM_CMD_EPC_TIMEOUT_BIT	BIT(17)
> +
> +#define STATUS_READ_DELAY_US		1
> +#define STATUS_READ_TIMEOUT_US		20000
> +
> +#define CFG_SYS_LOCK_OFFSET		0xA0
> +#define CFG_SYS_LOCK_PF3		BIT(5)
> +
> +#define BYTE_LOW			0x00FF
> +#define BYTE_HIGH			0x1F00
> +
> +struct pci1xxxx_otp_eeprom_device {
> +	struct auxiliary_device *pdev;
> +	void __iomem *reg_base;
> +	bool is_eeprom_present;
> +};
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
> +		return -EBUSY;

Why not do the dev_err() call here instead of having to do it everywhere
you call it and check for an error?

Also, why tell userspace about this, what can they do about it?


> +
> +	return 0;
> +}
> +
> +static int release_sys_lock(struct pci1xxxx_otp_eeprom_device *priv)
> +{
> +	void __iomem *sys_lock = priv->reg_base +
> +				 MMAP_CFG_OFFSET(CFG_SYS_LOCK_OFFSET);
> +	u8 data;
> +
> +	data = readl(sys_lock);
> +	if (data != CFG_SYS_LOCK_PF3)
> +		return 0;
> +
> +	writel(0, sys_lock);
> +	data = readl(sys_lock);
> +	if (data & CFG_SYS_LOCK_PF3)
> +		return -EBUSY;
> +
> +	return 0;
> +}
> +
> +static void get_pointers_from_kobj(struct kobject *kobj, struct device **p_dev,
> +				   struct pci1xxxx_otp_eeprom_device **p_priv,
> +				   void __iomem **p_rb)
> +{
> +	*p_dev = container_of(kobj, struct device, kobj);
> +	*p_priv = dev_get_drvdata(*p_dev);
> +	*p_rb = (*p_priv)->reg_base;

Ick, no, sorry, just open-code this whenever you need it, as sometimes
you do not need all of these, right?

Also, any need to verify that p_priv is not NULL?  Can that happen when
the device is removed and the file is still open?



> +}
> +
> +static ssize_t pci1xxxx_eeprom_read(struct file *filp, struct kobject *kobj,
> +				    struct bin_attribute *bin_attr,
> +				    char *buf, loff_t off, size_t count)
> +{
> +	struct pci1xxxx_otp_eeprom_device *priv;
> +	struct device *dev;
> +	void __iomem *rb;
> +	u32 regval;
> +	u32 byte;
> +	int ret;
> +
> +	get_pointers_from_kobj(kobj, &dev, &priv, &rb);
> +
> +	ret = set_sys_lock(priv);
> +	if (ret) {
> +		dev_err(dev, "SYS_LOCK_NOT_SET\n");
> +		return ret;
> +	}
> +
> +	for (byte = 0; byte < count; byte++) {
> +		writel(EEPROM_CMD_EPC_BUSY_BIT | (off + byte), rb +
> +		       MMAP_EEPROM_OFFSET(EEPROM_CMD_REG));
> +
> +		ret = read_poll_timeout(readl, regval,
> +					!(regval & EEPROM_CMD_EPC_BUSY_BIT),
> +					STATUS_READ_DELAY_US,
> +					STATUS_READ_TIMEOUT_US, true,
> +					rb + MMAP_EEPROM_OFFSET(EEPROM_CMD_REG));
> +		if (ret < 0 || (!ret && (regval & EEPROM_CMD_EPC_TIMEOUT_BIT)))
> +			return -EBUSY;

Shouldn't you return a short read if you do not read the full amount?
That tells userspace they need to resubmit the rest, otherwise they have
no idea how many bytes were successfully read.


> +
> +		buf[byte] = readl(rb + MMAP_EEPROM_OFFSET(EEPROM_DATA_REG));
> +	}
> +
> +	ret = release_sys_lock(priv);
> +	if (ret)
> +		dev_err(dev, "SYS_LOCK_NOT_RELEASED\n");

No error return value?

> +
> +	return count;
> +}
> +
> +
> +static ssize_t pci1xxxx_eeprom_write(struct file *filp, struct kobject *kobj,
> +				     struct bin_attribute *bin_attr,
> +				     char *value, loff_t off, size_t count)
> +{
> +	struct pci1xxxx_otp_eeprom_device *priv;
> +	struct device *dev;
> +	void __iomem *rb;
> +	u32 regval;
> +	u32 byte;
> +	int ret;
> +
> +	get_pointers_from_kobj(kobj, &dev, &priv, &rb);
> +
> +	ret = set_sys_lock(priv);
> +	if (ret) {
> +		dev_err(dev, "SYS_LOCK_NOT_SET\n");
> +		return ret;
> +	}
> +
> +	for (byte = 0; byte < count; byte++) {
> +		writel(*(value + byte), rb + MMAP_EEPROM_OFFSET(EEPROM_DATA_REG));
> +		regval = EEPROM_CMD_EPC_TIMEOUT_BIT | EEPROM_CMD_EPC_WRITE |
> +			 (off + byte);
> +		writel(regval, rb + MMAP_EEPROM_OFFSET(EEPROM_CMD_REG));
> +		writel(EEPROM_CMD_EPC_BUSY_BIT | regval,
> +		       rb + MMAP_EEPROM_OFFSET(EEPROM_CMD_REG));
> +
> +		ret = read_poll_timeout(readl, regval,
> +					!(regval & EEPROM_CMD_EPC_BUSY_BIT),
> +					STATUS_READ_DELAY_US,
> +					STATUS_READ_TIMEOUT_US, true,
> +					rb + MMAP_EEPROM_OFFSET(EEPROM_CMD_REG));
> +		if (ret < 0 || (!ret && (regval & EEPROM_CMD_EPC_TIMEOUT_BIT)))
> +			return -EBUSY;

Same as above, return a short write, otherwise userspace can never
recover properly.

How was this tested and never noticed?

> +	}
> +
> +	ret = release_sys_lock(priv);
> +	if (ret)
> +		dev_err(dev, "SYS_LOCK_NOT_RELEASED\n");

Again, no error?

> +
> +	return count;
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
> +	get_pointers_from_kobj(kobj, &dev, &priv, &rb);
> +
> +	ret = set_sys_lock(priv);
> +	if (ret) {
> +		dev_err(dev, "SYS_LOCK_NOT_SET\n");
> +		return ret;
> +	}
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
> +		if (ret < 0)
> +			return -EBUSY;

Again, short read please.

> +
> +		buf[byte] = readl(rb + MMAP_OTP_OFFSET(OTP_RD_DATA_OFFSET));
> +	}
> +
> +	ret = release_sys_lock(priv);
> +	if (ret)
> +		dev_err(dev, "SYS_LOCK_NOT_RELEASED\n");

If this can not cause an error, don't tell userspace that an error
happened.

> +
> +	return count;
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
> +	get_pointers_from_kobj(kobj, &dev, &priv, &rb);
> +
> +	ret = set_sys_lock(priv);
> +	if (ret) {
> +		dev_err(dev, "SYS_LOCK_NOT_SET\n");
> +		return ret;
> +	}
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
> +		if (ret < 0)
> +			return -EBUSY;
> +
> +		data = readl(rb + MMAP_OTP_OFFSET(OTP_PASS_FAIL_OFFSET));
> +		if (data & OTP_FAIL_BIT)
> +			return -EFAULT;

Again, short write please.

> +	}
> +
> +	ret = release_sys_lock(priv);
> +	if (ret)
> +		dev_err(dev, "SYS_LOCK_NOT_RELEASED\n");
> +
> +	return count;
> +}
> +
> +static const struct bin_attribute pci1xxxx_eeprom_attr = {
> +	.attr = {
> +		.name = EEPROM_NAME,
> +		.mode = 0777,
> +	},
> +	.size = EEPROM_SIZE_BYTES,
> +	.read = pci1xxxx_eeprom_read,
> +	.write = pci1xxxx_eeprom_write,
> +};
> +
> +static const struct bin_attribute pci1xxxx_otp_attr = {
> +	.attr = {
> +		.name = OTP_NAME,
> +		.mode = 0777,
> +	},
> +	.size = OTP_SIZE_BYTES,
> +	.read = pci1xxxx_otp_read,
> +	.write = pci1xxxx_otp_write,

You have new sysfs binary attributes, where are they documented?


> +};
> +
> +
> +static bool is_eeprom_responsive(struct pci1xxxx_otp_eeprom_device *priv)
> +{
> +	void __iomem *rb = priv->reg_base;
> +	u32 data;
> +	int ret;
> +
> +	if (set_sys_lock(priv))
> +		return false;
> +
> +	writel((EEPROM_CFG_PULSE_WIDTH_100KHZ | EEPROM_CFG_SIZE_SEL |
> +		EEPROM_CFG_BAUD_RATE_100KHZ),
> +		rb + MMAP_EEPROM_OFFSET(EEPROM_CFG_REG));
> +
> +	writel(EEPROM_CMD_EPC_TIMEOUT_BIT, rb + MMAP_EEPROM_OFFSET(EEPROM_CMD_REG));
> +	writel(EEPROM_CMD_EPC_BUSY_BIT, rb + MMAP_EEPROM_OFFSET(EEPROM_CMD_REG));
> +
> +	/* Wait for the EPC_BUSY bit to get cleared or timeout bit to get set*/
> +	ret = read_poll_timeout(readl, data, !(data & EEPROM_CMD_EPC_BUSY_BIT),
> +				STATUS_READ_DELAY_US, STATUS_READ_TIMEOUT_US,
> +				true, rb + MMAP_EEPROM_OFFSET(EEPROM_CMD_REG));
> +
> +	release_sys_lock(priv);
> +	/* Return failure if either of software or hardware timeouts happen */
> +	if (ret < 0 || (!ret && (data & EEPROM_CMD_EPC_TIMEOUT_BIT))) {
> +		dev_err(&priv->pdev->dev,
> +			"EPC_Timeout, EEPROM is unresponsive: %x\n", data);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +static int otp_eeprom_create_device(struct auxiliary_device *aux_dev)
> +{
> +	struct auxiliary_device_wrapper *aux_dev_wrapper;
> +	struct pci1xxxx_otp_eeprom_device *priv;
> +	struct gp_aux_data_type *pdata;
> +	int ret;
> +	u8 data;
> +
> +	aux_dev_wrapper = container_of(aux_dev, struct auxiliary_device_wrapper,
> +				       aux_dev);
> +	pdata = &aux_dev_wrapper->gp_aux_data;
> +	if (!pdata)
> +		return dev_err_probe(&aux_dev->dev, -EINVAL,
> +				     "Invalid data in aux_dev_wrapper->gp_aux_data\n");
> +
> +	priv = devm_kzalloc(&aux_dev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return dev_err_probe(&aux_dev->dev, -ENOMEM,
> +				     "Memory Allocation Failed\n");
> +
> +	priv->pdev = aux_dev;
> +	dev_set_drvdata(&aux_dev->dev, priv);
> +
> +	if (!devm_request_mem_region(&aux_dev->dev, pdata->region_start +
> +				     PERI_PF3_SYSTEM_REG_ADDR_BASE,
> +				     PERI_PF3_SYSTEM_REG_LENGTH,
> +				     aux_dev->name))
> +		return dev_err_probe(&aux_dev->dev, -ENOMEM,
> +				     "can't request otpeeprom region\n");
> +
> +	priv->reg_base = devm_ioremap(&aux_dev->dev, pdata->region_start +
> +				      PERI_PF3_SYSTEM_REG_ADDR_BASE,
> +				      PERI_PF3_SYSTEM_REG_LENGTH);
> +	if (!priv->reg_base)
> +		return dev_err_probe(&aux_dev->dev, -ENOMEM, "ioremap failed\n");
> +
> +	ret = sysfs_create_bin_file(&aux_dev->dev.kobj, &pci1xxxx_otp_attr);

You just raced with userspace and lost.  Please never do that, use a
default group instead.

AND you totally ignored the return value here, that's obviously wrong.

> +
> +	/* Set OTP_PWR_DN to 0 to make OTP Operational */
> +	data = readl(priv->reg_base + MMAP_OTP_OFFSET(OTP_PWR_DN_OFFSET));
> +	writel(data & ~OTP_PWR_DN_BIT,
> +	       priv->reg_base + MMAP_OTP_OFFSET(OTP_PWR_DN_OFFSET));
> +	if (ret) {
> +		writel(OTP_PWR_DN_BIT,
> +		       priv->reg_base + MMAP_OTP_OFFSET(OTP_PWR_DN_OFFSET));
> +		return dev_err_probe(&aux_dev->dev, ret,
> +				     "sysfs_create_bin_file otp failed\n");
> +	}
> +
> +	if (is_eeprom_responsive(priv)) {
> +		ret = sysfs_create_bin_file(&aux_dev->dev.kobj,
> +					    &pci1xxxx_eeprom_attr);

Again, default group will handle this automatically, you should never
need to call a sysfs_*() call from a driver.  Otherwise something is
usually very wrong.

thanks,

greg k-h
