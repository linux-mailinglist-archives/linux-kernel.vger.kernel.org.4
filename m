Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C734A6A8CB7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 00:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCBXK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 18:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjCBXK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 18:10:57 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C0C48E1A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 15:10:55 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id p20so861478plw.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 15:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677798655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OIO2BplgSwwa0QOcYMeKpXSJwqPWn5n80nZsHGXphts=;
        b=Lw3YqjsYYJitC8CakKNkK6I0EP2iwVyueP1TmPD/lQddkt+CdDHiPWuG5OLqrD8ksD
         5wljNh72JxBf0j7TplGBHE/oKOGPIDqf0721jppBg2zrh4mUx+x9p3NClJK/sUCxeMrB
         upXlZZI+Pgms4X6b7vWRf4xxU04cGaJL4KKCS9Em2Kd47VKxG60Z7sTcwNd2DNfn35Zi
         gqtBKoChCmJsFIv3g33zoYvCfX2fra9AGyCWe6RTkdL0LGnqCG33JBp82dE+3XTJ44Ga
         qhH6R7TcENLhQKvgQgvtqoJdUJuy1HAdcWQoHcVgv5iq45wt1AbT1PSVS15lYC/jxqMg
         5UXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677798655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIO2BplgSwwa0QOcYMeKpXSJwqPWn5n80nZsHGXphts=;
        b=Z1NsG3bwL96/8ZOezZH1iRVaZsgZ9Mn3NN2NgOcpG9013Pmo7UcY6hTOX7k9da0qLE
         7O2UQuzKbZPouwCaA73cINtWNXtZHx9b7kUP5zoqTBUZiH8QlrUCGvLavhDArQlLBsjx
         NHnJYH1WHmKbpULkRuRxvcqUkSeE6EpwvutMby9Bkivrqz1Vga5rXwt8NhuG9hF+VCRk
         GJr0LvnAk01tIuOQ7xaNsNvXO3oJOWpLQ8Slpp2QwV7/L+/SE2RX/ESoPyTu8k1KR8is
         RfBbhQzflWdvNVYT0C8YLE/qGHY8L00LbBCgjnxumWMq4fmpQPNB9lNmdT2bO3wR9gQp
         7sjA==
X-Gm-Message-State: AO0yUKX/2UB0DbzH11PwNuw2kHu9c7GHGPYMblzIML3m1nP6JPRcyFPr
        H+9TjfoJEQFtjwcUH0ZKayfFfw==
X-Google-Smtp-Source: AK7set92aAdc8gDXzG3FhKxkbzKff45zlSDK8gamnihQt9rDyE388+SEKrk4q+82nDhK6jWKUMopcw==
X-Received: by 2002:a17:902:ce8a:b0:19a:df76:ddd2 with SMTP id f10-20020a170902ce8a00b0019adf76ddd2mr13468886plg.36.1677798655322;
        Thu, 02 Mar 2023 15:10:55 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:f233:886c:8482:e0ce])
        by smtp.gmail.com with ESMTPSA id ky6-20020a170902f98600b0019cbec6c17bsm186675plb.190.2023.03.02.15.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 15:10:54 -0800 (PST)
Date:   Thu, 2 Mar 2023 16:10:52 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tanmay Shah <tanmay.shah@amd.com>
Cc:     michal.simek@amd.com, andersson@kernel.org,
        jaswinder.singh@linaro.org, ben.levinsky@amd.com,
        shubhrajyoti.datta@amd.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v4 5/5] remoteproc: xilinx: add mailbox channels for rpmsg
Message-ID: <20230302231052.GB1401708@p14s>
References: <20230228210216.447373-1-tanmay.shah@amd.com>
 <20230228210216.447373-6-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230228210216.447373-6-tanmay.shah@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 28, 2023 at 01:02:16PM -0800, Tanmay Shah wrote:
> This patch makes each r5 core mailbox client and uses
> tx and rx channels to send and receive data to/from
> remote processor respectively. This is needed for rpmsg
> communication to remote processor.
> 
> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> ---
> 
> Changes in v4:
>   - move zynqmp_r5_setup_mbox from zynqmp_r5_add_rproc_core to
>     zynqmp_r5_cluster_init
> 
> Changes in v3:
>   - fix multi-line comment format
>   - do not mixup mailbox information with memory-regions
>   - fix redundant dev_warn for split mode
>   - setting up mailboxes should return an error code
>   - redesign driver to move mailbox setup during driver probe
>   - add .kick function only if mailbox setup is success
> 
> v2: https://lore.kernel.org/all/20230126213154.1707300-1-tanmay.shah@amd.com/
> 
>  drivers/remoteproc/xlnx_r5_remoteproc.c | 227 +++++++++++++++++++++++-
>  1 file changed, 225 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
> index 5dd007622603..78c1638ccef0 100644
> --- a/drivers/remoteproc/xlnx_r5_remoteproc.c
> +++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
> @@ -8,16 +8,23 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/firmware/xlnx-zynqmp.h>
>  #include <linux/kernel.h>
> +#include <linux/mailbox_client.h>
> +#include <linux/mailbox/zynqmp-ipi-message.h>
>  #include <linux/module.h>
>  #include <linux/of_address.h>
>  #include <linux/of_platform.h>
>  #include <linux/of_reserved_mem.h>
>  #include <linux/platform_device.h>
>  #include <linux/remoteproc.h>
> -#include <linux/slab.h>
>  
>  #include "remoteproc_internal.h"
>  
> +/* IPI buffer MAX length */
> +#define IPI_BUF_LEN_MAX	32U
> +
> +/* RX mailbox client buffer max length */
> +#define MBOX_CLIENT_BUF_MAX	(IPI_BUF_LEN_MAX + \
> +				 sizeof(struct zynqmp_ipi_message))
>  /*
>   * settings for RPU cluster mode which
>   * reflects possible values of xlnx,cluster-mode dt-property
> @@ -43,6 +50,27 @@ struct mem_bank_data {
>  	char *bank_name;
>  };
>  
> +/**
> + * struct mbox_info
> + *
> + * @rx_mc_buf: to copy data from mailbox rx channel
> + * @tx_mc_buf: to copy data to mailbox tx channel
> + * @r5_core: this mailbox's corresponding r5_core pointer
> + * @mbox_work: schedule work after receiving data from mailbox
> + * @mbox_cl: mailbox client
> + * @tx_chan: mailbox tx channel
> + * @rx_chan: mailbox rx channel
> + */
> +struct mbox_info {
> +	unsigned char rx_mc_buf[MBOX_CLIENT_BUF_MAX];
> +	unsigned char tx_mc_buf[MBOX_CLIENT_BUF_MAX];
> +	struct zynqmp_r5_core *r5_core;
> +	struct work_struct mbox_work;
> +	struct mbox_client mbox_cl;
> +	struct mbox_chan *tx_chan;
> +	struct mbox_chan *rx_chan;
> +};
> +
>  /*
>   * Hardcoded TCM bank values. This will be removed once TCM bindings are
>   * accepted for system-dt specifications and upstreamed in linux kernel
> @@ -63,6 +91,7 @@ static const struct mem_bank_data zynqmp_tcm_banks[] = {
>   * @tcm_banks: array of each TCM bank data
>   * @rproc: rproc handle
>   * @pm_domain_id: RPU CPU power domain id
> + * @ipi: pointer to mailbox information
>   */
>  struct zynqmp_r5_core {
>  	struct device *dev;
> @@ -71,6 +100,7 @@ struct zynqmp_r5_core {
>  	struct mem_bank_data **tcm_banks;
>  	struct rproc *rproc;
>  	u32 pm_domain_id;
> +	struct mbox_info *ipi;
>  };
>  
>  /**
> @@ -88,6 +118,178 @@ struct zynqmp_r5_cluster {
>  	struct zynqmp_r5_core **r5_cores;
>  };
>  
> +/**
> + * event_notified_idr_cb() - callback for vq_interrupt per notifyid
> + * @id: rproc->notify id
> + * @ptr: pointer to idr private data
> + * @data: data passed to idr_for_each callback
> + *
> + * Pass notification to remoteproc virtio
> + *
> + * Return: 0. having return is to satisfy the idr_for_each() function
> + *          pointer input argument requirement.
> + **/
> +static int event_notified_idr_cb(int id, void *ptr, void *data)
> +{
> +	struct rproc *rproc = data;
> +
> +	if (rproc_vq_interrupt(rproc, id) == IRQ_NONE)
> +		dev_dbg(&rproc->dev, "data not found for vqid=%d\n", id);
> +
> +	return 0;
> +}
> +
> +/**
> + * handle_event_notified() - remoteproc notification work function
> + * @work: pointer to the work structure
> + *
> + * It checks each registered remoteproc notify IDs.
> + */
> +static void handle_event_notified(struct work_struct *work)
> +{
> +	struct mbox_info *ipi;
> +	struct rproc *rproc;
> +
> +	ipi = container_of(work, struct mbox_info, mbox_work);
> +	rproc = ipi->r5_core->rproc;
> +
> +	/*
> +	 * We only use IPI for interrupt. The RPU firmware side may or may
> +	 * not write the notifyid when it trigger IPI.
> +	 * And thus, we scan through all the registered notifyids and
> +	 * find which one is valid to get the message.
> +	 * Even if message from firmware is NULL, we attempt to get vqid
> +	 */
> +	idr_for_each(&rproc->notifyids, event_notified_idr_cb, rproc);
> +}
> +
> +/**
> + * zynqmp_r5_mb_rx_cb() - receive channel mailbox callback
> + * @cl: mailbox client
> + * @msg: message pointer
> + *
> + * Receive data from ipi buffer, ack interrupt and then
> + * it will schedule the R5 notification work.
> + */
> +static void zynqmp_r5_mb_rx_cb(struct mbox_client *cl, void *msg)
> +{
> +	struct zynqmp_ipi_message *ipi_msg, *buf_msg;
> +	struct mbox_info *ipi;
> +	size_t len;
> +
> +	ipi = container_of(cl, struct mbox_info, mbox_cl);
> +
> +	/* copy data from ipi buffer to r5_core */
> +	ipi_msg = (struct zynqmp_ipi_message *)msg;
> +	buf_msg = (struct zynqmp_ipi_message *)ipi->rx_mc_buf;
> +	len = ipi_msg->len;
> +	if (len > IPI_BUF_LEN_MAX) {
> +		dev_warn(cl->dev, "msg size exceeded than %d\n",
> +			 IPI_BUF_LEN_MAX);
> +		len = IPI_BUF_LEN_MAX;
> +	}
> +	buf_msg->len = len;
> +	memcpy(buf_msg->data, ipi_msg->data, len);
> +
> +	/* received and processed interrupt ack */
> +	if (mbox_send_message(ipi->rx_chan, NULL) < 0)
> +		dev_err(cl->dev, "ack failed to mbox rx_chan\n");
> +
> +	schedule_work(&ipi->mbox_work);
> +}
> +
> +/**
> + * zynqmp_r5_setup_mbox() - Setup mailboxes related properties
> + *			    this is used for each individual R5 core
> + *
> + * @cdev: child node device
> + *
> + * Function to setup mailboxes related properties
> + * return : NULL if failed else pointer to mbox_info
> + */
> +static struct mbox_info *zynqmp_r5_setup_mbox(struct device *cdev)
> +{
> +	struct mbox_client *mbox_cl;
> +	struct mbox_info *ipi;
> +
> +	ipi = kzalloc(sizeof(*ipi), GFP_KERNEL);
> +	if (!ipi)
> +		return NULL;
> +
> +	mbox_cl = &ipi->mbox_cl;
> +	mbox_cl->rx_callback = zynqmp_r5_mb_rx_cb;
> +	mbox_cl->tx_block = false;
> +	mbox_cl->knows_txdone = false;
> +	mbox_cl->tx_done = NULL;
> +	mbox_cl->dev = cdev;
> +
> +	/* Request TX and RX channels */
> +	ipi->tx_chan = mbox_request_channel_byname(mbox_cl, "tx");
> +	if (IS_ERR(ipi->tx_chan)) {
> +		ipi->tx_chan = NULL;
> +		kfree(ipi);
> +		dev_warn(cdev, "mbox tx channel request failed\n");
> +		return NULL;
> +	}
> +
> +	ipi->rx_chan = mbox_request_channel_byname(mbox_cl, "rx");
> +	if (IS_ERR(ipi->rx_chan)) {
> +		mbox_free_channel(ipi->tx_chan);
> +		ipi->rx_chan = NULL;
> +		ipi->tx_chan = NULL;
> +		kfree(ipi);
> +		dev_warn(cdev, "mbox rx channel request failed\n");
> +		return NULL;
> +	}
> +
> +	INIT_WORK(&ipi->mbox_work, handle_event_notified);
> +
> +	return ipi;
> +}
> +
> +static void zynqmp_r5_free_mbox(struct mbox_info *ipi)
> +{
> +	if (!ipi)
> +		return;
> +
> +	if (ipi->tx_chan) {
> +		mbox_free_channel(ipi->tx_chan);
> +		ipi->tx_chan = NULL;
> +	}
> +
> +	if (ipi->rx_chan) {
> +		mbox_free_channel(ipi->rx_chan);
> +		ipi->rx_chan = NULL;
> +	}
> +
> +	kfree(ipi);
> +}
> +
> +/*
> + * zynqmp_r5_core_kick() - kick a firmware if mbox is provided
> + * @rproc: r5 core's corresponding rproc structure
> + * @vqid: virtqueue ID
> + */
> +static void zynqmp_r5_rproc_kick(struct rproc *rproc, int vqid)
> +{
> +	struct zynqmp_r5_core *r5_core = rproc->priv;
> +	struct device *dev = r5_core->dev;
> +	struct zynqmp_ipi_message *mb_msg;
> +	struct mbox_info *ipi;
> +	int ret;
> +
> +	ipi = r5_core->ipi;
> +	if (!ipi)
> +		return;
> +
> +	mb_msg = (struct zynqmp_ipi_message *)ipi->tx_mc_buf;
> +	memcpy(mb_msg->data, &vqid, sizeof(vqid));
> +	mb_msg->len = sizeof(vqid);
> +	ret = mbox_send_message(ipi->tx_chan, mb_msg);
> +	if (ret < 0)
> +		dev_warn(dev, "failed to send message\n");
> +}
> +
>  /*
>   * zynqmp_r5_set_mode()
>   *
> @@ -614,7 +816,7 @@ static int zynqmp_r5_rproc_unprepare(struct rproc *rproc)
>  	return 0;
>  }
>  
> -static const struct rproc_ops zynqmp_r5_rproc_ops = {
> +static struct rproc_ops zynqmp_r5_rproc_ops = {
>  	.prepare	= zynqmp_r5_rproc_prepare,
>  	.unprepare	= zynqmp_r5_rproc_unprepare,
>  	.start		= zynqmp_r5_rproc_start,
> @@ -673,6 +875,7 @@ static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
>  	}
>  
>  	r5_core->rproc = r5_rproc;
> +

Spurious change.

>  	return r5_core;
>  
>  free_rproc:
> @@ -799,6 +1002,7 @@ static int zynqmp_r5_cluster_init(struct zynqmp_r5_cluster *cluster)
>  	struct device_node *child;
>  	enum rpu_tcm_comb tcm_mode;
>  	int core_count, ret, i;
> +	struct mbox_info *ipi;
>  
>  	ret = of_property_read_u32(dev_node, "xlnx,cluster-mode", &cluster_mode);
>  
> @@ -869,6 +1073,18 @@ static int zynqmp_r5_cluster_init(struct zynqmp_r5_cluster *cluster)
>  
>  		child_devs[i] = &child_pdev->dev;
>  
> +		/*
> +		 * If mailbox nodes are disabled using "status" property then
> +		 * setting up mailbox channels will be failed. In that case we
> +		 * don't really need kick() operation. Include .kick() only if
> +		 * mbox channels are acquired successfully.
> +		 */
> +		ipi = zynqmp_r5_setup_mbox(&child_pdev->dev);
> +		if (ipi)
> +			zynqmp_r5_rproc_ops.kick = zynqmp_r5_rproc_kick;
> +		else
> +			zynqmp_r5_rproc_ops.kick = NULL;
> +

Based on the way this patchset has turned out, I don't think it is required to
do this anymore.  After all, .kick() won't be called if the mailboxes aren't
initialized.

Please move the call to zynqmp_r5_setup_mbox() just below in the next hunk.

Thanks,
Mathieu

>  		/* create and add remoteproc instance of type struct rproc */
>  		r5_cores[i] = zynqmp_r5_add_rproc_core(&child_pdev->dev);
>  		if (IS_ERR(r5_cores[i])) {
> @@ -878,6 +1094,11 @@ static int zynqmp_r5_cluster_init(struct zynqmp_r5_cluster *cluster)
>  			goto release_r5_cores;
>  		}
>  
> +		if (ipi) {
> +			r5_cores[i]->ipi = ipi;
> +			ipi->r5_core = r5_cores[i];
> +		}
> +
>  		/*
>  		 * If two child nodes are available in dts in lockstep mode,
>  		 * then ignore second child node.
> @@ -915,6 +1136,7 @@ static int zynqmp_r5_cluster_init(struct zynqmp_r5_cluster *cluster)
>  	while (i >= 0) {
>  		put_device(child_devs[i]);
>  		if (r5_cores[i]) {
> +			zynqmp_r5_free_mbox(r5_cores[i]->ipi);
>  			of_reserved_mem_device_release(r5_cores[i]->dev);
>  			rproc_del(r5_cores[i]->rproc);
>  			rproc_free(r5_cores[i]->rproc);
> @@ -939,6 +1161,7 @@ static void zynqmp_r5_cluster_exit(void *data)
>  
>  	for (i = 0; i < cluster->core_count; i++) {
>  		r5_core = cluster->r5_cores[i];
> +		zynqmp_r5_free_mbox(r5_core->ipi);
>  		of_reserved_mem_device_release(r5_core->dev);
>  		put_device(r5_core->dev);
>  		rproc_del(r5_core->rproc);
> -- 
> 2.25.1
> 
