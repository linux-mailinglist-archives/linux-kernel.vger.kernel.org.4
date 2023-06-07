Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A824B726A2D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 21:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbjFGTvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 15:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjFGTv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 15:51:29 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB421BEF;
        Wed,  7 Jun 2023 12:51:28 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357JJQBg029061;
        Wed, 7 Jun 2023 19:51:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=MyBe12xlukVDy21RV8mGvzxBCep4BCefuMYAHQJmVTA=;
 b=erT+YlfWAvAso0poGql0wbYfGzp55tNqeAswL0ZN3Sh1dmus7+is+zxWoxuMDjyAyrvM
 iDiPBrWObbvQjFs9PQMW/C6h9IyroAztxaMdxEbCA2nXSHMUHRl/A4kSdf6I72Cv9ljq
 upAnEKz1ZTXKISq8IJTDAuVqfhHRzVFxpMWrEpI8UIQqW4B5wHaF0HFjjj+zf+StVudl
 4PY9HW+qP1kxwbdCbdAaVaAS/K7P9FtPkrXdlmjvqXIo/YI8ZRsVg0xFgIfK440Bt0ud
 wgppbM7o8pqC+WqLz5hq06HXdD/qbFAs0iSODV2z2twRoO1JSK+wGQWhnec0wRrR7oP3 KQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r2a71au0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jun 2023 19:51:16 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 357JpD6D003593
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 7 Jun 2023 19:51:13 GMT
Received: from [10.216.57.240] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 7 Jun 2023
 12:51:06 -0700
Message-ID: <99cded6f-6a71-ffce-8479-c7c0726bfb8e@quicinc.com>
Date:   Thu, 8 Jun 2023 01:21:02 +0530
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
 <bc347624-4539-4a3a-9399-9b4e272cdb32@quicinc.com>
 <ZGUCykpDFt9zgeTU@hovoldconsulting.com>
 <82553597-ce0e-48f4-44d4-9eeaaf4cb1c4@quicinc.com>
 <ZIBsDQJtgDZRe7MG@hovoldconsulting.com>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZIBsDQJtgDZRe7MG@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SMXrvb58mo55Ql3-t1vKI85-JROj7oCV
X-Proofpoint-ORIG-GUID: SMXrvb58mo55Ql3-t1vKI85-JROj7oCV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_10,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 malwarescore=0
 clxscore=1011 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306070172
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/7/2023 5:07 PM, Johan Hovold wrote:
> Hi Krishna,
> 
> and sorry about the delay in following up on this. As usual, there are
> just way too many threads and this one in particular requires a bit of
> thought.
> 
Hi Johan,

   Thanks for taking the time out and reviewing the patches again.

> On Sat, May 20, 2023 at 11:18:52PM +0530, Krishna Kurapati PSSNV wrote:
>> On 5/17/2023 10:07 PM, Johan Hovold wrote:
> 
>>> I don't think we should be adding more of these layering violations. A
>>> parent device driver has no business messing with the driver data for a
>>> child device which may or may not even have probed yet.
>>>
>>> I added a FIXME elsewhere in the driver about fixing up the current
>>> instances that have already snuck in (which in some sense is even worse
>>> by accessing driver data of a grandchild device).
>>>
>>> We really need to try sort this mess out and how to properly handle the
>>> interactions between these layers (e.g. glue, dwc3 core and xhci). This
>>> will likely involve adding callbacks from the child to the parent, for
>>> example, when the child is suspending.
> 
>>    I agree with you, but in this case I believe there is no other way we
>> can find the number of ports present. Unless its a dt property which
>> parent driver can access the child's of node and get the details. Like
>> done in v4 [1]. But it would be adding redundant data into DT as pointed
>> out by Rob and Krzysztof and so we removed these properties.
> 
> So there at least two issues with this series:
> 
> 	1. accessing xhci registers from the dwc3 core
> 	2. accessing driver data of a child device
> 
> 1. The first part about accessing xhci registers goes against the clear
> separation between glue, core and xhci that Felipe tried to maintain.
> 
> I'm not entirely against doing this from the core driver before
> registering the xhci platform device as the registers are unmapped
> afterwards. But if this is to be allowed, then the implementation should
> be shared with xhci rather than copied verbatim.
> 
> The alternative that avoids this issue entirely could indeed be to
> simply count the number of PHYs described in DT as Rob initially
> suggested. Why would that not work?
> 
The reason why I didn't want to read the Phy's from DT is explained in 
[1]. I felt it makes the code unreadable and its very tricky to read the 
phy's properly, so we decided we would initialize phy's for all ports 
and if a phy is missing in DT, the corresponding member in 
dwc->usbX_generic_phy[] would be NULL and any phy op on it would be a NOP.

Also as per Krzysztof suggestion on [2], we can add a compatible to read 
number of phy's / ports present. This avoids accessing xhci members 
atleast in driver core. But the layering violations would still be present.

> 2. The driver is already accessing driver data of the child device so
> arguably your series is not really making things much worse than they
> already are.
> 
> I've just sent a couple of fixes to address some of the symptoms of
> this layering violation here:
> 
> 	https://lore.kernel.org/lkml/20230607100540.31045-1-johan+linaro@kernel.org/
>

  As you pointed out offline to me that using xhci event notifiers I 
mentioned on [3], if it is not acceptable to use them as notifications 
to check whether we are in host mode, I believe the only way would be to 
use the patches you pushed in.

> Getting this fixed properly is going to take a bit of work, and
> depending on how your multiport wake up implementation is going to look
> like, adding support for multiport controllers may not make this much
> harder to address.
> 
> So perhaps we can indeed merge support for multiport and then get back
> to cleaning this up.
So, you are referring to use the patches you pushed today as a partial 
way to cleanup layering violations and merge multiport on top of it ? If 
so, I am fine with it. I can rebase my changes on top of them.

[1]: 
https://lore.kernel.org/all/4eb26a54-148b-942f-01c6-64e66541de8b@quicinc.com/
[2]: 
https://lore.kernel.org/all/ca729f62-672e-d3de-4069-e2205c97e7d8@linaro.org/
[3]: 
https://lore.kernel.org/all/37fd026e-ecb1-3584-19f3-f8c1e5a9d20a@quicinc.com/

Regards,
Krishna,
