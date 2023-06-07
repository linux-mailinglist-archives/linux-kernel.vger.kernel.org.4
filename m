Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991B8726A35
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 21:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjFGTzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 15:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjFGTzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 15:55:53 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B0111A;
        Wed,  7 Jun 2023 12:55:51 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357Jcn0f027806;
        Wed, 7 Jun 2023 19:55:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=zYnkk6rfdEFQh2yitNyYzT1Hcvi6eRKpKuWIs9uYX4c=;
 b=JLQIwLTlcMUDa/7ai3tpCX+U2S2LklqIqR3vH0/g0pOfJubaUFFq+O/fxESgKLGr17CP
 LXyPMisMIa4jH3icL8DhPUTPmJudHiCrD74Ji0PV6SKaIcKGCcW7Dw8woNjZ4KCvZf+/
 LVJO+Ij2ybgEVpTqiDt7/vqEyngGWkFRiCX4JS3wZGUErO42TmF4R0lNTKhkarObCJSZ
 157DtTw9WA44WkG3cDxluMRmUjyGxeAwuMxE6nqut99Bk6xPcpUDFZEf3yO0G3xc3bL/
 VU0NCTW0e6u/QEXQ9HMtyVOzpfn26pcBjDrLJRPGwyjYaUYCVt7l3/r8KBTYlUL/BYW5 0A== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r2rbth6n5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jun 2023 19:55:42 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 357JteFt003724
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 7 Jun 2023 19:55:40 GMT
Received: from [10.216.57.240] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 7 Jun 2023
 12:55:32 -0700
Message-ID: <3010d855-86b0-f87a-5eb7-85204be9b4b0@quicinc.com>
Date:   Thu, 8 Jun 2023 01:25:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH v8 6/9] usb: dwc3: qcom: Add multiport controller support
 for qcom wrapper
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>, <quic_wcheng@quicinc.com>,
        <quic_jackp@quicinc.com>, <quic_harshq@quicinc.com>,
        <ahalaney@redhat.com>
References: <20230514054917.21318-1-quic_kriskura@quicinc.com>
 <20230514054917.21318-7-quic_kriskura@quicinc.com>
 <20230515222730.7snn2i33gkg6ctd2@ripper>
 <20230526025554.ni527gsr2bqxadl3@ripper>
 <37fd026e-ecb1-3584-19f3-f8c1e5a9d20a@quicinc.com>
 <ZIBtnPp0oV6_GFFk@hovoldconsulting.com>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZIBtnPp0oV6_GFFk@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9smbBK24iUOq0l7o4f8vb29_VzCFTRnr
X-Proofpoint-ORIG-GUID: 9smbBK24iUOq0l7o4f8vb29_VzCFTRnr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_11,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxlogscore=799 spamscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306070172
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/7/2023 5:14 PM, Johan Hovold wrote:
> On Fri, May 26, 2023 at 08:55:22PM +0530, Krishna Kurapati PSSNV wrote:
>> On 5/26/2023 8:25 AM, Bjorn Andersson wrote:
> 
>>> We need to fix the dwc3 glue design, so that the glue and the core can
>>> cooperate - and we have a few other use cases where this is needed (e.g.
>>> usb_role_switch propagation to the glue code).
> 
>>     Thanks for the comments on this patch. I had some suggestions come in
>> from the team internally:
>>
>> 1. To use the notifier call available in drivers/usb/core/notify.c and
>> make sure that host mode is enabled. That way we can access dwc or xhci
>> without any issue.
> 
> I don't think this is a good idea and instead the callbacks should be
> dedicated for the xhci and dwc3 drivers. A struct with callbacks can be
> passed down to the child devices, which call back into the drivers of
> their parents for notifications and when they need services from them
> (e.g. during suspend or on role changes).
> 
Hi Johan,

   While I agree with you that these notifications are to be used during 
role switch or suspend/resume, there is no restriction on using them for 
checking whether we are in host mode or not. IMO, it would be cleaner as 
we won't be dereferencing dwc driver data at all to check if we are in 
host mode or not.

Regards,
Krishna,

>> 2. For this particular case where we are trying to get info on number of
>> ports present (dwc->num_usb2_ports), we can add compatible data for
>> sc8280-mp and provide input to driver telling num ports is 4.
> 
> That may also work as a way to avoid parsing the xhci registers, but I'm
> still not sure why simply counting the PHYs in DT would not work.
> 
> Johan
