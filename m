Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439056F14ED
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 12:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjD1KDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 06:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjD1KCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 06:02:52 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A395FFC;
        Fri, 28 Apr 2023 03:02:42 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33SA2M90107734;
        Fri, 28 Apr 2023 05:02:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1682676142;
        bh=xPAGe6USVONKPhacVckAD+PN9wf7T8+ye69IdQ+OCOA=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Zx0N0k8Fg48f/oi0xWH3MNGGt4IWE4drWka3JjMMGu9ZEsjmLY+aJCHXODDJYwyUg
         YLtsweoD5WqoGyyzY6pqMXIIDCAGfzVbVjbfS/kxFFTwgosY3PCS77THqypLFR0d9+
         dJCs+AzdbY3FybSuI/GyqYIpjUXKGm5iKxPxlo44=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33SA2Mc3094093
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Apr 2023 05:02:22 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Apr 2023 05:02:22 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Apr 2023 05:02:22 -0500
Received: from [10.24.69.26] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33SA2JKP126482;
        Fri, 28 Apr 2023 05:02:20 -0500
Message-ID: <951f0163-4b84-d12c-9c9a-8102abb51cfd@ti.com>
Date:   Fri, 28 Apr 2023 15:32:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH -next] soc: ti: smartreflex: Use
 devm_platform_ioremap_resource()
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, <nm@ti.com>
CC:     <ssantosh@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230428062825.126448-1-yang.lee@linux.alibaba.com>
From:   Dhruva Gole <d-gole@ti.com>
In-Reply-To: <20230428062825.126448-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 28/04/23 11:58, Yang Li wrote:
> Convert platform_get_resource(),devm_ioremap_resource() to a single
> call to devm_platform_ioremap_resource(), as this is exactly what this
> function does.
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>   drivers/soc/ti/smartreflex.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/ti/smartreflex.c b/drivers/soc/ti/smartreflex.c
> index da7898239a46..62b2f1464e46 100644
> --- a/drivers/soc/ti/smartreflex.c
> +++ b/drivers/soc/ti/smartreflex.c
> @@ -815,7 +815,6 @@ static int omap_sr_probe(struct platform_device *pdev)
>   {
>   	struct omap_sr *sr_info;
>   	struct omap_sr_data *pdata = pdev->dev.platform_data;
> -	struct resource *mem;
>   	struct dentry *nvalue_dir;
>   	int i, ret = 0;
>   
> @@ -835,8 +834,7 @@ static int omap_sr_probe(struct platform_device *pdev)
>   		return -EINVAL;
>   	}
>   
> -	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	sr_info->base = devm_ioremap_resource(&pdev->dev, mem);
> +	sr_info->base = devm_platform_ioremap_resource(pdev, 0);


Reviewed-by: Dhruva Gole <d-gole@ti.com>

>   	if (IS_ERR(sr_info->base))
>   		return PTR_ERR(sr_info->base);
>   

-- 
Thanks and Regards,
Dhruva Gole
