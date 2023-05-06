Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0786F8DC5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 03:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbjEFBxC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 5 May 2023 21:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjEFBw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 21:52:59 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1605A4C01;
        Fri,  5 May 2023 18:52:58 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 97AB324DEBC;
        Sat,  6 May 2023 09:52:55 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 6 May
 2023 09:52:55 +0800
Received: from [192.168.120.40] (171.223.208.138) by EXMBX062.cuchost.com
 (172.16.6.62) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 6 May
 2023 09:52:54 +0800
Message-ID: <cda098be-eb4a-75dc-ea12-977766e9e843@starfivetech.com>
Date:   Sat, 6 May 2023 09:52:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 2/2] net: phy: motorcomm: Add pad drive strength cfg
 support
Content-Language: en-US
To:     Frank Sae <Frank.Sae@motor-comm.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, Peter Geis <pgwipeout@gmail.com>
CC:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        "Heiner Kallweit" <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Yanhong Wang <yanhong.wang@starfivetech.com>
References: <20230505090558.2355-1-samin.guo@starfivetech.com>
 <20230505090558.2355-3-samin.guo@starfivetech.com>
 <ba94f81c-3fc0-303c-f0f9-8fd0ab7d33fe@motor-comm.com>
From:   Guo Samin <samin.guo@starfivetech.com>
In-Reply-To: <ba94f81c-3fc0-303c-f0f9-8fd0ab7d33fe@motor-comm.com>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX062.cuchost.com
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

data: Re: [PATCH v2 2/2] net: phy: motorcomm: Add pad drive strength cfg support
From: Frank Sae <Frank.Sae@motor-comm.com>
to: Samin Guo <samin.guo@starfivetech.com>, <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>, Peter Geis <pgwipeout@gmail.com>
data: 2023/5/6

> 
> 
> On 2023/5/5 17:05, Samin Guo wrote:
>> The motorcomm phy (YT8531) supports the ability to adjust the drive
>> strength of the rx_clk/rx_data, and the default strength may not be
>> suitable for all boards. So add configurable options to better match
>> the boards.(e.g. StarFive VisionFive 2)
>>
>> Signed-off-by: Samin Guo <samin.guo@starfivetech.com>
>> ---
>>  drivers/net/phy/motorcomm.c | 46 +++++++++++++++++++++++++++++++++++++
>>  1 file changed, 46 insertions(+)
>>
>> diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
>> index 2fa5a90e073b..191650bb1454 100644
>> --- a/drivers/net/phy/motorcomm.c
>> +++ b/drivers/net/phy/motorcomm.c
>> @@ -236,6 +236,7 @@
>>   */
>>  #define YTPHY_WCR_TYPE_PULSE			BIT(0)
>>  
>> +#define YTPHY_PAD_DRIVE_STRENGTH_REG		0xA010
>>  #define YTPHY_SYNCE_CFG_REG			0xA012
>>  #define YT8521_SCR_SYNCE_ENABLE			BIT(5)
>>  /* 1b0 output 25m clock
>> @@ -260,6 +261,14 @@
>>  #define YT8531_SCR_CLK_SRC_REF_25M		4
>>  #define YT8531_SCR_CLK_SRC_SSC_25M		5
>>  
>> +#define YT8531_RGMII_RXC_DS_DEFAULT		0x3
>> +#define YT8531_RGMII_RXC_DS_MAX			0x7
>> +#define YT8531_RGMII_RXC_DS			GENMASK(15, 13)
>> +#define YT8531_RGMII_RXD_DS_DEFAULT		0x3
>> +#define YT8531_RGMII_RXD_DS_MAX			0x7
>> +#define YT8531_RGMII_RXD_DS_LOW			GENMASK(5, 4) /* Bit 1/0 of rxd_ds */
>> +#define YT8531_RGMII_RXD_DS_HI			BIT(12) /* Bit 2 of rxd_ds */
> 
> 
> YT8531_RGMII_xxx is bit define for YTPHY_PAD_DRIVE_STRENGTH_REG, so it is better to put it under the define of YTPHY_PAD_DRIVE_STRENGTH_REG.
> 
> YT8531_RGMII_xxx bit define as reverse order:
> #define YTPHY_PAD_DRIVE_STRENGTH_REG		0xA010
> #define YT8531_RGMII_RXC_DS			GENMASK(15, 13)
> #define YT8531_RGMII_RXD_DS_HI			BIT(12) /* Bit 2 of rxd_ds */     <-------
> #define YT8531_RGMII_RXD_DS_LOW			GENMASK(5, 4) /* Bit 1/0 of rxd_ds */
> ...
> 
Hi Frank,

Ok, will fix it next version.
btw, do you have any information you can provide about Andrew's mention of using real unit uA/mA  instead of magic numbers?
(I couldn't find any information about current in the YT8531's datasheet other than the magic numbers.)


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

>> +
>>  /* Extended Register  end */
>>  
>>  #define YTPHY_DTS_OUTPUT_CLK_DIS		0
>> @@ -1495,6 +1504,7 @@ static int yt8531_config_init(struct phy_device *phydev)
>>  {
>>  	struct device_node *node = phydev->mdio.dev.of_node;
>>  	int ret;
>> +	u32 ds, val;
>>  
>>  	ret = ytphy_rgmii_clk_delay_config_with_lock(phydev);
>>  	if (ret < 0)
>> @@ -1518,6 +1528,42 @@ static int yt8531_config_init(struct phy_device *phydev)
>>  			return ret;
>>  	}
>>  
>> +	ds = YT8531_RGMII_RXC_DS_DEFAULT;
>> +	if (!of_property_read_u32(node, "motorcomm,rx-clk-driver-strength", &val)) {
>> +		if (val > YT8531_RGMII_RXC_DS_MAX)
>> +			return -EINVAL;
>> +
>> +		ds = val;
>> +	}
>> +
>> +	ret = ytphy_modify_ext_with_lock(phydev,
>> +					 YTPHY_PAD_DRIVE_STRENGTH_REG,
>> +					 YT8531_RGMII_RXC_DS,
>> +					 FIELD_PREP(YT8531_RGMII_RXC_DS, ds));
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ds = FIELD_PREP(YT8531_RGMII_RXD_DS_LOW, YT8531_RGMII_RXD_DS_DEFAULT);
>> +	if (!of_property_read_u32(node, "motorcomm,rx-data-driver-strength", &val)) {
>> +		if (val > YT8531_RGMII_RXD_DS_MAX)
>> +			return -EINVAL;
>> +
>> +		if (val > FIELD_MAX(YT8531_RGMII_RXD_DS_LOW)) {
>> +			ds = val & FIELD_MAX(YT8531_RGMII_RXD_DS_LOW);
>> +			ds = FIELD_PREP(YT8531_RGMII_RXD_DS_LOW, ds);
>> +			ds |= YT8531_RGMII_RXD_DS_HI;
>> +		} else {
>> +			ds = FIELD_PREP(YT8531_RGMII_RXD_DS_LOW, val);
>> +		}
>> +	}
>> +
>> +	ret = ytphy_modify_ext_with_lock(phydev,
>> +					 YTPHY_PAD_DRIVE_STRENGTH_REG,
>> +					 YT8531_RGMII_RXD_DS_LOW | YT8531_RGMII_RXD_DS_HI,
>> +					 ds);
>> +	if (ret < 0)
>> +		return ret;
>> +
>>  	return 0;
>>  }
>>  


