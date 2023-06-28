Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9860B740A52
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbjF1ICU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:02:20 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:44638 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbjF1H7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 03:59:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 084C56123B;
        Wed, 28 Jun 2023 06:30:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2EA5C433C8;
        Wed, 28 Jun 2023 06:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687933799;
        bh=lsVlDnsNS/ABPL5f2ejO6HC9u98Pds0akI3WMbUJ7GY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=riaF+fCp5gIS3QnWi0HQklfjkGQeyY7slQfFZQE5UcwRexZp+144sen0lOvvGItja
         Zcfn/wDQn8l8Jkt4vvqHe4UKo5WUK0Gsb5l4VyBWNB0JqSLWvKi/Ny+/dcuBllXRcT
         Qo4ylu07N3J+RKo2WcH4QzUUW9CiEtJAFTYKEeuQY9lbY/be2x/83C9Bm0bwLhaHqR
         BiE1xoEuPGx3KZH9zhE9R59NIjommtE9lLl9KXeBQwguMgDdKxSF66I4bOWVt5dK8Q
         ILU4OlOKFXY2tcGVHss+r1m9BPRbt+Iix6qrO87j1hop4tmtd89DM4Q6xpf9zqb0ZT
         rcDkMniaVWf/g==
Date:   Wed, 28 Jun 2023 11:59:46 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
        linux-arm-msm@vger.kernel.org, konrad.dybcio@linaro.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCIE ENDPOINT DRIVER FOR QUALCOMM" 
        <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v1 3/3] PCI: qcom: ep: Add wake up host op to
 dw_pcie_ep_ops
Message-ID: <20230628062946.GC20477@thinkpad>
References: <1686754850-29817-1-git-send-email-quic_krichai@quicinc.com>
 <1686754850-29817-4-git-send-email-quic_krichai@quicinc.com>
 <20230623061839.GC5611@thinkpad>
 <1b41ba64-51e2-7c66-104d-bc60ac131a0f@quicinc.com>
 <20230627135351.GE5490@thinkpad>
 <cd34d241-98e4-d3fa-3ae2-89182e9cd190@quicinc.com>
 <20230628045743.GA20477@thinkpad>
 <05ce24b1-68a0-5140-a857-8e97c022c0b3@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <05ce24b1-68a0-5140-a857-8e97c022c0b3@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 11:49:04AM +0530, Krishna Chaitanya Chundru wrote:
> 
> On 6/28/2023 10:27 AM, Manivannan Sadhasivam wrote:
> > On Wed, Jun 28, 2023 at 08:01:45AM +0530, Krishna Chaitanya Chundru wrote:
> > > On 6/27/2023 7:23 PM, Manivannan Sadhasivam wrote:
> > > > On Mon, Jun 26, 2023 at 07:18:49PM +0530, Krishna Chaitanya Chundru wrote:
> > > > > On 6/23/2023 11:48 AM, Manivannan Sadhasivam wrote:
> > > > > > On Wed, Jun 14, 2023 at 08:30:49PM +0530, Krishna chaitanya chundru wrote:
> > > > > > > Add wakeup host op to dw_pcie_ep_ops to wake up host from D3cold
> > > > > > > or D3hot.
> > > > > > > 
> > > > > > Commit message should describe how the wakeup is implemented in the driver.
> > > > > I will correct this in next series.
> > > > > > > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > > > > > > ---
> > > > > > >     drivers/pci/controller/dwc/pcie-qcom-ep.c | 34 +++++++++++++++++++++++++++++++
> > > > > > >     1 file changed, 34 insertions(+)
> > > > > > > 
> > > > > > > diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > > > > > > index 5d146ec..916a138 100644
> > > > > > > --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > > > > > > +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > > > > > > @@ -91,6 +91,7 @@
> > > > > > >     /* PARF_PM_CTRL register fields */
> > > > > > >     #define PARF_PM_CTRL_REQ_EXIT_L1		BIT(1)
> > > > > > >     #define PARF_PM_CTRL_READY_ENTR_L23		BIT(2)
> > > > > > > +#define PARF_PM_CTRL_XMT_PME			BIT(4)
> > > > > > >     #define PARF_PM_CTRL_REQ_NOT_ENTR_L1		BIT(5)
> > > > > > >     /* PARF_MHI_CLOCK_RESET_CTRL fields */
> > > > > > > @@ -794,10 +795,43 @@ static void qcom_pcie_ep_init(struct dw_pcie_ep *ep)
> > > > > > >     		dw_pcie_ep_reset_bar(pci, bar);
> > > > > > >     }
> > > > > > > +static int qcom_pcie_ep_wakeup_host(struct dw_pcie_ep *ep, u8 func_no)
> > > > > > > +{
> > > > > > > +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > > > > > > +	struct qcom_pcie_ep *pcie_ep = to_pcie_ep(pci);
> > > > > > > +	struct device *dev = pci->dev;
> > > > > > > +	u32 perst, dstate, val;
> > > > > > > +
> > > > > > > +	perst = gpiod_get_value(pcie_ep->reset);
> > > > > > > +	/* Toggle wake GPIO when device is in D3 cold */
> > > > > > > +	if (perst) {
> > > > > > > +		dev_info(dev, "Device is in D3 cold toggling wake\n");
> > > > > > dev_dbg(). "Waking up the host by toggling WAKE#"
> > > > > > 
> > > > > > > +		gpiod_set_value_cansleep(pcie_ep->wake, 1);
> > > > > > Waking a device from D3cold requires power-on sequence by the host and in the
> > > > > > presence of Vaux, the EPF should be prepared for that. In that case, the mode of
> > > > > > wakeup should be decided by the EPF driver. So the wakeup API should have an
> > > > > > argument to decide whether the wakeup is through PME or sideband WAKE#.
> > > > > > 
> > > > > > Also note that as per PCIe Spec 3.0, the devices can support PME generation from
> > > > > > D3cold provided that the Vaux is supplied to the device. I do not know if that
> > > > > > is supported by Qcom devices but API should honor the spec. So the wakeup
> > > > > > control should come from EPF driver as I suggested above.
> > > > > I aggre with you, but how will EPF know the PCI device state is in D3cold or
> > > > > D3hot.
> > > > > 
> > > > We should add a notifier in the controller driver which signals EPF when it
> > > > receives the DState events.. Take a look at pci_epc_linkdown().
> > > Ok I will add this kind of Dstate change event
> > > > > And how the EPF knows whether Vaux is supported or not in D3cold?
> > > > > 
> > > > > If there is any existing mechanism can you please point me that.
> > > > > 
> > > > > FYI Qcom does not support vaux power in D3 cold.
> > > > > 
> > > > If the EPF can trigger wakeup event during D3Cold then it means it is powered
> > > > by Vaux, isn't it?
> > > > 
> > > > - Mani
> > > EPF needs to know that if the endpoint is getting vaux in D3cold or not
> > > without this info
> > > 
> > > EPF doesn't know wheather to send toggle wake or send Inband PME right.
> > > 
> > > I mean EPF should have some  prior information wheather vaux is supplied or
> > > not to decide
> > > 
> > > wheather to toggle wake or send in band PME.
> > > 
> > Controller driver can use the #PERST level to detect D3Cold. Then it can pass
> > that info to EPF over notifiers. EPF may decide whether to toggle #WAKE or
> > send PME based on its configuration. For MHI EPF, it can toggle #WAKE as PME
> > during D3Cold is not supported.
> > 
> > - Mani
> 
> Can we add a new variable in ep features to know whether vaux is supported
> in D3 cold
> 
> or is there any register in the config space of EP which indicates that vaux
> is supported or not.
> 

I'm not aware of any method as of now but you do not need to worry. I was
just pointing it out as a possibility as per the spec. For this series, just
expose the wakeup logic to EPF as a flag.

- Mani

> > 
> > > -KC
> > > 
> > > > > > > +		usleep_range(WAKE_DELAY_US, WAKE_DELAY_US + 500);
> > > > > > > +		gpiod_set_value_cansleep(pcie_ep->wake, 0);
> > > > > > > +		return 0;
> > > > > > > +	}
> > > > > > > +
> > > > > > > +	dstate = dw_pcie_readl_dbi(pci, DBI_CON_STATUS) &
> > > > > > > +				   DBI_CON_STATUS_POWER_STATE_MASK;
> > > > > > > +	if (dstate == 3) {
> > > > > > > +		dev_info(dev, "Device is in D3 hot sending inband PME\n");
> > > > > > dev_dbg(). As I said, the device can sent PME from D3cold also. So the log could
> > > > > > be "Waking up the host using PME".
> > > > > > 
> > > > > > > +		val = readl_relaxed(pcie_ep->parf + PARF_PM_CTRL);
> > > > > > > +		val |= PARF_PM_CTRL_XMT_PME;
> > > > > > > +		writel_relaxed(val, pcie_ep->parf + PARF_PM_CTRL);
> > > > > > > +	} else {
> > > > > > > +		dev_err(dev, "Device is not in D3 state wakeup is not supported\n");
> > > > > > > +		return -EPERM;
> > > > > > -ENOTSUPP
> > > > > > 
> > > > > > - Mani
> > > > > > 
> > > > > > > +	}
> > > > > > > +
> > > > > > > +	return 0;
> > > > > > > +}
> > > > > > > +
> > > > > > >     static const struct dw_pcie_ep_ops pci_ep_ops = {
> > > > > > >     	.ep_init = qcom_pcie_ep_init,
> > > > > > >     	.raise_irq = qcom_pcie_ep_raise_irq,
> > > > > > >     	.get_features = qcom_pcie_epc_get_features,
> > > > > > > +	.wakeup_host = qcom_pcie_ep_wakeup_host,
> > > > > > >     };
> > > > > > >     static int qcom_pcie_ep_probe(struct platform_device *pdev)
> > > > > > > -- 
> > > > > > > 2.7.4
> > > > > > > 

-- 
மணிவண்ணன் சதாசிவம்
