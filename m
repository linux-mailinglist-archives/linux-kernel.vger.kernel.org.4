Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92266773B3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 02:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjAWBD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 20:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjAWBDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 20:03:24 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6851B13DC8
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 17:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1674435802; x=1705971802;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pN2HDtGApIdBIl3ZvJOgqtds3RPT7epxorJjMdFLsOE=;
  b=pzLelK7623dZxzkReIibS6kr71wbD6PMq+hspGDpfDyMrYfyEiGdd7xT
   sEOd3M82FkQmW2JLNUA8XyvPJT1V7WH1F02jpbhF86+nZup577CS6FWtN
   1vgnISUl+BUNhfVjK9peXN+jUYMhc8/ve9ATVOTUttjoEQc8fed5VKu5s
   brWg+4Gp+FFSJQ4bK5alJHV6Im31dAxZHp38Qq6clluzpldDv7tYGQ8fM
   ydFceRC6TSLZesRLsUV4D6xjC8CbdkYkZQYzrF1Ixrd43O7WgjyBNtoWb
   welIgMVnmWe0t2KHrAS/6GQeI4sMTmefehO2RaqUr5q8GliokMNf5T2BG
   g==;
X-IronPort-AV: E=Sophos;i="5.97,238,1669046400"; 
   d="scan'208";a="221581294"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jan 2023 09:03:21 +0800
IronPort-SDR: l4OPEYmaRLQvheUkb9yDxIgsgsC0+ltHPurHNAOnzLbTeZn4/W7+PPHUlc8fEj4mjFhchKs9vH
 jk8wi8z6OTk2WvzEiJWVeJNTOSzM2C+/Czv+Lpwc2twbuFGTFvFflVxgXk80ui1ThL7j8TItXT
 lH2d0kjOsbvfvHqH1pRLV9hcnTe2URkAX6NmfFQoL1PjQT25UmRMvflJeqU3KquHA5yz669rXp
 xJUTpBi0COCzEFXdLsH5W17PYIXfx0fLaRVQLQ6WfDEzX9sJNXiIxBFtB2lvAOFAb+fD9OmyAj
 VFc=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Jan 2023 16:15:12 -0800
IronPort-SDR: kpc1vE77Kc8n24/gLveHPrtpbOKAIQdDIbb0P316O4XxGah3JMCHGP3H8G+DzyCuQzTCcSo891
 Td3xyyMwORuM57Q81eoBb1J3TTQWAN+L8IEpFVe/qCJi6cVFT0f92D2XArUKOm5ZmNAivjx+jN
 pSfqTsd2h2mIWhPFglsApLFia4c1IvdyDE4TA6yNX5yzLRIkvUhfX4qzv9HDkJYM9JFzQJ2NOS
 /pvUUmFzGX8KerYV4RcoaigtVOmgERhm9ZC5xCoGTbt6kfAcN+TY9MTevdxeZZFTDYGmVVbdGk
 z70=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Jan 2023 17:03:21 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4P0X0T21Vlz1RvTr
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 17:03:21 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1674435799; x=1677027800; bh=pN2HDtGApIdBIl3ZvJOgqtds3RPT7epxorJ
        jMdFLsOE=; b=Ao/Wt6atS3+uC8y3jFIVm+EZ7jdScJSJbS+A/5Ru4MTZ5XLWyo3
        MWbN8f2HtqH4WmbOSjB/VcZ8TFmXqBnOEEsTaYXlJVayqsWdFrlFQYX6B2fIXARo
        YNE89XQjnhzGFSWswQge3DHvjWgxH2gpMuV+nNxVHdUUVgAFR1+KSGSsP58xDg0x
        xWchzx45IJ0PM/GJL2FSNjjPXy5GkKUY0E2i5psKFDOcig6dUeNKetb/ppDSuuHA
        b+/NR1WHyQSGGi5dQH/BuxTAUSeDufh3O8Zr8Todvy35gLaUaiREkEV/gBwFhzAj
        qCIs/F6txxgX55rmOlJHQHNLgyrrjcJzO1g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ovFT18h36sQz for <linux-kernel@vger.kernel.org>;
        Sun, 22 Jan 2023 17:03:19 -0800 (PST)
Received: from [10.225.163.50] (unknown [10.225.163.50])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4P0X0P4c6Rz1RvLy;
        Sun, 22 Jan 2023 17:03:17 -0800 (PST)
Message-ID: <425b5646-23e2-e271-5ca6-0f3783d39a3b@opensource.wdc.com>
Date:   Mon, 23 Jan 2023 10:03:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] pata_parport: add driver (PARIDE replacement)
To:     Ondrej Zary <linux@zary.sk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230121225314.32459-1-linux@zary.sk>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230121225314.32459-1-linux@zary.sk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/23 07:53, Ondrej Zary wrote:
> The pata_parport is a libata-based replacement of the old PARIDE
> subsystem - driver for parallel port IDE devices.
> It uses the original paride low-level protocol drivers but does not
> need the high-level drivers (pd, pcd, pf, pt, pg). The IDE devices
> behind parallel port adapters are handled by the ATA layer.
> 
> This will allow paride and its high-level drivers to be removed.
> 
> Unfortunately, libata drivers cannot sleep so pata_parport claims
> parport before activating the ata host and keeps it claimed (and
> protocol connected) until the ata host is removed. This means that
> no devices can be chained (neither other pata_parport devices nor
> a printer).
> 
> paride and pata_parport are mutually exclusive because the compiled
> protocol drivers are incompatible.
> 
> Tested with:
>  - Imation SuperDisk LS-120 and HP C4381A (EPAT)
>  - Freecom Parallel CD (FRPW)
>  - Toshiba Mobile CD-RW 2793008 w/Freecom Parallel Cable rev.903 (FRIQ)
>  - Backpack CD-RW 222011 and CD-RW 19350 (BPCK6)
> 
> The following bugs in low-level protocol drivers were found and will
> be fixed later:
> 
> Note: EPP-32 mode is buggy in EPAT - and also in all other protocol
> drivers - they don't handle non-multiple-of-4 block transfers
> correctly. This causes problems with LS-120 drive.
> There is also another bug in EPAT: EPP modes don't work unless a 4-bit
> or 8-bit mode is used first (probably some initialization missing?).
> Once the device is initialized, EPP works until power cycle.
> 
> So after device power on, you have to:
> echo "parport0 epat 0" >/sys/bus/pata_parport/new_device
> echo pata_parport.0 >/sys/bus/pata_parport/delete_device
> echo "parport0 epat 4" >/sys/bus/pata_parport/new_device
> (autoprobe will initialize correctly as it tries the slowest modes
> first but you'll get the broken EPP-32 mode)
> 
> Note: EPP modes are buggy in FRPW, only modes 0 and 1 work.
> Signed-off-by: Ondrej Zary <linux@zary.sk>

Overall, look good to me. Several comments below about simple
cleanups/improvements.

> ---

[...]
> diff --git a/drivers/ata/pata_parport.c b/drivers/ata/pata_parport.c
> new file mode 100644
> index 000000000000..1c583e54d083
> --- /dev/null
> +++ b/drivers/ata/pata_parport.c
> @@ -0,0 +1,783 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2023 Ondrej Zary
> + * based on paride.c by Grant R. Guenther <grant@torque.net>
> + */
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/parport.h>
> +#include <linux/pata_parport.h>
> +
> +#define DRV_NAME "pata_parport"
> +
> +static DEFINE_IDR(parport_list);
> +static DEFINE_IDR(protocols);
> +static DEFINE_IDA(pata_parport_bus_dev_ids);
> +static DEFINE_MUTEX(pi_mutex);
> +
> +static bool probe = true;
> +module_param(probe, bool, 0644);
> +MODULE_PARM_DESC(probe, "Enable automatic device probing (0=off, 1=on [default])");
> +
> +static bool verbose;
> +module_param(verbose, bool, 0644);
> +MODULE_PARM_DESC(verbose, "Enable verbose messages (0=off [default], 1=on)");

This is not needed. Use dynamic pr_debug()/dev_dbg() instead.

> +
> +#define DISCONNECT_TIMEOUT	(HZ / 10)
> +
> +/* libata drivers cannot sleep so this driver claims parport before activating
> + * the ata host and keeps it claimed (and protocol connected) until the ata
> + * host is removed. Unfortunately, this means that you cannot use any chained
> + * devices (neither other pata_parport devices nor a printer).
> + */

Incorrect comment format. This should start with a "/*" line.

> +static void pi_connect(struct pi_adapter *pi)
> +{
> +	parport_claim_or_block(pi->pardev);
> +	pi->proto->connect(pi);
> +}
> +
> +static void pi_disconnect(struct pi_adapter *pi)
> +{
> +	pi->proto->disconnect(pi);
> +	parport_release(pi->pardev);
> +}
> +
> +/* functions taken from libata-sff.c and converted from direct port I/O */

I do not see how this comment is useful. I think you can drop it.

> +static void pata_parport_dev_select(struct ata_port *ap, unsigned int device)
> +{
> +	struct pi_adapter *pi = ap->host->private_data;
> +	u8 tmp;
> +
> +	if (device == 0)
> +		tmp = ATA_DEVICE_OBS;
> +	else
> +		tmp = ATA_DEVICE_OBS | ATA_DEV1;
> +
> +	pi->proto->write_regr(pi, 0, ATA_REG_DEVICE, tmp);
> +	ata_sff_pause(ap);
> +}
> +
> +static bool pata_parport_devchk(struct ata_port *ap, unsigned int device)
> +{
> +	struct pi_adapter *pi = ap->host->private_data;
> +	u8 nsect, lbal;
> +
> +	pata_parport_dev_select(ap, device);
> +
> +	pi->proto->write_regr(pi, 0, ATA_REG_NSECT, 0x55);
> +	pi->proto->write_regr(pi, 0, ATA_REG_LBAL, 0xaa);
> +
> +	pi->proto->write_regr(pi, 0, ATA_REG_NSECT, 0xaa);
> +	pi->proto->write_regr(pi, 0, ATA_REG_LBAL, 0x55);
> +
> +	pi->proto->write_regr(pi, 0, ATA_REG_NSECT, 055);
> +	pi->proto->write_regr(pi, 0, ATA_REG_LBAL, 0xaa);
> +
> +	nsect = pi->proto->read_regr(pi, 0, ATA_REG_NSECT);
> +	lbal = pi->proto->read_regr(pi, 0, ATA_REG_LBAL);
> +
> +	if ((nsect == 0x55) && (lbal == 0xaa))
> +		return true;	/* we found a device */
> +
> +	return false;		/* nothing found */

Simplify:

	return (nsect == 0x55) && (lbal == 0xaa);

[...]

> +static u8 pata_parport_check_status(struct ata_port *ap)
> +{
> +	u8 status;
> +	struct pi_adapter *pi = ap->host->private_data;
> +
> +	status = pi->proto->read_regr(pi, 0, ATA_REG_STATUS);
> +
> +	return status;

The status variable is not necessary. Simply do:

	return pi->proto->read_regr(pi, 0, ATA_REG_STATUS);

> +}
> +
> +static u8 pata_parport_check_altstatus(struct ata_port *ap)
> +{
> +	u8 altstatus;
> +	struct pi_adapter *pi = ap->host->private_data;
> +
> +	altstatus = pi->proto->read_regr(pi, 1, 6);
> +
> +	return altstatus;

Same here for altstatus.

[...]

> +static int default_test_proto(struct pi_adapter *pi, char *scratch)
> +{
> +	int j, k;
> +	int e[2] = { 0, 0 };
> +
> +	pi->proto->connect(pi);
> +
> +	for (j = 0; j < 2; j++) {
> +		pi->proto->write_regr(pi, 0, 6, 0xa0 + j * 0x10);
> +		for (k = 0; k < 256; k++) {
> +			pi->proto->write_regr(pi, 0, 2, k ^ 0xaa);
> +			pi->proto->write_regr(pi, 0, 3, k ^ 0x55);
> +			if (pi->proto->read_regr(pi, 0, 2) != (k ^ 0xaa))
> +				e[j]++;
> +		}
> +	}
> +	pi->proto->disconnect(pi);
> +
> +	if (verbose)
> +		dev_info(&pi->dev, "%s: port 0x%x, mode %d, test=(%d,%d)\n",
> +		       pi->proto->name, pi->port,
> +		       pi->mode, e[0], e[1]);

Please remove the "if (verbose)" and use dev_dbg().

[...]

> +static struct bus_type pata_parport_bus_type = {
> +	.name = DRV_NAME,
> +};
> +
> +static struct device pata_parport_bus = {
> +	.init_name = DRV_NAME,
> +	.release = pata_parport_bus_release,
> +};
> +
> +/* temporary for old paride protocol modules */

s/temporary/necessary ?

[...]

> +int pata_parport_register_driver(struct pi_protocol *pr)
> +{
> +	int error;
> +	struct parport *parport;
> +	int port_num;
> +
> +	pr->driver.bus = &pata_parport_bus_type;
> +	pr->driver.name = pr->name;
> +	error = driver_register(&pr->driver);
> +	if (error)
> +		return error;
> +
> +	mutex_lock(&pi_mutex);
> +	error = idr_alloc(&protocols, pr, 0, 0, GFP_KERNEL);
> +	if (error < 0) {
> +		driver_unregister(&pr->driver);
> +		mutex_unlock(&pi_mutex);
> +		return error;
> +	}
> +
> +	pr_info("pata_parport: protocol %s registered\n", pr->name);
> +
> +	if (probe) {
> +		/* probe all parports using this protocol */
> +		idr_for_each_entry(&parport_list, parport, port_num)
> +			pi_init_one(parport, pr, -1, 0, -1);
> +	}
> +	mutex_unlock(&pi_mutex);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(pata_parport_register_driver);

EXPORT_SYMBOL_GPL()

> +
> +void pata_parport_unregister_driver(struct pi_protocol *pr)
> +{
> +	struct pi_protocol *pr_iter;
> +	int id = -1;
> +
> +	mutex_lock(&pi_mutex);
> +	idr_for_each_entry(&protocols, pr_iter, id) {
> +		if (pr_iter == pr)
> +			break;
> +	}
> +	idr_remove(&protocols, id);
> +	mutex_unlock(&pi_mutex);
> +	driver_unregister(&pr->driver);
> +}
> +EXPORT_SYMBOL(pata_parport_unregister_driver);

Same here.

> +
> +static ssize_t new_device_store(struct bus_type *bus, const char *buf,
> +				size_t count)
> +{
> +	char port[12] = "auto";
> +	char protocol[8] = "auto";
> +	int mode = -1, unit = -1, delay = -1;
> +	struct pi_protocol *pr, *pr_wanted;
> +	struct device_driver *drv;
> +	struct parport *parport;
> +	int port_num, port_wanted, pr_num;
> +	bool ok = false;
> +
> +	if (sscanf(buf, "%11s %7s %d %d %d",
> +			port, protocol, &mode, &unit, &delay) < 1)
> +		return -EINVAL;
> +
> +	if (sscanf(port, "parport%u", &port_wanted) < 1) {
> +		if (!strcmp(port, "auto")) {
> +			port_wanted = -1;
> +		} else {
> +			pr_err("invalid port name %s\n", port);
> +			return -EINVAL;
> +		}

It would be nicer to reverse the if condition to drop the else:

		if (strcmp(port, "auto")) {
			pr_err("invalid port name %s\n", port);
			return -EINVAL;
		}
		port_wanted = -1;

> +	}
> +
> +	drv = driver_find(protocol, &pata_parport_bus_type);
> +	if (!drv) {
> +		if (!strcmp(protocol, "auto")) {
> +			pr_wanted = NULL;
> +		} else {
> +			pr_err("protocol %s not found\n", protocol);
> +			return -EINVAL;
> +		}

Same here.

[...]

> +static ssize_t delete_device_store(struct bus_type *bus, const char *buf,
> +				   size_t count)
> +{
> +	struct device *dev;
> +	char device_name[32];
> +
> +	if (sscanf(buf, "%31s", device_name) < 1)
> +		return -EINVAL;

Why sscanf() ? You can strncpy from buf to device_name directly, no ?
And given how you use device_name below, I think that you do not even need
the device_name variable.

> +
> +	mutex_lock(&pi_mutex);
> +	dev = bus_find_device_by_name(bus, NULL, device_name);
> +	if (!dev) {
> +		mutex_unlock(&pi_mutex);
> +		return -ENODEV;
> +	}
> +
> +	pi_remove_one(dev);
> +	mutex_unlock(&pi_mutex);
> +
> +	return count;
> +}
> +static BUS_ATTR_WO(delete_device);

[...]

> diff --git a/include/linux/pata_parport.h b/include/linux/pata_parport.h
> new file mode 100644
> index 000000000000..913f49ff1fad
> --- /dev/null
> +++ b/include/linux/pata_parport.h
> @@ -0,0 +1,106 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + *	pata_parport.h	(c) 1997-8  Grant R. Guenther <grant@torque.net>
> + *				    Under the terms of the GPL.
> + *
> + * This file defines the interface for parallel port IDE adapter chip drivers.
> + */
> +

You are missing:

#ifndef LINUX_PATA_PARPORT_H
#define LINUX_PATA_PARPORT_H

> +#include <linux/libata.h>
> +
> +#define PI_PCD	1	/* dummy for paride protocol modules */
> +
> +struct pi_adapter {
> +	struct device dev;
> +	struct pi_protocol *proto;	/* adapter protocol */
> +	int port;			/* base address of parallel port */
> +	int mode;			/* transfer mode in use */
> +	int delay;			/* adapter delay setting */
> +	int devtype;			/* dummy for paride protocol modules */
> +	char *device;			/* dummy for paride protocol modules */
> +	int unit;			/* unit number for chained adapters */
> +	int saved_r0;			/* saved port state */
> +	int saved_r2;			/* saved port state */
> +	unsigned long private;		/* for protocol module */
> +	struct pardevice *pardev;	/* pointer to pardevice */
> +};
> +
> +typedef struct pi_adapter PIA;	/* for paride protocol modules */
> +
> +/* registers are addressed as (cont,regr)
> + *	cont: 0 for command register file, 1 for control register(s)
> + *	regr: 0-7 for register number.
> + */
> +
> +/* macros and functions exported to the protocol modules */
> +#define delay_p			(pi->delay ? udelay(pi->delay) : (void)0)
> +#define out_p(offs, byte)	do { outb(byte, pi->port + offs); delay_p; } while (0)
> +#define in_p(offs)		(delay_p, inb(pi->port + offs))

It would be way nicer to have these as inline functions.

> +
> +#define w0(byte)		out_p(0, byte)
> +#define r0()			in_p(0)
> +#define w1(byte)		out_p(1, byte)
> +#define r1()			in_p(1)
> +#define w2(byte)		out_p(2, byte)
> +#define r2()			in_p(2)
> +#define w3(byte)		out_p(3, byte)
> +#define w4(byte)		out_p(4, byte)
> +#define r4()			in_p(4)
> +#define w4w(data)		do { outw(data, pi->port + 4); delay_p; } while (0)
> +#define w4l(data)		do { outl(data, pi->port + 4); delay_p; } while (0)
> +#define r4w()			(delay_p, inw(pi->port + 4))
> +#define r4l()			(delay_p, inl(pi->port + 4))
> +
> +static inline u16 pi_swab16(char *b, int k)
> +{
> +	union { u16 u; char t[2]; } r;
> +
> +	r.t[0] = b[2 * k + 1]; r.t[1] = b[2 * k];
> +	return r.u;
> +}
> +
> +static inline u32 pi_swab32(char *b, int k)
> +{
> +	union { u32 u; char f[4]; } r;
> +
> +	r.f[0] = b[4 * k + 1]; r.f[1] = b[4 * k];
> +	r.f[2] = b[4 * k + 3]; r.f[3] = b[4 * k + 2];
> +	return r.u;
> +}
> +
> +struct pi_protocol {
> +	char name[8];
> +
> +	int max_mode;
> +	int epp_first;		/* modes >= this use 8 ports */
> +
> +	int default_delay;
> +	int max_units;		/* max chained units probed for */
> +
> +	void (*write_regr)(struct pi_adapter *pi, int cont, int regr, int val);
> +	int (*read_regr)(struct pi_adapter *pi, int cont, int regr);
> +	void (*write_block)(struct pi_adapter *pi, char *buf, int count);
> +	void (*read_block)(struct pi_adapter *pi, char *buf, int count);
> +
> +	void (*connect)(struct pi_adapter *pi);
> +	void (*disconnect)(struct pi_adapter *pi);
> +
> +	int (*test_port)(struct pi_adapter *pi);
> +	int (*probe_unit)(struct pi_adapter *pi);
> +	int (*test_proto)(struct pi_adapter *pi, char *scratch, int verbose);
> +	void (*log_adapter)(struct pi_adapter *pi, char *scratch, int verbose);
> +
> +	int (*init_proto)(struct pi_adapter *pi);
> +	void (*release_proto)(struct pi_adapter *pi);
> +	struct module *owner;
> +	struct device_driver driver;
> +	struct scsi_host_template sht;
> +};
> +
> +#define PATA_PARPORT_SHT ATA_PIO_SHT
> +
> +int pata_parport_register_driver(struct pi_protocol *pr);
> +void pata_parport_unregister_driver(struct pi_protocol *pr);
> +/* defines for old paride protocol modules */
> +#define paride_register pata_parport_register_driver
> +#define paride_unregister pata_parport_unregister_driver

-- 
Damien Le Moal
Western Digital Research

