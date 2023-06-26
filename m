Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F11C73DB3A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 11:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjFZJVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 05:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjFZJUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 05:20:52 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B7919F;
        Mon, 26 Jun 2023 02:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687771118; x=1719307118;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K9kEmxtQVecdL2apry1t1vkOJkQ2rr9zsviDcNY121c=;
  b=fffX4gxED4Mu1p3qR5PyImG0dDJHzpPBVISLvL17i+ZjoqsY9rVCtrc4
   NqX/ApiNooRshC4NtXwZ7jDuYIyZbUBcr+jOmlxZ2yPWe5zzI17PJK4rT
   qQ9+QWgZ5bCDM6Yc1nUR9MzpHbYD+YQxZ298KWgtp3Fuwwe42PzziAAHM
   PgwrPVQHSaCg2AFL5j+0VkDIzTZF9DasbpuBK8JCmbuT8vV2PdW5AB3Bn
   Z9OYlCiToF2CHz/iVgPAlNCiVfdHvVXlw3CrsE2gW4RKbf/rwopHU09SB
   BOAzcJVoT1o0/plLbSYwwG/PnfLtvCUqUHl22gRGsfY6Xy3NUOlnbEg5K
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="447605177"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="447605177"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 02:18:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="860618456"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="860618456"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 26 Jun 2023 02:18:33 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 26 Jun 2023 12:18:32 +0300
Date:   Mon, 26 Jun 2023 12:18:32 +0300
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
Subject: Re: [PATCH v3 2/8] soc: qcom: pmic_glink_altmode: handle safe mode
 when disconnect
Message-ID: <ZJlX6CsCI1EJXLKF@kuha.fi.intel.com>
References: <20230601-topic-sm8550-upstream-type-c-v3-0-22c9973012b6@linaro.org>
 <20230601-topic-sm8550-upstream-type-c-v3-2-22c9973012b6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601-topic-sm8550-upstream-type-c-v3-2-22c9973012b6@linaro.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 09:55:55AM +0200, Neil Armstrong wrote:
> On some Qcom SoCs, the Altmode event mode is set to 0xff when
> the Type-C port is disconnected.
> 
> Handle this specific mode and translate it as the SAFE mode.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

FWIW:

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/soc/qcom/pmic_glink_altmode.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmic_glink_altmode.c
> index df48fbea4b68..007d308e2f15 100644
> --- a/drivers/soc/qcom/pmic_glink_altmode.c
> +++ b/drivers/soc/qcom/pmic_glink_altmode.c
> @@ -173,6 +173,20 @@ static void pmic_glink_altmode_enable_usb(struct pmic_glink_altmode *altmode,
>  		dev_err(altmode->dev, "failed to switch mux to USB\n");
>  }
>  
> +static void pmic_glink_altmode_safe(struct pmic_glink_altmode *altmode,
> +				    struct pmic_glink_altmode_port *port)
> +{
> +	int ret;
> +
> +	port->state.alt = NULL;
> +	port->state.data = NULL;
> +	port->state.mode = TYPEC_STATE_SAFE;
> +
> +	ret = typec_mux_set(port->typec_mux, &port->state);
> +	if (ret)
> +		dev_err(altmode->dev, "failed to switch mux to safe mode\n");
> +}
> +
>  static void pmic_glink_altmode_worker(struct work_struct *work)
>  {
>  	struct pmic_glink_altmode_port *alt_port = work_to_altmode_port(work);
> @@ -180,7 +194,9 @@ static void pmic_glink_altmode_worker(struct work_struct *work)
>  
>  	typec_switch_set(alt_port->typec_switch, alt_port->orientation);
>  
> -	if (alt_port->svid == USB_TYPEC_DP_SID)
> +	if (alt_port->svid == USB_TYPEC_DP_SID && alt_port->mode == 0xff)
> +		pmic_glink_altmode_safe(altmode, alt_port);
> +	else if (alt_port->svid == USB_TYPEC_DP_SID)
>  		pmic_glink_altmode_enable_dp(altmode, alt_port, alt_port->mode,
>  					     alt_port->hpd_state, alt_port->hpd_irq);
>  	else
> 
> -- 
> 2.34.1

-- 
heikki
