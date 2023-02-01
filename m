Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E02686887
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 15:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbjBAOlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 09:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjBAOlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 09:41:07 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255B3C67C;
        Wed,  1 Feb 2023 06:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1675262466; x=1706798466;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FP3eOSKVuO2pSoDoClWW9jU0h8Pdb0AyhKyqyRnXwSc=;
  b=r1T9jDiSeP+TS1u56fv3ezZqx1ENuC7DNwTe7BQQbPm5wVcohBBNZX6Y
   AnTXmygQqCPj/h/FDmCclnD12WPWfLTyYPKxRqGLNsagjHH77fIBfjQXk
   H4ZJ8rJS98Ifn8HzU/tEMax1Slgh5GjMuIYv46IgYSI0A8ikbk182hG2k
   U=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 01 Feb 2023 06:41:05 -0800
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 06:41:05 -0800
Received: from [10.50.40.201] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 1 Feb 2023
 06:40:56 -0800
Message-ID: <f21b74b2-cdaf-1be1-17e7-d004bfdddedd@quicinc.com>
Date:   Wed, 1 Feb 2023 20:10:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 6/6] clk: qcom: Fix APSS PLL and RCG Configuration
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <jassisinghbrar@gmail.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <shawnguo@kernel.org>, <arnd@arndb.de>,
        <marcel.ziswiler@toradex.com>, <nfraprado@collabora.com>,
        <broonie@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>
References: <20230113143647.14961-1-quic_devipriy@quicinc.com>
 <20230113143647.14961-7-quic_devipriy@quicinc.com>
 <b87ab80d-0936-5a5a-25da-35c0dbdede33@linaro.org>
 <ea0dbbf0-958c-145b-abaa-3bbcb620df5c@quicinc.com>
 <b8eee15f-e3e4-4a2d-853e-31e966c19cf5@linaro.org>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <b8eee15f-e3e4-4a2d-853e-31e966c19cf5@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/31/2023 3:10 PM, Dmitry Baryshkov wrote:
> On 31/01/2023 11:17, Devi Priya wrote:
>> Thanks for taking time to review the patch
>>
>> On 1/13/2023 8:50 PM, Konrad Dybcio wrote:
>>>
>>>
>>> On 13.01.2023 15:36, devi priya wrote:
>>>> Included CLK_IS_CRITICAL flag which helps to properly enable
>>>> the APSS PLL during bootup.
>>> Please describe the issue and not only the user-visible impact it
>>> makes. Does the PLL get shut down by clk_ignore_unused? Maybe you
>>> would be interested in the sync_state changes that landed in recent
>>> -next that may solve it for you?
>>>
>>> I don't think it should be always-on, as you have an alternate source
>>> for low power modes, adding CLK_IS_CRITICAL will keep the PLL enabled
>>> even if you're not using it.
>> Yeah, got it. Will drop the critical flag
>>>
>>>> clk_rcg2_ops should be used for APSS clock RCG, as other ops
>>>> will not configure the RCG register
>>> RCG register meaning RCG register*s*, meaning in this case M/N/D
>>> which would be required for proper rate setting and not only input
>>> switching (which arguably doesn't seem to be of much concern on a
>>> single-parent clock)? This all is not obvious..
>>>
>>> Konrad
>> The source selection is done by configuring the RCGR config register 
>> with the source entry (P_APSS_PLL_EARLY) added to the frequency table. 
>> Proper rate is achieved by configuring the PLL and hence M/N/D values 
>> are not configured
> 
> But the clk_rcg2_mux_closest_ops also programs the parent for the clock. 
> So from your description it isn't obvious what is wrong with the current 
> _ops used for the clock.
> 
Okay, understood & agreed.
Will re-verify it once and update it accordingly in V2
>>>>
>>>> Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>>>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>>>> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
>>>> ---
>>>>   drivers/clk/qcom/apss-ipq-pll.c | 1 +
>>>>   drivers/clk/qcom/apss-ipq6018.c | 8 +++++++-
>>>>   2 files changed, 8 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/clk/qcom/apss-ipq-pll.c 
>>>> b/drivers/clk/qcom/apss-ipq-pll.c
>>>> index dd0c01bf5a98..75486a124fcd 100644
>>>> --- a/drivers/clk/qcom/apss-ipq-pll.c
>>>> +++ b/drivers/clk/qcom/apss-ipq-pll.c
>>>> @@ -33,6 +33,7 @@ static struct clk_alpha_pll ipq_pll = {
>>>>               },
>>>>               .num_parents = 1,
>>>>               .ops = &clk_alpha_pll_huayra_ops,
>>>> +            .flags = CLK_IS_CRITICAL,
>>>>           },
>>>>       },
>>>>   };
>>>> diff --git a/drivers/clk/qcom/apss-ipq6018.c 
>>>> b/drivers/clk/qcom/apss-ipq6018.c
>>>> index f2f502e2d5a4..0d0e7196a4dc 100644
>>>> --- a/drivers/clk/qcom/apss-ipq6018.c
>>>> +++ b/drivers/clk/qcom/apss-ipq6018.c
>>>> @@ -33,15 +33,21 @@ static const struct parent_map 
>>>> parents_apcs_alias0_clk_src_map[] = {
>>>>       { P_APSS_PLL_EARLY, 5 },
>>>>   };
>>>> +static const struct freq_tbl ftbl_apcs_alias0_clk_src[] = {
>>>> +    { .src = P_APSS_PLL_EARLY, .pre_div = 1 },
>>>> +    { }
>>>> +};
>>>> +
>>>>   static struct clk_rcg2 apcs_alias0_clk_src = {
>>>>       .cmd_rcgr = 0x0050,
>>>> +    .freq_tbl = ftbl_apcs_alias0_clk_src,
>>>>       .hid_width = 5,
>>>>       .parent_map = parents_apcs_alias0_clk_src_map,
>>>>       .clkr.hw.init = &(struct clk_init_data){
>>>>           .name = "apcs_alias0_clk_src",
>>>>           .parent_data = parents_apcs_alias0_clk_src,
>>>>           .num_parents = ARRAY_SIZE(parents_apcs_alias0_clk_src),
>>>> -        .ops = &clk_rcg2_mux_closest_ops,
>>>> +        .ops = &clk_rcg2_ops,
>>>>           .flags = CLK_SET_RATE_PARENT,
>>>>       },
>>>>   };
>> Best Regards,
>> Devi Priya
> 
Best Regards,
Devi Priya
