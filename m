Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242086A2790
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 07:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjBYGfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 01:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBYGfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 01:35:20 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8662F7A6;
        Fri, 24 Feb 2023 22:35:18 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31P6Nm1i016836;
        Sat, 25 Feb 2023 06:35:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=q3+CBTLERpWzCp2BafnwdrBMuoCgOVpWZrBd/AnGDY0=;
 b=UgFh5CCkmttKQlbmfo0Uq4QJaiO4zoV7WV4k7hHQkXoq4AoEkGTWkuTUfkeLx9jPlZnm
 CbCBGmvMymT1KcjoWHtIDF/fCpuwzZhlXwhCL9X6aM2X/9LIaKSmwvBYhyH5aNopgWcc
 U60QD1DNZHttugbomwKLt77WgCylwd36vJ2iHFlqUK2yGiNAAMkgn6SRejo9blye0lk0
 n9jiILJRTFHj6B8/8TpdQ29UeQJsbhtanV49A+cKakr57xl8hwBepeTtMLM42x76KdDS
 H7zqrOHT4aBcufekEJUJYqImuZ48bv5qa3zpQn6JPI6aBSfryExms5k/vq8qjnFI/fGf VQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ny81q8gdc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Feb 2023 06:35:13 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31P6ZDBa013154
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Feb 2023 06:35:13 GMT
Received: from [10.216.40.101] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 24 Feb
 2023 22:35:09 -0800
Message-ID: <3a69b51c-9e2a-2d36-27cd-2619f9e3a356@quicinc.com>
Date:   Sat, 25 Feb 2023 12:05:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 2/2] usb: gadget: composite: Draw 100mA current if not
 configured
Content-Language: en-US
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        =?UTF-8?B?SsOzIMOBZ2lsYSBCaXRzY2g=?= <jgilab@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Pratham Pratap <quic_ppratap@quicinc.com>,
        Jack Pham <quic_jackp@quicinc.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1677156121-30364-1-git-send-email-quic_prashk@quicinc.com>
 <1677156121-30364-3-git-send-email-quic_prashk@quicinc.com>
 <20230223201019.3a5njywzchztcs5e@synopsys.com>
 <3a189c0a-e82b-a80b-ac63-0f2c703b2eaa@quicinc.com>
 <20230224183830.ox65eocunuvlp7zt@synopsys.com>
From:   Prashanth K <quic_prashk@quicinc.com>
In-Reply-To: <20230224183830.ox65eocunuvlp7zt@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PYDZ-Qdwymk64WNS4cF4xebe37J9jk8f
X-Proofpoint-GUID: PYDZ-Qdwymk64WNS4cF4xebe37J9jk8f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-25_02,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=531 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302250051
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25-02-23 12:08 am, Thinh Nguyen wrote:
> On Fri, Feb 24, 2023, Prashanth K wrote:
>>
>>
>> On 24-02-23 01:40 am, Thinh Nguyen wrote:
>>> On Thu, Feb 23, 2023, Prashanth K wrote:
>>>> Currently we don't change the current value if device isn't in
>>>> configured state. But the battery charging specification says,
>>>
>>> Can you provide the spec section also?
>>>
>> 1.2 Background
>> 1.4.13 Standard Downstream Port
>>
>> Did you mean to add these in the commit message?
> 
> Yes, it's better to have the reference in case we need to revisit this.
I have added it in v4 patch, thanks for pointing it out.
> 
>>>> device can draw up to 100mA of current if its in unconfigured
>>>
>>> Is this related to being self-powered?
> 
>> I think its applicable for bus-powered devices.
> 
> No, I mean before configured state, is the device considered
> self-powered? Since being self-powered means drawing 100mA or less, we
> can use USB_SELF_POWER_VBUS_MAX_DRAW to provide more context. If it's
> totally unrelated, then you can ignore this.
> 
> Thanks,
> Thinh
As per my understanding, those are 2 different things. A self-powered 
device isn't allowed to draw more than 100mA. And an unconfigured device
isn't allowed to draw more than 100mA (in HS). One thing that I recently 
found out is that, as per usb3.0 spec, SS device can only draw up to 
150mA if its unconfigured state. So i have to check the speed and set 
the current values accordingly.

Thanks,
Prashanth K
