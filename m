Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3C66EC8E2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 11:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjDXJbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 05:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbjDXJbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 05:31:04 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51F4E7C;
        Mon, 24 Apr 2023 02:31:02 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33O80CCj002972;
        Mon, 24 Apr 2023 09:30:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=m/vlJIwgcDRqGwZGO7V4IR6/U4z/JyFTXt8KY/WbwaE=;
 b=GAfu3WFCvVFpSJd615x721eDIn15OZG1pYuMoJDouwl1WjSFJ9jca5q+rmXCjTEYm+0i
 4tNhEIuD6RptyE+azyIAiT9RVdA82LpDvGmqpEMU+coyyYxGT71JmQr5exnsXOMiHYFQ
 YnYZPculsqvY7YQxWdIL1VePKw3kF5I5OCYp4RQQu3lzH9EMrdX93gMl1pvF5wSyeSSX
 k2gHNrlDF/wFwzn+ECKNbJHS/8H/dAlzstAK8uANKmpE73+4B+Jo/KXQM7nstWroQ23G
 x6nWpanXXUoAkZBBUJNXK5qukPm7pFbG8UWGEiTbpoRNvfyAwHspIUNgKxu17CR0tCM9 VA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q48bxu05f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 09:30:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33O9UvWV010282
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 09:30:57 GMT
Received: from [10.216.19.242] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 24 Apr
 2023 02:30:52 -0700
Message-ID: <7af39e18-dafe-b013-5e2d-ea33dd27cf17@quicinc.com>
Date:   Mon, 24 Apr 2023 15:00:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 5/5] spi: spi-qcom-qspi: Add DMA mode support
Content-Language: en-CA
To:     Doug Anderson <dianders@chromium.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_msavaliy@quicinc.com>, <mka@chromium.org>,
        <swboyd@chromium.org>, <quic_vtanuku@quicinc.com>
References: <1681996394-13099-1-git-send-email-quic_vnivarth@quicinc.com>
 <1681996394-13099-6-git-send-email-quic_vnivarth@quicinc.com>
 <CAD=FV=VU9Zdk2wz=90cjmuBWxaVz9w+UxzrTtW_ny-jrwVLV3w@mail.gmail.com>
 <7a6fe89b-5898-08d3-6c44-2cfc9d8fae7a@quicinc.com>
 <CAD=FV=U_7t4H9nXy6Ku49qLqbhZ02K-_XQv_Ssgkp26s3LyDMw@mail.gmail.com>
 <166aa490-f217-7dd8-0152-1d216deb2805@quicinc.com>
 <CAD=FV=Wt2VWSkSq2FzbtXBrkS06hwizkKMjkgwgKFqAHmcmyNQ@mail.gmail.com>
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
In-Reply-To: <CAD=FV=Wt2VWSkSq2FzbtXBrkS06hwizkKMjkgwgKFqAHmcmyNQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3z2yjRHxCDWFtM3LRnAtVPFqG0yURjFY
X-Proofpoint-ORIG-GUID: 3z2yjRHxCDWFtM3LRnAtVPFqG0yURjFY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-24_06,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=897 adultscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304240085
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you very much for the review and all the inputs...


On 4/22/2023 1:28 AM, Doug Anderson wrote:
> On Fri, Apr 21, 2023 at 11:21 AM Vijaya Krishna Nivarthi
> <quic_vnivarth@quicinc.com> wrote:
>>>> If we were to have a linked list of descriptors that we can parse and
>>>> free, it would require 2 more fields
>>>>
>>>> this_descriptor_dma - dma address of the current descriptor
>>> Isn't that exactly the same value as "data_address"? Sure,
>>> "data_address" is a u32 and the DMA address is 64-bits, but elsewhere
>>> in the code you already rely on the fact that the upper bits of the
>>> DMA address are 0 when you do:
>>
>> No; data_address is the dma_address mapped to the xfer buffer.
>>
>> This is provided by spi framework and retrieved from sgl.
>>
>> "this_descriptor" would be the dma_address of the current cmd_descriptor.
>>
>> this is returned from dma_pool_alloc()
>>
>> this would be required for freeing.
> Oh! Of course, that's right. So you are correct, you'd need to add
> "this_descriptor_dma", but not the virtual address since that would be
> the same as the address of the structure via the list_node_t. I guess
> I won't insist on using a linked list even though it seems more
> elegant to me. In the very least it should fall back to PIO if the
> array isn't enough and if we need to change it later we always can.
>
> -Doug


Retained the array, addressed all other comments and uploaded v5.

Conditional can_dma() and clearing interrupts in handle_err(), I thought 
were particularly helpful as they were potential problems later.

test script was very useful too.

Thank you.


