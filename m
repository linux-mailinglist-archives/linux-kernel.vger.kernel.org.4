Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF6868CE31
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 05:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjBGEal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 23:30:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBGEaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 23:30:35 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BCC35265;
        Mon,  6 Feb 2023 20:30:32 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3174IIa5009596;
        Tue, 7 Feb 2023 04:30:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=bRhQuIglRpdjSUiz8zZ2CW02S5eDhSJ5Zk6RnH8XY5M=;
 b=VZbWM4H38Ar7Z62cjZ04m8XK7J6JXnvr8KaycsfnoWdzBNwlCfBNuUSzedc/WmeembKh
 vdS3lh6YAGACQ4IZmk6DQ429qAUuMY8YAdn0gc+u3f9MeBgOAfNwKiYgxtmDlm22rQ64
 U3ouOQYqZ8K26H1feoRBXXSa3gC95QCLqzyGbJELBEl46z7o7DLiOh9qXz4LB7BEqN7j
 B1f906FK3s2Gv7+xtWscMr6Vrwp6SnI2RI+cy1QlkuzLYZD2HBRQ3UoYTeQTG+fwUz/x
 WE3p1FfEkrBxmpcUMAv3oBPKZAFKHchZXolA70g2NfxcQBv1aXBBwgQl7D+me9Q0TG79 Ew== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nhd2qdgmh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Feb 2023 04:30:09 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3174U8OL007190
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Feb 2023 04:30:08 GMT
Received: from [10.201.2.96] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 6 Feb 2023
 20:30:00 -0800
Message-ID: <4bcf4bd9-e638-22a2-044d-47fd5fd5d104@quicinc.com>
Date:   Tue, 7 Feb 2023 09:59:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH V3 5/9] clk: qcom: add Global Clock controller (GCC)
 driver for IPQ5332 SoC
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <krzysztof.kozlowski@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <linus.walleij@linaro.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <shawnguo@kernel.org>, <arnd@arndb.de>,
        <marcel.ziswiler@toradex.com>, <nfraprado@collabora.com>,
        <robimarko@gmail.com>, <quic_gurus@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_varada@quicinc.com>, <quic_srichara@quicinc.com>
References: <20230206071217.29313-1-quic_kathirav@quicinc.com>
 <20230206071217.29313-6-quic_kathirav@quicinc.com>
 <019bf6ae-cdc4-8fa7-4d76-c39403d93b34@linaro.org>
From:   Kathiravan T <quic_kathirav@quicinc.com>
In-Reply-To: <019bf6ae-cdc4-8fa7-4d76-c39403d93b34@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qDcc2Ow3Z6Rjke8K4w2lpPhiUKTIHOuX
X-Proofpoint-GUID: qDcc2Ow3Z6Rjke8K4w2lpPhiUKTIHOuX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 mlxscore=0 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302070039
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Dmirty for the review!


On 2/6/2023 3:26 PM, Dmitry Baryshkov wrote:
> On 06/02/2023 09:12, Kathiravan T wrote:
> > Add support for the global clock controller found on IPQ5332 SoC.
> >
> > Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> > ---
> > Changes in V3:
> >     - As I mentined the bindings, changes need to be done in V2 got
> >       missed out and same has been done in V3, to call out
> >       specifically dropped the CLK_IS_CRITICAL and dropped the
> >       gcc_apss_ahb_clk, its source clock and gcc_apss_axi_clk
> >     - Used gcc_parent_data_xo wherever applicable and dropped the
> >       duplicate entries
> >     - dropped the unused parent_map_10 and parent_data_10
> >     - Used qcom_cc_probe instead of qcom_cc_really_probe
> > Changes in V2:
> >     - Added the 'dependes on' for Kconfig symbol
> >     - Dropped the CLK_IS_CRITICAL flag throughout the file
> >     - Dropped the gcc_apss_ahb_clk and gcc_apss_axi_clk as these are
> >       managed by bootloaders
>
>
> [skipped]
>
> > +static const struct freq_tbl ftbl_gcc_pcie_aux_clk_src[] = {
> > +    F(2000000, P_XO, 12, 0, 0),
> > +    { }
> > +};
> > +
> > +static struct clk_rcg2 gcc_pcie_aux_clk_src = {
> > +    .cmd_rcgr = 0x28004,
> > +    .mnd_width = 16,
> > +    .hid_width = 5,
> > +    .parent_map = gcc_parent_map_6,
> > +    .freq_tbl = ftbl_gcc_pcie_aux_clk_src,
> > +    .clkr.hw.init = &(const struct clk_init_data){
> > +        .name = "gcc_pcie_aux_clk_src",
> > +        .parent_data = gcc_parent_data_6,
> > +        .num_parents = ARRAY_SIZE(gcc_parent_data_6),
> > +        .ops = &clk_rcg2_ops,
> > +    },
> > +};
> > +
> > +static struct clk_regmap_mux pcie3x2_pipe_clk_src = {
> > +    .reg = 0x28064,
> > +    .shift = 8,
> > +    .width = 2,
> > +    .parent_map = gcc_parent_map_14,
> > +    .clkr = {
> > +        .hw.init = &(struct clk_init_data){
> > +            .name = "pcie3x2_phy_pipe_clk_src",
> > +            .parent_data = gcc_parent_data_14,
> > +            .num_parents = ARRAY_SIZE(gcc_parent_data_14),
> > +            .ops = &clk_regmap_mux_closest_ops,
>
> Should we use clk_regmap_phy_mux_ops here instead?


Sure, I will check this one. Also looking at the commit, 74e4190cdebe 
("clk: qcom: regmap: add PHY clock source implementation"), looks like I 
can use the clk_regmap_phy_mux struct instead of clk_regmap_mux. I will 
check into this and update accordingly.


>
> > +            .flags = CLK_SET_RATE_PARENT,
> > +        },
> > +    },
> > +};
> > +
> > +static struct clk_regmap_mux pcie3x1_0_pipe_clk_src = {
> > +    .reg = 0x29064,
> > +    .shift = 8,
> > +    .width = 2,
> > +    .parent_map = gcc_parent_map_15,
> > +    .clkr = {
> > +        .hw.init = &(struct clk_init_data){
> > +            .name = "pcie3x1_0_phy_pipe_clk_src",
> > +            .parent_data = gcc_parent_data_15,
> > +            .num_parents = ARRAY_SIZE(gcc_parent_data_15),
> > +            .ops = &clk_regmap_mux_closest_ops,
>
> And clk_regmap_phy_mux_ops here too?


Ack.


>
> > +            .flags = CLK_SET_RATE_PARENT,
> > +        },
> > +    },
> > +};
> > +
> > +static struct clk_regmap_mux pcie3x1_1_pipe_clk_src = {
> > +    .reg = 0x2A064,
> > +    .shift = 8,
> > +    .width = 2,
> > +    .parent_map = gcc_parent_map_16,
> > +    .clkr = {
> > +        .hw.init = &(struct clk_init_data){
> > +            .name = "pcie3x1_1_phy_pipe_clk_src",
> > +            .parent_data = gcc_parent_data_16,
> > +            .num_parents = ARRAY_SIZE(gcc_parent_data_16),
> > +            .ops = &clk_regmap_mux_closest_ops,
>
> And here?


Ack.


>
> > +            .flags = CLK_SET_RATE_PARENT,
> > +        },
> > +    },
> > +};
> > +
>
> [skipped]
>
>
> > +
> > +static struct clk_branch gcc_pcie3x1_0_pipe_clk = {
> > +    .halt_reg = 0x29068,
> > +    .halt_check = BRANCH_HALT_DELAY,
> > +    .clkr = {
> > +        .enable_reg = 0x29068,
> > +        .enable_mask = BIT(0),
> > +        .hw.init = &(const struct clk_init_data){
> > +            .name = "gcc_pcie3x1_0_pipe_clk",
> > +            .parent_names = (const char *[]){
> > +                "pcie3x1_0_pipe_clk_src"
> > +            },
>
> Nooo. No parent_names please. You have several of them in the driver


I missed this. I will fix in next spin.


>
> > +            .num_parents = 1,
> > +            .flags = CLK_SET_RATE_PARENT,
> > +            .ops = &clk_branch2_ops,
> > +        },
> > +    },
> > +};
> > +
>
