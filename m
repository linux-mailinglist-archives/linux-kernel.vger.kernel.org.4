Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B615F704439
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 06:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjEPEGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 00:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjEPEGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 00:06:13 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EEE55BD
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 21:06:09 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34G45xMY010672;
        Mon, 15 May 2023 23:05:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684209959;
        bh=JNhUHHuThHL5ZN5KuFWCha6xK5Kp9GKuvY5H0edATkY=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=nl+1qLeesxlDh4JAy2+ajh+BWmaYn5uOHF5GMBpARo89o3N0J73u/Dsl2WcYnk+Y7
         0vRtFwqhFm4y8TqjBlRRKJe0aEQ79F8j7szqOSkaV6L9x23mGr94eHXGG68i93SDvM
         WKkolFXTY5GI0jQ6w9JzYn0y9ttCObI/WW9pNPhw=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34G45xPR015389
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 May 2023 23:05:59 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 May 2023 23:05:59 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 May 2023 23:05:59 -0500
Received: from [172.24.145.61] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34G45uCk048986;
        Mon, 15 May 2023 23:05:57 -0500
Message-ID: <5ae4bd37-65ee-d6da-1ab6-c1018d9959ec@ti.com>
Date:   Tue, 16 May 2023 09:35:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
CC:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <s-vadapalli@ti.com>
Subject: Re: [PATCH] phy: ti: gmii-sel: Allow parent to not be syscon node
To:     Andrew Davis <afd@ti.com>
References: <20230515195922.617243-1-afd@ti.com>
Content-Language: en-US
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20230515195922.617243-1-afd@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

On 16/05/23 01:29, Andrew Davis wrote:
> If the parent node is not a syscon type, then fallback and check
> if we can get a regmap from our own node. This no longer forces
> us to make the parent of this node a syscon node when that might
> not be appropriate.

Could you please let me know in which cases it is appropriate versus in which
cases it isn't? Is syscon_node_to_regmap() being retained for backward
compatibility until the device-tree nodes are cleaned up across all devices?

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

If device_node_to_regmap() can always be used with the corresponding changes
made to the device-tree nodes, wouldn't it be better to use it directly instead
of using it as a fallback? (This is based on the assumption that
syscon_node_to_regmap() is only being retained until the device-tree nodes are
cleaned up to work with device_node_to_regmap()).

> +		if (IS_ERR(priv->regmap)) {
> +			ret = PTR_ERR(priv->regmap);
> +			dev_err(dev, "Failed to get syscon %d\n", ret);
> +			return ret;
> +		}
>  	}
>  
>  	ret = phy_gmii_sel_init_ports(priv);

-- 
Regards,
Siddharth.
