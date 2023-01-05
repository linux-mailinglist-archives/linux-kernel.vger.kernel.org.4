Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E494265E376
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 04:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjAED31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 22:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjAED3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 22:29:25 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A282F793;
        Wed,  4 Jan 2023 19:29:23 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3052rWB6028736;
        Thu, 5 Jan 2023 03:29:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=HN3LUrqDYyzsVwY15tu0C/Gs0tu6a9WOTa//TetOb94=;
 b=K/DEuViPtnV60D0YgRO3F/5IqpziEFohYLPuuN2nznvZMAza6ffG0g6MOM6cpXhJLJrM
 ywnRXzTC5nhQLpWCDIuuujwsvoKI4KnM0S0Pce9mlITJuLSTCJb1Lk0Msl1+3VNISWxg
 uNlPg9XGsYSeck7EaCfKneNMkJsLtLKE/YBHGlD+8vtdmRwK1cBsmF+7BezRf1s7RUY7
 IGTNJ5Gl5RVsd8J3eQ5hBaLoI42CzXVbPmSN7OpsgFzDoDGWnmraEAj/hCqh8eKpo8Un
 9mbCc1gHAL6kqmGy8cEVeYGmzrbdsJ2MVzbetJIhwWfCpPWLF/vdm21SuKJgyFFUp/Y1 yw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mwj4p8edr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Jan 2023 03:29:16 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3053TFIs006567
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 5 Jan 2023 03:29:15 GMT
Received: from [10.239.154.244] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 4 Jan 2023
 19:29:13 -0800
Message-ID: <af32e2f5-de45-38af-2b4f-47c1ac21ea9e@quicinc.com>
Date:   Thu, 5 Jan 2023 11:29:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] usb: dwc3: Clear DWC3_EVENT_PENDING when count is 0
Content-Language: en-US
To:     JaeHun Jung <jh0801.jung@samsung.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Seungchull Suh <sc.suh@samsung.com>,
        Daehwan Jung <dh10.jung@samsung.com>
References: <CGME20230102050839epcas2p4b9d09d926f9a14c3b8e8df2574d334c3@epcas2p4.samsung.com>
 <20230102050831.105499-1-jh0801.jung@samsung.com>
From:   Linyu Yuan <quic_linyyuan@quicinc.com>
In-Reply-To: <20230102050831.105499-1-jh0801.jung@samsung.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Vt_lQ5o88kUgz_s_V3PTvlZBDweHUNhF
X-Proofpoint-ORIG-GUID: Vt_lQ5o88kUgz_s_V3PTvlZBDweHUNhF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_07,2023-01-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=557 malwarescore=0
 phishscore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301050027
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/2/2023 1:08 PM, JaeHun Jung wrote:
> Sometimes very rarely, The count is 0 and the DWC3 flag is set has status.
> It must not have these status. Because, It can make happen interrupt storming
> status.

could you help explain without clear the flag, how interrupt storming 
happen ?

as your change didn't touch any hardware register, i don't know how it 
fix storming.

storming from software layer ?

> So, It have to clean up DWC3_EVENT_PENDING flags set when count is 0.
> It means "There are no interrupts to handle.".
>
> (struct dwc3_event_buffer *) ev_buf = 0xFFFFFF883DBF1180 (
> 	(void *) buf = 0xFFFFFFC00DBDD000 = end+0x337D000,
> 	(void *) cache = 0xFFFFFF8839F54080,
> 	(unsigned int) length = 0x1000,
> 	(unsigned int) lpos = 0x0,
> 	(unsigned int) count = 0x0,
> 	(unsigned int) flags = 0x00000001,
> 	(dma_addr_t) dma = 0x00000008BD7D7000,
> 	(struct dwc3 *) dwc = 0xFFFFFF8839CBC880,
> 	(u64) android_kabi_reserved1 = 0x0),
>
> (time = 47557628930999, irq = 165, fn = dwc3_interrupt, latency = 0, en = 1),
> (time = 47557628931268, irq = 165, fn = dwc3_interrupt, latency = 0, en = 3),
> (time = 47557628932383, irq = 165, fn = dwc3_interrupt, latency = 0, en = 1),
> (time = 47557628932652, irq = 165, fn = dwc3_interrupt, latency = 0, en = 3),
> (time = 47557628933768, irq = 165, fn = dwc3_interrupt, latency = 0, en = 1),
> (time = 47557628934037, irq = 165, fn = dwc3_interrupt, latency = 0, en = 3),
> (time = 47557628935152, irq = 165, fn = dwc3_interrupt, latency = 0, en = 1),
> (time = 47557628935460, irq = 165, fn = dwc3_interrupt, latency = 0, en = 3),
> (time = 47557628936575, irq = 165, fn = dwc3_interrupt, latency = 0, en = 1),
> (time = 47557628936845, irq = 165, fn = dwc3_interrupt, latency = 0, en = 3),
> (time = 47557628937960, irq = 165, fn = dwc3_interrupt, latency = 0, en = 1),
> (time = 47557628938229, irq = 165, fn = dwc3_interrupt, latency = 0, en = 3),
> (time = 47557628939345, irq = 165, fn = dwc3_interrupt, latency = 0, en = 1),
> (time = 47557628939652, irq = 165, fn = dwc3_interrupt, latency = 0, en = 3),
> (time = 47557628940768, irq = 165, fn = dwc3_interrupt, latency = 0, en = 1),
> (time = 47557628941037, irq = 165, fn = dwc3_interrupt, latency = 0, en = 3),
> (time = 47557628942152, irq = 165, fn = dwc3_interrupt, latency = 0, en = 1),
> (time = 47557628942422, irq = 165, fn = dwc3_interrupt, latency = 0, en = 3),
> (time = 47557628943537, irq = 165, fn = dwc3_interrupt, latency = 0, en = 1),
> (time = 47557628943806, irq = 165, fn = dwc3_interrupt, latency = 0, en = 3),
> (time = 47557628944922, irq = 165, fn = dwc3_interrupt, latency = 0, en = 1),
> (time = 47557628945229, irq = 165, fn = dwc3_interrupt, latency = 0, en = 3),
> (time = 47557628946345, irq = 165, fn = dwc3_interrupt, latency = 0, en = 1),
> (time = 47557628946614, irq = 165, fn = dwc3_interrupt, latency = 0, en = 3),
> (time = 47557628947729, irq = 165, fn = dwc3_interrupt, latency = 0, en = 1),
> (time = 47557628947999, irq = 165, fn = dwc3_interrupt, latency = 0, en = 3),
>
> Signed-off-by: JaeHun Jung <jh0801.jung@samsung.com>
> ---
>   drivers/usb/dwc3/gadget.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 789976567f9f..5d2d5a9b9915 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -4355,8 +4355,11 @@ static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
>   	 * irq event handler completes before caching new event to prevent
>   	 * losing events.
>   	 */
> -	if (evt->flags & DWC3_EVENT_PENDING)
> +	if (evt->flags & DWC3_EVENT_PENDING) {
> +		if (!evt->count)
> +			evt->flags &= ~DWC3_EVENT_PENDING;
>   		return IRQ_HANDLED;
> +	}
>   
>   	count = dwc3_readl(dwc->regs, DWC3_GEVNTCOUNT(0));
>   	count &= DWC3_GEVNTCOUNT_MASK;

how about below change ?

         count = dwc3_readl(dwc->regs, DWC3_GEVNTCOUNT(0));
         count &= DWC3_GEVNTCOUNT_MASK;
-       if (!count)
+       if (!count) {
+               evt->flags &= ~DWC3_EVENT_PENDING;
                 return IRQ_NONE;
+       }

         evt->count = count;
         evt->flags |= DWC3_EVENT_PENDING;

