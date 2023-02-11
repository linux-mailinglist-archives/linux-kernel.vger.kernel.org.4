Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310A56931D2
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 15:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjBKO4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 09:56:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjBKOz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 09:55:59 -0500
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AD216AFE
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 06:55:58 -0800 (PST)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id QrI9p1F8JIxv0QrIApn25B; Sat, 11 Feb 2023 15:55:57 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 11 Feb 2023 15:55:57 +0100
X-ME-IP: 86.243.2.178
Message-ID: <e75c23f0-9369-1848-d873-c48dffeab88c@wanadoo.fr>
Date:   Sat, 11 Feb 2023 15:55:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] soc: brcmstb: pm-arm: Remove duplicate/repeating constant
Content-Language: fr
To:     Deepak R Varma <drv@mailo.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
References: <Y+dT6du6Nysyd8/t@ubun2204.myguest.virtualbox.org>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <Y+dT6du6Nysyd8/t@ubun2204.myguest.virtualbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 11/02/2023 à 09:38, Deepak R Varma a écrit :
> Constant DDR_PHY_RST_N is unnecessarily or'ed with itself. Remove
> the redundant constant from the expression.
> Issue identified using doublebitand.cocci Coccinelle semantic patch.
> 
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
> Please note: I was unable to build the change though I had the appropriate
> config, arch and  cross compiler. I used the following:
> 	.config = bmips_stb_defconfig
> 	ARCH=mips
> 	CROSS_COMPILE=/usr/bin/mips-linux-gnu-
> 	BRCMSTB_PM=y

The driver is pm-arm.c, try with arm instead of mips?

Worked for me with make.cross

> 
> Let me know what I missed so I can build the objects myself. Thank you.
> 
> 
>   drivers/soc/bcm/brcmstb/pm/pm-arm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/bcm/brcmstb/pm/pm-arm.c b/drivers/soc/bcm/brcmstb/pm/pm-arm.c
> index d681cd24c6e1..633e715446f7 100644
> --- a/drivers/soc/bcm/brcmstb/pm/pm-arm.c
> +++ b/drivers/soc/bcm/brcmstb/pm/pm-arm.c
> @@ -288,7 +288,7 @@ static inline void s5entry_method1(void)
>   		/* Step 3: Channel A (RST_N = CKE = 0) */
>   		tmp = readl_relaxed(ctrl.memcs[i].ddr_phy_base +
>   				  ctrl.phy_a_standby_ctrl_offs);
> -		tmp &= ~(DDR_PHY_RST_N | DDR_PHY_RST_N);
> +		tmp &= ~DDR_PHY_RST_N;

Based on step 3 comment above, maybe:

  -		tmp &= ~(DDR_PHY_RST_N | DDR_PHY_RST_N);
  +		tmp &= ~(DDR_PHY_RST_N | DDR_PHY_CKE);

?
>   		writel_relaxed(tmp, ctrl.memcs[i].ddr_phy_base +
>   			     ctrl.phy_a_standby_ctrl_offs);
>   
> @@ -296,7 +296,7 @@ static inline void s5entry_method1(void)
>   		if (ctrl.phy_b_standby_ctrl_offs != DDR_PHY_NO_CHANNEL) {
>   			tmp = readl_relaxed(ctrl.memcs[i].ddr_phy_base +
>   					  ctrl.phy_b_standby_ctrl_offs);
> -			tmp &= ~(DDR_PHY_RST_N | DDR_PHY_RST_N);
> +			tmp &= ~DDR_PHY_RST_N;

No such comment, but the code looks the same, so...

CJ

>   			writel_relaxed(tmp, ctrl.memcs[i].ddr_phy_base +
>   				     ctrl.phy_b_standby_ctrl_offs);
>   		}

