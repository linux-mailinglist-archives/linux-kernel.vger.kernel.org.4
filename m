Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492706C114E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 12:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjCTL4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 07:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjCTL4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 07:56:32 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A6C24108;
        Mon, 20 Mar 2023 04:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679313390; x=1710849390;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r1s5/ZMg2lLOSle8HVr6eWPHl10IKSNJRBE1UwV5bX0=;
  b=FDm1uJvrHZad9clSGe2KXImZdlrkJVDWEB2puL5mqpRZ5sCuR0MXAO+b
   6RahidznhZT0N+LfmkAq6YYnhsuL0AOAGU3iU0Tpm9YBxtOTjgtLyB02C
   s/gzi+EtX1Zlgc4kFUM2kFrHfTRnCpCHPwqIbKGvCyEjP+SEiTCSissJ1
   /kWB0j3tS5goQoX57EYdtOYk4HUYRdWBUYUcLpvSqHJAV49QfBq+W1JLQ
   n723F2+WabhUMDPxu1ORYpvfbQ+E3Ivyg+Vfb6R7D/hUCNEccBsWPzqSl
   8Tx2yc0a11lA4IvMSQMha8HeHdS8bTU7dmVflHoqSC1PmNmOZSyyhNFvX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="403511333"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="403511333"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 04:56:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="824450449"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="824450449"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 20 Mar 2023 04:56:25 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 20 Mar 2023 13:56:24 +0200
Date:   Mon, 20 Mar 2023 13:56:24 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 01/12] usb: typec: ucsi: add PMIC Glink UCSI driver
Message-ID: <ZBhJ6P9lDcvwW3/x@kuha.fi.intel.com>
References: <20230130-topic-sm8450-upstream-pmic-glink-v4-0-38bf0f5d07bd@linaro.org>
 <20230130-topic-sm8450-upstream-pmic-glink-v4-1-38bf0f5d07bd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130-topic-sm8450-upstream-pmic-glink-v4-1-38bf0f5d07bd@linaro.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 04:04:17PM +0100, Neil Armstrong wrote:
> Introduce the UCSI PMIC Glink aux driver that communicates
> with the aDSP firmware with the UCSI protocol which handles
> the USB-C Port(s) Power Delivery.
> 
> The UCSI messaging is necessary on newer Qualcomm SoCs to
> provide USB role switch and altmode notifications.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/Kconfig      |  10 ++
>  drivers/usb/typec/ucsi/Makefile     |   1 +
>  drivers/usb/typec/ucsi/ucsi_glink.c | 345 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 356 insertions(+)
> 
> diff --git a/drivers/usb/typec/ucsi/Kconfig b/drivers/usb/typec/ucsi/Kconfig
> index 8f9c4b9f31f7..b3bb0191987e 100644
> --- a/drivers/usb/typec/ucsi/Kconfig
> +++ b/drivers/usb/typec/ucsi/Kconfig
> @@ -58,4 +58,14 @@ config UCSI_STM32G0
>  	  To compile the driver as a module, choose M here: the module will be
>  	  called ucsi_stm32g0.
>  
> +config UCSI_PMIC_GLINK
> +	tristate "UCSI Qualcomm PMIC GLINK Interface Driver"
> +	depends on QCOM_PMIC_GLINK
> +	help
> +	  This driver enables UCSI support on platforms that expose UCSI
> +	  interface as PMIC GLINK device.
> +
> +	  To compile the driver as a module, choose M here: the module will be
> +	  called ucsi_glink.
> +
>  endif
> diff --git a/drivers/usb/typec/ucsi/Makefile b/drivers/usb/typec/ucsi/Makefile
> index 480d533d762f..77f09e136956 100644
> --- a/drivers/usb/typec/ucsi/Makefile
> +++ b/drivers/usb/typec/ucsi/Makefile
> @@ -18,3 +18,4 @@ endif
>  obj-$(CONFIG_UCSI_ACPI)			+= ucsi_acpi.o
>  obj-$(CONFIG_UCSI_CCG)			+= ucsi_ccg.o
>  obj-$(CONFIG_UCSI_STM32G0)		+= ucsi_stm32g0.o
> +obj-$(CONFIG_UCSI_PMIC_GLINK)		+= ucsi_glink.o
> diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
> new file mode 100644
> index 000000000000..b454a5159896
> --- /dev/null
> +++ b/drivers/usb/typec/ucsi/ucsi_glink.c
> @@ -0,0 +1,345 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2019-2020, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2023, Linaro Ltd
> + */
> +#include <linux/auxiliary_bus.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/mutex.h>
> +#include <linux/property.h>
> +#include <linux/soc/qcom/pdr.h>
> +#include <linux/soc/qcom/pmic_glink.h>
> +#include "ucsi.h"
> +
> +#define UCSI_BUF_SIZE                   48
> +
> +#define MSG_TYPE_REQ_RESP               1
> +#define UCSI_BUF_SIZE                   48
> +
> +#define UC_NOTIFY_RECEIVER_UCSI         0x0
> +#define UC_UCSI_READ_BUF_REQ            0x11
> +#define UC_UCSI_WRITE_BUF_REQ           0x12
> +#define UC_UCSI_USBC_NOTIFY_IND         0x13
> +
> +struct ucsi_read_buf_req_msg {
> +	struct pmic_glink_hdr   hdr;
> +};
> +
> +struct ucsi_read_buf_resp_msg {
> +	struct pmic_glink_hdr   hdr;
> +	u8                      buf[UCSI_BUF_SIZE];
> +	u32                     ret_code;
> +};
> +
> +struct ucsi_write_buf_req_msg {
> +	struct pmic_glink_hdr   hdr;
> +	u8                      buf[UCSI_BUF_SIZE];
> +	u32                     reserved;
> +};
> +
> +struct ucsi_write_buf_resp_msg {
> +	struct pmic_glink_hdr   hdr;
> +	u32                     ret_code;
> +};
> +
> +struct ucsi_notify_ind_msg {
> +	struct pmic_glink_hdr   hdr;
> +	u32                     notification;
> +	u32                     receiver;
> +	u32                     reserved;
> +};
> +
> +struct pmic_glink_ucsi {
> +	struct device *dev;
> +
> +	struct pmic_glink_client *client;
> +
> +	struct ucsi *ucsi;
> +	struct completion read_ack;
> +	struct completion write_ack;
> +	struct completion sync_ack;
> +	bool sync_pending;
> +	struct mutex lock;	/* protects concurrent access to PMIC Glink interface */
> +
> +	int sync_val;
> +
> +	struct work_struct notify_work;
> +	struct work_struct register_work;
> +
> +	u8 read_buf[UCSI_BUF_SIZE];
> +};
> +
> +static int pmic_glink_ucsi_read(struct ucsi *__ucsi, unsigned int offset,
> +				void *val, size_t val_len)
> +{
> +	struct pmic_glink_ucsi *ucsi = ucsi_get_drvdata(__ucsi);
> +	struct ucsi_read_buf_req_msg req = {};
> +	unsigned long left;
> +	int ret;
> +
> +	req.hdr.owner = PMIC_GLINK_OWNER_USBC;
> +	req.hdr.type = MSG_TYPE_REQ_RESP;
> +	req.hdr.opcode = UC_UCSI_READ_BUF_REQ;
> +
> +	mutex_lock(&ucsi->lock);
> +	memset(ucsi->read_buf, 0, sizeof(ucsi->read_buf));
> +	reinit_completion(&ucsi->read_ack);
> +
> +	ret = pmic_glink_send(ucsi->client, &req, sizeof(req));
> +	if (ret < 0) {
> +		dev_err(ucsi->dev, "failed to send UCSI read request: %d\n", ret);
> +		goto out_unlock;
> +	}
> +
> +	left = wait_for_completion_timeout(&ucsi->read_ack, 5 * HZ);
> +	if (!left) {
> +		dev_err(ucsi->dev, "timeout waiting for UCSI read response\n");
> +		ret = -ETIMEDOUT;
> +		goto out_unlock;
> +	}
> +
> +	memcpy(val, &ucsi->read_buf[offset], val_len);
> +	ret = 0;
> +
> +out_unlock:
> +	mutex_unlock(&ucsi->lock);
> +
> +	return ret;
> +}
> +
> +static int pmic_glink_ucsi_locked_write(struct pmic_glink_ucsi *ucsi, unsigned int offset,
> +					const void *val, size_t val_len)
> +{
> +	struct ucsi_write_buf_req_msg req = {};
> +	unsigned long left;
> +	int ret;
> +
> +	req.hdr.owner = PMIC_GLINK_OWNER_USBC;
> +	req.hdr.type = MSG_TYPE_REQ_RESP;
> +	req.hdr.opcode = UC_UCSI_WRITE_BUF_REQ;
> +	memcpy(&req.buf[offset], val, val_len);
> +
> +	reinit_completion(&ucsi->write_ack);
> +
> +	ret = pmic_glink_send(ucsi->client, &req, sizeof(req));
> +	if (ret < 0) {
> +		dev_err(ucsi->dev, "failed to send UCSI write request: %d\n", ret);
> +		return ret;
> +	}
> +
> +	left = wait_for_completion_timeout(&ucsi->write_ack, 5 * HZ);
> +	if (!left) {
> +		dev_err(ucsi->dev, "timeout waiting for UCSI write response\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}
> +
> +static int pmic_glink_ucsi_async_write(struct ucsi *__ucsi, unsigned int offset,
> +				       const void *val, size_t val_len)
> +{
> +	struct pmic_glink_ucsi *ucsi = ucsi_get_drvdata(__ucsi);
> +	int ret;
> +
> +	mutex_lock(&ucsi->lock);
> +	ret = pmic_glink_ucsi_locked_write(ucsi, offset, val, val_len);
> +	mutex_unlock(&ucsi->lock);
> +
> +	return ret;
> +}
> +
> +static int pmic_glink_ucsi_sync_write(struct ucsi *__ucsi, unsigned int offset,
> +				      const void *val, size_t val_len)
> +{
> +	struct pmic_glink_ucsi *ucsi = ucsi_get_drvdata(__ucsi);
> +	unsigned long left;
> +	int ret;
> +
> +	/* TOFIX: Downstream forces recipient to CON when UCSI_GET_ALTERNATE_MODES command */
> +
> +	mutex_lock(&ucsi->lock);
> +	ucsi->sync_val = 0;
> +	reinit_completion(&ucsi->sync_ack);
> +	ucsi->sync_pending = true;
> +	ret = pmic_glink_ucsi_locked_write(ucsi, offset, val, val_len);
> +	mutex_unlock(&ucsi->lock);
> +
> +	left = wait_for_completion_timeout(&ucsi->sync_ack, 5 * HZ);
> +	if (!left) {
> +		dev_err(ucsi->dev, "timeout waiting for UCSI sync write response\n");
> +		ret = -ETIMEDOUT;
> +	} else if (ucsi->sync_val) {
> +		dev_err(ucsi->dev, "sync write returned: %d\n", ucsi->sync_val);
> +	}
> +
> +	ucsi->sync_pending = false;
> +
> +	return ret;
> +}
> +
> +static const struct ucsi_operations pmic_glink_ucsi_ops = {
> +	.read = pmic_glink_ucsi_read,
> +	.sync_write = pmic_glink_ucsi_sync_write,
> +	.async_write = pmic_glink_ucsi_async_write
> +};
> +
> +static void pmic_glink_ucsi_read_ack(struct pmic_glink_ucsi *ucsi, const void *data, int len)
> +{
> +	const struct ucsi_read_buf_resp_msg *resp = data;
> +
> +	if (resp->ret_code)
> +		return;
> +
> +	memcpy(ucsi->read_buf, resp->buf, UCSI_BUF_SIZE);
> +	complete(&ucsi->read_ack);
> +}
> +
> +static void pmic_glink_ucsi_write_ack(struct pmic_glink_ucsi *ucsi, const void *data, int len)
> +{
> +	const struct ucsi_write_buf_resp_msg *resp = data;
> +
> +	if (resp->ret_code)
> +		return;
> +
> +	ucsi->sync_val = resp->ret_code;
> +	complete(&ucsi->write_ack);
> +}
> +
> +static void pmic_glink_ucsi_notify(struct work_struct *work)
> +{
> +	struct pmic_glink_ucsi *ucsi = container_of(work, struct pmic_glink_ucsi, notify_work);
> +	unsigned int con_num;
> +	u32 cci;
> +	int ret;
> +
> +	ret = pmic_glink_ucsi_read(ucsi->ucsi, UCSI_CCI, &cci, sizeof(cci));
> +	if (ret) {
> +		dev_err(ucsi->dev, "failed to read CCI on notification\n");
> +		return;
> +	}
> +
> +	con_num = UCSI_CCI_CONNECTOR(cci);
> +	if (con_num)
> +		ucsi_connector_change(ucsi->ucsi, con_num);
> +
> +	if (ucsi->sync_pending && cci & UCSI_CCI_BUSY) {
> +		ucsi->sync_val = -EBUSY;
> +		complete(&ucsi->sync_ack);
> +	} else if (ucsi->sync_pending &&
> +		   (cci & (UCSI_CCI_ACK_COMPLETE | UCSI_CCI_COMMAND_COMPLETE))) {
> +		complete(&ucsi->sync_ack);
> +	}
> +}
> +
> +static void pmic_glink_ucsi_register(struct work_struct *work)
> +{
> +	struct pmic_glink_ucsi *ucsi = container_of(work, struct pmic_glink_ucsi, register_work);
> +
> +	ucsi_register(ucsi->ucsi);
> +}
> +
> +static void pmic_glink_ucsi_callback(const void *data, size_t len, void *priv)
> +{
> +	struct pmic_glink_ucsi *ucsi = priv;
> +	const struct pmic_glink_hdr *hdr = data;
> +
> +	switch (hdr->opcode) {
> +	case UC_UCSI_READ_BUF_REQ:
> +		pmic_glink_ucsi_read_ack(ucsi, data, len);
> +		break;
> +	case UC_UCSI_WRITE_BUF_REQ:
> +		pmic_glink_ucsi_write_ack(ucsi, data, len);
> +		break;
> +	case UC_UCSI_USBC_NOTIFY_IND:
> +		schedule_work(&ucsi->notify_work);
> +		break;
> +	};
> +}
> +
> +static void pmic_glink_ucsi_pdr_notify(void *priv, int state)
> +{
> +	struct pmic_glink_ucsi *ucsi = priv;
> +
> +	if (state == SERVREG_SERVICE_STATE_UP)
> +		schedule_work(&ucsi->register_work);
> +	else if (state == SERVREG_SERVICE_STATE_DOWN)
> +		ucsi_unregister(ucsi->ucsi);
> +}
> +
> +static void pmic_glink_ucsi_destroy(void *data)
> +{
> +	struct pmic_glink_ucsi *ucsi = data;
> +
> +	/* Protect to make sure we're not in a middle of a transaction from a glink callback */
> +	mutex_lock(&ucsi->lock);
> +	ucsi_destroy(ucsi->ucsi);
> +	mutex_unlock(&ucsi->lock);
> +}
> +
> +static int pmic_glink_ucsi_probe(struct auxiliary_device *adev,
> +				 const struct auxiliary_device_id *id)
> +{
> +	struct pmic_glink_ucsi *ucsi;
> +	struct device *dev = &adev->dev;
> +	int ret;
> +
> +	ucsi = devm_kzalloc(dev, sizeof(*ucsi), GFP_KERNEL);
> +	if (!ucsi)
> +		return -ENOMEM;
> +
> +	ucsi->dev = dev;
> +	dev_set_drvdata(dev, ucsi);
> +
> +	INIT_WORK(&ucsi->notify_work, pmic_glink_ucsi_notify);
> +	INIT_WORK(&ucsi->register_work, pmic_glink_ucsi_register);
> +	init_completion(&ucsi->read_ack);
> +	init_completion(&ucsi->write_ack);
> +	init_completion(&ucsi->sync_ack);
> +	mutex_init(&ucsi->lock);
> +
> +	ucsi->ucsi = ucsi_create(dev, &pmic_glink_ucsi_ops);
> +	if (IS_ERR(ucsi->ucsi))
> +		return PTR_ERR(ucsi->ucsi);
> +
> +	/* Make sure we destroy *after* pmic_glink unregister */
> +	ret = devm_add_action_or_reset(dev, pmic_glink_ucsi_destroy, ucsi);
> +	if (ret)
> +		return ret;
> +
> +	ucsi_set_drvdata(ucsi->ucsi, ucsi);
> +
> +	ucsi->client = devm_pmic_glink_register_client(dev,
> +						       PMIC_GLINK_OWNER_USBC,
> +						       pmic_glink_ucsi_callback,
> +						       pmic_glink_ucsi_pdr_notify,
> +						       ucsi);
> +	return PTR_ERR_OR_ZERO(ucsi->client);
> +}
> +
> +static void pmic_glink_ucsi_remove(struct auxiliary_device *adev)
> +{
> +	struct pmic_glink_ucsi *ucsi = dev_get_drvdata(&adev->dev);
> +
> +	/* Unregister first to stop having read & writes */
> +	ucsi_unregister(ucsi->ucsi);
> +}
> +
> +static const struct auxiliary_device_id pmic_glink_ucsi_id_table[] = {
> +	{ .name = "pmic_glink.ucsi", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(auxiliary, pmic_glink_ucsi_id_table);
> +
> +static struct auxiliary_driver pmic_glink_ucsi_driver = {
> +	.name = "pmic_glink_ucsi",
> +	.probe = pmic_glink_ucsi_probe,
> +	.remove = pmic_glink_ucsi_remove,
> +	.id_table = pmic_glink_ucsi_id_table,
> +};
> +
> +module_auxiliary_driver(pmic_glink_ucsi_driver);
> +
> +MODULE_DESCRIPTION("Qualcomm PMIC GLINK UCSI driver");
> +MODULE_LICENSE("GPL");

thanks,

-- 
heikki
