Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25D96F8FBB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 09:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjEFHOB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 6 May 2023 03:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjEFHN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 03:13:58 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7F64C1E;
        Sat,  6 May 2023 00:13:56 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 57CCD24DE83;
        Sat,  6 May 2023 15:13:54 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 6 May
 2023 15:13:54 +0800
Received: from [192.168.120.40] (171.223.208.138) by EXMBX062.cuchost.com
 (172.16.6.62) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 6 May
 2023 15:13:53 +0800
Message-ID: <f2b54fc5-81a6-45ae-0218-193a993333ab@starfivetech.com>
Date:   Sat, 6 May 2023 15:13:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 2/2] net: phy: motorcomm: Add pad drive strength cfg
 support
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, Peter Geis <pgwipeout@gmail.com>,
        Frank <Frank.Sae@motor-comm.com>,
        "David S . Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Yanhong Wang <yanhong.wang@starfivetech.com>
References: <20230505090558.2355-1-samin.guo@starfivetech.com>
 <20230505090558.2355-3-samin.guo@starfivetech.com>
 <fc516e65-cde2-4a65-a3c5-bd8c939e7eb1@lunn.ch>
From:   Guo Samin <samin.guo@starfivetech.com>
In-Reply-To: <fc516e65-cde2-4a65-a3c5-bd8c939e7eb1@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX062.cuchost.com
 (172.16.6.62)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Re: [PATCH v2 2/2] net: phy: motorcomm: Add pad drive strength cfg support
From: Andrew Lunn <andrew@lunn.ch>
to: Samin Guo <samin.guo@starfivetech.com>
data: 2023/5/5

>>  #define YTPHY_DTS_OUTPUT_CLK_DIS		0
>> @@ -1495,6 +1504,7 @@ static int yt8531_config_init(struct phy_device *phydev)
>>  {
>>  	struct device_node *node = phydev->mdio.dev.of_node;
>>  	int ret;
>> +	u32 ds, val;
> 
> Reverse Christmas tree.  Sort these longest first, shortest last.
> 
Thanks, will fix.
> Otherwise this looks O.K.
> 
> The only open question is if real unit should be used, uA, not some
> magic numbers. Lets see what the DT Maintainers say.
> 
>       Andrew

Hi Andrew,

As I communicated with Frank, Motorcomm doesn't give specific units on their datasheet, except for magic numbers.
Tried to ask Motorcomm last week, but it seems that they themselves do not know what the unit is and have no response so far.


Below is all the relevant information I found：

Pad Drive Strength Cfg (EXT_0xA010)

Bit   |  Symbol           |  Access |  Default |  Description
15:13 |  Rgmii_sw_dr_rx   |  RW     |  0x3     |  Drive strenght of rx_clk pad.
                                               |  3'b111: strongest; 3'b000: weakest.

12    |  Rgmii_sw_dr[2]   |  RW     |  0x0     |  Bit 2 of Rgmii_sw_dr[2:0], refer to ext A010[5:4]

5:4   |  Rgmii_sw_dr[1:0] |  RW     |  0x3     |  Bit 1 and 0 of Rgmii_sw_dr, Drive strenght of rxd/rx_ctl rgmii pad.
                                               |  3'b111: strongest; 3'b000: weakest



Best regards,
Samin
