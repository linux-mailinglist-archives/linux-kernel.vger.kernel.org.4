Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E9F716FDF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 23:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbjE3VkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 17:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbjE3Vjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 17:39:46 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9B610D;
        Tue, 30 May 2023 14:39:39 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34UJw0p6024498;
        Tue, 30 May 2023 21:39:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=KecizHeDfxL0x86L1tnH168BxhZtJILtJs255kwRHUw=;
 b=ji73h/OUTmBjUG74w/Xk0MO54yqEpqj+clPbPuM8ukQcBlNJuF/fvci1SgbLhTp4L+80
 egM3Y24GtHVl8QTM0zOZ5BvHIicEceBajJaQY8PohQNET/uqvb+MBpDn3C6N9wpueEFe
 p9ezPgBC3F7KkE94pGAgwT79rIHfwcCmQKCjbeAEjJYeT5LtwUbI73Gn+tn/lrVo9Jeb
 TeBgp74/gXaQ1kkZK6WYSIIb4J2upcVZTUU0P5PN/2QanAr7bpaKHKPEVrYsOETaFxwk
 AEtKJf87gqxN38waxOuMh2WTq94oF2Q+90WgvDpJp06DD+Mr+K4CIeuz2JwOVX3bzRwd gQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qw7rtt8nq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 21:39:34 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34ULdXIU001455
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 21:39:33 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 30 May 2023 14:39:32 -0700
Date:   Tue, 30 May 2023 14:39:31 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Stephan Gerhold <stephan@gerhold.net>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] soc: qcom: rmtfs: Support dynamic placement of region
Message-ID: <20230530213931.GB3645274@hu-bjorande-lv.qualcomm.com>
References: <20230530193436.3833889-1-quic_bjorande@quicinc.com>
 <20230530193436.3833889-3-quic_bjorande@quicinc.com>
 <ZHZTHlfDsngUrTRX@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZHZTHlfDsngUrTRX@gerhold.net>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: n94yZGMHZTjwLrirnP5nUVJ1RbdhHpdt
X-Proofpoint-ORIG-GUID: n94yZGMHZTjwLrirnP5nUVJ1RbdhHpdt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_16,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 phishscore=0 mlxscore=0 mlxlogscore=821 bulkscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305300175
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 09:48:46PM +0200, Stephan Gerhold wrote:
> On Tue, May 30, 2023 at 12:34:36PM -0700, Bjorn Andersson wrote:
> > In some configurations, the exact placement of the rmtfs shared memory
> > region isn't so strict. In the current implementation the author of the
> > DeviceTree source is forced to make up a memory region.
> > 
> > Extend the rmtfs memory driver to relieve the author of this
> > responsibility by introducing support for using dynamic allocation in
> > the driver.
> > 
> > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > ---
> >  arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 10 ++++
> >  drivers/soc/qcom/rmtfs_mem.c            | 66 +++++++++++++++++++------
> >  2 files changed, 61 insertions(+), 15 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> > index d1440b790fa6..e6191b8ba4c6 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> > +++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> > @@ -12,6 +12,8 @@
> >  #include "pm8998.dtsi"
> >  #include "pmi8998.dtsi"
> >  
> > +/delete-node/ &rmtfs_mem;
> > +
> >  / {
> >  	model = "Qualcomm Technologies, Inc. SDM845 MTP";
> >  	compatible = "qcom,sdm845-mtp", "qcom,sdm845";
> > @@ -48,6 +50,14 @@ vreg_s4a_1p8: pm8998-smps4 {
> >  		vin-supply = <&vph_pwr>;
> >  	};
> >  
> > +	rmtfs {
> > +		compatible = "qcom,rmtfs-mem";
> > +
> > +		qcom,alloc-size = <(2*1024*1024)>;
> > +		qcom,client-id = <1>;
> > +		qcom,vmid = <15>;
> > +	};
> > +
> 
> Couldn't you just use the existing dynamic allocation of
> reserved-memory, without any driver changes?
> 

That should give us a similar end result, but we have alloc-ranges as
well, if the placement needs to be further refined...

> / {
> 	reserved-memory {
> 		rmtfs {
> 			compatible = "qcom,rmtfs-mem";
> 			size = <0x0 (2*1024*1024)>;
> 			alignment = <0x0 ...>; // if you want a special one
> 			no-map; // don't we want to map this actually?
> 
> 			qcom,client-id = <1>;
> 			qcom,vmid = <15>;
> 		};
> 	};
> };
> 
> You won't get the 4K empty pages but I guess you just have them because
> you allocate the memory without proper alignment?
> 

With dynamic placement there's no guarantee that the region isn't
physically adjacent to another protected region, so this needs to be
handled somehow.

Perhaps the intention to include guard pages can be derived from the
size...

> Related patch series where I propose using it for most firmware memory
> regions:
> https://lore.kernel.org/linux-arm-msm/20230510-dt-resv-bottom-up-v1-5-3bf68873dbed@gerhold.net/
> 

Thanks for the suggestion,
Bjorn

> Thanks,
> Stephan
