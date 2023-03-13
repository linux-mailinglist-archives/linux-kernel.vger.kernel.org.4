Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D51D6B6DAF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 03:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjCMC5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 22:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCMC5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 22:57:16 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079FB234DC;
        Sun, 12 Mar 2023 19:57:14 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32D2FjWv019797;
        Mon, 13 Mar 2023 02:56:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=lqLYkvu2wxu/IOZBe1fyU2RVWR97f7qTklHjVHNfheU=;
 b=h3Z9O4pECcqrfeZyDBhffwRVIjpEp+rdGtOgykRg/nCaaEpa6hYOaP9JHfsyMtM4R30l
 74U8HP33VzYzjypTWcmLmY0nTpRlnPKRoErErxZgqFeIPDd6JIjQQXgPAMjtoGhy6Fjl
 lBH76kntA5N5np3o8ohmUK8XAf6WL/me4XbJ3O2ksF9NKvMGD4MNnKAlLNaSFNMPW15S
 UaEJ6BZKHBn8CKNi5PmFQEihCc4QqPogsN8m68WrUEbxyElUOKz4hXHZSShxPsYUrRfH
 2d6JG2yKx+R7bZJuiABpTKzFOOq+jcbcSpciwffS82p9aEwUm8qwkW7lZWDZAxh/i36A Eg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p8gysuh1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 02:56:56 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32D2utD0028776
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 02:56:55 GMT
Received: from [10.216.43.170] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 12 Mar
 2023 19:56:48 -0700
Message-ID: <87c3f7c6-f288-3aaf-d7dd-cb28ba5c206c@quicinc.com>
Date:   Mon, 13 Mar 2023 08:26:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 3/8] usb: dwc3: core: Skip setting event buffers for host
 only controllers
Content-Language: en-US
To:     Dongliang Mu <mudongliangabcd@gmail.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>, <quic_wcheng@quicinc.com>,
        <quic_jackp@quicinc.com>, <quic_harshq@quicinc.com>,
        <ahalaney@redhat.com>, <quic_shazhuss@quicinc.com>
References: <20230310163420.7582-1-quic_kriskura@quicinc.com>
 <20230310163420.7582-4-quic_kriskura@quicinc.com>
 <CAD-N9QVT7qaiUbmPapZc5+6XXDVTPeXG4HD4p-n8WSi9FK2CbQ@mail.gmail.com>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <CAD-N9QVT7qaiUbmPapZc5+6XXDVTPeXG4HD4p-n8WSi9FK2CbQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ldITf53Dxyt5EbcJcKYyV3DTbXMyN7Ce
X-Proofpoint-ORIG-GUID: ldITf53Dxyt5EbcJcKYyV3DTbXMyN7Ce
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-12_10,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 priorityscore=1501 clxscore=1011
 mlxlogscore=764 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303130024
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/13/2023 7:37 AM, Dongliang Mu wrote:
> On Sat, Mar 11, 2023 at 12:40 AM Krishna Kurapati
> <quic_kriskura@quicinc.com> wrote:
>>
>> On some SoC's like SA8295P where the teritiary controller is host-only
>> capable, GEVTADDRHI/LO, GEVTSIZ, GEVTCOUNT registers are not accessible.
>> Trying to setup them up during core_init leads to a crash.
>>
>> For DRD/Peripheral supported controllers, event buffer setup is done
>> again in gadget_pullup. Skip setup or cleanup of event buffers if
>> controller is host-only capable.
>>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> ---
>>   drivers/usb/dwc3/core.c | 20 ++++++++++++++------
>>   1 file changed, 14 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index 076c0f8a4441..1ca9fa40a66e 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -840,7 +840,11 @@ static void dwc3_clk_disable(struct dwc3 *dwc)
>>
>>   static void dwc3_core_exit(struct dwc3 *dwc)
>>   {
>> -       dwc3_event_buffers_cleanup(dwc);
>> +       unsigned int    hw_mode;
>> +
>> +       hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
>> +       if (hw_mode != DWC3_GHWPARAMS0_MODE_HOST)
>> +               dwc3_event_buffers_cleanup(dwc);
> 
> quick question about dwc3_event_buffers_cleanup, there are other
> similar sites calling this function.
> 
> C symbol: dwc3_event_buffers_cleanup
> 
>    File   Function                   Line
> 0 core.h <global>                   1546 void
> dwc3_event_buffers_cleanup(struct dwc3 *dwc);
> 1 core.c __dwc3_set_mode             152 dwc3_event_buffers_cleanup(dwc);
> 2 core.c dwc3_event_buffers_cleanup  522 void
> dwc3_event_buffers_cleanup(struct dwc3 *dwc)
> 3 core.c dwc3_core_exit              842 dwc3_event_buffers_cleanup(dwc);
> 4 core.c dwc3_probe                 1936 dwc3_event_buffers_cleanup(dwc);
> 5 drd.c  dwc3_otg_update             363 dwc3_event_buffers_cleanup(dwc);
> 6 drd.c  dwc3_drd_exit               607 dwc3_event_buffers_cleanup(dwc);
> 
> For 1, 5, and 6, any need to take care of this situation?
> 
Hi Dongliang,

   Thanks for the review.
In the other places mentioned like set_mode otg_update or drd_exit, 
cleanup is called if we are in device mode and we want to exit that 
mode. Since for MP, we have a host only controller those paths won't be 
accessed I believe.

Regards,
Krishna,
>>
>>          usb_phy_set_suspend(dwc->usb2_phy, 1);
>>          usb_phy_set_suspend(dwc->usb3_phy, 1);
>> @@ -1177,10 +1181,12 @@ static int dwc3_core_init(struct dwc3 *dwc)
>>          if (ret < 0)
>>                  goto err3;
>>
>> -       ret = dwc3_event_buffers_setup(dwc);
>> -       if (ret) {
>> -               dev_err(dwc->dev, "failed to setup event buffers\n");
>> -               goto err4;
>> +       if (hw_mode != DWC3_GHWPARAMS0_MODE_HOST) {
>> +               ret = dwc3_event_buffers_setup(dwc);
>> +               if (ret) {
>> +                       dev_err(dwc->dev, "failed to setup event buffers\n");
>> +                       goto err4;
>> +               }
>>          }
>>
>>          /*
>> @@ -2008,7 +2014,9 @@ static int dwc3_probe(struct platform_device *pdev)
>>
>>   err5:
>>          dwc3_debugfs_exit(dwc);
>> -       dwc3_event_buffers_cleanup(dwc);
>> +
>> +       if (hw_mode != DWC3_GHWPARAMS0_MODE_HOST)
>> +               dwc3_event_buffers_cleanup(dwc);
>>
>>          usb_phy_set_suspend(dwc->usb2_phy, 1);
>>          usb_phy_set_suspend(dwc->usb3_phy, 1);
>> --
>> 2.39.0
>>
