Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69B26F640B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 06:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjEDE1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 00:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjEDE1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 00:27:49 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1A011D;
        Wed,  3 May 2023 21:27:47 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3443tWhv021678;
        Thu, 4 May 2023 04:27:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=uos9HuZG2tYmeaAuDA9IM4uMN10ul3cN91BH8BuVnyI=;
 b=JS83mZgMXG8WrTNTC5ntpTzg8UjZJDYo7JU4vmEAx/fC1pMJxc1cTYbon5vY5JvAnAvK
 cduCIMyGHFFoyhHkDdba67u7rA/2tp1ohT5pNeDVIpwtYWvyVFo8EiPVuX5e6Csl6dq7
 zGheTATHjDvX+Kix44k4G3MZuXrzhKAm4Je9+emv7/sk7/CMjBa/Ftt6EDetqyKeE6o8
 CR7IicoEHUbTOgNZjnOi2rbeVXRrCCdP9KYqqLhYAAq4F+Y5iHW45GdmxfhdTWJjhAc7
 gTlkQWRQb93D4CTzhKN84SoHrFr1hjE7Lr/EKtLNkkKnzju5RGz1nsS1h2b0BzOx/X93 8w== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qc2aj0afv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 May 2023 04:27:37 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3444Ra3Y018627
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 4 May 2023 04:27:36 GMT
Received: from [10.216.20.183] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 3 May 2023
 21:27:30 -0700
Message-ID: <9672285c-d81c-2ef5-46bc-13708392b5aa@quicinc.com>
Date:   Thu, 4 May 2023 09:57:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v7 5/9] usb: dwc3: core: Refactor PHY logic to support
 Multiport Controller
Content-Language: en-US
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        "Wesley Cheng" <quic_wcheng@quicinc.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "quic_pkondeti@quicinc.com" <quic_pkondeti@quicinc.com>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_harshq@quicinc.com" <quic_harshq@quicinc.com>,
        "ahalaney@redhat.com" <ahalaney@redhat.com>,
        "quic_shazhuss@quicinc.com" <quic_shazhuss@quicinc.com>
References: <20230501143445.3851-1-quic_kriskura@quicinc.com>
 <20230501143445.3851-6-quic_kriskura@quicinc.com>
 <20230502221100.ecska23anlzv3iwq@synopsys.com>
 <f55fbdc1-444c-eba5-02f4-aeab7a1b6f04@quicinc.com>
 <20230503215511.52udfef6amdcapng@synopsys.com>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <20230503215511.52udfef6amdcapng@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SzxGQNK_kcRI51JUR3yikyBVABsYfoev
X-Proofpoint-GUID: SzxGQNK_kcRI51JUR3yikyBVABsYfoev
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_01,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 adultscore=0 mlxlogscore=835 impostorscore=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305040035
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/4/2023 3:25 AM, Thinh Nguyen wrote:
> On Wed, May 03, 2023, Krishna Kurapati PSSNV wrote:
>>
>>
>> On 5/3/2023 3:41 AM, Thinh Nguyen wrote:
>>> On Mon, May 01, 2023, Krishna Kurapati wrote:
>>>> Currently the DWC3 driver supports only single port controller
>>>> which requires at most one HS and one SS PHY.
>>>>
>>>> But the DWC3 USB controller can be connected to multiple ports and
>>>> each port can have their own PHYs. Each port of the multiport
>>>> controller can either be HS+SS capable or HS only capable
>>>> Proper quantification of them is required to modify GUSB2PHYCFG
>>>> and GUSB3PIPECTL registers appropriately.
>>>>
>>>> Add support for detecting, obtaining and configuring phy's supported
>>>> by a multiport controller and limit the max number of ports
>>>> supported to 4.
>>>>
>>>> Signed-off-by: Harsh Agarwal <quic_harshq@quicinc.com>
>>>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>>>
>>> Are you a co-author or only Harsh is the main author of this patch?
>>>
>> Harsh began developing this series and pushed the first 3 RFC versions
>> (supporting both usb-phy / generic phy frameworks) until maintainers pointed
>> out that we only support generic phy changes.
>>
>>  From then on I took it up and started pushing next versions. I would say
>> both of us are primary authors for this patch. But if there has to be only
>> one, I would say its Harsh.
>>
>> Regards,
>> Krishna,
>>
> 
> I just want to check to give you proper credit for the patch's
> contribution. Since Harsh isn't the only one working on this you're not
> simply transporting this change. Perhaps you should add Co-developed-by
> tags.
> 
> Thanks,
> Thinh

Sure,

  Let me put myself under Co-developed-by in the next version.

Regards,
Krishna,
