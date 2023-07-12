Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365F2750AF2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbjGLO1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbjGLO1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:27:40 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECE11989
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 07:27:13 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36CER5ch029292;
        Wed, 12 Jul 2023 09:27:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689172025;
        bh=tgpzX7QWPsEBoq2YVex6dFWCYww0hHbnLKRoDTJV320=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=ud5lIk2HMJBOE1USreiJPCpCezK5SdhGru23J3JJ4zgf6mC5ybZgsONo0GWNRAo7S
         K26fBhvO8lLyfyu2bXWp89/zXJpKlu8Jx+ZX9MwI5xUQROJYiBRI6H4R4M8grj9HPZ
         N0LkXsHrsUcrXcb4wB8atyXxOdYOnSmQvxSjgbq8=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36CER5ll011000
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Jul 2023 09:27:05 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jul 2023 09:27:04 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jul 2023 09:27:04 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36CER4BE014048;
        Wed, 12 Jul 2023 09:27:04 -0500
Date:   Wed, 12 Jul 2023 09:27:04 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Jayesh Choudhary <j-choudhary@ti.com>
CC:     <ssantosh@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH v2] soc: ti: k3-ringacc: remove non-fatal probe
 deferral log
Message-ID: <20230712142704.3o5s7pbh4ul7ifak@carport>
References: <20230710104215.156114-1-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230710104215.156114-1-j-choudhary@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16:12-20230710, Jayesh Choudhary wrote:
> Drop the non-fatal probe deferral log for getting MSI domain.
> This makes the kernel log clean and we do not get recurring logs
> stating: "Failed to get MSI domain".
> 
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
> 
> v2 patch: <https://lore.kernel.org/all/20230117052052.29953-1-j-choudhary@ti.com/>
> 
> Changelog v1->v2:
> - Removed the print instead of dropping the loglevel according to the comment
>   on similar patch for udma:
>   <https://lore.kernel.org/all/Y6wiXlZh1MUL2WrF@matsya/>
>   
> v1 patch: <https://lore.kernel.org/all/20221128102138.529398-1-j-choudhary@ti.com/>
> 
>  drivers/soc/ti/k3-ringacc.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
> index 8f131368a758..5eb81895f8bc 100644
> --- a/drivers/soc/ti/k3-ringacc.c
> +++ b/drivers/soc/ti/k3-ringacc.c
> @@ -1374,7 +1374,6 @@ static int k3_ringacc_init(struct platform_device *pdev,
>  	dev->msi.domain = of_msi_get_domain(dev, dev->of_node,
>  					    DOMAIN_BUS_TI_SCI_INTA_MSI);
>  	if (!dev->msi.domain) {
> -		dev_err(dev, "Failed to get MSI domain\n");
>  		return -EPROBE_DEFER;
>  	}

Do you need braces for a one liner? why not drop them?
>  
> -- 
> 2.25.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
