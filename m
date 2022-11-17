Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6D662D40E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 08:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239260AbiKQH2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 02:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239319AbiKQH2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 02:28:23 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3994299C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 23:28:22 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AH7SD8n032937;
        Thu, 17 Nov 2022 01:28:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1668670093;
        bh=tebsc38g2Whz8eftsOPrN/73sByHALX4RohyYL0Pyw0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=LrLYyMyJIrgPJ0ARW8sSx0XCbSFJ4H2EDCk4ibgqorK9M3RREKAuEzEHxO+J27yVC
         UDrukp9bI5CSA9HIIwkSVTpTTmgY3Zma7VPJU06XDs3v/6Xee6AGYx3w6tk8BfxBSg
         wkyC6o2FZQtAu+tdokUNeGtyeyqlpZjEbPp4VxTU=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AH7SDk4074125
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Nov 2022 01:28:13 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 17
 Nov 2022 01:28:13 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 17 Nov 2022 01:28:12 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2AH7SCGo072518;
        Thu, 17 Nov 2022 01:28:12 -0600
Date:   Thu, 17 Nov 2022 01:28:12 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Nicolas Frayer <nfrayer@baylibre.com>
CC:     <ssantosh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <khilman@baylibre.com>,
        <glaroque@baylibre.com>
Subject: Re: [PATCH v5 0/2] soc: ti: Add module build support to the k3
 socinfo driver
Message-ID: <20221117072812.ctrw54q2qqruxlts@dollhouse>
References: <20221116145103.26744-1-nfrayer@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221116145103.26744-1-nfrayer@baylibre.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15:51-20221116, Nicolas Frayer wrote:
> In order for the TI K3 SoC info driver to be built as a module, the
> following changes have been made:
> - Converted memory allocations to devm and added the remove callback
> - Added necessary code to build the driver as a module
> 
> v2->v3:
> dropped module conversion part of this series while other driver
> dependencies on socinfo are worked out.
> A dependency issue is introduced by changing subsys_initcall()
> to module_platform_driver(). Some drivers using the socinfo information
> probe before the socinfo driver itself and it makes their probe fail.
> 
> v3->v4:
> reintegrated the module build support and added patches for udma and mdio
> drivers to allow for deferred probe if socinfo hasn't probed yet.
> 
> v4->v5:
> Remove the k3 udma and mdio patches from this series and sent them
> individually
> 
> Nicolas Frayer (2):
>   soc: ti: Convert allocations to devm
>   soc: ti: Add module build support
> 
>  arch/arm64/Kconfig.platforms |  1 -
>  drivers/soc/ti/Kconfig       |  3 ++-
>  drivers/soc/ti/k3-socinfo.c  | 47 +++++++++++++++++++++++-------------
>  3 files changed, 32 insertions(+), 19 deletions(-)

Sorry about another respin, but could you fix up $subject as per
git log --oneline drivers/soc/ti/k3-socinfo.c

I think you might want to use "soc: ti: k3-socinfo:"
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
