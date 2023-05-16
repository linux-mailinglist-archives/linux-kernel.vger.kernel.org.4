Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD153704269
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 02:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245722AbjEPAry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 20:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjEPArv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 20:47:51 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E339630FA;
        Mon, 15 May 2023 17:47:49 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 391377FFB;
        Tue, 16 May 2023 08:47:47 +0800 (CST)
Received: from EXMBX073.cuchost.com (172.16.6.83) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 16 May
 2023 08:47:47 +0800
Received: from [192.168.60.149] (180.164.60.184) by EXMBX073.cuchost.com
 (172.16.6.83) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 16 May
 2023 08:47:46 +0800
Message-ID: <62d1ca89-7fe2-5435-c5c6-9158c58cb97e@starfivetech.com>
Date:   Tue, 16 May 2023 08:47:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 3/5] media: cadence: Add operation on reset
Content-Language: en-US
To:     Philipp Zabel <p.zabel@pengutronix.de>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <changhuang.liang@starfivetech.com>
References: <20230512102637.50917-1-jack.zhu@starfivetech.com>
 <20230512102637.50917-4-jack.zhu@starfivetech.com>
 <20230515144245.GA29284@pengutronix.de>
From:   Jack Zhu <jack.zhu@starfivetech.com>
In-Reply-To: <20230515144245.GA29284@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX073.cuchost.com
 (172.16.6.83)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

Thank you for your review!

On 2023/5/15 22:42, Philipp Zabel wrote:
> Hi Jack,
> 
> On Fri, May 12, 2023 at 06:26:35PM +0800, Jack Zhu wrote:
> [...]
>> @@ -299,6 +312,16 @@ static int csi2rx_get_resources(struct csi2rx_priv *csi2rx,
>>  		return PTR_ERR(csi2rx->p_clk);
>>  	}
>>  
>> +	csi2rx->sys_rst = devm_reset_control_get_optional_exclusive(&pdev->dev,
>> +								    "sys_rst");
> 
> This doesn't match the bindings documented in patch 2.
> Should this be "sys"?

Yes, will fix it.

> 
>> +	if (IS_ERR(csi2rx->sys_rst))
>> +		return PTR_ERR(csi2rx->sys_rst);
>> +
>> +	csi2rx->p_rst = devm_reset_control_get_optional_exclusive(&pdev->dev,
>> +								  "p_rst");
> 
> This doesn't match the bindings documented in patch 2.
> Should this be "reg_bank"?
> 

Yes, will fix it.

>> +	if (IS_ERR(csi2rx->p_rst))
>> +		return PTR_ERR(csi2rx->p_rst);
>> +
>>  	csi2rx->dphy = devm_phy_optional_get(&pdev->dev, "dphy");
>>  	if (IS_ERR(csi2rx->dphy)) {
>>  		dev_err(&pdev->dev, "Couldn't get external D-PHY\n");
>> @@ -349,14 +372,21 @@ static int csi2rx_get_resources(struct csi2rx_priv *csi2rx,
>>  	}
>>  
>>  	for (i = 0; i < csi2rx->max_streams; i++) {
>> -		char clk_name[16];
>> +		char name[16];
>>  
>> -		snprintf(clk_name, sizeof(clk_name), "pixel_if%u_clk", i);
>> -		csi2rx->pixel_clk[i] = devm_clk_get(&pdev->dev, clk_name);
>> +		snprintf(name, sizeof(name), "pixel_if%u_clk", i);
>> +		csi2rx->pixel_clk[i] = devm_clk_get(&pdev->dev, name);
>>  		if (IS_ERR(csi2rx->pixel_clk[i])) {
>> -			dev_err(&pdev->dev, "Couldn't get clock %s\n", clk_name);
>> +			dev_err(&pdev->dev, "Couldn't get clock %s\n", name);
>>  			return PTR_ERR(csi2rx->pixel_clk[i]);
>>  		}
>> +
>> +		snprintf(name, sizeof(name), "pixel_if%u_rst", i);
> 
> This doesn't match the bindings documented in patch 2.
> Should this be "pixel_if%u"?
> 

Yes, will fix it.

regards
Jack

> regards
> Philipp
