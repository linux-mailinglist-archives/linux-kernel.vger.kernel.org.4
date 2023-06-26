Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A06073DB42
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 11:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjFZJWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 05:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjFZJVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 05:21:49 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DE22951;
        Mon, 26 Jun 2023 02:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687771190; x=1719307190;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4iirlHjDQFEOmwfWu25Zqlp+FjDKn3qrPL7a4DX2oxs=;
  b=A+M/UZFQUjCFGzotGIOlX78dhQTyVY+i+g9bUJod9QSCk/SXAT349Eb/
   BxPiBp7u64yhfgINjY9T+ZdmeKTB4BRd/SB+GCmdqJZa4zS4oj5AFrxGs
   WA1IFVhpfD+wkUcKZACJ5nNq7s798pJgK34APhCgnEsA1XTZNrFyu/SkT
   OxIytmIvMql3Bb/ztYetu+t1QvKM9pryDGygQKAsTkp7VsCm9Y6xkiAAK
   2uCAKhQ8QBzUcKqLl82YL8sJZ4zaH7euvc0W7XbgkwJBl/8B+TlDRnriu
   eJOMYYQFUsOd54K/PZi05qItPEPVtUHX9frtuyoYDKP8dorls1u7RQzxR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="447605392"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="447605392"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 02:19:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="860618521"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="860618521"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 26 Jun 2023 02:19:31 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 26 Jun 2023 12:19:31 +0300
Date:   Mon, 26 Jun 2023 12:19:31 +0300
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
Subject: Re: [PATCH v3 4/8] qcom: pmic_glink_altmode: add retimer-switch
 support
Message-ID: <ZJlYI+Ked1gA8NOh@kuha.fi.intel.com>
References: <20230601-topic-sm8550-upstream-type-c-v3-0-22c9973012b6@linaro.org>
 <20230601-topic-sm8550-upstream-type-c-v3-4-22c9973012b6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601-topic-sm8550-upstream-type-c-v3-4-22c9973012b6@linaro.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 09:55:57AM +0200, Neil Armstrong wrote:
> Some boards have a retimer/redriver between the SuperSpeed
> PHY and the USB-C connector to compensates signal integrity
> losses mainly due to PCB & transmission cables.
> 
> Add support for an optional retimer-switch in the USB-C
> connector graph.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/soc/qcom/pmic_glink_altmode.c | 43 +++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmic_glink_altmode.c
> index 007d308e2f15..41d732f5b647 100644
> --- a/drivers/soc/qcom/pmic_glink_altmode.c
> +++ b/drivers/soc/qcom/pmic_glink_altmode.c
> @@ -15,6 +15,7 @@
>  #include <linux/usb/typec_altmode.h>
>  #include <linux/usb/typec_dp.h>
>  #include <linux/usb/typec_mux.h>
> +#include <linux/usb/typec_retimer.h>
>  
>  #include <linux/soc/qcom/pmic_glink.h>
>  
> @@ -68,6 +69,8 @@ struct pmic_glink_altmode_port {
>  	struct typec_switch *typec_switch;
>  	struct typec_mux *typec_mux;
>  	struct typec_mux_state state;
> +	struct typec_retimer *typec_retimer;
> +	struct typec_retimer_state retimer_state;
>  	struct typec_altmode dp_alt;
>  
>  	struct work_struct work;
> @@ -157,6 +160,14 @@ static void pmic_glink_altmode_enable_dp(struct pmic_glink_altmode *altmode,
>  	ret = typec_mux_set(port->typec_mux, &port->state);
>  	if (ret)
>  		dev_err(altmode->dev, "failed to switch mux to DP\n");
> +
> +	port->retimer_state.alt = &port->dp_alt;
> +	port->retimer_state.data = &dp_data;
> +	port->retimer_state.mode = TYPEC_MODAL_STATE(mode);
> +
> +	ret = typec_retimer_set(port->typec_retimer, &port->retimer_state);
> +	if (ret)
> +		dev_err(altmode->dev, "failed to setup retimer to DP\n");
>  }
>  
>  static void pmic_glink_altmode_enable_usb(struct pmic_glink_altmode *altmode,
> @@ -171,6 +182,14 @@ static void pmic_glink_altmode_enable_usb(struct pmic_glink_altmode *altmode,
>  	ret = typec_mux_set(port->typec_mux, &port->state);
>  	if (ret)
>  		dev_err(altmode->dev, "failed to switch mux to USB\n");
> +
> +	port->retimer_state.alt = NULL;
> +	port->retimer_state.data = NULL;
> +	port->retimer_state.mode = TYPEC_STATE_USB;
> +
> +	ret = typec_retimer_set(port->typec_retimer, &port->retimer_state);
> +	if (ret)
> +		dev_err(altmode->dev, "failed to setup retimer to USB\n");
>  }
>  
>  static void pmic_glink_altmode_safe(struct pmic_glink_altmode *altmode,
> @@ -185,6 +204,14 @@ static void pmic_glink_altmode_safe(struct pmic_glink_altmode *altmode,
>  	ret = typec_mux_set(port->typec_mux, &port->state);
>  	if (ret)
>  		dev_err(altmode->dev, "failed to switch mux to safe mode\n");
> +
> +	port->retimer_state.alt = NULL;
> +	port->retimer_state.data = NULL;
> +	port->retimer_state.mode = TYPEC_STATE_SAFE;
> +
> +	ret = typec_retimer_set(port->typec_retimer, &port->retimer_state);
> +	if (ret)
> +		dev_err(altmode->dev, "failed to setup retimer to USB\n");
>  }
>  
>  static void pmic_glink_altmode_worker(struct work_struct *work)
> @@ -347,6 +374,11 @@ static const struct drm_bridge_funcs pmic_glink_altmode_bridge_funcs = {
>  	.attach = pmic_glink_altmode_attach,
>  };
>  
> +static void pmic_glink_altmode_put_retimer(void *data)
> +{
> +	typec_retimer_put(data);
> +}
> +
>  static void pmic_glink_altmode_put_mux(void *data)
>  {
>  	typec_mux_put(data);
> @@ -453,6 +485,17 @@ static int pmic_glink_altmode_probe(struct auxiliary_device *adev,
>  		if (ret)
>  			return ret;
>  
> +		alt_port->typec_retimer = fwnode_typec_retimer_get(fwnode);
> +		if (IS_ERR(alt_port->typec_retimer))
> +			return dev_err_probe(dev, PTR_ERR(alt_port->typec_retimer),
> +					     "failed to acquire retimer-switch for port: %d\n",
> +					     port);
> +
> +		ret = devm_add_action_or_reset(dev, pmic_glink_altmode_put_retimer,
> +					       alt_port->typec_retimer);
> +		if (ret)
> +			return ret;
> +
>  		alt_port->typec_switch = fwnode_typec_switch_get(fwnode);
>  		if (IS_ERR(alt_port->typec_switch))
>  			return dev_err_probe(dev, PTR_ERR(alt_port->typec_switch),
> 
> -- 
> 2.34.1

-- 
heikki
