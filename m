Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C863A725E77
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 14:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240426AbjFGMQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 08:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240043AbjFGMQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:16:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72531FD8;
        Wed,  7 Jun 2023 05:16:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CCA163E61;
        Wed,  7 Jun 2023 12:16:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B98C433D2;
        Wed,  7 Jun 2023 12:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686140174;
        bh=HlNz6Ado0d6eQj5JSweTVMGGnPL01vC2DAZcoI7FHFI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DEIITjoGO3GkItGqBWXi+9iVYCuWUzGrd4MGMROGP2tHYbHZGHCSNDYh3F7Ur5iOr
         arxxLbdZK8FSXny3cFjY4tAuQcRzQ0kLuOVYOaEs5r/QA7KExTtdncgHrK8Vr1EFNv
         X15TgSZWo7QAXQbzfJe4Hk8fGM/C4clgNTAFswMcURbqYXpupEG1cRYCIS1SfseOkn
         f92TBG5umrejEA3df+L6E4ADb3a+PEfVauW1bpZnGsDaaPhzCF8NKDW3Ddky9EUDKN
         /GxBUdefrvvI/c80fzza8se405I51Cjo27cCjqQUY+v0aU6jZ6wm+us7Ol/sB4gddV
         2C+AvRBC+FLtg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q6s5c-0001DA-JW; Wed, 07 Jun 2023 14:16:37 +0200
Date:   Wed, 7 Jun 2023 14:16:36 +0200
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
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com, quic_wcheng@quicinc.com,
        quic_jackp@quicinc.com, quic_harshq@quicinc.com,
        ahalaney@redhat.com
Subject: Re: [PATCH v8 6/9] usb: dwc3: qcom: Add multiport controller support
 for qcom wrapper
Message-ID: <ZIB1JEmLCw41v_4e@hovoldconsulting.com>
References: <20230514054917.21318-1-quic_kriskura@quicinc.com>
 <20230514054917.21318-7-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230514054917.21318-7-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 14, 2023 at 11:19:14AM +0530, Krishna Kurapati wrote:
> QCOM SoC SA8295P's tertiary quad port controller supports 2 HS+SS
> ports and 2 HS only ports. Add support for configuring PWR_EVENT_IRQ's
> for all the ports during suspend/resume.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  drivers/usb/dwc3/dwc3-qcom.c | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index 959fc925ca7c..7a9bce66295d 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -37,7 +37,10 @@
>  #define PIPE3_PHYSTATUS_SW			BIT(3)
>  #define PIPE_UTMI_CLK_DIS			BIT(8)
>  
> -#define PWR_EVNT_IRQ_STAT_REG			0x58
> +#define PWR_EVNT_IRQ1_STAT_REG			0x58
> +#define PWR_EVNT_IRQ2_STAT_REG			0x1dc
> +#define PWR_EVNT_IRQ3_STAT_REG			0x228
> +#define PWR_EVNT_IRQ4_STAT_REG			0x238
>  #define PWR_EVNT_LPM_IN_L2_MASK			BIT(4)
>  #define PWR_EVNT_LPM_OUT_L2_MASK		BIT(5)
>  
> @@ -93,6 +96,13 @@ struct dwc3_qcom {
>  	struct icc_path		*icc_path_apps;
>  };
>  
> +static u32 pwr_evnt_irq_stat_reg_offset[4] = {
> +			PWR_EVNT_IRQ1_STAT_REG,
> +			PWR_EVNT_IRQ2_STAT_REG,
> +			PWR_EVNT_IRQ3_STAT_REG,
> +			PWR_EVNT_IRQ4_STAT_REG,
> +};

Indentation is off, as I believe Bjorn pointed out.

>  static inline void dwc3_qcom_setbits(void __iomem *base, u32 offset, u32 val)
>  {
>  	u32 reg;
> @@ -413,13 +423,16 @@ static int dwc3_qcom_suspend(struct dwc3_qcom *qcom, bool wakeup)
>  {
>  	u32 val;
>  	int i, ret;
> +	struct dwc3 *dwc = platform_get_drvdata(qcom->dwc3);
>  
>  	if (qcom->is_suspended)
>  		return 0;
>  
> -	val = readl(qcom->qscratch_base + PWR_EVNT_IRQ_STAT_REG);
> -	if (!(val & PWR_EVNT_LPM_IN_L2_MASK))
> -		dev_err(qcom->dev, "HS-PHY not in L2\n");
> +	for (i = 0; i < dwc->num_usb2_ports; i++) {
> +		val = readl(qcom->qscratch_base + pwr_evnt_irq_stat_reg_offset[i]);
> +		if (!(val & PWR_EVNT_LPM_IN_L2_MASK))
> +			dev_err(qcom->dev, "HS-PHY%d not in L2\n", i);
> +	}

You need check for NULL dwc as we just discussed and skip the above
check if core has not probed yet.

When testing this on the X13s I get:

	dwc3-qcom a4f8800.usb: HS-PHY2 not in L2

for the third port, whose status registers always seems to return zero
(e.g. as if we're checking the wrong register?):

dwc3-qcom a4f8800.usb: dwc3_qcom_suspend - phy 0, pwr_event_stat = 38103c
dwc3-qcom a4f8800.usb: dwc3_qcom_suspend - phy 1, pwr_event_stat = 38103c
dwc3-qcom a4f8800.usb: dwc3_qcom_suspend - phy 2, pwr_event_stat = 00
dwc3-qcom a4f8800.usb: dwc3_qcom_suspend - phy 3, pwr_event_stat = 140030

I verified that everything appears to work as expected on sa8295p-adp.

Do you have any idea of what may be causing this?

Johan
