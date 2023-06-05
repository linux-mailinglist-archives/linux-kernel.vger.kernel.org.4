Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3C47223C5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 12:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjFEKqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 06:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbjFEKqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 06:46:00 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EF0EA;
        Mon,  5 Jun 2023 03:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685961959; x=1717497959;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p5URlSMRlx8Wq02hvARuSDlMSFf/lU44gWl/ckAOxo8=;
  b=UX4tWJ8x0MblyLcx+Jd5tfqW+gAaeghFljVTxAKg2086tvLSf2+XkK2I
   SyIoN7wjshEIOD8P+qCLu8g4N8oMGEOSh9Utdf4Ku+AN6cPsRvcsGEJPU
   bAuMx5/6eO642/c29lg2yePjfPZgnqhXWlAXfEaWJ8M1oPyJXiVGp6lpn
   6mmePpHWUqgKip8Qk52bY2xfC4YcpCsrwHJDpvtcc0Vlgzum+OwxglHU4
   GIvWjYaUzFCxZOGOVn1U6tka8bGFVRS0QudO2+1tQioN4K6vXb/XN33mV
   dYkoy0FAJ9S0z7tpujlPz//cmJoy8zJNDpzfEAXp2fFE2j36IcWdDrFU9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="335954387"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="335954387"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 03:45:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="852929198"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="852929198"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 05 Jun 2023 03:45:51 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 05 Jun 2023 13:45:50 +0300
Date:   Mon, 5 Jun 2023 13:45:50 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH RFC 3/7] usb: ucsi: glink: use the connector orientation
 GPIO to provide switch events
Message-ID: <ZH283tlyRffPMXGm@kuha.fi.intel.com>
References: <20230601-topic-sm8550-upstream-type-c-v1-0-d4d97b4d8bab@linaro.org>
 <20230601-topic-sm8550-upstream-type-c-v1-3-d4d97b4d8bab@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601-topic-sm8550-upstream-type-c-v1-3-d4d97b4d8bab@linaro.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 04:07:03PM +0200, Neil Armstrong wrote:
> On SM8550, the non-altmode orientation is not given anymore within
> altmode events, even with USB SVIDs events.
> 
> On the other side, the Type-C connector orientation is correctly
> reported by a signal from the PMIC.
> 
> Take this gpio signal when we detect some Type-C port activity
> to notify any Type-C switches tied to the Type-C port connectors.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi_glink.c | 52 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 51 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
> index 1fe9cb5b6bd9..88491dbff7e3 100644
> --- a/drivers/usb/typec/ucsi/ucsi_glink.c
> +++ b/drivers/usb/typec/ucsi/ucsi_glink.c
> @@ -9,9 +9,13 @@
>  #include <linux/mutex.h>
>  #include <linux/property.h>
>  #include <linux/soc/qcom/pdr.h>
> +#include <linux/usb/typec_mux.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/soc/qcom/pmic_glink.h>
>  #include "ucsi.h"
>  
> +#define PMIC_GLINK_MAX_PORTS	2
> +
>  #define UCSI_BUF_SIZE                   48
>  
>  #define MSG_TYPE_REQ_RESP               1
> @@ -53,6 +57,9 @@ struct ucsi_notify_ind_msg {
>  struct pmic_glink_ucsi {
>  	struct device *dev;
>  
> +	struct gpio_desc *port_orientation[PMIC_GLINK_MAX_PORTS];
> +	struct typec_switch *port_switch[PMIC_GLINK_MAX_PORTS];
> +
>  	struct pmic_glink_client *client;
>  
>  	struct ucsi *ucsi;
> @@ -221,8 +228,20 @@ static void pmic_glink_ucsi_notify(struct work_struct *work)
>  	}
>  
>  	con_num = UCSI_CCI_CONNECTOR(cci);
> -	if (con_num)
> +	if (con_num) {
> +		if (con_num < PMIC_GLINK_MAX_PORTS &&
> +		    ucsi->port_orientation[con_num - 1]) {
> +			int orientation = gpiod_get_value(ucsi->port_orientation[con_num - 1]);
> +
> +			if (orientation >= 0) {
> +				typec_switch_set(ucsi->port_switch[con_num - 1],
> +						 orientation ? TYPEC_ORIENTATION_REVERSE
> +							     : TYPEC_ORIENTATION_NORMAL);
> +			}
> +		}
> +
>  		ucsi_connector_change(ucsi->ucsi, con_num);
> +	}
>  
>  	if (ucsi->sync_pending && cci & UCSI_CCI_BUSY) {
>  		ucsi->sync_val = -EBUSY;
> @@ -283,6 +302,7 @@ static int pmic_glink_ucsi_probe(struct auxiliary_device *adev,
>  {
>  	struct pmic_glink_ucsi *ucsi;
>  	struct device *dev = &adev->dev;
> +	struct fwnode_handle *fwnode;
>  	int ret;
>  
>  	ucsi = devm_kzalloc(dev, sizeof(*ucsi), GFP_KERNEL);
> @@ -310,6 +330,36 @@ static int pmic_glink_ucsi_probe(struct auxiliary_device *adev,
>  
>  	ucsi_set_drvdata(ucsi->ucsi, ucsi);
>  
> +	device_for_each_child_node(dev, fwnode) {
> +		u32 port;
> +
> +		ret = fwnode_property_read_u32(fwnode, "reg", &port);
> +		if (ret < 0) {
> +			dev_err(dev, "missing reg property of %pOFn\n", fwnode);
> +			return ret;
> +		}
> +
> +		if (port >= PMIC_GLINK_MAX_PORTS) {
> +			dev_warn(dev, "invalid connector number, ignoring\n");
> +			continue;
> +		}
> +
> +		ucsi->port_orientation[port] = devm_fwnode_gpiod_get(&adev->dev, fwnode,
> +								     "orientation",
> +								     GPIOD_IN, NULL);
> +		if (IS_ERR(ucsi->port_orientation[port]))
> +			return dev_err_probe(dev, PTR_ERR(ucsi->port_orientation[port]),
> +					     "unable to acquire orientation gpio\n");
> +
> +		if (!ucsi->port_orientation[port])
> +			continue;
> +
> +		ucsi->port_switch[port] = fwnode_typec_switch_get(fwnode);
> +		if (IS_ERR(ucsi->port_switch[port]))
> +			return dev_err_probe(dev, PTR_ERR(ucsi->port_switch[port]),
> +					"failed to acquire orientation-switch\n");
> +	}
> +
>  	ucsi->client = devm_pmic_glink_register_client(dev,
>  						       PMIC_GLINK_OWNER_USBC,
>  						       pmic_glink_ucsi_callback,
> 
> -- 
> 2.34.1

-- 
heikki
