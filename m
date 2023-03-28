Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD0C6CBD53
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 13:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjC1LTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 07:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjC1LTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 07:19:38 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925FAAA;
        Tue, 28 Mar 2023 04:19:37 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32SAEY3o009515;
        Tue, 28 Mar 2023 11:19:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=97c3pXB/WN3ouuJ1a2KcLrV4gwtPErUklI/JNZ8pz2c=;
 b=it1ezcQWJeeyHKD8Dg56dn2bhaW58+RgXIsWT52dX6xIvXejYW36HhX6GZT0iSSuG3hh
 tuXjn7jdI/OonZqjCVxXEr+uqeF0RctRz6NT6YFuDt2x/PbMVPJ3q8iXBganxyfFBLSE
 jQChM8gLI0NBGHhZB7TbT0OfpDmSPsXW9OKvzRwoZ8sxVGBeKiK6UPug+WQJBLOyYvVz
 WfFoEjJvk6YQoDIJ3lrrRmeQcSQFyfxJYMF5k2XKFbzFPU2yiWi+Q4wrlxGyPnbLYq6A
 vcVkiwjVqz3Xi0igqN7SuPiuYbeI8Myr1BSs60VBhypQ4HQIfpmca2/Dag3C55za46Dw ww== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pkk7b9gw2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 11:19:08 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32SBJ8TQ031123
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 11:19:08 GMT
Received: from [10.216.62.255] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Mar
 2023 04:19:02 -0700
Message-ID: <80ab07f8-fd7b-da08-f92e-20b76f5cefea@quicinc.com>
Date:   Tue, 28 Mar 2023 16:48:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/5] mtd: rawnand: qcom: Add initial support for qspi nand
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Boris Brezillon <boris.brezillon@collabora.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-arm-msm@vger.kernel.org>,
        <robh+dt@kernel.org>, <vigneshr@ti.com>, <richard@nod.at>,
        <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <quic_srichara@quicinc.com>, <qpic_varada@quicinc.com>,
        <quic_sjaganat@quicinc.com>, Mark Brown <broonie@kernel.org>
References: <1602307902-16761-1-git-send-email-mdalam@codeaurora.org>
 <1602307902-16761-3-git-send-email-mdalam@codeaurora.org>
 <20201029100751.713e27df@collabora.com>
 <b70ddb40-a1f1-f967-6b7b-057a39b0bcc2@quicinc.com>
 <20230306153851.0dcdda27@xps-13>
 <745e6bd6-96a5-ceab-1f0c-31440d34e4c8@quicinc.com>
 <20230327164949.465750a0@xps-13>
From:   Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <20230327164949.465750a0@xps-13>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8tIg0m9ltrXYXbPzZheTvTd1MACtDxXu
X-Proofpoint-GUID: 8tIg0m9ltrXYXbPzZheTvTd1MACtDxXu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-28_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1011 malwarescore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303280093
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/27/2023 8:19 PM, Miquel Raynal wrote:
> Hello,
> 
> + Mark
> 
> quic_mdalam@quicinc.com wrote on Mon, 27 Mar 2023 19:24:02 +0530:
> 
>> On 3/6/2023 8:08 PM, Miquel Raynal wrote:
>>> Hello,
>>>
>>> quic_mdalam@quicinc.com wrote on Mon, 6 Mar 2023 19:45:58 +0530:
>>>    
>>>> On 10/29/2020 2:37 PM, Boris Brezillon wrote:
>>>>> Hello,
>>>>>
>>>>> On Sat, 10 Oct 2020 11:01:39 +0530
>>>>> Md Sadre Alam <mdalam@codeaurora.org> wrote:
>>>>>    >>>> This change will add initial support for qspi (serial nand).
>>>>>>
>>>>>> QPIC Version v.2.0 onwards supports serial nand as well so this
>>>>>> change will initialize all required register to enable qspi (serial
>>>>>> nand).
>>>>>>
>>>>>> This change is supporting very basic functionality of qspi nand flash.
>>>>>>
>>>>>> 1. Reset device (Reset QSPI NAND device).
>>>>>>
>>>>>> 2. Device detection (Read id QSPI NAND device).
>>>>> Unfortunately, that's not going to work in the long term. You're
>>>>> basically hacking the raw NAND framework to make SPI NANDs fit. I do
>>>>> understand the rationale behind this decision (re-using the code for
>>>>> ECC and probably other things), but that's not going to work. So I'd
>>>>> recommend doing the following instead:
>>>>>
>>>>> 1/ implement a SPI-mem controller driver
>>>>> 2/ implement an ECC engine driver so the ECC logic can be shared
>>>>>       between the SPI controller and raw NAND controller drivers
>>>>> 3/ convert the raw NAND driver to the exec_op() interface (none of
>>>>>       this hack would have been possible if the driver was using the new
>>>>>       API)
>>>>>
>>>>> Regards,
>>>>>
>>>>> Boris
>>>>>    >>      Sorry for late reply, again started working on this feature support.  The QPIC v2 on wards there is serial nand support got added , its not a standard SPI controller
>>>>
>>>>       its QPIC controller having support for serial nand. All SPI related configuration done by QPIC hardware and its not exposed as SPI bus to the external world. Only based on
>>>>
>>>>       QPIC_SPI_CFG = 1, serial functionality will get selected. So that no need to implement as SPI-mem controller driver, since its not a SPI controller.
>>>>
>>>>      Please check the below diagram for top view of QPIC controller.
>>>
>>> One of the hard things in the Linux kernel is to make devices fit
>>> frameworks. This feature does not fit the raw NAND framework. It does
>>> not follow any of the conventions taken there. It is not gonna be
>>> accepted there. You need to expose spi-mem functionalities, even if the
>>> spi-proper features are not available. I believe your situation still
>>> fits the spi-mem abstraction.
>>>
>>> Thanks,
>>> Miquèl
>>
>>
>> I have started writing the driver code for SPI NAND. Please check the below design,
>> is this fine as per Boris suggestion.
> 
> Thanks.
> 
> 
>>             |------------------------|                      |------------------------------|                        |---------------------------------|
>>             |qcom spi nand driver    |--------------------->|common ECC engine driver      |<-----------------------|qcom raw nand driver             |
>>             |                        |                      |                              |                        |                                 |
>>             |                        |                      |drivers/mtd/nand/ecc-qcom.c   |                        |drivers/mtd/nand/raw/qcom_nand.c |
>>             |                        |                      |                              |                        |                                 |
>>             |drivers/spi/spi-qpic.c  |                      |------------------------------|                        |                                 |
>>             |                        |                      |common API file:              |                        |                                 |
>>             |                        |                      |common API: reset, read id,   |                        |                                 |
>>             |                        |--------------------->|erase, read page, write page, |<-----------------------|                                 |
>>             |------------------------|                      |bad block check etc.          |                        |                                 |
>>                                                             |                              |                        |---------------------------------|
>>                                                             |drivers/mtd/nand/raw/qpic_comm|
>>                                                             |    on.c                      |
>>                                                             |------------------------------|
>>
>>
>> Here ECC engine driver as separate file under (drivers/mtd/nand/ecc-qcom.c) and all
>> common APIs like reset, read id, erase, write page, read page, check block bad etc.
> 
> I'm not sure how generic these APIs are, please try to not put anything
> raw NAND or SPI-NAND specific in the common file. I don't want to see
> "if (raw)" or "if (spi)" conditions there.

  I agree , I will not try to put any condition like if(raw) or if(spi).

  I am doing in the below sequence.

  1) exec->op() in raw nand driver

  2) Move ecc related code to new ecc engine driver under ./drivers/mtd/nand/ecc-qcom.c
     and make raw nand driver to work with this ecc engine driver.

  3) Write separate SPI-mem driver under ./drivers/spi/spi-qpic.c

  4) Move common code under qpic_common.c under ./driver/mtd/nand/raw/qpic_common.c

> 
>> as separate file under drivers/mtd/nand/raw/qpic_common.c.APIs under ECC engine drivers
>> and qpic_common.c will be exported and used by spi-qpic.c driver (Serial NAND) and qcom_nand.c
>> (raw nand driver).
> 
> On my side, I don't have a strong opinion yet but it looks good to me.
> 
> Can you confirm you are considering switching to the ->exec_op() API in
> the raw NAND driver?

   Yes, first priority is switching to ->exec_op() API in raw nand driver.
   I have already started and sent couple of patches, will address latest comment
   send again.

> 
> Thanks,
> Miquèl
