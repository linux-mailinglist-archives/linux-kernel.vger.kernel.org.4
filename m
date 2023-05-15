Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE7F7040E7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 00:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245438AbjEOWXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 18:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236784AbjEOWXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 18:23:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDFEA3;
        Mon, 15 May 2023 15:23:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 035846334A;
        Mon, 15 May 2023 22:23:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 191A4C433D2;
        Mon, 15 May 2023 22:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684189419;
        bh=OqIemthk74Japxf8JKty+wpFYdyckxcj/Mt28A6kSCU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J5uGurHmS/0tRRbC7hB2MmYS8N06SxfaPIOP4Ch/thZWa/94X9c8zKIl1D0wSnCjk
         dqBRrTNde11hMZcSBH1zyPJWt5MateFyXxPxSGOpd2jT2Fz51l3xmilc1MRjo/DIj4
         4lhVERDDv1fNus0XCxlYxU4dh2qNS5Kx3vA+78uNSXIkU7pC/qnYwuA2hqEO2n6mgt
         EFhtTDAGl8p27u3cho7fV2IuBkc4I5HiciCI+zqUNU0BrF8KtveSqHCOIc5bIVi4Ua
         EC0GuBHLmURNMjkxGUfDl/CXGuJniAGQ9al+OlAK1Bj6Oki4cyH2cCXBchjTNW8y/r
         2OzRZOJEMwQPw==
Date:   Mon, 15 May 2023 15:27:30 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
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
Message-ID: <20230515222730.7snn2i33gkg6ctd2@ripper>
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

Seems to be excessive indentation of these...

Can you also please confirm that these should be counted starting at 1 -
given that you otherwise talk about port0..N-1?

> +};
> +
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

In the event that the dwc3 core fails to acquire or enable e.g. clocks
its drvdata will be NULL. If you then hit a runtime pm transition in the
dwc3-qcom glue you will dereference NULL here. (You can force this issue
by e.g. returning -EINVAL from dwc3_clk_enable()).

So if you're peaking into qcom->dwc3 you need to handle the fact that
dwc might be NULL, here and in resume below.

Regards,
Bjorn
