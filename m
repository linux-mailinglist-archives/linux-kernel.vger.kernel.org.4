Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207DA61767A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 06:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbiKCF6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 01:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiKCF5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 01:57:55 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DAA5598
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 22:57:52 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2A35vaKU001401;
        Thu, 3 Nov 2022 00:57:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667455056;
        bh=aQLHO0tfG1+nYxW1sZcdLelyPml8l1CAuYKSu3DDLFY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=BG7uH/XFITlBIE99V0xK9YrlfEI2EtYOiC7TjlF0gS78o7u6DKKiGaUjTgfdt9pQ3
         fkx0lnr6XGMJqPj2bFJsI/+n9o3UWm71h/LtiWVCgBU2+ymMYma83lWjIsh+/Zi7kA
         8LQonU6B6dxW8N8Z0J1Ci6Gku8HCuIHrjI00iE/8=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2A35vaOw087235
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Nov 2022 00:57:36 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 3 Nov
 2022 00:57:35 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 3 Nov 2022 00:57:36 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2A35vZDt015191;
        Thu, 3 Nov 2022 00:57:35 -0500
Date:   Thu, 3 Nov 2022 00:57:35 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, kernel test robot <lkp@intel.com>,
        Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH] reset: ti-sci: honor TI_SCI_PROTOCOL setting when not
 COMPILE_TEST
Message-ID: <20221103055735.eo7t5aqniwlp2ykv@roulette>
References: <20221030055636.3139-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221030055636.3139-1-rdunlap@infradead.org>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22:56-20221029, Randy Dunlap wrote:
> There is a build error when COMPILE_TEST=y, TI_SCI_PROTOCOL=m,
> and RESET_TI_SCI=y:
> 
> drivers/reset/reset-ti-sci.o: in function `ti_sci_reset_probe':
> reset-ti-sci.c:(.text+0x22c): undefined reference to `devm_ti_sci_get_handle'
> 
> Fix this by making RESET_TI_SCI honor the Kconfig setting of
> TI_SCI_PROTOCOL when COMPILE_TEST is not set. When COMPILE_TEST is set,
> TI_SCI_PROTOCOL must be disabled (=n).
> 
> Fixes: a6af504184c9 ("reset: ti-sci: Allow building under COMPILE_TEST")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Tero Kristo <kristo@kernel.org>
> Cc: Santosh Shilimkar <ssantosh@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  drivers/reset/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -- a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -257,7 +257,7 @@ config RESET_SUNXI
>  
>  config RESET_TI_SCI
>  	tristate "TI System Control Interface (TI-SCI) reset driver"
> -	depends on TI_SCI_PROTOCOL || COMPILE_TEST
> +	depends on TI_SCI_PROTOCOL || (COMPILE_TEST && TI_SCI_PROTOCOL=n)
>  	help
>  	  This enables the reset driver support over TI System Control Interface
>  	  available on some new TI's SoCs. If you wish to use reset resources

Reviewed-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
