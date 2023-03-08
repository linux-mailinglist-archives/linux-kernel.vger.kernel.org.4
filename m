Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920BB6B01F5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 09:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjCHIsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 03:48:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjCHIsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 03:48:39 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AD99438D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 00:48:36 -0800 (PST)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32879V4P019611;
        Wed, 8 Mar 2023 09:48:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=iuAQdYFKTGYmPSS5SLf5c/qCK6pWGs2MRbmLc5fNhG4=;
 b=xzsQqRmdDMHYsL1kZ0hQQoCD8+B+TIPM3ukBpktDxODZXDj8b6++c+mLA5kI46FB7UAQ
 RsomBZT9ZGevmulS/wpqOr6w5hBFobsobYml/+9tEOS8d21fyFLSI+auk7C2RNqZ0iZB
 Kp0JpHKLLT2HeuUyXyTMoJ94VFvA4zaBw9aeYGdvcPnX+t/nz5DntwoTeTUxYttag6vP
 otMSn2x3+ClabYdHoCitkugbcjW/3dfYPGk+CCYpXOST4xLvlHvAZS875w/Xke0bUjFc
 ypkBjM2QtWxvOCpKcs/X15TsNXZp5/pqVjeVjsfOvP1tSb5ggmoMTLvR62+6YFu4zgJV OQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3p6fdrjkhn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 09:48:10 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1425910002A;
        Wed,  8 Mar 2023 09:48:09 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3CFCD210F7E;
        Wed,  8 Mar 2023 09:48:09 +0100 (CET)
Received: from [10.201.21.26] (10.201.21.26) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Wed, 8 Mar
 2023 09:48:08 +0100
Message-ID: <d422fd7b-05e8-c29b-90f6-f2a4742411f1@foss.st.com>
Date:   Wed, 8 Mar 2023 09:48:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] phy: st: miphy28lp: use _poll_timeout functions for waits
To:     Alain Volmat <avolmat@me.com>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20230210224309.98452-1-avolmat@me.com>
Content-Language: en-US
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20230210224309.98452-1-avolmat@me.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.26]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_04,2023-03-08_01,2023-02-09_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alain

On 2/10/23 23:43, Alain Volmat wrote:
> This commit introduces _poll_timeout functions usage instead of
> wait loops waiting for a status bit.
> 
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---
>  drivers/phy/st/phy-miphy28lp.c | 42 ++++++++--------------------------
>  1 file changed, 10 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/phy/st/phy-miphy28lp.c b/drivers/phy/st/phy-miphy28lp.c
> index 068160a34f5c..e30305b77f0d 100644
> --- a/drivers/phy/st/phy-miphy28lp.c
> +++ b/drivers/phy/st/phy-miphy28lp.c
> @@ -9,6 +9,7 @@
>  
>  #include <linux/platform_device.h>
>  #include <linux/io.h>
> +#include <linux/iopoll.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> @@ -484,19 +485,11 @@ static inline void miphy28lp_pcie_config_gen(struct miphy28lp_phy *miphy_phy)
>  
>  static inline int miphy28lp_wait_compensation(struct miphy28lp_phy *miphy_phy)
>  {
> -	unsigned long finish = jiffies + 5 * HZ;
>  	u8 val;
>  
>  	/* Waiting for Compensation to complete */
> -	do {
> -		val = readb_relaxed(miphy_phy->base + MIPHY_COMP_FSM_6);
> -
> -		if (time_after_eq(jiffies, finish))
> -			return -EBUSY;
> -		cpu_relax();
> -	} while (!(val & COMP_DONE));
> -
> -	return 0;
> +	return readb_relaxed_poll_timeout(miphy_phy->base + MIPHY_COMP_FSM_6,
> +					  val, val & COMP_DONE, 1, 5 * USEC_PER_SEC);
>  }
>  
>  
> @@ -805,7 +798,6 @@ static inline void miphy28lp_configure_usb3(struct miphy28lp_phy *miphy_phy)
>  
>  static inline int miphy_is_ready(struct miphy28lp_phy *miphy_phy)
>  {
> -	unsigned long finish = jiffies + 5 * HZ;
>  	u8 mask = HFC_PLL | HFC_RDY;
>  	u8 val;
>  
> @@ -816,21 +808,14 @@ static inline int miphy_is_ready(struct miphy28lp_phy *miphy_phy)
>  	if (miphy_phy->type == PHY_TYPE_SATA)
>  		mask |= PHY_RDY;
>  
> -	do {
> -		val = readb_relaxed(miphy_phy->base + MIPHY_STATUS_1);
> -		if ((val & mask) != mask)
> -			cpu_relax();
> -		else
> -			return 0;
> -	} while (!time_after_eq(jiffies, finish));
> -
> -	return -EBUSY;
> +	return readb_relaxed_poll_timeout(miphy_phy->base + MIPHY_STATUS_1,
> +					  val, (val & mask) == mask, 1,
> +					  5 * USEC_PER_SEC);
>  }
>  
>  static int miphy_osc_is_ready(struct miphy28lp_phy *miphy_phy)
>  {
>  	struct miphy28lp_dev *miphy_dev = miphy_phy->phydev;
> -	unsigned long finish = jiffies + 5 * HZ;
>  	u32 val;
>  
>  	if (!miphy_phy->osc_rdy)
> @@ -839,17 +824,10 @@ static int miphy_osc_is_ready(struct miphy28lp_phy *miphy_phy)
>  	if (!miphy_phy->syscfg_reg[SYSCFG_STATUS])
>  		return -EINVAL;
>  
> -	do {
> -		regmap_read(miphy_dev->regmap,
> -				miphy_phy->syscfg_reg[SYSCFG_STATUS], &val);
> -
> -		if ((val & MIPHY_OSC_RDY) != MIPHY_OSC_RDY)
> -			cpu_relax();
> -		else
> -			return 0;
> -	} while (!time_after_eq(jiffies, finish));
> -
> -	return -EBUSY;
> +	return regmap_read_poll_timeout(miphy_dev->regmap,
> +					miphy_phy->syscfg_reg[SYSCFG_STATUS],
> +					val, val & MIPHY_OSC_RDY, 1,
> +					5 * USEC_PER_SEC);
>  }
>  
>  static int miphy28lp_get_resource_byname(struct device_node *child,

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
