Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F5B739671
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 06:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjFVEjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 00:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjFVEjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 00:39:39 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B280EE69;
        Wed, 21 Jun 2023 21:39:38 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35M3rpGN000655;
        Thu, 22 Jun 2023 04:39:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=b3QY04BaXwdxDByWW6IPZPiZMwPBhZgi2RIteR6pKGQ=;
 b=B6nso4tg9DmX7jyXWouafFaVpAEiIY2tdnU+3G5xsWjW3PeB26xFPXkLLrCC1bdxB1Gl
 /93vpMZW3lcuIGHKLS+Wp9zisRDaXWesWpEZfSUzAq8kj4TbpuFmOcUsiPqZb/9XFRBc
 v8kN3nQnLOPlhpW9vao8MDvuvtlY9ALvgXSdvOMv5doMwnhOAKGHneX4gMVb9rTOo8xm
 QFx320XvRmxDNypu2uf7TfhQMs4xoM12qKploqQU7xjQF+S813ZWTWTMVr1jI6K/JvKj
 cOGcThqo2lvZ8HsD4pUwQPQpASjqRSqZyBN2psXAn5R2nd8UwDAX4fI7OEy/ob34x/gH tw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rbqjbaxfe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 04:39:23 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35M4dL2n000851
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 04:39:21 GMT
Received: from [10.216.6.225] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 21 Jun
 2023 21:39:16 -0700
Message-ID: <3f9957ad-cc73-2a4b-f11c-98b0b79f829c@quicinc.com>
Date:   Thu, 22 Jun 2023 10:09:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH v8 6/9] usb: dwc3: qcom: Add multiport controller support
 for qcom wrapper
To:     Johan Hovold <johan@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "quic_pkondeti@quicinc.com" <quic_pkondeti@quicinc.com>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_harshq@quicinc.com" <quic_harshq@quicinc.com>,
        "ahalaney@redhat.com" <ahalaney@redhat.com>
References: <82553597-ce0e-48f4-44d4-9eeaaf4cb1c4@quicinc.com>
 <ZIBsDQJtgDZRe7MG@hovoldconsulting.com>
 <99cded6f-6a71-ffce-8479-c7c0726bfb8e@quicinc.com>
 <ZIGihYS5EacISEFm@hovoldconsulting.com>
 <279fff8b-57e2-cfc8-cd6d-c69d00e71799@quicinc.com>
 <20230608175705.2ajrteztdeqdrkzg@synopsys.com>
 <ZILgW5CwfSlBxzNB@hovoldconsulting.com>
 <20230609181602.ljxdchgzl7kzk73n@synopsys.com>
 <acd46bb7-0708-d095-c3c6-53653f9e47d6@quicinc.com>
 <20230615210800.lvmekpvxjiszkrh4@synopsys.com>
 <ZJKo3LyIMD1xr2ru@hovoldconsulting.com>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZJKo3LyIMD1xr2ru@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: E9IEAhF4tL47Moo3iCf2rcMMLYffulG6
X-Proofpoint-GUID: E9IEAhF4tL47Moo3iCf2rcMMLYffulG6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_02,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxlogscore=659
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306220036
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/21/2023 1:08 PM, Johan Hovold wrote:
> On Thu, Jun 15, 2023 at 09:08:01PM +0000, Thinh Nguyen wrote:
>> On Thu, Jun 15, 2023, Krishna Kurapati PSSNV wrote:
> 
>>>   How about we add compatible data indicating the number of usb2/usb3 ports.
>>> That way we needn't parse the DT or read xhci registers atleast as a
>>> temporary solution to unblock other patches. Once this series is merged, we
>>> can get back to fixing the port count calculation. Does it seem fine ?
>>>
>>
>> Temporary solution should not involve DT as it's not easily reverted or
>> changed. Just include xhci-ext-caps.h and use the inline function. I
>> think Johan is fine with that. If not, he can provide more feedback.
> 
> Yes, I already suggested that as a quick way forward since it is already
> used this way by the xhci debug driver.
> 
> Johan

Hi Johan, Thinh,

  Pushed a v9 following the above suggestion.

Thanks,
Krishna,
