Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6A9720926
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 20:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236816AbjFBS2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 14:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235851AbjFBS2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 14:28:45 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC24123;
        Fri,  2 Jun 2023 11:28:37 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b0236ee816so18976005ad.1;
        Fri, 02 Jun 2023 11:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685730517; x=1688322517;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=fBKULgtDd7k+HlwZ8YsT4VJLaQfjvnfFMGovvcxj3fg=;
        b=bQmARUdNPR6Hm4+hsM6iQK7P5CKAAoAODzwVET+LuUw6Fx3GAt1pwG6Jym1bO0sQIs
         /Tpq0xpXhrViyc7YdYZgsj4EvkxJ+7hM7VZOGrU763ix/15bsVbIiqE8KIy3duZ5vfFx
         r+uUtuxIQeWFg1IQOPIR5qHWxLfVp7CmT3IgRnFB7hf5idTn22AHUJw4natofA3L6h56
         rhjKZVahTWlQAggHi01d7ON328dTmNGsqFi3HNYkB6Z74SbONVPVjN1QXwDgIhIODXQv
         /EcYPz1+D0EQH1S2WgeVDlhdiuVZEXUFnIPWYssNdj5xfe17MRHIANfMG7qu3YQmyTI/
         GN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685730517; x=1688322517;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fBKULgtDd7k+HlwZ8YsT4VJLaQfjvnfFMGovvcxj3fg=;
        b=jsbC9FIZ+iGgpC3a5VtoIup060S20FK9a0yU60XKp93v0rUUdo8xZYGwqDinL0uyal
         VMLpFqdd6gqgUnGVhqDisxUvC76QeqYaQADXVwO0aG0L0DIL4e622c3N5O2EPimK9yDf
         B2Up9w0aYPv0Nj4dku9/9Un0bFWzq6GH6r+vFC9051n27dWTG2L6vIO4hG+zR/yrvOdj
         7A2HZTjdL00zbdPD+U5ZjaS6nPoxGEqD0PHuoeMSj/FBVG7odZivv2BBBrTojPUCYxRe
         FvYbuWH86JaDZ0o9JMVqzGg9oXl3aj8WwvmXCnLY3URODluVXT+EXKKXWgwitzkxR+2A
         37ug==
X-Gm-Message-State: AC+VfDxMRGTCB2joNS/1l1h46LV35k+TB8rAfyZH0mRedf0WdTmHpOvs
        6HGeUMFAHo5jTn3ZxzC2o7xWyEI/z8c=
X-Google-Smtp-Source: ACHHUZ6z1YZK8rnYc9muOpiCPvRw1wVtLDE9ZWKEit9DHhQHaU2D140714kqN4rl8vgNH1T+Fk5/yw==
X-Received: by 2002:a17:902:e881:b0:1b1:9069:db5f with SMTP id w1-20020a170902e88100b001b19069db5fmr444862plg.18.1685730516382;
        Fri, 02 Jun 2023 11:28:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a6-20020a170902ecc600b001b00dae8771sm1668125plh.201.2023.06.02.11.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 11:28:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 2 Jun 2023 11:28:34 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     David Ober <dober6023@gmail.com>
Cc:     wim@linux-watchdog.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, mpearson@lenovo.com,
        dober@lenovo.com
Subject: Re: [PATCH] New module to add NCT6692D watchdog funtionality
Message-ID: <53fe02f9-be0a-4e6e-87c4-5e0614f472da@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2023 at 12:30:45PM -0400, David Ober wrote:
> The new module adds in the basic functionality of the NCT6692D
> watchdog driver. This functionality is added to support the
> Lenovo SE30 device
> 
> Signed-off-by: David Ober <dober6023@gmail.com>

checkpatch --strict says:

total: 0 errors, 1 warnings, 14 checks, 715 lines checked

The warning is about an entry in MAINTAINERS, which is not
necessary, but please fix everything else.

> ---
>  drivers/watchdog/Kconfig       |  12 +
>  drivers/watchdog/Makefile      |   1 +
>  drivers/watchdog/nct6692_wdt.c | 690 +++++++++++++++++++++++++++++++++
>  3 files changed, 703 insertions(+)
>  create mode 100644 drivers/watchdog/nct6692_wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index f22138709bf5..e5b9a25c5b45 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1672,6 +1672,18 @@ config SIEMENS_SIMATIC_IPC_WDT
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called simatic-ipc-wdt.
>  
> +config NCT6692_WDT
> +        tristate "Nuvoton NCT6692D Watchdog"
> +        depends on !PPC

Why ?

> +        depends on ACPI

Why ?

> +        select WATCHDOG_CORE
> +        help
> +          If you say yes here you get support for the hardware watchdog
> +          functionality of the Nuvoton NCT6692D eSIO chip.
> +
> +          This driver can also be built as a module. If so, the module
> +          will be called nct6692_wdt.
> +
>  # M68K Architecture
>  
>  config M54xx_WATCHDOG
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index b4c4ccf2d703..2ec1e703faae 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -151,6 +151,7 @@ obj-$(CONFIG_NIC7018_WDT) += nic7018_wdt.o
>  obj-$(CONFIG_MLX_WDT) += mlx_wdt.o
>  obj-$(CONFIG_KEEMBAY_WATCHDOG) += keembay_wdt.o
>  obj-$(CONFIG_SIEMENS_SIMATIC_IPC_WDT) += simatic-ipc-wdt.o
> +obj-$(CONFIG_NCT6692D_WDT) += nct6692_wdt.o
>  
>  # M68K Architecture
>  obj-$(CONFIG_M54xx_WATCHDOG) += m54xx_wdt.o
> diff --git a/drivers/watchdog/nct6692_wdt.c b/drivers/watchdog/nct6692_wdt.c
> new file mode 100644
> index 000000000000..4a2e9a249e6d
> --- /dev/null
> +++ b/drivers/watchdog/nct6692_wdt.c
> @@ -0,0 +1,690 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * ThinkEdge Watchdog Driver

Not really, according to the text in Kconfig. It is either a watchdog driver
for ThinkEdge or for NCT6692D.

> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/acpi.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/platform_device.h>
> +#include <linux/types.h>
> +#include <linux/watchdog.h>
> +#include <linux/ioport.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/pci.h>
> +
> +#include <linux/string.h>
> +

Alphabetic include file order, please.

> +/*
> + * ISA constants
> + */
> +
> +#define IOREGION_ALIGNMENT      (~7)
> +#define IOREGION_OFFSET         4       /* Use EC port 1 */
> +#define IOREGION_LENGTH         4
> +
> +#define WATCHDOG_TIMEOUT 60 /* 60 sec default timeout */
> +#define WATCHDOG_WDT_SEL 1

tab after WATCHDOG_TIMEOUT and WATCHDOG_WDT_SEL, please

> +
> +/*The timeout range is 1-255 seconds*/
> +#define MIN_TIMEOUT	     1
> +#define MAX_TIMEOUT	     255
> +
> +#define THINKEDGE_MAX_PARAM_STRING_LEN 16

Please always use

#define<space>NAME<tab>value

> +
> +static int timeout; /* in seconds */
> +module_param(timeout, int, 0);
> +MODULE_PARM_DESC(timeout,
> +		 "Watchdog timeout in seconds. 1 <= timeout <= 255, default="
> +		 __MODULE_STRING(WATCHDOG_TIMEOUT) ".");
> +
> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +module_param(nowayout, bool, 0);
> +MODULE_PARM_DESC(nowayout,
> +		 "Watchdog cannot be stopped once started (default="
> +		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +
> +static int early_disable;
> +module_param(early_disable, int, 0);
> +MODULE_PARM_DESC(early_disable, "Disable watchdog at boot time (default=0)");

Why would this ever be desirable over letting the watchdog core handle
the watchdog if it should already be enabled ?

> +
> +#define DRVNAME "nct6692"
> +
> +#define NCT6692 "nct6692"

Duplicate define with the same name.

> +#define NCT6692_ID 0x0110
> +
> +#define WDT_EFER(X) (X + 0)  /* Extended Function Enable Registers */

(X)

> +#define WDT_EFIR(X) (X + 0)  /* Extended Function Index Register(same as EFER) */
> +#define WDT_EFDR(X) (WDT_EFIR(X) + 1) /* Extended Function Data Register */
> +#define CHIPID_MASK 0xFFF0
> +
> +#define NCT6692_MAX_IO_RETRY_NUM 0x300
> +
> +#define NCT6692_EC_NAME "nct6692_ec"
> +#define NCT6692_EC_REPORT_NAME "nct6692_ec_rep"
> +#define NCT6692_HWM_CFG		 0x180
> +
> +#define NCT6692_SIO_UNLOCK_KEY 0x87
> +#define NCT6692_SIO_LOCK_KEY 0xAA
> +
> +#define NCT6692_LD_NUM_SHM 0x0F
> +#define NCT6692_LD_WIN2_BASE_ADDR 0xF8
> +#define NCT6692_LD_REPORT_BASE_ADDR 0xE4

Please align values after the name using the appropriate number of tabs.

> +
> +// Host Interface WIN2 offset definition

Please no C++ comments in the code.

> +#define SHM_WIN_MOD_OFFSET 0x01
> +#define SHM_WIN_CMD_OFFSET 0x02
> +#define SHM_WIN_SEL_OFFSET 0x03
> +#define SHM_WIN_CTL_OFFSET 0x04
> +#define VAL_SHM_WIN_CTRL_WR 0x40
> +#define VAL_SHM_WIN_CTRL_RD 0x80
> +#define SHM_WIN_ID_OFFSET 0x08
> +#define SHM_WIN_DAT_OFFSET 0x10
> +
> +struct nct6692_shm_t {
> +	u_char *base_addr;
> +	u_long base_phys;
> +	u_char offset_mod;
> +	u_char offset_cmd;
> +	u_char offset_sel;
> +	u_char offset_ctl;
> +	u_char offset_id;
> +	u_char offset_dat;
> +	u_char *report_addr;
> +	u_long report_phys;
> +};
> +
> +/* REGs definitions */
> +enum nct6692_channel_type {
> +	NCT6692_CHANNEL_DEFAULT,
> +	NCT6692_CHANNEL_REPORT,      /* Not used in this driver. */

So what is the point of defining it ?

> +};
> +
> +struct nct6692_sio_data {
> +	u_long base_phys;
> +	u_long report_phys;
> +	int sioreg;
> +};
> +
> +struct nct6692_reg_t {
> +	u_char channel;  /* nct6692_channel_type */
> +	u_char mod;
> +	u_char cmd;
> +	u_char sel;
> +	u_int idx;
> +};
> +
> +struct nct6692_data_t {
> +	struct nct6692_shm_t shm;
> +	struct nct6692_reg_t cfg;
> +	struct nct6692_reg_t cnt;
> +	u_char timeout;
> +	struct watchdog_device wdt;
> +};
> +
> +static inline void superio_outb(int ioreg, int reg, int val)
> +{
> +	outb(reg, WDT_EFER(ioreg));
> +	outb(val, WDT_EFDR(ioreg));
> +}
> +
> +static inline int superio_inb(int ioreg, int reg)
> +{
> +	outb(reg, WDT_EFER(ioreg));
> +	return inb(WDT_EFDR(ioreg));
> +}
> +
> +static inline int superio_enter(int key, int addr, const char *name)
> +{
> +	if (!request_muxed_region(addr, 2, name)) {
> +		pr_err("I/O address 0x%04x already in use\n", addr);
> +		return -EBUSY;
> +	}
> +	outb_p(key, WDT_EFER(addr)); /* Enter extended function mode */
> +	outb_p(key, WDT_EFER(addr)); /* Again according to manual */
> +
> +	return 0;
> +}
> +
> +static inline void superio_select(int ioreg, int ld)
> +{
> +	superio_outb(ioreg, 0x07, ld);
> +}
> +
> +static inline void superio_exit(int key, int addr)
> +{
> +	outb_p(key, WDT_EFER(addr)); /* Leave extended function mode */
> +	release_region(addr, 2);
> +}
> +
> +/*
> + * The following several functions are used to access host interface according
> + * to the definition of memory region, reg (as a base addr) and an index offset
> + * It uses (shm.base_addr + shm.offset) format to locate the data area of the
> + * host interface channel. Then access the address "reg.idx + idx_offset" that
> + * are suitable for a loop accessing. Where the idx_offset is an extra offset
> + * based on the definition of reg for accessing the address based on the reg.
> + *
> + * Functions with suffix of 'report' are used to access report channel.

... which are not used here and pointless.

> + */
> +
> +int read_shm_win(const struct nct6692_shm_t *shm,
> +		 const struct nct6692_reg_t *reg,
> +		 u_char idx_offset)
> +{

All those functions should be static.

> +	int retval;
> +	u_char pre_id;
> +	u_char new_id;
> +	u_int count = 0;
> +
> +	if (!request_mem_region(shm->base_phys, 256, NCT6692_EC_NAME)) {
> +		pr_err("nuv:request channel mutex fail (base_addr=%lX)\n",
> +		       shm->base_phys);

What mutex ?

> +		retval = -EBUSY;
> +		goto exit;
> +	}
> +
> +	iowrite8(reg->mod, shm->base_addr + shm->offset_mod);
> +	iowrite8(reg->cmd, shm->base_addr + shm->offset_cmd);
> +	iowrite8(reg->sel, shm->base_addr + shm->offset_sel);
> +	pre_id = ioread8(shm->base_addr + shm->offset_id);
> +	iowrite8(VAL_SHM_WIN_CTRL_RD, shm->base_addr + shm->offset_ctl);
> +	do {
> +		new_id = ioread8(shm->base_addr + shm->offset_id);
> +		if (count == NCT6692_MAX_IO_RETRY_NUM) {
> +			pr_warn("nuv:Wait ID count timeout in %s!\n", __func__);

This is a platform driver. Use dev_ functions for messages.

> +			retval = 0;
> +			goto exit_release;
> +		}
> +		count++;
> +	} while (pre_id == new_id);
> +	retval = ioread8(shm->base_addr + shm->offset_dat + reg->idx + idx_offset);
> +
> +exit_release:
> +	release_mem_region(shm->base_phys, 256);
> +exit:
> +	return retval;
> +}
> +
> +int write_shm_win(const struct nct6692_shm_t *shm,
> +		  const struct nct6692_reg_t *reg,
> +		  u_char idx_offset,
> +		  u_char val)
> +{
> +	int err = 0;
> +	u_char pre_id;
> +	u_char new_id;
> +	u_int count = 0;
> +
> +	if (!request_mem_region(shm->base_phys, 256, NCT6692_EC_NAME)) {
> +		pr_err("nuv:request channel mutex fail (base_addr=%lX)\n",
> +		       shm->base_phys);
> +		err = -EBUSY;
> +		goto err_exit;

Please no goto to return statements.

> +	}
> +
> +	iowrite8(reg->mod, shm->base_addr + shm->offset_mod);
> +	iowrite8(reg->cmd, shm->base_addr + shm->offset_cmd);
> +	iowrite8(reg->sel, shm->base_addr + shm->offset_sel);
> +
> +	pre_id = ioread8(shm->base_addr + shm->offset_id);
> +	iowrite8(VAL_SHM_WIN_CTRL_RD, shm->base_addr + shm->offset_ctl);
> +	do {
> +		new_id = ioread8(shm->base_addr + shm->offset_id);
> +		if (count == NCT6692_MAX_IO_RETRY_NUM) {
> +			pr_warn("nuv:Wait ID count timeout in %s!\n", __func__);
> +			err = -EINVAL;
> +			goto err_exit_release;
> +		}
> +		count++;
> +	} while (pre_id == new_id);

This is repeated several times. Please combine common code in a
separate function.

> +
> +	iowrite8(val, shm->base_addr + shm->offset_dat + reg->idx + idx_offset);
> +
> +	pre_id = new_id;
> +
> +	iowrite8(VAL_SHM_WIN_CTRL_WR, shm->base_addr + shm->offset_ctl);
> +	do {
> +		new_id = ioread8(shm->base_addr + shm->offset_id);
> +		if (count == NCT6692_MAX_IO_RETRY_NUM) {
> +			pr_warn("nuv:Wait ID count timeout in %s!\n", __func__);
> +			err = -EINVAL;
> +			goto err_exit_release;
> +		}
> +		count++;

No timeout or delay between reads makes this code highly CPU speed dependent.
Please rewrite to check against some timeout.

> +	} while (pre_id == new_id);
> +
> +err_exit_release:
> +	release_mem_region(shm->base_phys, 256);
> +
> +err_exit:
> +	return err;
> +}
> +
> +int read_shm_report(const struct nct6692_shm_t *shm,
> +		    const struct nct6692_reg_t *reg,
> +		    u_char idx_offset)
> +{
> +	int val;
> +
> +	if (!request_mem_region(shm->report_phys, 256,
> +				NCT6692_EC_REPORT_NAME)) {
> +		pr_err("nuv:request channel mutex fail (base_addr=%lX)\n",
> +		       shm->report_phys);
> +		return -EBUSY;
> +	}
> +
> +	val = ioread8(shm->report_addr + reg->idx + idx_offset);
> +
> +	release_mem_region(shm->report_phys, 256);
> +
> +	return val;
> +}
> +
> +int read_shm(const struct nct6692_shm_t *shm,
> +	     const struct nct6692_reg_t *reg)
> +{
> +	if (reg->channel == NCT6692_CHANNEL_DEFAULT)
> +		return read_shm_win(shm, reg, 0);
> +

I do not understand those if checks. The channel is always set
to NCT6692_CHANNEL_DEFAULT. Why have reg->channel in the first
place ?

> +	return read_shm_report(shm, reg, 0);
> +}
> +
> +int write_shm(const struct nct6692_shm_t *shm,
> +	      const struct nct6692_reg_t *reg,
> +	      u_char val)
> +{
> +	if (reg->channel == NCT6692_CHANNEL_DEFAULT)
> +		return write_shm_win(shm, reg, 0, val);
> +
> +	pr_warn("Report channel CAN NOT be written!\n");
> +	return -EINVAL;
> +}
> +
> +int read_shm_with_offset(const struct nct6692_shm_t *shm,
> +			 const struct nct6692_reg_t *reg,
> +			 u_char idx_offset)
> +{
> +	if (reg->channel == NCT6692_CHANNEL_DEFAULT)
> +		return read_shm_win(shm, reg, idx_offset);
> +
> +	return read_shm_report(shm, reg, idx_offset);
> +}
> +
> +int write_shm_with_offset(const struct nct6692_shm_t *shm,
> +			  const struct nct6692_reg_t *reg,
> +			  u_char idx_offset,
> +			  u_char val)
> +{
> +	if (reg->channel == NCT6692_CHANNEL_DEFAULT)
> +		return write_shm_win(shm, reg, idx_offset, val);
> +
> +	pr_warn("Report channel CAN NOT be written!\n");

How would this ever happen ? What would be the point of calling
this function with a channel other than NCT6692_CHANNEL_DEFAULT
in the first place ?

> +	return -EINVAL;
> +}
> +
> +static int nct6692_wdt_init(struct watchdog_device *wdog)
> +{
> +	int err = 0;
> +	u_char timeout, cfg;
> +	struct nct6692_data_t *data = watchdog_get_drvdata(wdog);
> +
> +	timeout = read_shm(&data->shm, &data->cnt);
> +	cfg = read_shm(&data->shm, &data->cfg);
> +
> +	if (timeout < 0)
> +		return timeout;
> +	if (timeout == 0)
> +		return 0;
> +
> +	if (early_disable) {
> +		pr_warn("Stopping previously enabled watchdog until userland kicks in\n");
> +		// Disable WDT and clear timeout count
> +		data->timeout = 0;
> +		err = write_shm(&data->shm, &data->cnt, data->timeout);
> +	} else {
> +		pr_info("Watchdog already running. Resetting timeout to %d sec\n",
> +			wdog->timeout);
> +		data->timeout = wdog->timeout;
> +		err = write_shm(&data->shm, &data->cnt, data->timeout);
> +	}

This code is called when starting the watchdog.

nct6692_wdt_start -> nct6692_wdt_setup -> nct6692_wdt_init.

This can only be done from userland, and there is no other caller.
The above code does not make sense because by definition userland
has already "kicked in" at this point.

> +
> +	return err;
> +}
> +
> +static int nct6692_wdt_enable(bool enable, u_int timeout,
> +				struct nct6692_data_t *data)
> +{
> +	u_char reg;
> +
> +	reg = read_shm(&data->shm, &data->cfg);
> +
> +	if (enable) {
> +		write_shm(&data->shm, &data->cfg, 0x02);
> +		/* ^^^^ 0x00 to disable reboot */
> +		data->timeout = timeout;
> +		write_shm(&data->shm, &data->cnt, data->timeout);

I do not understand why data->timeout is necessary. 

> +		reg = read_shm(&data->shm, &data->cfg);
> +	} else {
> +		data->timeout = 0;
> +		write_shm(&data->shm, &data->cnt, data->timeout);
> +	}
> +	reg = read_shm(&data->shm, &data->cfg);
> +	reg = read_shm(&data->shm, &data->cnt);
> +	return 0;
> +}
> +
> +static int nct6692_wdt_set_time(struct watchdog_device *wdog, u_int timeout)
> +{
> +	struct nct6692_data_t *data = watchdog_get_drvdata(wdog);
> +
> +	if (timeout != 0)
> +		nct6692_wdt_enable(true, timeout, data);
> +	else
> +		nct6692_wdt_enable(false, timeout, data);
> +
> +	return 0;
> +}
> +
> +static int nct6692_wdt_setup(struct watchdog_device *wdt)
> +{
> +	int err = 0;
> +
> +	watchdog_stop_on_reboot(wdt);

This is supposed to be called once, in the probe function,
not every time the watchdog is started.

> +
> +	err = nct6692_wdt_init(wdt);
> +	if (err) {
> +		pr_err("failed to initialize watchdog (err=%d)\n", err);
> +		return err;
> +	}
> +	return err;
> +}
> +
> +static int nct6692_wdt_start(struct watchdog_device *wdog)
> +{
> +	struct nct6692_data_t *data = watchdog_get_drvdata(wdog);
> +
> +	nct6692_wdt_setup(wdog);
> +	nct6692_wdt_set_time(wdog, data->timeout);
> +	return 0;
> +}
> +
> +static int nct6692_wdt_stop(struct watchdog_device *wdog)
> +{
> +	return nct6692_wdt_set_time(wdog, 0);
> +}
> +
> +static int nct6692_wdt_set_timeout(struct watchdog_device *wdog,
> +				     u_int timeout)
> +{
> +	wdog->timeout = timeout;
> +	return 0;
> +}
> +
> +static u_int nct6692_wdt_get_timeleft(struct watchdog_device *wdog)
> +{
> +	struct nct6692_data_t *data = watchdog_get_drvdata(wdog);
> +	u_int timeleft;
> +
> +	timeleft = read_shm(&data->shm, &data->cnt);
> +	return timeleft;
> +}
> +
> +static int nct6692_wdt_ping(struct watchdog_device *wdt)
> +{
> +	struct nct6692_data_t *data = watchdog_get_drvdata(wdt);
> +	int timeout;
> +
> +	/*
> +	 * Note:
> +	 * NCT6692 does not support refreshing WDT_TIMER_REG register when
> +	 * the watchdog is active. Please disable watchdog before feeding
> +	 * the watchdog and enable it again.
> +	 */
> +	/* Disable soft watchdog timer */
> +	timeout = 0;
> +	nct6692_wdt_enable(false, timeout, data);
> +
> +	/* feed watchdog */
> +	timeout = wdt->timeout;
> +	write_shm(&data->shm, &data->cnt, data->timeout);
> +
> +	/* Enable soft watchdog timer */
> +	nct6692_wdt_enable(true, timeout, data);
> +	return 0;
> +
> +}
> +
> +static const struct watchdog_info nct6692_wdt_info = {
> +	.options	= WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING |
> +			  WDIOF_MAGICCLOSE,
> +	.identity       = "nct6692 watchdog",
> +};
> +
> +static const struct watchdog_ops nct6692_wdt_ops = {
> +	.owner	  = THIS_MODULE,
> +	.start	  = nct6692_wdt_start,
> +	.stop	   = nct6692_wdt_stop,
> +	.ping	   = nct6692_wdt_ping,
> +	.set_timeout    = nct6692_wdt_set_timeout,
> +	.get_timeleft   = nct6692_wdt_get_timeleft,
> +};
> +
> +static int nct6692_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct nct6692_data_t *data = NULL;
> +	struct nct6692_sio_data *sio_data = dev->platform_data;
> +	struct resource *res;
> +
> +	pr_info("Probe NCT6692 called\n");
> +	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
> +
> +	data = kzalloc(sizeof(struct nct6692_data_t), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	// init value
> +	data->shm.base_addr = 0;
> +	data->shm.report_addr = 0;
> +

Initialization to 0 afer kzalloc() is pointless.

> +	data->shm.base_phys = sio_data->base_phys;
> +	data->shm.base_addr = (u_char *)ioremap_cache(data->shm.base_phys, 256);

ioremap_cache() returns a void __iomem *. The tyoecast is only necessary because
base_addr is not marked as __iomem *. Please fix that.

> +
> +	data->shm.offset_mod = SHM_WIN_MOD_OFFSET;
> +	data->shm.offset_cmd = SHM_WIN_CMD_OFFSET;
> +	data->shm.offset_sel = SHM_WIN_SEL_OFFSET;
> +	data->shm.offset_ctl = SHM_WIN_CTL_OFFSET;
> +	data->shm.offset_id = SHM_WIN_ID_OFFSET;
> +	data->shm.offset_dat = SHM_WIN_DAT_OFFSET;
> +
> +	// Base for REPORT Channel
> +	data->shm.report_phys = sio_data->report_phys;
> +	data->shm.report_addr = (u_char *)ioremap_cache(data->shm.report_phys, 256);
> +
> +	data->cfg.channel = NCT6692_CHANNEL_DEFAULT;
> +	data->cfg.mod = 0x10;
> +	data->cfg.cmd = 0;
> +	data->cfg.sel = 0;
> +	data->cfg.idx = 0x15;
> +	data->cnt.channel = NCT6692_CHANNEL_DEFAULT;
> +	data->cnt.mod = 0x10;
> +	data->cnt.cmd = 0;
> +	data->cnt.sel = 0;
> +	data->cnt.idx = 0x16;
> +
> +	data->wdt.ops = &nct6692_wdt_ops;
> +	data->wdt.info = &nct6692_wdt_info;
> +
> +	data->wdt.timeout = WATCHDOG_TIMEOUT; /* Set default timeout */
> +	data->wdt.min_timeout = MIN_TIMEOUT;
> +	data->wdt.max_timeout = MAX_TIMEOUT;
> +	data->wdt.parent = &pdev->dev;
> +
> +	watchdog_init_timeout(&data->wdt, timeout, &pdev->dev);
> +	watchdog_set_nowayout(&data->wdt, nowayout);
> +	watchdog_set_drvdata(&data->wdt, data);
> +
> +	watchdog_stop_on_unregister(&data->wdt);
> +
> +	return devm_watchdog_register_device(dev, &data->wdt);
> +}
> +
> +static struct platform_driver nct6692_driver = {
> +	.driver = {
> +		.name = DRVNAME,
> +		/*.pm   = NCT6692_DEV_PM_OPS,*/
> +	},
> +	.probe	= nct6692_probe,
> +};
> +
> +static int __init nct6692_find(int addr, u_long *base_phys,
> +			      u_long *report_phys)
> +{
> +	u16 val;
> +	int err = 0;
> +	u_long tmp_base_phys;
> +	u_long tmp_report_phys;
> +
> +	err = superio_enter(NCT6692_SIO_UNLOCK_KEY, addr, NCT6692);
> +	if (err)
> +		return err;
> +
> +	val = superio_inb(addr, 0x20);
> +	val = ((val << 8) | (superio_inb(addr, 0x21) & 0xFF)) & CHIPID_MASK;

Unnecessary "& 0xff".

> +
> +	if (val != NCT6692_ID) {
> +		err = -ENODEV;
> +		goto fail;
> +	}
> +
> +	superio_select(addr, NCT6692_LD_NUM_SHM);
> +	tmp_base_phys = ((superio_inb(addr, NCT6692_LD_WIN2_BASE_ADDR) & 0xFF) |
> +			 ((superio_inb(addr, NCT6692_LD_WIN2_BASE_ADDR + 1) & 0xFF) << 8) |
> +			 ((superio_inb(addr, NCT6692_LD_WIN2_BASE_ADDR + 2) & 0xFF) << 16) |
> +			 ((superio_inb(addr, NCT6692_LD_WIN2_BASE_ADDR + 3) & 0xFF) << 24)) &
> +		0xFFFFFFFF;

What is the logical & for ?

> +
> +	if ((tmp_base_phys == 0xFFFFFFFF) || (tmp_base_phys == 0)) {
> +		err = -ENODEV;
> +		goto fail;
> +	}
> +
> +	tmp_report_phys = ((superio_inb(addr, NCT6692_LD_REPORT_BASE_ADDR) & 0xFF) |
> +			   ((superio_inb(addr, NCT6692_LD_REPORT_BASE_ADDR + 1) & 0xFF) << 8) |
> +			   ((superio_inb(addr, NCT6692_LD_REPORT_BASE_ADDR + 2) & 0xFF) << 16) |
> +			   ((superio_inb(addr, NCT6692_LD_REPORT_BASE_ADDR + 3) & 0xFF) << 24)) &
> +		0xFFFFFFFF;

Same as above.

> +
> +	if ((tmp_report_phys == 0xFFFFFFFF) || (tmp_report_phys == 0)) {

Lots of unnecessary () sprinkled through the code.

> +		err = -ENODEV;
> +		goto fail;
> +	}
> +
> +fail:
> +	superio_exit(NCT6692_SIO_LOCK_KEY, addr);
> +	if (!err) {
> +		if (base_phys != NULL)
> +			*base_phys = tmp_base_phys;
> +		if (report_phys != NULL)
> +			*report_phys = tmp_report_phys;
> +	}
> +	return err;
> +}
> +
> +static struct platform_device *pdev;
> +
> +static int __init nct6692_init(void)
> +{
> +	struct nct6692_sio_data sio_data;
> +	int sioaddr[2] = { 0x2e, 0x4e };
> +	struct resource res;
> +	int err;
> +	int address;
> +	bool found = false;
> +	u_long base_phys = 0;
> +	u_long report_phys = 0;

Unnecessary initializations.

> +
> +	platform_driver_register(&nct6692_driver);
> +
> +	/*
> +	 * initialize sio_data->kind and sio_data->sioreg.
> +	 *
> +	 * when Super-I/O functions move to a separate file, the Super-I/O
> +	 * driver will probe 0x2e and 0x4e and auto-detect the presence of a
> +	 * nct6692 hardware monitor, and call probe()
> +	 */
> +	err = nct6692_find(sioaddr[0], &base_phys, &report_phys);
> +	if (err) {
> +		err = nct6692_find(sioaddr[1], &base_phys, &report_phys);
> +		if (err)
> +			return -ENODEV;

This does not unregister the platform driver. Please only register it
after confirming that a chip is there.

> +	}
> +	found = true;
> +	sio_data.base_phys = base_phys;
> +	sio_data.report_phys = report_phys;
> +
> +	pr_info("NCT6692 device found\n");
> +	pdev = platform_device_alloc(DRVNAME, base_phys);
> +	if (!pdev) {
> +		err = -ENOMEM;
> +		goto exit_device_unregister;
> +	}
> +	err = platform_device_add_data(pdev, &sio_data,
> +					sizeof(struct nct6692_sio_data));
> +	if (err)
> +		goto exit_device_put;
> +
> +	memset(&res, 0, sizeof(res));
> +	res.name = DRVNAME;
> +	res.start = address + IOREGION_OFFSET;
> +	res.end = address + IOREGION_OFFSET + IOREGION_LENGTH - 1;
> +	res.flags = IORESOURCE_IO;
> +
> +	err = acpi_check_resource_conflict(&res);
> +	if (err) {
> +		platform_device_put(pdev);
> +		pdev = NULL;
> +	}

This check should be done before registering the platform driver.

> +
> +	err = platform_device_add_resources(pdev, &res, 1);
> +	if (err)
> +		goto exit_device_put;
> +
> +	/* platform_device_add calls probe() */
> +	err = platform_device_add(pdev);
> +	if (err)
> +		goto exit_device_put;
> +
> +	if (!found) {

This check and the flag is pointless: found is always true here.

> +		err = -ENODEV;
> +		goto exit_unregister;
> +	}
> +
> +	return 0;
> +exit_device_put:
> +	platform_device_put(pdev);
> +exit_device_unregister:
> +	if (pdev)
> +		platform_device_unregister(pdev);
> +exit_unregister:
> +	platform_driver_unregister(&nct6692_driver);
> +	return err;
> +}
> +
> +static void __exit nct6692_exit(void)
> +{
> +	platform_device_unregister(pdev);
> +	platform_driver_unregister(&nct6692_driver);
> +}
> +
> +MODULE_AUTHOR("David Ober <dober@lenovo.com>");
> +MODULE_DESCRIPTION("NCT6692D driver");
> +MODULE_LICENSE("GPL");
> +
> +module_init(nct6692_init);
> +module_exit(nct6692_exit);
> +
> -- 
> 2.34.1
> 
