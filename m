Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A46718731
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 18:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjEaQSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 12:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjEaQSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 12:18:03 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D0CE2;
        Wed, 31 May 2023 09:18:02 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VBUmvC006564;
        Wed, 31 May 2023 16:17:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Qh2GGerr2d0RNJC2IMcfWBoUYTAUMgGeuDdnmlkrO9w=;
 b=RFM6Mb+WToorNfBoBUZuo8PsSkw6sM3LOhm1egNAQrmVuPVCgvwYbC0SNZJ7PMaq9/qH
 6EldkZvGJ2Y7hEHRZCeOOXGAhC0klU5tuq0zkflmP26Y6DDSCydb9UtjiUbf4M7qsnc9
 SfALWzWzm8VV1znmULIsRy98Hrr2/egaZL4R3MBG6hfx73FyUlT/6Gis4VklOdJz2Ifx
 hJYrd9TdBu0VxfO5xAom4xIC2/viHuWC9uNj+pYqF/nV7tfshX1wECkdReVpyDKFEyOM
 m+Bx1hoyoajFehF65/QbRxmYP7PhiM/p96X9R08FaYKAqeAS8fynC6mhGHf65U0X/7sH +g== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qwx8q9q1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 16:17:48 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34VGHkxK028336
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 16:17:46 GMT
Received: from [10.110.116.41] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 31 May
 2023 09:17:46 -0700
Message-ID: <2be5948e-c3ea-9baa-7fd4-9fb4527a0988@quicinc.com>
Date:   Wed, 31 May 2023 09:17:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V23 2/3] misc: dcc: Add driver support for Data Capture
 and Compare unit(DCC)
Content-Language: en-US
From:   Trilok Soni <quic_tsoni@quicinc.com>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Alex Elder <elder@ieee.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <cover.1683265984.git.quic_schowdhu@quicinc.com>
 <2259ab0348282349e88905ea99bcb4aa815d941f.1683265984.git.quic_schowdhu@quicinc.com>
 <6b3b33c1-0186-3a3f-0d6a-03bf0725fb73@quicinc.com>
In-Reply-To: <6b3b33c1-0186-3a3f-0d6a-03bf0725fb73@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0GB1IK3npKJo9Or1Eusavv7WXbwON4Sb
X-Proofpoint-GUID: 0GB1IK3npKJo9Or1Eusavv7WXbwON4Sb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_11,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 mlxlogscore=956 adultscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305310139
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/2023 10:10 PM, Trilok Soni wrote:
> On 5/4/2023 11:36 PM, Souradeep Chowdhury wrote:
>> The DCC is a DMA Engine designed to capture and store data during system
>> crash or software triggers. The DCC operates based on user inputs via
>> the debugfs interface. The user gives addresses as inputs and these
>> addresses are stored in the dcc sram. In case of a system crash or a
>> manual software trigger by the user through the debugfs interface, the
>> dcc captures and stores the values at these addresses. This patch
>> contains the driver which has all the methods pertaining to the debugfs
>> interface, auxiliary functions to support all the four fundamental
>> operations of dcc namely read, write, read/modify/write and loop. The
>> probe method here instantiates all the resources necessary for dcc to
>> operate mainly the dedicated dcc sram where it stores the values. The
>> DCC driver can be used for debugging purposes without going for a reboot
>> since it can perform software triggers as well based on user inputs.
>>
>> Also update the documentation for debugfs entries which explains the
>> functionalities of each debugfs file that has been created for dcc.
>> Update the documentation to reflect new module name for dcc.
>>
>> The following is the justification of using debugfs interface over the
>> other alternatives like sysfs/ioctls
>>
>> i) As can be seen from the debugfs attribute descriptions, some of the
>> debugfs attribute files here contains multiple arguments which needs to
>> be accepted from the user. This goes against the design style of sysfs.
>>
>> ii) The user input patterns have been made simple and convenient in this
>> case with the use of debugfs interface as user doesn't need to shuffle
>> between different files to execute one instruction as was the case on
>> using other alternatives.
>>
>> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> Reviewed-by: Alex Elder <elder@linaro.org>
> 
> 
> Bjorn, do you have any remaining comments here? Are you going to provide 
>   your Reviewed-by here and other patches?
> 
> If there are no comments then I would like this series to be picked by 
> the maintainer you suggest.
> 

Gentle reminder again here. I would like to make some progress on DCC 
discussion here. Is it ready to be picked up by Bjorn or Arnd?

---Trilok Soni
