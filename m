Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DFA74CDE4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 09:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjGJHEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 03:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbjGJHEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:04:44 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD28EB;
        Mon, 10 Jul 2023 00:04:43 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36A6II3a032380;
        Mon, 10 Jul 2023 07:04:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=eLB1OtlGXj8/CYnnrkGRgRz9H4dX9cEB2sKFebmizG0=;
 b=Nj7LsZnVjQ/+8+Bd1nB46poWsOIkfJ58xgZ5fupJzw/v9jx8lMBqxhk+kaO9ZdiW9HFz
 XvlXCSLSy3Fr7gm6fi3Jmab3ut9rucgVF7YfbO/GjcRMfKTGaPYdAjHCT1ctjPqQvLPP
 93WJlaML67rjEvXnHI/KGR7hIfeNpQqw/kXbskbScUIJYeh99noNUdyqrT6IB/2U2AQ+
 N9uSLufQVw0NGm7Z4GTspf2jqmNAkK0INUs4UDPSmb1XxwvpGD8buSjjX3YMz8CK2cfg
 evisugQmZT60q9tFLpIN/uP71v1PyCpX/+eSq9UUjwp3MzHCJN7wMQkTbbrt/djxdzcC PQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rpwgm2vbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 07:04:30 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36A746Wk017443
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 07:04:06 GMT
Received: from [10.50.37.218] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 10 Jul
 2023 00:04:02 -0700
Message-ID: <8dbd10c4-a91a-df1b-64c4-f96b9eca3f1c@quicinc.com>
Date:   Mon, 10 Jul 2023 12:33:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] media: venus: core: Set up secure memory ranges for
 SC7180
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     Marijn Suijten <marijn.suijten@somainline.org>,
        Nikita Travkin <nikita@trvn.ru>, <linux-media@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230616-topic-sc7180_venus_lawp-v1-1-15a8f44d474e@linaro.org>
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
In-Reply-To: <20230616-topic-sc7180_venus_lawp-v1-1-15a8f44d474e@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YTicSOdzJRocoCJ3t6FPMBn9Qw-N2aQ2
X-Proofpoint-ORIG-GUID: YTicSOdzJRocoCJ3t6FPMBn9Qw-N2aQ2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_04,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307100065
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/16/2023 5:06 AM, Konrad Dybcio wrote:
> Not all SC7180 devices ship with ChromeOS firmware. WoA devices use
> Android-like TZ, which uses PAS for image authentication. That requires
> the predefined virtual address ranges to be passed via scm calls.
> Define them to enable Venus on non-CrOS SC7180 devices.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Vikash Garodia <quic_vgarodia@quicinc.com>

> ---
>  drivers/media/platform/qcom/venus/core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> index 2ae867cb4c48..bee1b4c98060 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -760,6 +760,10 @@ static const struct venus_resources sc7180_res = {
>  	.vmem_size = 0,
>  	.vmem_addr = 0,
>  	.dma_mask = 0xe0000000 - 1,
> +	.cp_start = 0,
> +	.cp_size = 0x70800000,
> +	.cp_nonpixel_start = 0x1000000,
> +	.cp_nonpixel_size = 0x24800000,
>  	.fwname = "qcom/venus-5.4/venus.mdt",
>  };
>  
> 
> ---
> base-commit: 925294c9aa184801cc0a451b69a18dd0fe7d847d
> change-id: 20230616-topic-sc7180_venus_lawp-965e5fd18c7a
> 
> Best regards,
