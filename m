Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B65688D3F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 03:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbjBCCsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 21:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbjBCCsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 21:48:15 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B2A2B1F5DA;
        Thu,  2 Feb 2023 18:48:10 -0800 (PST)
Received: from loongson.cn (unknown [10.20.42.133])
        by gateway (Coremail) with SMTP id _____8DxSurpddxjJxUNAA--.26113S3;
        Fri, 03 Feb 2023 10:48:09 +0800 (CST)
Received: from [10.20.42.133] (unknown [10.20.42.133])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxY+Xkddxj6DUoAA--.43750S3;
        Fri, 03 Feb 2023 10:48:06 +0800 (CST)
Message-ID: <c5925b1c-8251-43e4-9ca2-6d3dfb45025d@loongson.cn>
Date:   Fri, 3 Feb 2023 10:48:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v11 7/7] drm/lsdc: add drm driver for loongson display
 controller
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Sui Jingfeng <15330273260@189.cn>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Qing Zhang <zhangqing@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, kernel test robot <lkp@intel.com>
References: <20220321162916.1116541-1-15330273260@189.cn>
 <20220321162916.1116541-8-15330273260@189.cn>
 <Yjo2R5LQrRICr7dC@robh.at.kernel.org>
From:   suijingfeng <suijingfeng@loongson.cn>
In-Reply-To: <Yjo2R5LQrRICr7dC@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxY+Xkddxj6DUoAA--.43750S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvAXoW3Kr47ZryDZw1fGw4kXFyxXwb_yoW8WrW7Wo
        WfZwsIvw1xtry2y345A34xXFZIv3sruw13Aa17ArnxCrWjg3Z8GF1aqw1rur4fCr43Aa18
        Aa4jgws8AF4jv3Wfn29KB7ZKAUJUUUjU529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
        J3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnRJU
        UUPab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s
        0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
        ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
        M2kKe7AKxVWUtVW8ZwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zV
        CFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2
        z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2
        IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E
        4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jw0_GFylx2IqxVAqx4xG67AKxVWUJVWUGw
        C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48J
        MIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMI
        IF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E
        87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUShiSDUUUU
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/3/23 04:49, Rob Herring wrote:
> On Tue, Mar 22, 2022 at 12:29:16AM +0800, Sui Jingfeng wrote:
>> From: suijingfeng <suijingfeng@loongson.cn>
>>
>> There is a display controller in loongson's LS2K1000 SoC and LS7A1000
>> bridge chip, the display controller is a PCI device in those chips. It
>> has two display pipes but with only one hardware cursor. Each way has
>> a DVO interface which provide RGB888 signals, vertical & horizontal
>> synchronisations, data enable and the pixel clock. Each CRTC is able to
>> scanout from 1920x1080 resolution at 60Hz, the maxmium resolution is
>> 2048x2048 according to the hardware spec. Loongson display controllers
>> are simple which require scanout buffers to be physically contiguous.
>>
>> For LS7A1000 bridge chip, the DC is equipped with a dedicated video RAM
>> which is typically 64MB or more. In this case, VRAM helper based driver
>> is intend to be used. While LS2K1000 is a SoC, only system memory is
>> available. Therefore CMA helper based driver is intend to be used. It is
>> possible to use VRAM helper based solution by carving out part of system
>> memory as VRAM though.
>>
>> For LS7A1000, there are 4 dedicated GPIOs whose control register is
>> located at the DC register space, They are used to emulate two way i2c.
>> One for DVO0, another for DVO1. LS2K1000 and LS2K0500 SoC don't have such
>> GPIO hardwared, they grab i2c adapter from other module, either general
>> purpose GPIO emulated i2c or hardware i2c adapter.
>>
>>      +------+            +-----------------------------------+
>>      | DDR4 |            |  +-------------------+            |
>>      +------+            |  | PCIe Root complex |   LS7A1000 |
>>         || MC0           |  +--++---------++----+            |
>>    +----------+  HT 3.0  |     ||         ||                 |
>>    | LS3A4000 |<-------->| +---++---+  +--++--+    +---------+   +------+
>>    |   CPU    |<-------->| | GC1000 |  | LSDC |<-->| DDR3 MC |<->| VRAM |
>>    +----------+          | +--------+  +-+--+-+    +---------+   +------+
>>         || MC1           +---------------|--|----------------+
>>      +------+                            |  |
>>      | DDR4 |          +-------+   DVO0  |  |  DVO1   +------+
>>      +------+   VGA <--|ADV7125|<--------+  +-------->|TFP410|--> DVI/HDMI
>>                        +-------+                      +------+
>>
>> The above picture give a simple usage of LS7A1000, note that the encoder
>> is not necessary adv7125 or tfp410, other candicates can be ch7034b,
>> sil9022, ite66121 and lt8618 etc.
>>
>> v2: Fixup warnings reported by kernel test robot
>>
>> v3: Fix more grammar mistakes in Kconfig reported by Randy Dunlap and give
>>      more details about lsdc.
>>
>> v4:
>>     1) Add dts required and explain why device tree is required.
>>     2) Give more description about lsdc and VRAM helper based driver.
>>     3) Fix warnings reported by kernel test robot.
>>     4) Introduce stride_alignment member into struct lsdc_chip_desc, the
>>        stride alignment is 256 bytes for ls7a1000, ls2k1000 and ls2k0500.
>>
>> v5:
>>     1) Using writel and readl replace writeq and readq, to fix kernel test
>>        robot report build error on other archtecture.
>>     2) Set default fb format to XRGB8888 at crtc reset time.
>>
>> v6:
>>     1) Explain why we are not switch to drm dridge subsystem on ls2k1000.
>>     2) Explain why tiny drm driver is not suitable for us.
>>     3) Give a short description of the trival dirty uppdate implement based
>>        on CMA helper.
>>
>> v7:
>>     1) Remove select I2C_GPIO and I2C_LS2X in Kconfig, it is not ready now
>>     2) Licensing issues are fixed suggested by Krzysztof Kozlowski.
>>     3) Remove lsdc_pixpll_print(), part of it move to debugfs.
>>     4) Set prefer_shadow to true if vram based driver is in using.
>>     5) Replace double blank lines with single line in all files.
>>     6) Verbose cmd line parameter is replaced with drm_dbg()
>>     7) All warnnings reported by ./scripts/checkpatch.pl --strict are fixed
>>     8) Get edid from dtb support is removed as suggested by Maxime Ripard
>>     9) Fix typos and various improvement
>>
>> v8:
>>     1) Drop damage update implement and its command line.
>>     2) Drop DRM_LSDC_VRAM_DRIVER config option as suggested by Maxime.
>>     3) Deduce DC's identification from its compatible property.
>>     4) Drop the board specific dts patch.
>>     5) Add documention about the display controller device node.
>>
>> v9:
>>     1) Fix the warnings reported by checkpatch script and fix typos
>>
>> v10:
>>     1) Pass `make dt_binding_check` validation
>>     2) Fix warnings reported by kernel test robot
>>
>> v11:
>>     1) Convert the driver to use drm bridge and of graph framework.
>>     2) Dump register value support through debugfs.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: suijingfeng <suijingfeng@loongson.cn>
>> Signed-off-by: Sui Jingfeng <15330273260@189.cn>
>> Signed-off-by: suijingfeng <suijingfeng@loongson.cn>
>> ---
>>   drivers/gpu/drm/Kconfig             |   2 +
>>   drivers/gpu/drm/Makefile            |   1 +
>>   drivers/gpu/drm/lsdc/Kconfig        |  23 ++
>>   drivers/gpu/drm/lsdc/Makefile       |  13 +
>>   drivers/gpu/drm/lsdc/lsdc_crtc.c    | 396 +++++++++++++++++++
>>   drivers/gpu/drm/lsdc/lsdc_drv.c     | 547 ++++++++++++++++++++++++++
>>   drivers/gpu/drm/lsdc/lsdc_drv.h     | 197 ++++++++++
>>   drivers/gpu/drm/lsdc/lsdc_i2c.c     | 235 ++++++++++++
>>   drivers/gpu/drm/lsdc/lsdc_i2c.h     |  42 ++
>>   drivers/gpu/drm/lsdc/lsdc_irq.c     |  58 +++
>>   drivers/gpu/drm/lsdc/lsdc_irq.h     |  18 +
>>   drivers/gpu/drm/lsdc/lsdc_output.c  | 262 +++++++++++++
>>   drivers/gpu/drm/lsdc/lsdc_output.h  |  24 ++
>>   drivers/gpu/drm/lsdc/lsdc_pci_drv.c | 328 ++++++++++++++++
>>   drivers/gpu/drm/lsdc/lsdc_plane.c   | 470 +++++++++++++++++++++++
>>   drivers/gpu/drm/lsdc/lsdc_pll.c     | 574 ++++++++++++++++++++++++++++
>>   drivers/gpu/drm/lsdc/lsdc_pll.h     |  88 +++++
>>   drivers/gpu/drm/lsdc/lsdc_regs.h    | 220 +++++++++++
>>   18 files changed, 3498 insertions(+)
>>   create mode 100644 drivers/gpu/drm/lsdc/Kconfig
>>   create mode 100644 drivers/gpu/drm/lsdc/Makefile
>>   create mode 100644 drivers/gpu/drm/lsdc/lsdc_crtc.c
>>   create mode 100644 drivers/gpu/drm/lsdc/lsdc_drv.c
>>   create mode 100644 drivers/gpu/drm/lsdc/lsdc_drv.h
>>   create mode 100644 drivers/gpu/drm/lsdc/lsdc_i2c.c
>>   create mode 100644 drivers/gpu/drm/lsdc/lsdc_i2c.h
>>   create mode 100644 drivers/gpu/drm/lsdc/lsdc_irq.c
>>   create mode 100644 drivers/gpu/drm/lsdc/lsdc_irq.h
>>   create mode 100644 drivers/gpu/drm/lsdc/lsdc_output.c
>>   create mode 100644 drivers/gpu/drm/lsdc/lsdc_output.h
>>   create mode 100644 drivers/gpu/drm/lsdc/lsdc_pci_drv.c
>>   create mode 100644 drivers/gpu/drm/lsdc/lsdc_plane.c
>>   create mode 100644 drivers/gpu/drm/lsdc/lsdc_pll.c
>>   create mode 100644 drivers/gpu/drm/lsdc/lsdc_pll.h
>>   create mode 100644 drivers/gpu/drm/lsdc/lsdc_regs.h
> [...]
>
>> diff --git a/drivers/gpu/drm/lsdc/lsdc_i2c.c b/drivers/gpu/drm/lsdc/lsdc_i2c.c
>> new file mode 100644
>> index 000000000000..55beed9266fa
>> --- /dev/null
>> +++ b/drivers/gpu/drm/lsdc/lsdc_i2c.c
>> @@ -0,0 +1,235 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * KMS driver for Loongson display controller
> Not really a useful comment since every file has the same one.
>
>> + * Copyright (C) 2022 Loongson Corporation
>> + */
>> +
>> +/*
>> + * Authors:
>> + *      Sui Jingfeng <suijingfeng@loongson.cn>
>> + */
>> +
>> +#include <linux/i2c.h>
>> +#include <linux/pci.h>
>> +
>> +#include "lsdc_drv.h"
>> +#include "lsdc_regs.h"
>> +#include "lsdc_i2c.h"
>> +
>> +/*
>> + * ls7a_gpio_i2c_set - set the state of a gpio pin indicated by mask
>> + * @mask: gpio pin mask
>> + */
>> +static void ls7a_gpio_i2c_set(struct lsdc_i2c * const li2c, int mask, int state)
>> +{
>> +	unsigned long flags;
>> +	u8 val;
>> +
>> +	spin_lock_irqsave(&li2c->reglock, flags);
> What are you protecting? Doesn't the caller serialize calls to these
> functions?
>
>> +
>> +	if (state) {
>> +		val = readb(li2c->dir_reg);
>> +		val |= mask;
>> +		writeb(val, li2c->dir_reg);
>> +	} else {
>> +		val = readb(li2c->dir_reg);
>> +		val &= ~mask;
>> +		writeb(val, li2c->dir_reg);
>> +
>> +		val = readb(li2c->dat_reg);
>> +		if (state)
> This condition is never true. We're in the 'else' because !state.
>
>> +			val |= mask;
>> +		else
>> +			val &= ~mask;
>> +		writeb(val, li2c->dat_reg);
> Shouldn't you set the data register low first and then change the
> direction? Otherwise, you may be driving high for a moment. However, if
> high is always done by setting the direction as input,

Setting the direction as input will get high, because the external
pull-up resistor will pull the level up.

> why write the
> data register each time? I'm assuming whatever is written to the dat_reg
> is maintained regardless of pin state.
>
Because we have only one data reg corresponding two direction(input and 
output).

our DC hardware design engineer is not good. :(

Value written to the dat_reg will get flushed when pin state changed.

Changed from output to input, for example. Otherwise, how can we read the pin level state back?

>> +	}
>> +
>> +	spin_unlock_irqrestore(&li2c->reglock, flags);
>> +}
>> +
>> +/*
>> + * ls7a_gpio_i2c_get - read value back from gpio pin
>> + * @mask: gpio pin mask
>> + */
>> +static int ls7a_gpio_i2c_get(struct lsdc_i2c * const li2c, int mask)
>> +{
>> +	unsigned long flags;
>> +	u8 val;
>> +
>> +	spin_lock_irqsave(&li2c->reglock, flags);
>> +
>> +	/* first set this pin as input */
>> +	val = readb(li2c->dir_reg);
>> +	val |= mask;
>> +	writeb(val, li2c->dir_reg);
>> +
>> +	/* then get level state from this pin */
>> +	val = readb(li2c->dat_reg);
>> +
>> +	spin_unlock_irqrestore(&li2c->reglock, flags);
>> +
>> +	return (val & mask) ? 1 : 0;
>> +}
>> +
>> +/* set the state on the i2c->sda pin */
>> +static void ls7a_i2c_set_sda(void *i2c, int state)
>> +{
>> +	struct lsdc_i2c * const li2c = (struct lsdc_i2c *)i2c;
>> +
>> +	return ls7a_gpio_i2c_set(li2c, li2c->sda, state);
>> +}
>> +
>> +/* set the state on the i2c->scl pin */
>> +static void ls7a_i2c_set_scl(void *i2c, int state)
>> +{
>> +	struct lsdc_i2c * const li2c = (struct lsdc_i2c *)i2c;
>> +
>> +	return ls7a_gpio_i2c_set(li2c, li2c->scl, state);
>> +}
>> +
>> +/* read the value from the i2c->sda pin */
>> +static int ls7a_i2c_get_sda(void *i2c)
>> +{
>> +	struct lsdc_i2c * const li2c = (struct lsdc_i2c *)i2c;
>> +
>> +	return ls7a_gpio_i2c_get(li2c, li2c->sda);
>> +}
>> +
>> +/* read the value from the i2c->scl pin */
>> +static int ls7a_i2c_get_scl(void *i2c)
>> +{
>> +	struct lsdc_i2c * const li2c = (struct lsdc_i2c *)i2c;
>> +
>> +	return ls7a_gpio_i2c_get(li2c, li2c->scl);
>> +}
>> +
>> +/*
>> + * mainly for dc in ls7a1000 which have builtin gpio emulated i2c
>> + *
>> + * @index : output channel index, 0 for DVO0, 1 for DVO1
>> + */
>> +struct lsdc_i2c *lsdc_create_i2c_chan(struct device *dev, void *base, unsigned int index)
>> +{
>> +	char compat[32] = {0};
>> +	unsigned int udelay = 5;
>> +	unsigned int timeout = 2200;
>> +	int nr = -1;
>> +	struct i2c_adapter *adapter;
>> +	struct lsdc_i2c *li2c;
>> +	struct device_node *i2c_np;
>> +	int ret;
>> +
>> +	li2c = devm_kzalloc(dev, sizeof(*li2c), GFP_KERNEL);
>> +	if (!li2c)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	li2c->index = index;
>> +	li2c->dev = dev;
>> +
>> +	if (index == 0) {
>> +		li2c->sda = 0x01;
>> +		li2c->scl = 0x02;
>> +	} else if (index == 1) {
>> +		li2c->sda = 0x04;
>> +		li2c->scl = 0x08;
> Just require this to be in DT rather than having some default.
>
If only this driver  be used in embedded environment(like arms and 
risc-v), relay on DT solely is the right way.

But Loongson display controller have been applied in both PC class 
desktop(using UEFI+ACPI) and  embedded environment(using DT),  this is 
the key difference. I suddenly realize that  i didn't explain this fact 
clearly at that time.

The default code works in almost 99% case, through.

>> +	}
>> +
>> +	spin_lock_init(&li2c->reglock);
>> +
>> +	snprintf(compat, sizeof(compat), "lsdc,i2c-gpio-%d", index);
> compatible values shouldn't have an index and you shouldn't need a
> index in DT. You need to iterate over child nodes with matching
> compatible.
>
>> +	i2c_np = of_find_compatible_node(dev->of_node, NULL, compat);
>> +	if (i2c_np) {
>> +		u32 sda, scl;
>> +
>> +		dev_dbg(dev, "Has %s property in the DT", compat);
>> +
>> +		/*  */
>> +		ret = of_property_read_u32(i2c_np, "sda", &sda);
> Custom properties need a vendor prefix.
>
>> +		if (ret == 0)
>> +			li2c->sda = 1 << sda;
>> +
>> +		ret = of_property_read_u32(i2c_np, "scl", &scl);
>> +		if (ret == 0)
>> +			li2c->scl = 1 << scl;
>> +
>> +		/* Optional properties which made the driver more flexible */
>> +		of_property_read_u32(i2c_np, "udelay", &udelay);
>> +		of_property_read_u32(i2c_np, "timeout", &timeout);
> These aren't documented. Do you really need them in DT?
>
>> +		of_property_read_u32(i2c_np, "reg", &nr);
>> +	}
>> +
>> +	dev_dbg(dev, "%s: sda=%u, scl=%u, nr=%d, udelay=%u, timeout=%u\n",
>> +		compat, li2c->sda, li2c->scl, nr, udelay, timeout);
>> +
>> +	li2c->reg_base = base;
>> +
>> +	li2c->dir_reg = li2c->reg_base + LS7A_DC_GPIO_DIR_REG;
>> +	li2c->dat_reg = li2c->reg_base + LS7A_DC_GPIO_DAT_REG;
>> +
>> +	li2c->bit.setsda = ls7a_i2c_set_sda;
>> +	li2c->bit.setscl = ls7a_i2c_set_scl;
>> +	li2c->bit.getsda = ls7a_i2c_get_sda;
>> +	li2c->bit.getscl = ls7a_i2c_get_scl;
>> +	li2c->bit.udelay = udelay;
>> +	li2c->bit.timeout = usecs_to_jiffies(timeout);
>> +	li2c->bit.data = li2c;
>> +
>> +	adapter = &li2c->adapter;
>> +	adapter->algo_data = &li2c->bit;
>> +	adapter->owner = THIS_MODULE;
>> +	adapter->class = I2C_CLASS_DDC;
>> +	adapter->dev.parent = dev;
>> +	adapter->nr = nr;
>> +	if (i2c_np) {
>> +		adapter->dev.of_node = i2c_np;
>> +		of_node_put(i2c_np);
>> +	}
>> +
>> +	strscpy(adapter->name, &compat[5], sizeof(adapter->name));
>> +
>> +	i2c_set_adapdata(adapter, li2c);
>> +
>> +	ret = i2c_bit_add_numbered_bus(adapter);
> Why do you care what the bus number is? You shouldn't need to.

Yes, we didn't need that. the i2c core will allocate one for us automatically.

Your advice is valuable, thanks your kindness review.

>> +	if (ret) {
>> +		if (i2c_np)
>> +			of_node_put(i2c_np);
>> +
>> +		devm_kfree(dev, li2c);
>> +		return ERR_PTR(ret);
>> +	}
>> +
>> +	return li2c;
>> +}
>> +
>> +void lsdc_destroy_i2c(struct drm_device *ddev, struct lsdc_i2c *li2c)
>> +{
>> +	struct i2c_adapter *adapter;
>> +
>> +	if (li2c) {
>> +		adapter = &li2c->adapter;
>> +
>> +		if (adapter && adapter->dev.of_node)
>> +			of_node_put(adapter->dev.of_node);
>> +
>> +		devm_kfree(ddev->dev, li2c);
>> +	}
>> +}
>> +
>> +struct i2c_adapter *lsdc_get_i2c_adapter(struct lsdc_device *ldev,
>> +					 unsigned int index)
>> +{
>> +	const struct lsdc_chip_desc * const descp = ldev->desc;
>> +	struct lsdc_i2c *li2c;
>> +
>> +	if (index >= descp->num_of_crtc) {
>> +		drm_err(ldev->ddev, "I2c adapter is no more than %u, %u\n",
>> +			descp->num_of_crtc, index);
>> +		return NULL;
>> +	}
>> +
>> +	li2c = ldev->li2c[index];
>> +	if (li2c)
>> +		return &li2c->adapter;
>> +
>> +	return NULL;
>> +}
>> diff --git a/drivers/gpu/drm/lsdc/lsdc_i2c.h b/drivers/gpu/drm/lsdc/lsdc_i2c.h
>> new file mode 100644
>> index 000000000000..4ab825143eb4
>> --- /dev/null
>> +++ b/drivers/gpu/drm/lsdc/lsdc_i2c.h
>> @@ -0,0 +1,42 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * KMS driver for Loongson display controller
>> + * Copyright (C) 2022 Loongson Corporation
>> + */
>> +
>> +/*
>> + * Authors:
>> + *      Sui Jingfeng <suijingfeng@loongson.cn>
>> + */
>> +
>> +#ifndef __LSDC_I2C__
>> +#define __LSDC_I2C__
>> +
>> +#include <linux/i2c.h>
>> +#include <linux/i2c-algo-bit.h>
>> +#include <linux/pci.h>
>> +
>> +struct lsdc_i2c {
>> +	struct device *dev;
>> +	struct i2c_adapter adapter;
>> +	struct i2c_algo_bit_data bit;
>> +	/* @reglock: protects concurrent register access */
>> +	spinlock_t reglock;
>> +	void __iomem *reg_base;
>> +	void __iomem *dir_reg;
>> +	void __iomem *dat_reg;
>> +	int index;
>> +	/* pin bit mask */
>> +	u8 sda;
>> +	u8 scl;
>> +};
>> +
>> +void lsdc_destroy_i2c(struct drm_device *ddev, struct lsdc_i2c *li2c);
>> +
>> +struct lsdc_i2c *lsdc_create_i2c_chan(struct device *dev,
>> +				      void *base,
>> +				      unsigned int index);
>> +
>> +struct i2c_adapter *lsdc_get_i2c_adapter(struct lsdc_device *ldev,
>> +					 unsigned int index);
>> +#endif

