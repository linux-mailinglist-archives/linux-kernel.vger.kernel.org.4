Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAE66EAFEB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 18:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbjDUQ7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 12:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbjDUQ7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 12:59:05 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D8914F5F;
        Fri, 21 Apr 2023 09:58:46 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33LG2BnA018871;
        Fri, 21 Apr 2023 16:57:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=TOuREHmMT9d1Q2oXJ6E6Dcbwdn6YFtPhxYWVHby9U3I=;
 b=MAMG6aO4TfnhUJUmw8591wGrbfYrsMvUb6/2QbKAFYQx3V98VQiDtUOxSmTiql0l5G9/
 GIq5ta0eIN2MQ0TDN8XJGfUGy1PBAUEYKMIs1NRJv11y9FeFQ4D2NM58+s7zvJR/rE9e
 vSxfiCy6zs4VI3isRxxNyhO4Qyn6DbQJ2NaD/cBg+txJfYinJv4bQBz48jp7YVT3iSgB
 TssFbGSq7RWsrbySc1y1+udyEH1SZ3ts7TJFeCUeByw1GeVWvai7BUdynbk43ZmJOEih
 ENlHFctk20fQ5u1JpFxKcxIfEvdQvOtEeiNB1jdVG4AEkiYDADgzf0t62LSoMfP7YnlT 8A== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q3tmerkg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Apr 2023 16:57:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33LGvvRl015645
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Apr 2023 16:57:57 GMT
Received: from [10.216.24.183] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 21 Apr
 2023 09:57:52 -0700
Message-ID: <7a6fe89b-5898-08d3-6c44-2cfc9d8fae7a@quicinc.com>
Date:   Fri, 21 Apr 2023 22:27:49 +0530
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
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
In-Reply-To: <CAD=FV=VU9Zdk2wz=90cjmuBWxaVz9w+UxzrTtW_ny-jrwVLV3w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JlAty90BrMtuSCy19RkLBWsrvNo3AfPG
X-Proofpoint-ORIG-GUID: JlAty90BrMtuSCy19RkLBWsrvNo3AfPG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-21_08,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=896 phishscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304210148
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks a lot for the review and inputs...


On 4/20/2023 10:49 PM, Doug Anderson wrote:
> Hi,
>
> On Thu, Apr 20, 2023 at 6:13 AM Vijaya Krishna Nivarthi
> <quic_vnivarth@quicinc.com> wrote:
>> @@ -137,11 +155,29 @@ enum qspi_clocks {
>>          QSPI_NUM_CLKS
>>   };
>>
>> +enum qspi_xfer_mode {
>> +       QSPI_FIFO,
>> +       QSPI_DMA
>> +};
>> +
>> +/*
>> + * Number of entries in sgt returned from spi framework that-
>> + * will be supported. Can be modified as required.
>> + * In practice, given max_dma_len is 64KB, the number of
>> + * entries is not expected to exceed 1.
>> + */
>> +#define QSPI_MAX_SG 5
> I actually wonder if this would be more nicely done just using a
> linked list, which naturally mirrors how SGs work anyway. You'd add
> "struct list_head" to the end of "struct qspi_cmd_desc" and just store
> a pointer to the head in "struct qcom_qspi".
>
> For freeing, you can always get back the "virtual" address because
> it's just the address of each node. You can always get back the
> physical address because it's stored in "data_address".
>
Please note that in "struct qspi_cmd_desc"

data_address - dma_address of data buffer returned by spi framework

next_descriptor - dma_address of the next descriptor in chain


If we were to have a linked list of descriptors that we can parse and 
free, it would require 2 more fields

this_descriptor_dma - dma address of the current descriptor

next_descriptor_virt - virtual address of the next descriptor in chain


I tried adding same and it seemed like it was getting a little confusing.

Given the SGL is also an array in SGT, it seemed ok to retain an array, 
though it would have good to have a chain of cmd_descriptors in SW like 
in HW.

Agreed the fixed size array comes at a cost of artificial limitation of 
5 entries, which anyway seems like something we are not going to 
encounter in practice.


So for now, I retained the array.

All the other comments are addressed as recommended, except 1 change below

Please let know what you think.


Thank you,

Vijay/


>
>> +static int qcom_qspi_alloc_desc(struct qcom_qspi *ctrl, dma_addr_t dma_ptr,
>> +                       uint32_t n_bytes)
>> +{
>> +       struct qspi_cmd_desc *virt_cmd_desc, *prev;
>> +       dma_addr_t dma_cmd_desc;
>> +
>> +       /* allocate for dma cmd descriptor */
>> +       virt_cmd_desc = (struct qspi_cmd_desc *)dma_pool_alloc(ctrl->dma_cmd_pool,
>> +               GFP_KERNEL, &dma_cmd_desc);
> Remove unnecessary cast; "void *" assigns fine w/out a cast.
>
> Add "| GFP_ZERO" and then get rid of the need to clear the "reserved"
> and "next_descriptor" stuff below.
>
I needed __GFP_ZERO to prevent a compile error, used same.


