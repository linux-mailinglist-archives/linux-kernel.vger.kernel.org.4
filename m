Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B44173FF3F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 17:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjF0PF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 11:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjF0PFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 11:05:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD94010C;
        Tue, 27 Jun 2023 08:05:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AB77611D0;
        Tue, 27 Jun 2023 15:05:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43D5C433C0;
        Tue, 27 Jun 2023 15:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687878321;
        bh=Igz0+zgGNJxPGQdFDxdiXQoZkx8c/w5HnwZQxadYHqo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sY5xqp8KFH5K2TytOrPvOSlVZUDMVlxctCX4GF6T64MVLMsOd5DqbrxsxdQaTRwnl
         jyHY1brJ5qHPBMiPykAtJ4pW+Pflt02M35IaTR5OhHa7F4lWVEVTthnb0L1A7BpBHJ
         +Za71JzLRBawLG65EUWaW6Fq501xbbsxSWTD9H4H+/APsrMA6TbC5JqaGZc4gRhFhc
         +PB4vjjeNlthwBVGUtrd+LRMoYqiA72vbI0XCWvPCfcoRtwlGRkTcg0yGjNQ8QfVve
         zfJdYOdhp6NLKsQ3O0GWCFFABlXQ1Ej2Vwvk6zyKzfgz673YDnpQRrwNtNKru1icXm
         P7tTmsZAUB/JA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1qEAFr-0003xi-H7; Tue, 27 Jun 2023 17:05:19 +0200
Date:   Tue, 27 Jun 2023 17:05:19 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        quic_jackp@quicinc.com, quic_harshq@quicinc.com,
        ahalaney@redhat.com, quic_shazhuss@quicinc.com
Subject: Re: [PATCH v9 07/10] usb: dwc3: qcom: Add multiport suspend/resume
 support for wrapper
Message-ID: <ZJr6r-cdDCFDc89R@hovoldconsulting.com>
References: <20230621043628.21485-1-quic_kriskura@quicinc.com>
 <20230621043628.21485-8-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621043628.21485-8-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 10:06:25AM +0530, Krishna Kurapati wrote:
> QCOM SoC SA8295P's tertiary quad port controller supports 2 HS+SS
> ports and 2 HS only ports. Add support for configuring PWR_EVENT_IRQ's
> for all the ports during suspend/resume.

Please be more specific here. You don't seem to be configuring anything.

> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  drivers/usb/dwc3/dwc3-qcom.c | 48 +++++++++++++++++++++++++++++++-----
>  1 file changed, 42 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index 3ab48a6925fe..699485a85233 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -37,7 +37,11 @@
>  #define PIPE3_PHYSTATUS_SW			BIT(3)
>  #define PIPE_UTMI_CLK_DIS			BIT(8)
>  
> -#define PWR_EVNT_IRQ_STAT_REG			0x58
> +#define PWR_EVNT_IRQ1_STAT_REG			0x58
> +#define PWR_EVNT_IRQ2_STAT_REG			0x1dc
> +#define PWR_EVNT_IRQ3_STAT_REG			0x228
> +#define PWR_EVNT_IRQ4_STAT_REG			0x238
> +
>  #define PWR_EVNT_LPM_IN_L2_MASK			BIT(4)
>  #define PWR_EVNT_LPM_OUT_L2_MASK		BIT(5)
>  
> @@ -93,6 +97,13 @@ struct dwc3_qcom {
>  	struct icc_path		*icc_path_apps;
>  };
>  
> +static u32 pwr_evnt_irq_stat_reg_offset[4] = {
> +	PWR_EVNT_IRQ1_STAT_REG,
> +	PWR_EVNT_IRQ2_STAT_REG,
> +	PWR_EVNT_IRQ3_STAT_REG,
> +	PWR_EVNT_IRQ4_STAT_REG,
> +};
> +
>  static inline void dwc3_qcom_setbits(void __iomem *base, u32 offset, u32 val)
>  {
>  	u32 reg;
> @@ -417,17 +428,37 @@ static void dwc3_qcom_enable_interrupts(struct dwc3_qcom *qcom)
>  	dwc3_qcom_enable_wakeup_irq(qcom->ss_phy_irq[0], 0);
>  }
>  
> +static u8 dwc3_qcom_get_port_info(struct dwc3_qcom *qcom)

"port_info" is not very specific, call it get_num_ports() or similar.

> +{
> +	struct dwc3 __maybe_unused *dwc = platform_get_drvdata(qcom->dwc3);

__maybe unused makes no sense here.

> +
> +	if (dwc3_qcom_is_host(qcom))
> +		return dwc->num_usb2_ports;

Here you're accessing the core driver data again, which we want to
avoid going forward so this at least warrants a FIXME to rework this as
well.

> +
> +	/*
> +	 * If not in host mode, either dwc was not probed
> +	 * or we are in device mode, either case checking for
> +	 * only first pwr event irq would suffice.

Rewrap comment at 80 columns.

> +	 */
> +
> +	return 1;
> +}
> +
>  static int dwc3_qcom_suspend(struct dwc3_qcom *qcom, bool wakeup)
>  {
>  	u32 val;
>  	int i, ret;
> +	u8 num_ports;

Move first.

>  	if (qcom->is_suspended)
>  		return 0;
>  
> -	val = readl(qcom->qscratch_base + PWR_EVNT_IRQ_STAT_REG);
> -	if (!(val & PWR_EVNT_LPM_IN_L2_MASK))
> +	num_ports = dwc3_qcom_get_port_info(qcom);
> +	for (i = 0; i < num_ports; i++) {
> +		val = readl(qcom->qscratch_base + pwr_evnt_irq_stat_reg_offset[i]);
> +		if (!(val & PWR_EVNT_LPM_IN_L2_MASK))
>  		dev_err(qcom->dev, "HS-PHY not in L2\n");

This line is not indented properly.

Make sure to run checkpatch before submitting so that I don't have to
point out things like this again.

> +	}
>  
>  	for (i = qcom->num_clocks - 1; i >= 0; i--)
>  		clk_disable_unprepare(qcom->clks[i]);
> @@ -452,12 +483,14 @@ static int dwc3_qcom_suspend(struct dwc3_qcom *qcom, bool wakeup)
>  
>  static int dwc3_qcom_resume(struct dwc3_qcom *qcom, bool wakeup)
>  {
> +	int num_ports;
>  	int ret;
>  	int i;
>  
>  	if (!qcom->is_suspended)
>  		return 0;
>  
> +	num_ports = dwc3_qcom_get_port_info(qcom);

Move below to where you use num_ports.

>  	if (dwc3_qcom_is_host(qcom) && wakeup)
>  		dwc3_qcom_disable_interrupts(qcom);
>  
> @@ -474,9 +507,12 @@ static int dwc3_qcom_resume(struct dwc3_qcom *qcom, bool wakeup)
>  	if (ret)
>  		dev_warn(qcom->dev, "failed to enable interconnect: %d\n", ret);
>  
> -	/* Clear existing events from PHY related to L2 in/out */

No need to move the comment.

> -	dwc3_qcom_setbits(qcom->qscratch_base, PWR_EVNT_IRQ_STAT_REG,
> -			  PWR_EVNT_LPM_IN_L2_MASK | PWR_EVNT_LPM_OUT_L2_MASK);
> +	for (i = 0; i < num_ports; i++) {
> +		/* Clear existing events from PHY related to L2 in/out */
> +		dwc3_qcom_setbits(qcom->qscratch_base,
> +			pwr_evnt_irq_stat_reg_offset[i],
> +			PWR_EVNT_LPM_IN_L2_MASK | PWR_EVNT_LPM_OUT_L2_MASK);

Indent continuation lines at least two tabs further than the previous
line.

> +	}
>  
>  	qcom->is_suspended = false;

Johan
