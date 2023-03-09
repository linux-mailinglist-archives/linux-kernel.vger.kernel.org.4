Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FD96B31D7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 00:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjCIXBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 18:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjCIXBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 18:01:33 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85968E2771
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 15:01:30 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id i3so3683276plg.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 15:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678402890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xAmD35txHPJZM9FPGzIiZtIyJZnyYAAvXLLRN7HY00k=;
        b=PWsM40LE6mMbruRmwGxdOw8opvcvxJn4YcjWy/ReaGTZnT4FbslX+mRVVw/S0oNDHC
         4l2RQc3NAituG8jLWXtqBIFaWi5kb4BPqMxi7ms9knQVFa8bdpoYmhI6I//maKg7GgxT
         Hih9XFYlTcLnICKbHf4n7EAL6iWW0l2kOy10S1o1814AY2ySEInBVcb/u3SIc/ZXgjpR
         K+PB3rSJ2DFoapqxQ0rE1/H+Lp0llGFst6QIQUSLKSfhvVmV2dl7bPdtneX8/yls4aUL
         DpJqR+xL1SN6868qy+uWqRrD+wyycXB59Y64GI/OmFsybexMVxQ9WcUEbimCxLxZQNnw
         f+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678402890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xAmD35txHPJZM9FPGzIiZtIyJZnyYAAvXLLRN7HY00k=;
        b=zPlDiW6JkIZzA8dh7t0IfQJw4jOQdShoKJH2xgOwlO8w61xs05s3hMrE0HKUIhSQJH
         HN5SYonUsA63ZgHOi4ojrPvfPYcEhD+VbWANMamh/HAdf/bdtYJWqMSnyLyJ6ztpb0Lh
         /pLdSV4rdSbMgUXlAE/iZdd+OL77B0igzTea9+tR9yypkiQ7sJA/1f5RxBEGEiqmieZp
         09ZMCoTuLXUliOSQxfskspQP9lvJWpsi9S81BC0rjo72ry700E5f24M69w5Gvi3wbUHz
         6SW+HtBqTtrGLIWUw9ImccD2bPdCk9dRH7R5UBFEOuA7o+pgCFM4JKmclZUMtsZ+LqJU
         KDJA==
X-Gm-Message-State: AO0yUKXwABwwmrNWpqdQc1TuGeWBVc49/1xhONZBatRzSBdQUyAQ4JfI
        mXos30IsB8twGJqXAJUzMRX7zw==
X-Google-Smtp-Source: AK7set/oiHm6LEYIWf4SKd4z0Jmgfz9n+6htG2tObHW4tk6e0+7jJc0qobgjhl7AP+8qUrbnCiNw8g==
X-Received: by 2002:a17:903:41c8:b0:19a:6ec0:50c2 with SMTP id u8-20020a17090341c800b0019a6ec050c2mr28685644ple.26.1678402889693;
        Thu, 09 Mar 2023 15:01:29 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:f58c:e21:9d45:4a5b])
        by smtp.gmail.com with ESMTPSA id kz3-20020a170902f9c300b0019f0fb0bf7dsm16820plb.297.2023.03.09.15.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 15:01:29 -0800 (PST)
Date:   Thu, 9 Mar 2023 16:01:27 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Martyn Welch <martyn.welch@collabora.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, kernel@collabora.com,
        Hari Nagalla <hnagalla@ti.com>, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v3 3/3] remoteproc: k4-m4: Add a remoteproc driver for
 M4F subsystem
Message-ID: <20230309230127.GA1838463@p14s>
References: <20230302171450.1598576-1-martyn.welch@collabora.com>
 <20230302171450.1598576-4-martyn.welch@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302171450.1598576-4-martyn.welch@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 05:14:50PM +0000, Martyn Welch wrote:
> The AM62x and AM64x SoCs of the TI K3 family has a Cortex  M4F core in

s/"a Cortex  M4F core"/"a Cortex M4F core"

> the MCU domain. This core is typically used for safety applications in a
> stand alone mode. However, some application (non safety related) may
> want to use the M4F core as a generic remote processor with IPC to the
> host processor. The M4F core has internal IRAM and DRAM memories and are
> exposed to the system bus for code and data loading.
> 
> A remote processor driver is added to support this subsystem, including
> being able to load and boot the M4F core. Loading includes to M4F
> internal memories and to any predefined external code/data memory. The

Here "and to" doesn't make sense - please refactor.

> carveouts for external contiguous memory is defined in the M4F device
> node and should match with the external memory declarations in the M4F
> image binary. The M4F subsystem has two resets. One reset is for the
> entire subsystem i.e including the internal memories and ther other, a

s/ther/the

> local reset is only for the M4F processing core. When loading the image,
> the driver first releases the subsystem reset, loads the firmware image
> and then releases the local reset to let the M4F processing core run.
> 
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> [Martyn Welch: Modified to use common code refactored from DSP driver]

Same comment as before

> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> ---
> 
> Changes since v1:
>  - Addressed minor review comments (refactoring completed in separate
>    patch)
> 
> Changes since v2:
>  - Refactoring completed first, thus smaller change
> 
> Note: The only review comment that I don't see directly addressed regards
>       the copyright date. I have no knowledge of whether this driver was
>       written in 2021 or 2022. The R5 and DSP drivers have copyright date
>       ranges from 2017 and 2018 respectively, so it seems plausible the
>       development of this driver was carried out during 2021 (given that
>       it was originally submitted upstream in Jan 2022).
> 

I think what you have below is just fine.  Hari can advise if he thinks
otherwise.

>  drivers/remoteproc/Kconfig               |  13 +
>  drivers/remoteproc/Makefile              |   1 +
>  drivers/remoteproc/ti_k3_common.h        |   7 +-
>  drivers/remoteproc/ti_k3_m4_remoteproc.c | 491 +++++++++++++++++++++++
>  4 files changed, 511 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/remoteproc/ti_k3_m4_remoteproc.c
> 
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index a850e9f486dd..ff65b73d7e59 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -339,6 +339,19 @@ config TI_K3_DSP_REMOTEPROC
>  	  It's safe to say N here if you're not interested in utilizing
>  	  the DSP slave processors.
>  
> +config TI_K3_M4_REMOTEPROC
> +	tristate "TI K3 M4 remoteproc support"
> +	depends on ARCH_K3
> +	select MAILBOX
> +	select OMAP2PLUS_MBOX
> +	help
> +	  Say m here to support TI's M4 remote processor subsystems
> +	  on various TI K3 family of SoCs through the remote processor
> +	  framework.
> +
> +	  It's safe to say N here if you're not interested in utilizing
> +	  a remote processor.
> +
>  config TI_K3_R5_REMOTEPROC
>  	tristate "TI K3 R5 remoteproc support"
>  	depends on ARCH_K3
> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
> index 55c552e27a45..e30908ca4bfc 100644
> --- a/drivers/remoteproc/Makefile
> +++ b/drivers/remoteproc/Makefile
> @@ -37,5 +37,6 @@ obj-$(CONFIG_ST_REMOTEPROC)		+= st_remoteproc.o
>  obj-$(CONFIG_ST_SLIM_REMOTEPROC)	+= st_slim_rproc.o
>  obj-$(CONFIG_STM32_RPROC)		+= stm32_rproc.o
>  obj-$(CONFIG_TI_K3_DSP_REMOTEPROC)	+= ti_k3_dsp_remoteproc.o ti_k3_common.o
> +obj-$(CONFIG_TI_K3_M4_REMOTEPROC)	+= ti_k3_m4_remoteproc.o ti_k3_common.o
>  obj-$(CONFIG_TI_K3_R5_REMOTEPROC)	+= ti_k3_r5_remoteproc.o
>  obj-$(CONFIG_XLNX_R5_REMOTEPROC)	+= xlnx_r5_remoteproc.o
> diff --git a/drivers/remoteproc/ti_k3_common.h b/drivers/remoteproc/ti_k3_common.h
> index 312df2ab3cd2..ed8ca5858492 100644
> --- a/drivers/remoteproc/ti_k3_common.h
> +++ b/drivers/remoteproc/ti_k3_common.h
> @@ -2,11 +2,15 @@
>  /*
>   * TI K3 Remote Processor(s) driver common code
>   *
> - * Refactored from ti_k3_dsp_remoteproc.c.
> + * Refactored from ti_k3_dsp_remoteproc.c and ti_k3_m4_remoteproc.c.
>   *
>   * ti_k3_dsp_remoteproc.c:
>   * Copyright (C) 2018-2022 Texas Instruments Incorporated - https://www.ti.com/
>   *	Suman Anna <s-anna@ti.com>
> + *
> + * ti_k3_m4_remoteproc.c:
> + * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
> + *	Hari Nagalla <hnagalla@ti.com>
>   */
>  
>  #ifndef REMOTEPROC_TI_K3_COMMON_H
> @@ -83,6 +87,7 @@ struct k3_rproc {
>  	u32 ti_sci_id;
>  	struct mbox_chan *mbox;
>  	struct mbox_client client;
> +	bool ipc_only;
>  };
>  
>  void k3_rproc_kick(struct rproc *rproc, int vqid);
> diff --git a/drivers/remoteproc/ti_k3_m4_remoteproc.c b/drivers/remoteproc/ti_k3_m4_remoteproc.c
> new file mode 100644
> index 000000000000..8a55e42544af
> --- /dev/null
> +++ b/drivers/remoteproc/ti_k3_m4_remoteproc.c
> @@ -0,0 +1,491 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * TI K3 Cortex-M4 Remote Processor(s) driver
> + *
> + * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
> + *	Hari Nagalla <hnagalla@ti.com>
> + */
> +
> +#include <linux/io.h>
> +#include <linux/mailbox_client.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of_reserved_mem.h>
> +#include <linux/omap-mailbox.h>
> +#include <linux/platform_device.h>
> +#include <linux/remoteproc.h>
> +#include <linux/reset.h>
> +#include <linux/slab.h>
> +
> +#include "omap_remoteproc.h"
> +#include "remoteproc_internal.h"
> +#include "ti_sci_proc.h"
> +#include "ti_k3_common.h"
> +
> +/**
> + * k3_m4_rproc_mbox_callback() - inbound mailbox message handler
> + * @client: mailbox client pointer used for requesting the mailbox channel
> + * @data: mailbox payload
> + *
> + * This handler is invoked by the OMAP mailbox driver whenever a mailbox
> + * message is received. Usually, the mailbox payload simply contains
> + * the index of the virtqueue that is kicked by the remote processor,
> + * and we let remoteproc core handle it.
> + *
> + * In addition to virtqueue indices, we also have some out-of-band values
> + * that indicate different events. Those values are deliberately very
> + * large so they don't coincide with virtqueue indices.
> + */
> +static void k3_m4_rproc_mbox_callback(struct mbox_client *client, void *data)
> +{
> +	struct k3_rproc *kproc = container_of(client, struct k3_rproc,
> +						  client);
> +	struct device *dev = kproc->rproc->dev.parent;
> +	const char *name = kproc->rproc->name;
> +	u32 msg = omap_mbox_message(data);
> +
> +	dev_dbg(dev, "mbox msg: 0x%x\n", msg);
> +
> +	switch (msg) {
> +	case RP_MBOX_CRASH:
> +		/*
> +		 * remoteproc detected an exception, but error recovery is not
> +		 * supported. So, just log this for now
> +		 */
> +		dev_err(dev, "K3 M4 rproc %s crashed\n", name);

We have rproc->name here and that should be sufficient for users to know which
remote processor has crashed without having to specify the "M4" part.  The same
applies to the "DSP" in k3_dsp_rproc_mbox_callback().  Other than this the
functions are the same and could be shared.

> +		break;
> +	case RP_MBOX_ECHO_REPLY:
> +		dev_info(dev, "received echo reply from %s\n", name);
> +		break;
> +	default:
> +		/* silently handle all other valid messages */
> +		if (msg >= RP_MBOX_READY && msg < RP_MBOX_END_MSG)
> +			return;
> +		if (msg > kproc->rproc->max_notifyid) {
> +			dev_dbg(dev, "dropping unknown message 0x%x", msg);
> +			return;
> +		}
> +		/* msg contains the index of the triggered vring */
> +		if (rproc_vq_interrupt(kproc->rproc, msg) == IRQ_NONE)
> +			dev_dbg(dev, "no message was found in vqid %d\n", msg);
> +	}
> +}
> +
> +static int k3_m4_rproc_request_mbox(struct rproc *rproc)
> +{
> +	struct k3_rproc *kproc = rproc->priv;
> +	struct mbox_client *client = &kproc->client;
> +	struct device *dev = kproc->dev;
> +	int ret;
> +
> +	client->dev = dev;
> +	client->tx_done = NULL;
> +	client->rx_callback = k3_m4_rproc_mbox_callback;

Same comment as above, i.e if k3_m4_rproc_mbox_callback() becomes generic than
k3_rproc_request_mbox() can be shared by both drivers.

> +	client->tx_block = false;
> +	client->knows_txdone = false;
> +
> +	kproc->mbox = mbox_request_channel(client, 0);
> +	if (IS_ERR(kproc->mbox)) {
> +		ret = -EBUSY;
> +		dev_err(dev, "mbox_request_channel failed: %ld\n",
> +			PTR_ERR(kproc->mbox));
> +		return ret;
> +	}
> +
> +	/*
> +	 * Ping the remote processor, this is only for sanity-sake for now;
> +	 * there is no functional effect whatsoever.
> +	 *
> +	 * Note that the reply will _not_ arrive immediately: this message
> +	 * will wait in the mailbox fifo until the remote processor is booted.
> +	 */
> +	ret = mbox_send_message(kproc->mbox, (void *)RP_MBOX_ECHO_REQUEST);
> +	if (ret < 0) {
> +		dev_err(dev, "mbox_send_message failed: %d\n", ret);
> +		mbox_free_channel(kproc->mbox);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * The M4F cores have a local reset that affects only the CPU, and a
> + * generic module reset that powers on the device and allows the M4 internal
> + * memories to be accessed while the local reset is asserted. This function is
> + * used to release the global reset on M4F to allow loading into the M4F
> + * internal RAMs. The .prepare() ops is invoked by remoteproc core before any
> + * firmware loading, and is followed by the .start() ops after loading to
> + * actually let the M4F core run.
> + */
> +static int k3_m4_rproc_prepare(struct rproc *rproc)
> +{
> +	struct k3_rproc *kproc = rproc->priv;
> +	struct device *dev = kproc->dev;
> +	int ret;
> +
> +	/* IPC-only mode does not require the core to be released from reset */
> +	if (kproc->ipc_only)
> +		return 0;
> +

See my comment below

> +	ret = kproc->ti_sci->ops.dev_ops.get_device(kproc->ti_sci,
> +						    kproc->ti_sci_id);
> +	if (ret)
> +		dev_err(dev, "module-reset deassert failed, cannot enable internal RAM loading, ret = %d\n",
> +			ret);
> +
> +	return ret;
> +}
> +
> +/*
> + * This function implements the .unprepare() ops and performs the complimentary
> + * operations to that of the .prepare() ops. The function is used to assert the
> + * global reset on applicable M4F cores. This completes the second portion of
> + * powering down the M4F cores. The cores themselves are only halted in the
> + * .stop() callback through the local reset, and the .unprepare() ops is invoked
> + * by the remoteproc core after the remoteproc is stopped to balance the global
> + * reset.
> + */
> +static int k3_m4_rproc_unprepare(struct rproc *rproc)
> +{
> +	struct k3_rproc *kproc = rproc->priv;
> +	struct device *dev = kproc->dev;
> +	int ret;
> +
> +	/* do not put back the cores into reset in IPC-only mode */
> +	if (kproc->ipc_only)
> +		return 0;
> +

Same

> +	ret = kproc->ti_sci->ops.dev_ops.put_device(kproc->ti_sci,
> +						    kproc->ti_sci_id);
> +	if (ret)
> +		dev_err(dev, "module-reset assert failed, ret = %d\n", ret);
> +
> +	return ret;
> +}
> +
> +/*
> + * Power up the M4F remote processor.
> + *
> + * This function will be invoked only after the firmware for this rproc
> + * was loaded, parsed successfully, and all of its resource requirements
> + * were met.
> + */
> +static int k3_m4_rproc_start(struct rproc *rproc)
> +{
> +	struct k3_rproc *kproc = rproc->priv;
> +	struct device *dev = kproc->dev;
> +	u32 boot_addr;
> +	int ret;
> +
> +	if (kproc->ipc_only) {
> +		dev_err(dev, "%s cannot be invoked in IPC-only mode\n",
> +			__func__);
> +		return -EINVAL;
> +	}

The above is not needed if k3_m4_rproc_ops is fixed in probe() to enact the
right operations based on the operating mode, as it is done in
k3_dsp_rproc_probe().  That way prepare(), unprepare(), start(), stop(),
attach() and detach() can be shared by both drivers.

> +
> +	ret = k3_m4_rproc_request_mbox(rproc);
> +	if (ret)
> +		return ret;
> +
> +	boot_addr = rproc->bootaddr;
> +	ret = k3_rproc_release(kproc);
> +	if (ret)
> +		goto put_mbox;
> +
> +	return 0;
> +
> +put_mbox:
> +	mbox_free_channel(kproc->mbox);
> +	return ret;
> +}
> +
> +/*
> + * Stop the M4 remote processor.
> + *
> + * This function puts the M4 processor into reset, and finishes processing
> + * of any pending messages.
> + */
> +static int k3_m4_rproc_stop(struct rproc *rproc)
> +{
> +	struct k3_rproc *kproc = rproc->priv;
> +	struct device *dev = kproc->dev;
> +
> +	if (kproc->ipc_only) {
> +		dev_err(dev, "%s cannot be invoked in IPC-only mode\n",
> +			__func__);
> +		return -EINVAL;
> +	}
> +
> +	mbox_free_channel(kproc->mbox);
> +
> +	k3_rproc_reset(kproc);
> +
> +	return 0;
> +}
> +
> +/*
> + * Attach to a running M4 remote processor (IPC-only mode)
> + *
> + * This rproc attach callback only needs to request the mailbox, the remote
> + * processor is already booted, so there is no need to issue any TI-SCI
> + * commands to boot the M4 core.
> + */
> +static int k3_m4_rproc_attach(struct rproc *rproc)
> +{
> +	struct k3_rproc *kproc = rproc->priv;
> +	struct device *dev = kproc->dev;
> +	int ret;
> +
> +	if (!kproc->ipc_only || rproc->state != RPROC_DETACHED) {
> +		dev_err(dev, "M4 is expected to be in IPC-only mode and RPROC_DETACHED state\n");
> +		return -EINVAL;
> +	}

Checking for RPROC_DETACHED is not required since it is already done in the
core.

> +
> +	ret = k3_m4_rproc_request_mbox(rproc);
> +	if (ret)
> +		return ret;
> +
> +	dev_err(dev, "M4 initialized in IPC-only mode\n");

Move this to dev_info()

> +	return 0;
> +}
> +
> +/*
> + * Detach from a running M4 remote processor (IPC-only mode)
> + *
> + * This rproc detach callback performs the opposite operation to attach callback
> + * and only needs to release the mailbox, the M4 core is not stopped and will
> + * be left to continue to run its booted firmware.
> + */
> +static int k3_m4_rproc_detach(struct rproc *rproc)
> +{
> +	struct k3_rproc *kproc = rproc->priv;
> +	struct device *dev = kproc->dev;
> +
> +	if (!kproc->ipc_only || rproc->state != RPROC_ATTACHED) {
> +		dev_err(dev, "M4 is expected to be in IPC-only mode and RPROC_ATTACHED state\n");
> +		return -EINVAL;
> +	}
> +
> +	mbox_free_channel(kproc->mbox);
> +	dev_err(dev, "M4 deinitialized in IPC-only mode\n");

Same

> +	return 0;
> +}
> +
> +
> +

Extra new lines.

> +static const struct rproc_ops k3_m4_rproc_ops = {
> +	.start		= k3_m4_rproc_start,
> +	.stop		= k3_m4_rproc_stop,
> +	.attach		= k3_m4_rproc_attach,
> +	.detach		= k3_m4_rproc_detach,
> +	.kick		= k3_rproc_kick,
> +	.da_to_va	= k3_rproc_da_to_va,
> +	.get_loaded_rsc_table = k3_get_loaded_rsc_table,
> +};
> +
> +static int k3_m4_rproc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	const struct k3_rproc_dev_data *data;
> +	struct k3_rproc *kproc;
> +	struct rproc *rproc;
> +	const char *fw_name;
> +	bool r_state = false;
> +	bool p_state = false;
> +	int ret = 0;
> +	int ret1;
> +
> +	data = of_device_get_match_data(dev);
> +	if (!data)
> +		return -ENODEV;
> +
> +	ret = rproc_of_parse_firmware(dev, 0, &fw_name);
> +	if (ret) {
> +		dev_err(dev, "failed to parse firmware-name property, ret = %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	rproc = rproc_alloc(dev, dev_name(dev), &k3_m4_rproc_ops, fw_name,
> +			    sizeof(*kproc));
> +	if (!rproc)
> +		return -ENOMEM;
> +
> +	rproc->has_iommu = false;
> +	rproc->recovery_disabled = true;
> +	if (data->uses_lreset) {
> +		rproc->ops->prepare = k3_m4_rproc_prepare;
> +		rproc->ops->unprepare = k3_m4_rproc_unprepare;
> +	}
> +	kproc = rproc->priv;
> +	kproc->rproc = rproc;
> +	kproc->dev = dev;
> +	kproc->data = data;
> +
> +	kproc->ti_sci = ti_sci_get_by_phandle(np, "ti,sci");
> +	if (IS_ERR(kproc->ti_sci)) {
> +		ret = PTR_ERR(kproc->ti_sci);
> +		if (ret != -EPROBE_DEFER) {
> +			dev_err(dev, "failed to get ti-sci handle, ret = %d\n",
> +				ret);
> +		}
> +		kproc->ti_sci = NULL;
> +		goto free_rproc;
> +	}
> +
> +	ret = of_property_read_u32(np, "ti,sci-dev-id", &kproc->ti_sci_id);
> +	if (ret) {
> +		dev_err(dev, "missing 'ti,sci-dev-id' property\n");
> +		goto put_sci;
> +	}
> +
> +	kproc->reset = devm_reset_control_get_exclusive(dev, NULL);
> +	if (IS_ERR(kproc->reset)) {
> +		ret = PTR_ERR(kproc->reset);
> +		dev_err(dev, "failed to get reset, status = %d\n", ret);
> +		goto put_sci;
> +	}
> +
> +	kproc->tsp = k3_rproc_of_get_tsp(dev, kproc->ti_sci);
> +	if (IS_ERR(kproc->tsp)) {
> +		dev_err(dev, "failed to construct ti-sci proc control, ret = %d\n",
> +			ret);
> +		ret = PTR_ERR(kproc->tsp);
> +		goto put_sci;
> +	}
> +
> +	ret = ti_sci_proc_request(kproc->tsp);
> +	if (ret < 0) {
> +		dev_err(dev, "ti_sci_proc_request failed, ret = %d\n", ret);
> +		goto free_tsp;
> +	}
> +
> +	ret = k3_rproc_of_get_memories(pdev, kproc);
> +	if (ret)
> +		goto release_tsp;
> +
> +	ret = k3_reserved_mem_init(kproc);
> +	if (ret) {
> +		dev_err(dev, "reserved memory init failed, ret = %d\n", ret);
> +		goto release_tsp;
> +	}
> +
> +	ret = kproc->ti_sci->ops.dev_ops.is_on(kproc->ti_sci, kproc->ti_sci_id,
> +					       &r_state, &p_state);
> +	if (ret) {
> +		dev_err(dev, "failed to get initial state, mode cannot be determined, ret = %d\n",
> +			ret);
> +		goto release_mem;
> +	}
> +
> +	/* configure devices for either remoteproc or IPC-only mode */
> +	if (p_state) {
> +		dev_err(dev, "configured M4 for IPC-only mode\n");

Change this to dev_info()

> +		rproc->state = RPROC_DETACHED;
> +		kproc->ipc_only = true;
> +	} else {
> +		dev_err(dev, "configured M4 for remoteproc mode\n");

Same here

I am done reviewing this set.

Thanks,
Mathieu

> +		/*
> +		 * ensure the M4 local reset is asserted to ensure the core
> +		 * doesn't execute bogus code in .prepare() when the module
> +		 * reset is released.
> +		 */
> +		if (data->uses_lreset) {
> +			ret = reset_control_status(kproc->reset);
> +			if (ret < 0) {
> +				dev_err(dev, "failed to get reset status, status = %d\n",
> +					ret);
> +				goto release_mem;
> +			} else if (ret == 0) {
> +				dev_warn(dev, "local reset is deasserted for device\n");
> +				k3_rproc_reset(kproc);
> +			}
> +		}
> +	}
> +
> +	ret = rproc_add(rproc);
> +	if (ret) {
> +		dev_err(dev, "failed to add register device with remoteproc core, status = %d\n",
> +			ret);
> +		goto release_mem;
> +	}
> +
> +	platform_set_drvdata(pdev, kproc);
> +
> +	return 0;
> +
> +release_mem:
> +	k3_reserved_mem_exit(kproc);
> +release_tsp:
> +	ret1 = ti_sci_proc_release(kproc->tsp);
> +	if (ret1)
> +		dev_err(dev, "failed to release proc, ret = %d\n", ret1);
> +free_tsp:
> +	kfree(kproc->tsp);
> +put_sci:
> +	ret1 = ti_sci_put_handle(kproc->ti_sci);
> +	if (ret1)
> +		dev_err(dev, "failed to put ti_sci handle, ret = %d\n", ret1);
> +free_rproc:
> +	rproc_free(rproc);
> +	return ret;
> +}
> +
> +static int k3_m4_rproc_remove(struct platform_device *pdev)
> +{
> +	struct k3_rproc *kproc = platform_get_drvdata(pdev);
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	rproc_del(kproc->rproc);
> +
> +	ret = ti_sci_proc_release(kproc->tsp);
> +	if (ret)
> +		dev_err(dev, "failed to release proc, ret = %d\n", ret);
> +
> +	kfree(kproc->tsp);
> +
> +	ret = ti_sci_put_handle(kproc->ti_sci);
> +	if (ret)
> +		dev_err(dev, "failed to put ti_sci handle, ret = %d\n", ret);
> +
> +	k3_reserved_mem_exit(kproc);
> +	rproc_free(kproc->rproc);
> +
> +	return 0;
> +}
> +
> +static const struct k3_rproc_mem_data am64_m4_mems[] = {
> +	{ .name = "iram", .dev_addr = 0x0 },
> +	{ .name = "dram", .dev_addr = 0x30000 },
> +};
> +
> +static const struct k3_rproc_dev_data am64_m4_data = {
> +	.mems = am64_m4_mems,
> +	.num_mems = ARRAY_SIZE(am64_m4_mems),
> +	.boot_align_addr = SZ_1K,
> +	.uses_lreset = true,
> +};
> +
> +static const struct of_device_id k3_m4_of_match[] = {
> +	{ .compatible = "ti,am64-m4fss", .data = &am64_m4_data, },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, k3_m4_of_match);
> +
> +static struct platform_driver k3_m4_rproc_driver = {
> +	.probe	= k3_m4_rproc_probe,
> +	.remove	= k3_m4_rproc_remove,
> +	.driver	= {
> +		.name = "k3-m4-rproc",
> +		.of_match_table = k3_m4_of_match,
> +	},
> +};
> +
> +module_platform_driver(k3_m4_rproc_driver);
> +
> +MODULE_AUTHOR("Hari Nagalla <hnagalla@ti.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("TI K3 M4 Remoteproc driver");
> -- 
> 2.39.1
> 
