Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC0073CDF4
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 04:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjFYCMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 22:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjFYCMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 22:12:01 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8125510A;
        Sat, 24 Jun 2023 19:11:59 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id C77AB24DCFA;
        Sun, 25 Jun 2023 10:11:45 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sun, 25 Jun
 2023 10:11:45 +0800
Received: from [192.168.125.107] (113.72.146.167) by EXMBX062.cuchost.com
 (172.16.6.62) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sun, 25 Jun
 2023 10:11:44 +0800
Message-ID: <6573a50b-e414-9eba-5a70-f1993c7924c2@starfivetech.com>
Date:   Sun, 25 Jun 2023 10:11:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 2/3] phy: starfive: Add mipi dphy rx support
To:     Vinod Koul <vkoul@kernel.org>
CC:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
References: <20230529121503.3544-1-changhuang.liang@starfivetech.com>
 <20230529121503.3544-3-changhuang.liang@starfivetech.com>
 <ZJLtVoi2qpKOR1l6@matsya>
Content-Language: en-US
From:   Changhuang Liang <changhuang.liang@starfivetech.com>
In-Reply-To: <ZJLtVoi2qpKOR1l6@matsya>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.146.167]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX062.cuchost.com
 (172.16.6.62)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/6/21 20:30, Vinod Koul wrote:
> On 29-05-23, 05:15, Changhuang Liang wrote:
>> +static int stf_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
>> +{
>> +	struct stf_dphy *dphy = phy_get_drvdata(phy);
>> +	const struct stf_dphy_info *info = dphy->info;
>> +	int i;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(stf_dphy_init_list); i++)
>> +		writel(stf_dphy_init_list[i].val,
>> +		       dphy->regs + stf_dphy_init_list[i].addr);
>> +
>> +	writel(FIELD_PREP(STF_DPHY_DA_CDPHY_R100_CTRL0_2D1C_EFUSE_EN, 1) |
>> +	       FIELD_PREP(STF_DPHY_DA_CDPHY_R100_CTRL0_2D1C_EFUSE_IN, 0x1b) |
>> +	       FIELD_PREP(STF_DPHY_DA_CDPHY_R100_CTRL1_2D1C_EFUSE_EN, 1) |
>> +	       FIELD_PREP(STF_DPHY_DA_CDPHY_R100_CTRL1_2D1C_EFUSE_IN, 0x1b),
>> +	       dphy->regs + STF_DPHY_APBCFGSAIF_SYSCFG(0));
>> +
>> +	writel(FIELD_PREP(STF_DPHY_DATA_BUS16_8, 0) |
>> +	       FIELD_PREP(STF_DPHY_DEBUG_MODE_SEL, 0x5a),
>> +	       dphy->regs + STF_DPHY_APBCFGSAIF_SYSCFG(184));
> 
> bunch of magic numbers here and previous one..?
> 

magic numbers is "1" "0x1b" "0" "0x5a"? 
If so,  I will move this two registers into stf_dphy_init_list[].
And maybe also have some magic numbers below, I will replace them will macro.

>> +
>> +	writel(FIELD_PREP(STF_DPHY_ENABLE_CLK, 1) |
>> +	       FIELD_PREP(STF_DPHY_ENABLE_CLK1, 1) |
>> +	       FIELD_PREP(STF_DPHY_ENABLE_LAN0, 1) |
>> +	       FIELD_PREP(STF_DPHY_ENABLE_LAN1, 1) |
>> +	       FIELD_PREP(STF_DPHY_ENABLE_LAN2, 1) |
>> +	       FIELD_PREP(STF_DPHY_ENABLE_LAN3, 1) |
>> +	       FIELD_PREP(STF_DPHY_GPI_EN, 0) |
>> +	       FIELD_PREP(STF_DPHY_HS_FREQ_CHANGE_CLK, 0) |
>> +	       FIELD_PREP(STF_DPHY_HS_FREQ_CHANGE_CLK1, 0) |
>> +	       FIELD_PREP(STF_DPHY_LANE_SWAP_CLK, info->maps[0]) |
>> +	       FIELD_PREP(STF_DPHY_LANE_SWAP_CLK1, info->maps[5]) |
>> +	       FIELD_PREP(STF_DPHY_LANE_SWAP_LAN0, info->maps[1]) |
>> +	       FIELD_PREP(STF_DPHY_LANE_SWAP_LAN1, info->maps[2]),
>> +	       dphy->regs + STF_DPHY_APBCFGSAIF_SYSCFG(188));
[...]
>> +
>> +	writel(FIELD_PREP(STF_DPHY_PRECOUNTER_IN_LAN3, 7) |
>> +	       FIELD_PREP(STF_DPHY_RX_1C2C_SEL, 0),
>> +	       dphy->regs + STF_DPHY_APBCFGSAIF_SYSCFG(200));
>> +
>> +	return 0;
>> +}
>> +
>> +static int stf_dphy_power_on(struct phy *phy)
>> +{
>> +	struct stf_dphy *dphy = phy_get_drvdata(phy);
>> +	int ret;
>> +
>> +	pm_runtime_get_sync(dphy->dev);
> 
> no error check?
> 

I will replace pm_runtime_get_sync with pm_runtime_resume_and_get to handle error:

	ret = pm_runtime_resume_and_get(dphy->dev);
	if (ret < 0)
		return ret;

>> +
>> +	ret = regulator_enable(dphy->mipi_0p9);
>> +	if (ret)
>> +		return ret;
> 
> should you not drop the pm reference on error here?
> 

I will add pm_runtime_put in this error handle.

Thanks for your comments.

