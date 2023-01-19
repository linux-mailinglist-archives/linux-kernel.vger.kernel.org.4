Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3488E672E8D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 02:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjASB6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 20:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjASB5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 20:57:47 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DCC24128;
        Wed, 18 Jan 2023 17:57:40 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30J18pou004323;
        Thu, 19 Jan 2023 01:57:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=GejtsQXmqWA8A6r2URa+Ahm9Rucef480F6z05mm28cM=;
 b=dihzjYQQIddX0IjhTMaN00ea7NMj5ZUwVtMHuoS9S6db3p2DkgaG2bdaHY/g2B9Ixp2M
 jA2qVTAXE2xa/H3MC3NU0fAk2IJjqSo1V9ANfEzzU8xF3xVnZNe/GwTGXDUiNG3HQ2vH
 rhauoz6XRVI9pWAHjY6mm1wJEoFWikcnYSy+Qb9b/+94N2h4u75Tm5lSC76E8n6G9YIR
 hlSaw0G9DLEAq/E6IGz9amQf5oEkB6gROLtwaD3TEBOD2bukT8GmR85ExIP6d9lyGSVb
 eQnSUKVK6TPxY/YJRVTXXv5Uv28bCESvQQTgGLOStPQTj4n8f3hZmYONh82SnlxOjCMx KQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n5ws6kt36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 01:57:24 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30J1vN2U029723
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 01:57:23 GMT
Received: from jackp-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 18 Jan 2023 17:57:22 -0800
Date:   Wed, 18 Jan 2023 17:57:19 -0800
From:   Jack Pham <quic_jackp@quicinc.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Krishna Kurapati <quic_kriskura@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "quic_pkondeti@quicinc.com" <quic_pkondeti@quicinc.com>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_harshq@quicinc.com" <quic_harshq@quicinc.com>
Subject: Re: [RFC v4 3/5] usb: dwc3: core: Do not setup event buffers for
 host only controllers
Message-ID: <20230119015535.GF28337@jackp-linux.qualcomm.com>
References: <20230115114146.12628-1-quic_kriskura@quicinc.com>
 <20230115114146.12628-4-quic_kriskura@quicinc.com>
 <20230119003850.id3gtcokdim5pvf7@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230119003850.id3gtcokdim5pvf7@synopsys.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 27jiZz9dfSBcvJImV5Zws5IVlhBz31Ar
X-Proofpoint-ORIG-GUID: 27jiZz9dfSBcvJImV5Zws5IVlhBz31Ar
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 mlxlogscore=999 clxscore=1011 lowpriorityscore=0 mlxscore=0
 adultscore=0 spamscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190010
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thinh,

On Thu, Jan 19, 2023 at 12:38:51AM +0000, Thinh Nguyen wrote:
> On Sun, Jan 15, 2023, Krishna Kurapati wrote:
> > Multiport controllers being host-only capable do not have GEVNTADDR

Multiport may not be relevant here.  Host-only is though.

> > HI/LO, SIZE, COUNT reigsters present. Accsesing them to setup event
> 
> I think you should reword "present" to something else. They're still
> present

In our case we have an instance where the IP is statically configured
via coreConsultant with DWC_USB31_MODE==1 (host only) and we did observe
that none of the registers pertaining to device mode (including GEVNT*
and of course all the D* ones) are even *present* in the register map.
If we try to access them we encounter some kind of access error or stall
(or translation fault as described).  So the approach here is to first
verify by checking the HWPARAMS0 register if the HW is even capable of
device mode in the first place.

> but those registers are to be set while operating in device
> mode. The rest looks fine.

Are you suggesting only touching the GEVNT* registers when *operating*
in device mode, even in the case of a dual-role capable controller?  In
that case would it make more sense to additionally move the calls to
dwc3_event_buffers_{setup,cleanup} out of core.c and into
dwc3_gadget_{init,exit} perhaps?  That way we avoid them completely
unless and until we switch into peripheral mode (assuming controller
supports that, which we should already have checks for).  Moreover, if
the devicetree dr_mode property is set to host-only we'd also avoid
calling these.

> > buffers during core_init can cause an SMMU Fault. Avoid event buffers
> > setup if the GHWPARAMS0 tells that the controller is host-only.
> > 
> > Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> > ---
> >  drivers/usb/dwc3/core.c | 23 +++++++++++++++--------
> >  1 file changed, 15 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index 7e0a9a598dfd..f61ebddaecc0 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -871,9 +871,12 @@ static void dwc3_clk_disable(struct dwc3 *dwc)
> >  
> >  static void dwc3_core_exit(struct dwc3 *dwc)
> >  {
> > -	int i;
> > +	int		i;
> > +	unsigned int	hw_mode;
> >  
> > -	dwc3_event_buffers_cleanup(dwc);
> > +	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
> > +	if (hw_mode != DWC3_GHWPARAMS0_MODE_HOST)

If we stick with this approach, we probably could just check
dwc->dr_mode instead as probe should have already set that to be an
intersection between the values given in devicetree "dr_mode" and the
HWPARAMS0 capability.

Thanks,
Jack

> > +		dwc3_event_buffers_cleanup(dwc);
> >  
> >  	usb_phy_set_suspend(dwc->usb2_phy, 1);
> >  	usb_phy_set_suspend(dwc->usb3_phy, 1);
> > @@ -1246,10 +1249,12 @@ static int dwc3_core_init(struct dwc3 *dwc)
> >  		}
> >  	}
> >  
> > -	ret = dwc3_event_buffers_setup(dwc);
> > -	if (ret) {
> > -		dev_err(dwc->dev, "failed to setup event buffers\n");
> > -		goto err4;
> > +	if (hw_mode != DWC3_GHWPARAMS0_MODE_HOST) {
> > +		ret = dwc3_event_buffers_setup(dwc);
> > +		if (ret) {
> > +			dev_err(dwc->dev, "failed to setup event buffers\n");
> > +			goto err4;
> > +		}
> >  	}
> >  
> >  	/*
> > @@ -1886,7 +1891,7 @@ static int dwc3_probe(struct platform_device *pdev)
> >  	struct resource		*res, dwc_res;
> >  	struct dwc3		*dwc;
> >  	int			ret, i;
> > -
> > +	unsigned int		hw_mode;
> >  	void __iomem		*regs;
> >  
> >  	dwc = devm_kzalloc(dev, sizeof(*dwc), GFP_KERNEL);
> > @@ -2063,7 +2068,9 @@ static int dwc3_probe(struct platform_device *pdev)
> >  err5:
> >  	dwc3_debugfs_exit(dwc);
> >  
> > -	dwc3_event_buffers_cleanup(dwc);
> > +	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
> > +	if (hw_mode != DWC3_GHWPARAMS0_MODE_HOST)
> > +		dwc3_event_buffers_cleanup(dwc);
> >  
> >  	usb_phy_set_suspend(dwc->usb2_phy, 1);
> >  	usb_phy_set_suspend(dwc->usb3_phy, 1);
> > -- 
> > 2.39.0
> > 
