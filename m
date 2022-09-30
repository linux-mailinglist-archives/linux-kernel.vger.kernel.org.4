Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDCE5F0B85
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 14:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbiI3MRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 08:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbiI3MRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 08:17:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C8C10BB22;
        Fri, 30 Sep 2022 05:17:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0333B8289D;
        Fri, 30 Sep 2022 12:17:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B21BC433C1;
        Fri, 30 Sep 2022 12:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664540225;
        bh=Lw4RNjdwg6MJ1iI94XdpY86OA87TCxd8pkck5BKG96k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LhkLBfYYQbVQrM+WUAux08+9pyP8lETcqzw87cuEXuE+K3gVbgOItUFMeZLejQYbP
         gB4rZx7j8FZ2Ny6hhjK6uHENQk6f0NDLikHgzY7oGpiO/k2w4JGH8RFbe7Nlz+d/ZC
         XIPVbGQj3gpTtuHufzOsvB0UaT115PWWNaS+M92U=
Date:   Fri, 30 Sep 2022 14:17:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 14/14] tty: gunyah: Add tty console driver for RM
 Console Services
Message-ID: <YzbePxTF8hRbWNRU@kroah.com>
References: <20220928195633.2348848-1-quic_eberman@quicinc.com>
 <20220928195633.2348848-15-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928195633.2348848-15-quic_eberman@quicinc.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 12:56:33PM -0700, Elliot Berman wrote:
> Gunyah provides a console for each VM using the VM console resource
> manager APIs. This driver allows console data from other
> VMs to be accessed via a TTY device and exports a console device to dump
> Linux's own logs to our console.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>  MAINTAINERS              |   1 +
>  drivers/tty/Kconfig      |   8 +
>  drivers/tty/Makefile     |   1 +
>  drivers/tty/gunyah_tty.c | 409 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 419 insertions(+)
>  create mode 100644 drivers/tty/gunyah_tty.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a0cba618e5f6..e8d4a6d9491a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8890,6 +8890,7 @@ F:	Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
>  F:	Documentation/virt/gunyah/
>  F:	arch/arm64/gunyah/
>  F:	drivers/mailbox/gunyah-msgq.c
> +F:	drivers/tty/gunyah_tty.c
>  F:	drivers/virt/gunyah/
>  F:	include/asm-generic/gunyah.h
>  F:	include/linux/gunyah*.h
> diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
> index cc30ff93e2e4..ff86e977f9ac 100644
> --- a/drivers/tty/Kconfig
> +++ b/drivers/tty/Kconfig
> @@ -380,6 +380,14 @@ config RPMSG_TTY
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called rpmsg_tty.
>  
> +config GUNYAH_CONSOLE
> +	tristate "Gunyah Consoles"
> +	depends on GUNYAH
> +	help
> +	  This enables support for console output using Gunyah's Resource Manager RPC.
> +	  This is normally used when a secondary VM which does not have exclusive access
> +	  to a real or virtualized serial device and virtio-console is unavailable.

module name?

> +
>  endif # TTY
>  
>  source "drivers/tty/serdev/Kconfig"
> diff --git a/drivers/tty/Makefile b/drivers/tty/Makefile
> index 07aca5184a55..d183fbfd835b 100644
> --- a/drivers/tty/Makefile
> +++ b/drivers/tty/Makefile
> @@ -27,5 +27,6 @@ obj-$(CONFIG_GOLDFISH_TTY)	+= goldfish.o
>  obj-$(CONFIG_MIPS_EJTAG_FDC_TTY) += mips_ejtag_fdc.o
>  obj-$(CONFIG_VCC)		+= vcc.o
>  obj-$(CONFIG_RPMSG_TTY)		+= rpmsg_tty.o
> +obj-$(CONFIG_GUNYAH_CONSOLE)	+= gunyah_tty.o
>  
>  obj-y += ipwireless/
> diff --git a/drivers/tty/gunyah_tty.c b/drivers/tty/gunyah_tty.c
> new file mode 100644
> index 000000000000..80a20da11ad0
> --- /dev/null
> +++ b/drivers/tty/gunyah_tty.c
> @@ -0,0 +1,409 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#define pr_fmt(fmt) "gh_rsc_mgr_console: " fmt

You are a driver, use dev_printk() functions, no need for pr_fmt() at
all, right?

> +
> +#include <linux/gunyah_rsc_mgr.h>
> +#include <linux/auxiliary_bus.h>
> +#include <linux/workqueue.h>
> +#include <linux/spinlock.h>
> +#include <linux/tty_flip.h>
> +#include <linux/console.h>
> +#include <linux/module.h>
> +#include <linux/kfifo.h>
> +#include <linux/kref.h>
> +#include <linux/slab.h>
> +#include <linux/tty.h>
> +
> +/*
> + * The Linux TTY code does not support dynamic addition of tty derived devices so we need to know
> + * how many tty devices we might need when space is allocated for the tty device. Since VMs might be
> + * added/removed dynamically, we need to make sure we have enough allocated.

Wrap comments at 80 columns please.

> + */
> +#define RSC_MGR_TTY_ADAPTERS		16

We can have dynamic tty devices, so I don't understand this comment.
What really is the problem here?

> +
> +/* # of payload bytes that can fit in a 1-fragment CONSOLE_WRITE message */
> +#define RM_CONS_WRITE_MSG_SIZE	((1 * (GH_MSGQ_MAX_MSG_SIZE - 8)) - 4)
> +
> +struct rm_cons_port {
> +	struct tty_port port;
> +	u16 vmid;
> +	bool open;

Why do you care if it is open or not?

> +	unsigned int index;
> +
> +	DECLARE_KFIFO(put_fifo, char, 1024);
> +	spinlock_t fifo_lock;
> +	struct work_struct put_work;
> +
> +	struct rm_cons_data *cons_data;
> +};
> +
> +struct rm_cons_data {
> +	struct tty_driver *tty_driver;
> +	struct device *dev;
> +
> +	spinlock_t ports_lock;
> +	struct rm_cons_port *ports[RSC_MGR_TTY_ADAPTERS];
> +
> +	struct notifier_block rsc_mgr_notif;
> +	struct console console;
> +};
> +
> +static void put_work_fn(struct work_struct *ws)
> +{
> +	char buf[RM_CONS_WRITE_MSG_SIZE];
> +	int count, ret;
> +	struct rm_cons_port *port = container_of(ws, struct rm_cons_port, put_work);
> +
> +	while (!kfifo_is_empty(&port->put_fifo)) {
> +		count = kfifo_out_spinlocked(&port->put_fifo, buf, sizeof(buf), &port->fifo_lock);
> +		if (count <= 0)
> +			continue;
> +
> +		ret = gh_rm_console_write(port->vmid, buf, count);
> +		if (ret) {
> +			pr_warn_once("failed to send characters: %d\n", ret);

What will this warning help with?

> +			break;

If an error happens, shouldn't you keep trying to send the rest of the
data?

> +		}
> +	}
> +}
> +
> +static int rsc_mgr_console_notif(struct notifier_block *nb, unsigned long cmd, void *data)
> +{
> +	int count, i;
> +	struct rm_cons_port *rm_port = NULL;
> +	struct tty_port *tty_port = NULL;
> +	struct rm_cons_data *cons_data = container_of(nb, struct rm_cons_data, rsc_mgr_notif);
> +	const struct gh_rm_notification *notif = data;
> +	struct gh_rm_notif_vm_console_chars const * const msg = notif->buff;
> +
> +	if (cmd != GH_RM_NOTIF_VM_CONSOLE_CHARS ||
> +		notif->size < sizeof(*msg))
> +		return NOTIFY_DONE;
> +
> +	spin_lock(&cons_data->ports_lock);
> +	for (i = 0; i < RSC_MGR_TTY_ADAPTERS; i++) {
> +		if (!cons_data->ports[i])
> +			continue;
> +		if (cons_data->ports[i]->vmid == msg->vmid) {
> +			rm_port = cons_data->ports[i];
> +			break;
> +		}
> +	}
> +	if (rm_port)
> +		tty_port = tty_port_get(&rm_port->port);
> +	spin_unlock(&cons_data->ports_lock);
> +
> +	if (!rm_port)
> +		pr_warn("Received unexpected console characters for VMID %u\n", msg->vmid);
> +	if (!tty_port)
> +		return NOTIFY_DONE;
> +
> +	count = tty_buffer_request_room(tty_port, msg->num_bytes);
> +	tty_insert_flip_string(tty_port, msg->bytes, count);
> +	tty_flip_buffer_push(tty_port);
> +
> +	tty_port_put(tty_port);
> +	return NOTIFY_OK;
> +}
> +
> +static ssize_t vmid_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct rm_cons_port *rm_port = dev_get_drvdata(dev);
> +
> +	if (rm_port->vmid == GH_VMID_SELF)
> +		return sysfs_emit(buf, "self\n");
> +
> +	return sysfs_emit(buf, "%u\n", rm_port->vmid);

You didn't document this sysfs file, why not?

And tty drivers should not have random sysfs files, please don't add
this.

> +}
> +
> +static DEVICE_ATTR_RO(vmid);
> +
> +static struct attribute *rsc_mgr_tty_dev_attrs[] = {
> +	&dev_attr_vmid.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group rsc_mgr_tty_dev_attr_group = {
> +	.attrs = rsc_mgr_tty_dev_attrs,
> +};
> +
> +static const struct attribute_group *rsc_mgr_tty_dev_attr_groups[] = {
> +	&rsc_mgr_tty_dev_attr_group,
> +	NULL
> +};
> +
> +static int rsc_mgr_tty_open(struct tty_struct *tty, struct file *filp)
> +{
> +	int ret;
> +	struct rm_cons_port *rm_port = dev_get_drvdata(tty->dev);
> +
> +	if (!rm_port->open) {

Why are you caring if the port is open already or not?

> +		ret = gh_rm_console_open(rm_port->vmid);

Can't this just be called for every open()?

And what happens if this changes right after it is checked?

> +		if (ret) {
> +			pr_err("Failed to open RM console for vmid %x: %d\n", rm_port->vmid, ret);

dev_err()

> +			return ret;
> +		}
> +		rm_port->open = true;
> +	}
> +
> +	return tty_port_open(&rm_port->port, tty, filp);
> +}
> +
> +static void rsc_mgr_tty_close(struct tty_struct *tty, struct file *filp)
> +{
> +	int ret;
> +	struct rm_cons_port *rm_port = dev_get_drvdata(tty->dev);
> +
> +	if (rm_port->open) {
> +		if (rm_port->vmid != GH_VMID_SELF) {
> +			ret = gh_rm_console_close(rm_port->vmid);
> +			if (ret)
> +				pr_warn("Failed to close RM console for vmid %d: %d\n",
> +					rm_port->vmid, ret);
> +		}
> +		rm_port->open = false;

So if you had multiple open/close this would close the console the first
close call, but not the second?

Are you sure you tested this out properly?

> +
> +		tty_port_close(&rm_port->port, tty, filp);
> +	}
> +
> +}
> +
> +static int rsc_mgr_tty_write(struct tty_struct *tty, const unsigned char *buf, int count)
> +{
> +	struct rm_cons_port *rm_port = dev_get_drvdata(tty->dev);
> +	int ret;
> +
> +	ret = kfifo_in_spinlocked(&rm_port->put_fifo, buf, count, &rm_port->fifo_lock);
> +	if (ret > 0)
> +		schedule_work(&rm_port->put_work);

Why not just do the write here?  Why is a work queue needed?

> +
> +	return ret;
> +}
> +
> +static unsigned int rsc_mgr_mgr_tty_write_room(struct tty_struct *tty)
> +{
> +	struct rm_cons_port *rm_port = dev_get_drvdata(tty->dev);
> +
> +	return kfifo_avail(&rm_port->put_fifo);
> +}
> +
> +static void rsc_mgr_console_write(struct console *co, const char *buf, unsigned count)
> +{
> +	struct rm_cons_port *rm_port = co->data;
> +	int ret;
> +
> +	ret = kfifo_in_spinlocked(&rm_port->put_fifo, buf, count, &rm_port->fifo_lock);
> +	if (ret > 0)
> +		schedule_work(&rm_port->put_work);

Same here, why not just send the data now?

> +}
> +
> +static struct tty_driver *rsc_mgr_console_device(struct console *co, int *index)
> +{
> +	struct rm_cons_port *rm_port = co->data;
> +
> +	*index = rm_port->index;
> +	return rm_port->port.tty->driver;

Love the locking :(

> +}
> +
> +static int rsc_mgr_console_setup(struct console *co, char *unused)
> +{
> +	int ret;
> +	struct rm_cons_port *rm_port = co->data;
> +
> +	if (!rm_port->open) {
> +		ret = gh_rm_console_open(rm_port->vmid);
> +		if (ret) {
> +			pr_err("Failed to open RM console for vmid %x: %d\n", rm_port->vmid, ret);
> +			return ret;
> +		}
> +		rm_port->open = true;

Again, don't mess with open/close.

> +	}
> +
> +	return 0;
> +}
> +
> +static int rsc_mgr_console_exit(struct console *co)
> +{
> +	int ret;
> +	struct rm_cons_port *rm_port = co->data;
> +
> +	if (rm_port->open) {
> +		ret = gh_rm_console_close(rm_port->vmid);
> +		if (ret) {
> +			pr_err("Failed to close RM console for vmid %x: %d\n", rm_port->vmid, ret);
> +			return ret;
> +		}
> +		rm_port->open = false;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct tty_operations rsc_mgr_tty_ops = {
> +	.open = rsc_mgr_tty_open,
> +	.close = rsc_mgr_tty_close,
> +	.write = rsc_mgr_tty_write,
> +	.write_room = rsc_mgr_mgr_tty_write_room,
> +};
> +
> +static void rsc_mgr_port_destruct(struct tty_port *port)
> +{
> +	struct rm_cons_port *rm_port = container_of(port, struct rm_cons_port, port);
> +	struct rm_cons_data *cons_data = rm_port->cons_data;
> +
> +	spin_lock(&cons_data->ports_lock);
> +	WARN_ON(cons_data->ports[rm_port->index] != rm_port);

Does this mean you just crashed the system if something went wrong?

How can this ever happen?


> +	cons_data->ports[rm_port->index] = NULL;
> +	spin_unlock(&cons_data->ports_lock);
> +	kfree(rm_port);
> +}
> +
> +static const struct tty_port_operations rsc_mgr_port_ops = {
> +	.destruct = rsc_mgr_port_destruct,
> +};
> +
> +static struct rm_cons_port *rsc_mgr_port_create(struct rm_cons_data *cons_data, u16 vmid)
> +{
> +	struct rm_cons_port *rm_port;
> +	struct device *ttydev;
> +	unsigned int index;
> +	int ret;
> +
> +	rm_port = kzalloc(sizeof(*rm_port), GFP_KERNEL);
> +	rm_port->vmid = vmid;
> +	INIT_KFIFO(rm_port->put_fifo);
> +	spin_lock_init(&rm_port->fifo_lock);
> +	INIT_WORK(&rm_port->put_work, put_work_fn);
> +	tty_port_init(&rm_port->port);
> +	rm_port->port.ops = &rsc_mgr_port_ops;
> +
> +	spin_lock(&cons_data->ports_lock);
> +	for (index = 0; index < RSC_MGR_TTY_ADAPTERS; index++) {
> +		if (!cons_data->ports[index]) {
> +			cons_data->ports[index] = rm_port;
> +			rm_port->index = index;
> +			break;
> +		}
> +	}
> +	spin_unlock(&cons_data->ports_lock);
> +	if (index >= RSC_MGR_TTY_ADAPTERS) {
> +		ret = -ENOSPC;
> +		goto err_put_port;
> +	}
> +
> +	ttydev = tty_port_register_device_attr(&rm_port->port, cons_data->tty_driver, index,
> +					      cons_data->dev, rm_port, rsc_mgr_tty_dev_attr_groups);
> +	if (IS_ERR(ttydev)) {
> +		ret = PTR_ERR(ttydev);
> +		goto err_put_port;
> +	}
> +
> +	return rm_port;
> +err_put_port:
> +	tty_port_put(&rm_port->port);
> +	return ERR_PTR(ret);
> +}
> +
> +static int rsc_mgr_console_probe(struct auxiliary_device *auxdev,
> +	const struct auxiliary_device_id *aux_dev_id)
> +{
> +	struct rm_cons_data *cons_data;
> +	struct rm_cons_port *rm_port;
> +	int ret;
> +	u16 vmid;
> +
> +	cons_data = devm_kzalloc(&auxdev->dev, sizeof(*cons_data), GFP_KERNEL);
> +	if (!cons_data)
> +		return -ENOMEM;
> +	dev_set_drvdata(&auxdev->dev, cons_data);
> +	cons_data->dev = &auxdev->dev;
> +
> +	cons_data->tty_driver = tty_alloc_driver(RSC_MGR_TTY_ADAPTERS,
> +						 TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV);
> +	if (IS_ERR(cons_data->tty_driver))
> +		return PTR_ERR(cons_data->tty_driver);
> +
> +	cons_data->tty_driver->driver_name = "gh";
> +	cons_data->tty_driver->name = "ttyGH";

Where did you pick this name from?

Where is it documented?

> +	cons_data->tty_driver->type = TTY_DRIVER_TYPE_SYSTEM;
> +	cons_data->tty_driver->init_termios = tty_std_termios;
> +	tty_set_operations(cons_data->tty_driver, &rsc_mgr_tty_ops);
> +
> +	ret = tty_register_driver(cons_data->tty_driver);
> +	if (ret) {
> +		dev_err(&auxdev->dev, "Could not register tty driver: %d\n", ret);
> +		goto err_put_tty;
> +	}
> +
> +	spin_lock_init(&cons_data->ports_lock);
> +
> +	cons_data->rsc_mgr_notif.notifier_call = rsc_mgr_console_notif;
> +	ret = gh_rm_register_notifier(&cons_data->rsc_mgr_notif);
> +	if (ret) {
> +		dev_err(&auxdev->dev, "Could not register for resource manager notifications: %d\n",
> +			ret);
> +		goto err_put_tty;
> +	}
> +
> +	rm_port = rsc_mgr_port_create(cons_data, GH_VMID_SELF);
> +	if (IS_ERR(rm_port)) {
> +		ret = PTR_ERR(rm_port);
> +		dev_err(&auxdev->dev, "Could not create own console: %d\n", ret);
> +		goto err_unreg_notif;
> +	}
> +
> +	strncpy(cons_data->console.name, "ttyGH", sizeof(cons_data->console.name));

Again, where did this name come from?

thanks,

greg k-h
