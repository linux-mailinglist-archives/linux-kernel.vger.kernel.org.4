Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18B1706E4A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjEQQhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjEQQhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:37:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FFFB3;
        Wed, 17 May 2023 09:37:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B71ED61A1E;
        Wed, 17 May 2023 16:37:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15B40C433D2;
        Wed, 17 May 2023 16:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684341449;
        bh=06Z0AwxSNoOJ/iYAWocPIk6y4yMewQTiHHzN6mMWoiQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bTlZa9I17UidvuKZJ03+fRwOBPrSNyjiibFWQgk5r0wxq0AMb4KnB8zfDynJSoxic
         ct0XZmfFupS8SwQ5lyTKJx6z87Ez17nxmiBylp84BoytAyZ3KJsu1R5bAqjlVKZBD5
         oAQq4XZ1QuVAkKXAlrVgG9hb5uFiBiQX9Ny06vaTjEiRdK1B/D32EY4+s0XDupoFLv
         wujKRnugBiftnH8DsXGa+84L4DeNcNLt+Xgga6BW3wmeXgxNB9hCreDtxe7oGyD6vS
         XeOZ4t3CLSShHYfh0AmZB7mS/RBiQOBh2TwaansRtTjpvXX2UJQ8sTvU0YKmvQn+xc
         xoJi7fyi/CVQQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pzK9a-0006Wr-C1; Wed, 17 May 2023 18:37:30 +0200
Date:   Wed, 17 May 2023 18:37:30 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
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
Message-ID: <ZGUCykpDFt9zgeTU@hovoldconsulting.com>
References: <20230514054917.21318-1-quic_kriskura@quicinc.com>
 <20230514054917.21318-7-quic_kriskura@quicinc.com>
 <20230515222730.7snn2i33gkg6ctd2@ripper>
 <bc347624-4539-4a3a-9399-9b4e272cdb32@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc347624-4539-4a3a-9399-9b4e272cdb32@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 07:49:14AM +0530, Krishna Kurapati PSSNV wrote:
> 
> 
> On 5/16/2023 3:57 AM, Bjorn Andersson wrote:
> > On Sun, May 14, 2023 at 11:19:14AM +0530, Krishna Kurapati wrote:

> >> -#define PWR_EVNT_IRQ_STAT_REG			0x58
> >> +#define PWR_EVNT_IRQ1_STAT_REG			0x58
> >> +#define PWR_EVNT_IRQ2_STAT_REG			0x1dc
> >> +#define PWR_EVNT_IRQ3_STAT_REG			0x228
> >> +#define PWR_EVNT_IRQ4_STAT_REG			0x238
> >>   #define PWR_EVNT_LPM_IN_L2_MASK			BIT(4)
> >>   #define PWR_EVNT_LPM_OUT_L2_MASK		BIT(5)
> >>   
> >> @@ -93,6 +96,13 @@ struct dwc3_qcom {
> >>   	struct icc_path		*icc_path_apps;
> >>   };
> >>   
> >> +static u32 pwr_evnt_irq_stat_reg_offset[4] = {
> >> +			PWR_EVNT_IRQ1_STAT_REG,
> >> +			PWR_EVNT_IRQ2_STAT_REG,
> >> +			PWR_EVNT_IRQ3_STAT_REG,
> >> +			PWR_EVNT_IRQ4_STAT_REG,
> > 
> > Seems to be excessive indentation of these...
> > 
> > Can you also please confirm that these should be counted starting at 1 -
> > given that you otherwise talk about port0..N-1?

>    I am fine with either way. Since this just denoted 4 different ports, 
> I named them starting with 1. Either ways, we will run through array 
> from (0-3), so we must be fine.

Actually, the USB ports are indexed from 1, so the above naming may or
may not be correct depending on how they are defined.

> >> +};
> >> +
> >>   static inline void dwc3_qcom_setbits(void __iomem *base, u32 offset, u32 val)
> >>   {
> >>   	u32 reg;
> >> @@ -413,13 +423,16 @@ static int dwc3_qcom_suspend(struct dwc3_qcom *qcom, bool wakeup)
> >>   {
> >>   	u32 val;
> >>   	int i, ret;
> >> +	struct dwc3 *dwc = platform_get_drvdata(qcom->dwc3);
> >>   
> >>   	if (qcom->is_suspended)
> >>   		return 0;
> >>   
> >> -	val = readl(qcom->qscratch_base + PWR_EVNT_IRQ_STAT_REG);
> >> -	if (!(val & PWR_EVNT_LPM_IN_L2_MASK))
> >> -		dev_err(qcom->dev, "HS-PHY not in L2\n");
> >> +	for (i = 0; i < dwc->num_usb2_ports; i++) {
> > 
> > In the event that the dwc3 core fails to acquire or enable e.g. clocks
> > its drvdata will be NULL. If you then hit a runtime pm transition in the
> > dwc3-qcom glue you will dereference NULL here. (You can force this issue
> > by e.g. returning -EINVAL from dwc3_clk_enable()).
> > 
> > So if you're peaking into qcom->dwc3 you need to handle the fact that
> > dwc might be NULL, here and in resume below.
> > 
> Thanks for catching this. You are right, there were instances where the 
> we saw probe for dwc3 being deferred while the probe for dwc3-qcom was 
> still successful [1]. In this case, if the dwc3 probe never happened and 
> system tries to enter suspend, we might hit a NULL pointer dereference.

I don't think we should be adding more of these layering violations. A
parent device driver has no business messing with the driver data for a
child device which may or may not even have probed yet.

I added a FIXME elsewhere in the driver about fixing up the current
instances that have already snuck in (which in some sense is even worse
by accessing driver data of a grandchild device).

We really need to try sort this mess out and how to properly handle the
interactions between these layers (e.g. glue, dwc3 core and xhci). This
will likely involve adding callbacks from the child to the parent, for
example, when the child is suspending.

Johan
