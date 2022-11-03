Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB429618B20
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 23:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbiKCWIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 18:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiKCWIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 18:08:05 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45C121E36;
        Thu,  3 Nov 2022 15:08:03 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A3LfvN7021100;
        Thu, 3 Nov 2022 22:07:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0Q4UYJo0r4CAvLo84TRF+qOpG8p4iPvKnthKy/ejt7k=;
 b=RlcfmzbFyO9u35F10nQ6EgqBj45EHHMPr/a1igEh8DGR+qO0bXKgrQlbSQBS8wuhvHoy
 qwkndz98dqyfJTDt99rwTjOwIJ/g+konDnvEkbm/JhzJVk58Uil6SZfCBUAeP0z5y0vX
 0WjevBkC/FWUkS4mHfJpgXLX1YwrEknAobUtlHzP+1x/EPp9AlrAg6csYWFlKz/oXEBQ
 fmfKSRD548oLvKqKMvo2GApMvDbqGyq5UX/CcL+EjrMOOddRSBXZHXUXY4srtJm9eXAQ
 Cq9f8ZBX1bxMkzAZNA9vmCPzVbOMlhKOoHPAWNfGt39MzD4xteq6EJlX24VoTQG1XFFR tQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kmhuerpqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 22:07:47 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A3M7kmK009283
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 3 Nov 2022 22:07:46 GMT
Received: from [10.110.42.219] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 3 Nov 2022
 15:07:45 -0700
Message-ID: <032eeabb-28a5-9568-6aee-5631acb72a7b@quicinc.com>
Date:   Thu, 3 Nov 2022 15:07:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v6 10/21] gunyah: rsc_mgr: Add resource manager RPC core
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Will Deacon" <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Kalle Valo <kvalo@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221026185846.3983888-1-quic_eberman@quicinc.com>
 <20221026185846.3983888-11-quic_eberman@quicinc.com>
 <Y2FfKCKZ3N8rOqcT@kroah.com>
 <3d2858fe-ea3e-159c-faff-5052cba1e08c@quicinc.com>
 <Y2Hbl4y9Hioybxmq@kroah.com>
 <28eaa4bd-a9ee-c415-57c4-a9a56ffeef18@quicinc.com>
 <Y2MJ43oVYfNgBZsQ@kroah.com>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <Y2MJ43oVYfNgBZsQ@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1-FvWOgjVbh2h8A49qQZ54Ga2lNccyoG
X-Proofpoint-ORIG-GUID: 1-FvWOgjVbh2h8A49qQZ54Ga2lNccyoG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_04,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=751 priorityscore=1501
 phishscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211030151
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/2/2022 5:22 PM, Greg Kroah-Hartman wrote:
> On Wed, Nov 02, 2022 at 11:04:45AM -0700, Elliot Berman wrote:
>>>>>> +/* Resource Manager Header */
>>>>>> +struct gh_rm_rpc_hdr {
>>>>>> +	u8 version : 4, hdr_words : 4;
>>>>>> +	u8 type : 2, fragments : 6;
>>>>>
>>>>> Ick, that's hard to read.  One variable per line please?
>>>>
>>>> Ack.
>>>>
>>>>> And why the bit packed stuff?  Are you sure this is the way to do this?
>>>>> Why not use a bitmask instead?
>>>>>
>>>>
>>>> I felt bit packed implementation is cleaner and easier to map to
>>>> understanding what the fields are used for.
>>>
>>> Ah, so this isn't what is on the "wire", then don't use a bitfield like
>>> this, use a real variable and that will be faster and simpler to
>>> understand.
>>>
>>
>> This is what's on the "wire". Whether I use bitfield or bit packed would be
>> functionally the same and is just a cosmetic change IMO.
> 
> Ah, that wasn't obvious at all.
> 
> Usually using bitfields like this for "wire" protocols is not a good
> idea (endian issues and all of that.)  Please use a bitmask instead, as
> that way you know exactly what is happening, and the compiler can
> usually generate much better code overall.
> 
> And as this is on the wire, please specify the endian values, _AND_ use
> the proper kernel types for stuff that goes between user/kernel or
> kernel/hardware, as you are not doing that here.

Ack
