Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2DF7298B0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 13:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239619AbjFILv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 07:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239171AbjFILvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 07:51:35 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F2D3AB6;
        Fri,  9 Jun 2023 04:51:02 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 359Bd2o1000758;
        Fri, 9 Jun 2023 11:50:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=NPhbozQU0wdDU6eIZ+1Q8MK7nTo18UT8EOjcVwsE9UE=;
 b=Z9X+8wGQ/AjPV806roo6eWh2YxUhpi15Dh7KMHdtPWlxKmemIFZQb+LeQajof0F3owKz
 6jypQ43Z1IE+/Uq6pHr4I7+TtcgT0LuOxRS+iLyN6rmE0fMCCY5wKpy5THepzu17LDBF
 0X/xQN/TD2fi7nPtHZWeHQ7s8mYbKPnpMUoWApTrl84KgZcS0ByS+5kd3on4kiaSI0RQ
 HNtWpm3yT2LCdZ43SDfgTRILY7hBRDRiLkCePDZ5GzPRhDEdRQ9/1OiVlpMwzXq2WQj4
 +10HP1smZgbN/2ufw69e3CXJFwIDMpJHqTE945TqcdAlewcc4v7YINYQSSLU9W14hKvG Wg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r43d480hv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 11:50:59 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 359BopVR006490
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Jun 2023 11:50:51 GMT
Received: from [10.218.22.90] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 9 Jun 2023
 04:50:44 -0700
Message-ID: <a818de04-ca30-f4fb-4c69-fd172b96f816@quicinc.com>
Date:   Fri, 9 Jun 2023 17:20:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH V3 4/5] clk: qcom: camcc-sm8550: Add support for qdss,
 sleep and xo clocks
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
References: <20230601143430.5595-1-quic_jkona@quicinc.com>
 <20230601143430.5595-5-quic_jkona@quicinc.com>
 <ee48f7fd-35f1-288f-2133-1c473e8804ab@linaro.org>
From:   Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <ee48f7fd-35f1-288f-2133-1c473e8804ab@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8XLIQubghEBVJ88io84yqyiA9tY5_ihT
X-Proofpoint-GUID: 8XLIQubghEBVJ88io84yqyiA9tY5_ihT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_08,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=825 clxscore=1015 adultscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306090100
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

Thanks for your review!

On 6/1/2023 8:23 PM, Dmitry Baryshkov wrote:
> On 01/06/2023 17:34, Jagadeesh Kona wrote:
>> Add support for camera qdss, sleep and xo clocks.
>>
>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> 
> You probably missed the Co-developed-by tag.
>

Yes, will add in the next series.

>> ---
>> Changes since V2:
>>   - No changes.
>> Changes since V1:
>>   - Newly added.
>>
>>   drivers/clk/qcom/camcc-sm8550.c | 180 ++++++++++++++++++++++++++++++++
>>   1 file changed, 180 insertions(+)
> 
> 

Thanks & Regards,
Jagadeesh
