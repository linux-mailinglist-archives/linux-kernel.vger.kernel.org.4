Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894E168238C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 05:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjAaEwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 23:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjAaEwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 23:52:35 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646B0CA0D;
        Mon, 30 Jan 2023 20:52:33 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30V2tUb6014894;
        Tue, 31 Jan 2023 04:52:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=awNgFRVp8lSxLrOJJUbczcUtxqgim8oex5qs0NUrYlc=;
 b=HbaPJjJlJK9cIq12Ak959Yryw+knB/BCnZAkaiJMfr4Pv0YI2ub+mPFSsJAveoEtMdJD
 GckupzK0SdNW+yVL3ngBYkWIvj6AVZPRQ5jgUF4vBB9GWOqoV44TXIyKNNl8xthHqi9b
 Lt0DidIu/dppvdHucwd7nYf1j51W1KAhJE6DOq14xSYXrnq75KnLAOY/e5qj5oZRZDLn
 Ml95IBxpApF0w+iuNtL3+4Ho+f/ryjeFCNaQ9D9lZdjFfETTv+Za14WX1hDinlgBhWAh
 brr92IJq0KlXaJaBqotQjReUGnYmcXG4tOCvASWXiIsmmxX4Hb44rl/49FqsLVnMqqM5 Zg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncsdpwjmq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 04:52:29 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30V4qS99012120
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 04:52:28 GMT
Received: from [10.50.4.92] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 30 Jan
 2023 20:52:25 -0800
Message-ID: <99c91609-61ce-fa30-96b1-ba45e9fe1e1e@quicinc.com>
Date:   Tue, 31 Jan 2023 10:22:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH V5] clk: qcom: clk-alpha-pll: Add support for Stromer PLLs
To:     Stephen Boyd <sboyd@kernel.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mturquette@baylibre.com>
CC:     Varadarajan Narayanan <quic_varada@quicinc.com>,
        Sricharan R <quic_srichara@quicinc.com>
References: <20230120082631.22053-1-quic_kathirav@quicinc.com>
 <2987f2ce9377bd17d1cd85fce4bd3c28.sboyd@kernel.org>
Content-Language: en-US
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <2987f2ce9377bd17d1cd85fce4bd3c28.sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gE-cOFG_4Zp0Ag0GGlkUZwTgc3dNmcuP
X-Proofpoint-ORIG-GUID: gE-cOFG_4Zp0Ag0GGlkUZwTgc3dNmcuP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_02,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 mlxlogscore=737
 spamscore=0 clxscore=1015 impostorscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301310043
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/26/2023 2:59 AM, Stephen Boyd wrote:
> Quoting Kathiravan Thirumoorthy (2023-01-20 00:26:31)
>> From: Varadarajan Narayanan <quic_varada@quicinc.com>
>>
>> Add programming sequence support for managing the Stromer
>> PLLs.
>>
>> Co-developed-by: Sricharan R <quic_srichara@quicinc.com>
>> Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
>> ---
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>

Thanks Stephen. Bjorn, is it possible to pick up this patch for v6.3?

Thanks, Kathiravan T.

