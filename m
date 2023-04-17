Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6F46E3E90
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 06:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjDQElL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 00:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjDQElB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 00:41:01 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E65BAD;
        Sun, 16 Apr 2023 21:41:00 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33H4UWGF023450;
        Mon, 17 Apr 2023 04:40:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=EN0FMN5loUlgn1vfCleo2+w2tmhm6o9jKmgdg156a4Q=;
 b=Bv4Y0uYH4hOUg/lnG8tAFGa1GlWAW+trllSB2z5IugjIhsupi9eCXng/ivfCPHstpw1e
 Pyl3bu7HUNwZ5Q4DNqL4+BtGmie/fuzxTwZiqzsy7w+LJbU72keyiGWhuL/XhvGFPL8C
 1qDtT3jN+4xhM01/rNKO/w+YPTc5LP7FiIf2XC1tOFol6q+Kps/NyctCotirc+GQgH3m
 JElBo7+qawjIUKZOJulzU42eIf8MF1iT5rm0oxSKisy5JN45Mz9kuuAt5mrRVl35GUGB
 D5JvYq3qbIHo5aaePbVloWVLxWK0IUVyKXyiSXhZpvYa+P5FhbnsGnM1iDWrpFKWnrUN fg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pymp4akbx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 04:40:55 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33H4esxs024149
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 04:40:54 GMT
Received: from [10.217.216.152] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Sun, 16 Apr
 2023 21:40:51 -0700
Message-ID: <ce6c952b-2e2b-67d9-5023-e740ed798758@quicinc.com>
Date:   Mon, 17 Apr 2023 10:10:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] clk: qcom: common: Handle invalid index error
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230303092859.22094-1-quic_tdas@quicinc.com>
 <20230303092859.22094-2-quic_tdas@quicinc.com>
 <CAA8EJpq5xBF=Wt-1_hGR-7qZHREcALurmR4ucmMmZaC-R_7Ttg@mail.gmail.com>
From:   Taniya Das <quic_tdas@quicinc.com>
In-Reply-To: <CAA8EJpq5xBF=Wt-1_hGR-7qZHREcALurmR4ucmMmZaC-R_7Ttg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NJfFyt5rPfqQVDjXd1pUl6al8DyzF4eT
X-Proofpoint-ORIG-GUID: NJfFyt5rPfqQVDjXd1pUl6al8DyzF4eT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_02,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 impostorscore=0 spamscore=0 mlxlogscore=658 lowpriorityscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304170041
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

Thanks for the comments.


On 3/3/2023 4:14 PM, Dmitry Baryshkov wrote:
> On Fri, 3 Mar 2023 at 11:30, Taniya Das <quic_tdas@quicinc.com> wrote:
>>
>> Introduce start_index to handle invalid index error
>> seen when there are two clock descriptors assigned
>> to the same clock controller.
> 
> Please provide details of the exact case that you are trying to solve
> (this might go to the cover letter). I think the commit message is
> slightly misleading here. Are you trying to add error messages or to
> prevent them from showing up?
> 

We are trying to avoid error messages from showing up.

> I'm asking because error messages do not seem to correspond to patch
> 2. You add start_index to make the kernel warn for the clock indices
> less than LPASS_AUDIO_CC_CDIV_RX_MCLK_DIV_CLK_SRC = 4, while quoted
> messages show indices 5,6,7.
> 

Right, we want the kernel to warn if the clock index is less than 
start_index, along with that we also want to handle the case where 
num_rclks is uninitialized because of same clock descriptor being 
assigned to two clock controllers.

Earlier Invalid index error was showing up for valid indices 5,6,7 
because of the simple if check(idx >= num_rclks), hence we enhanced the 
checks to handle the above case and compare the index to the start_index 
+ num_rclks, instead of simply comparing it with num_clks.

> Nit: please don't overwrap the commit message, the recommended line
> width is about 72-77 chars.
> 

Done.

>>
>> [ 3.600604] qcom_cc_clk_hw_get: invalid index 5
>> [ 3.625251] qcom_cc_clk_hw_get: invalid index 6
>> [ 3.648190] qcom_cc_clk_hw_get: invalid index 7
> 
>>
>> Fixes: 120c15528390 ("clk: qcom: Migrate to clk_hw based registration and OF APIs")
>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>> ---
>>   drivers/clk/qcom/common.c | 12 ++++++++----
>>   drivers/clk/qcom/common.h |  1 +
>>   2 files changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
>> index 75f09e6e057e..0e80535b61f2 100644
>> --- a/drivers/clk/qcom/common.c
>> +++ b/drivers/clk/qcom/common.c
>> @@ -21,6 +21,7 @@ struct qcom_cc {
>>          struct qcom_reset_controller reset;
>>          struct clk_regmap **rclks;
>>          size_t num_rclks;
>> +       u32 rclks_start_index;
>>   };
>>
>>   const
>> @@ -226,12 +227,13 @@ static struct clk_hw *qcom_cc_clk_hw_get(struct of_phandle_args *clkspec,
>>          struct qcom_cc *cc = data;
>>          unsigned int idx = clkspec->args[0];
>>
>> -       if (idx >= cc->num_rclks) {
>> +       if (idx >= cc->rclks_start_index && idx < cc->num_rclks)
>> +               return cc->rclks[idx] ? &cc->rclks[idx]->hw : NULL;
>> +       else if (idx < cc->rclks_start_index && idx >= cc->num_rclks)
>>                  pr_err("%s: invalid index %u\n", __func__, idx);
>> -               return ERR_PTR(-EINVAL);
>> -       }
>>
>> -       return cc->rclks[idx] ? &cc->rclks[idx]->hw : NULL;
>> +       return ERR_PTR(-EINVAL);
>> +
>>   }
>>
>>   int qcom_cc_really_probe(struct platform_device *pdev,
>> @@ -281,6 +283,8 @@ int qcom_cc_really_probe(struct platform_device *pdev,
>>
>>          cc->rclks = rclks;
>>          cc->num_rclks = num_clks;
>> +       if (desc->start_index)
>> +               cc->rclks_start_index = desc->start_index;
>>
>>          qcom_cc_drop_protected(dev, cc);
>>
>> diff --git a/drivers/clk/qcom/common.h b/drivers/clk/qcom/common.h
>> index 9c8f7b798d9f..924f36af55b3 100644
>> --- a/drivers/clk/qcom/common.h
>> +++ b/drivers/clk/qcom/common.h
>> @@ -23,6 +23,7 @@ struct qcom_cc_desc {
>>          const struct regmap_config *config;
>>          struct clk_regmap **clks;
>>          size_t num_clks;
>> +       u32 start_index;
>>          const struct qcom_reset_map *resets;
>>          size_t num_resets;
>>          struct gdsc **gdscs;
>> --
>> 2.17.1
>>
> 
> 
> --
> With best wishes
> 
> 
> 
> Dmitry

-- 
Thanks & Regards,
Taniya Das.
