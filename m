Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B72705607
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 20:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjEPSdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 14:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEPSda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 14:33:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AA476BA
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 11:33:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEE13632ED
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 18:33:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE016C433D2;
        Tue, 16 May 2023 18:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684262005;
        bh=a7PTnqs0YEm7IsOGAlvOif0wre27TfjbZbHFQy0cnwU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rEa9im+Rl2Y/r0Y6FeNozIBqp5Zuk3+/eyERtBc0g5sI+ih30RXMoSsu+sN+tFfxj
         9HYfjcxHwxe4tLNtYzuGQQKP7uJISNhwhIR5r940lyJs0DQ770/NPseu81MkSQ8tUS
         AWipO7RjPqGElhY9WCcGeXysVrsGE74TCy7htWmf9XGXYaN7EDigzEZhkU0M+caz7S
         xPDu42RfMh0+W81Ae7ymp1R40QOC7UBEcqeKuobuDrxg1sUwHIJIPoFumo6HONtOnc
         KgFpGqblHmIDsVHvHFTry7WJwknjXOjeyjjgYlGV0LRUtIfMXxQ5EmPMyzTizphM3S
         ECk+e3H1+1ENA==
Message-ID: <3c7d7d0b-b859-8921-952c-870c9474969c@kernel.org>
Date:   Tue, 16 May 2023 21:33:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] phy: ti: gmii-sel: Allow parent to not be syscon node
Content-Language: en-US
To:     Andrew Davis <afd@ti.com>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230515195922.617243-1-afd@ti.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230515195922.617243-1-afd@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 15/05/2023 22:59, Andrew Davis wrote:
> If the parent node is not a syscon type, then fallback and check
> if we can get a regmap from our own node. This no longer forces
> us to make the parent of this node a syscon node when that might
> not be appropriate.

Trying to understand the motive for this and if it is better to
introduce a "syscon = <&syscon_node>" property instead which
makes it fool proof for all cases.

> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  drivers/phy/ti/phy-gmii-sel.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/phy/ti/phy-gmii-sel.c b/drivers/phy/ti/phy-gmii-sel.c
> index 8c667819c39a..1e67ed9a5cf6 100644
> --- a/drivers/phy/ti/phy-gmii-sel.c
> +++ b/drivers/phy/ti/phy-gmii-sel.c
> @@ -435,9 +435,12 @@ static int phy_gmii_sel_probe(struct platform_device *pdev)
>  
>  	priv->regmap = syscon_node_to_regmap(node->parent);
>  	if (IS_ERR(priv->regmap)) {
> -		ret = PTR_ERR(priv->regmap);
> -		dev_err(dev, "Failed to get syscon %d\n", ret);
> -		return ret;
> +		priv->regmap = device_node_to_regmap(node);
> +		if (IS_ERR(priv->regmap)) {
> +			ret = PTR_ERR(priv->regmap);
> +			dev_err(dev, "Failed to get syscon %d\n", ret);
> +			return ret;
> +		}
>  	}
>  
>  	ret = phy_gmii_sel_init_ports(priv);

-- 
cheers,
-roger
