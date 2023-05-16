Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B42F7051FA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbjEPPVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233997AbjEPPU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:20:59 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2202040E8;
        Tue, 16 May 2023 08:20:58 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34GFKhRJ047095;
        Tue, 16 May 2023 10:20:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684250443;
        bh=jnLrcu0eOUoX1UidnkX2uPXFwv9flHOtRKmBMNOjhAI=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=bhckaHOEV0Vrwx7IZ+/23oJZnmI7dTTw665ZvvcCmCeGt5S9S4XBc4YFGjir2ZyTD
         vDU/4eZ6V7dEpdi4rI1g46EBeWcy2jbAG3cwzVfKcsWEnW3T33PSgtPs3fdp8/aKNP
         eFgI934y+kxcs9IAu6sF2r2CWAJCBftJh9COu98c=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34GFKhxm019444
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 May 2023 10:20:43 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 16
 May 2023 10:20:43 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 16 May 2023 10:20:43 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34GFKhJ7061028;
        Tue, 16 May 2023 10:20:43 -0500
Date:   Tue, 16 May 2023 10:20:43 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Markus Elfring <Markus.Elfring@web.de>
CC:     <kernel-janitors@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <kristo@kernel.org>, <cocci@inria.fr>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [cocci] [PATCH] firmware: ti_sci: Fix exception handling in
 ti_sci_probe()
Message-ID: <20230516152043.bq2hnessstrhbc6s@distort>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <8f785de5-ebe2-edd9-2155-f440acacc643@web.de>
 <f1eaec48-cabb-5fc6-942b-f1ef7af9bb57@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f1eaec48-cabb-5fc6-942b-f1ef7af9bb57@web.de>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22:10-20230405, Markus Elfring wrote:
> Date: Wed, 5 Apr 2023 22:00:18 +0200

B4 does'nt pick this patch up cleanly. And for some reason, I get
mangled patch from public-inbox as well :( a clean git-send-email might
help.

> 
> The label “out” was used to jump to another pointer check despite of

Please use " for quotes.

> the detail in the implementation of the function “ti_sci_probe”
> that it was determined already that the corresponding variable
> contained an error pointer because of a failed call of
> the function “mbox_request_channel_byname”.

> 
> * Thus use more appropriate labels instead.
> 
> * Delete two redundant checks.
> 

How about this:

Optimize out the redundant pointer check in exit path of "out" using
appropriate labels to jump in the error path
> 
Drop the extra EoL

> This issue was detected by using the Coccinelle software.

Curious: what rule of coccicheck caught this?

> 
> Fixes: aa276781a64a5f15ecc21e920960c5b1f84e5fee ("firmware: Add basic support for TI System Control Interface (TI-SCI) protocol")

12 char sha please. Please read Documentation/process/submitting-patches.rst

> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/firmware/ti_sci.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index 039d92a595ec..77012d2f4160 100644
> --- a/drivers/firmware/ti_sci.c
turns out as =2D-- instead of -- (might check the git format-patch
output closer).

> +++ b/drivers/firmware/ti_sci.c
> @@ -3433,18 +3433,18 @@ static int ti_sci_probe(struct platform_device *pdev)
>  	info->chan_rx = mbox_request_channel_byname(cl, "rx");
>  	if (IS_ERR(info->chan_rx)) {
>  		ret = PTR_ERR(info->chan_rx);
> -		goto out;
> +		goto remove_debugfs;
>  	}
> 
>  	info->chan_tx = mbox_request_channel_byname(cl, "tx");
>  	if (IS_ERR(info->chan_tx)) {
>  		ret = PTR_ERR(info->chan_tx);
> -		goto out;
> +		goto free_mbox_channel_rx;
>  	}
>  	ret = ti_sci_cmd_get_revision(info);
>  	if (ret) {
>  		dev_err(dev, "Unable to communicate with TISCI(%d)\n", ret);
> -		goto out;
> +		goto free_mbox_channel_tx;
>  	}
> 
>  	ti_sci_setup_ops(info);
> @@ -3456,7 +3456,7 @@ static int ti_sci_probe(struct platform_device *pdev)
>  		ret = register_restart_handler(&info->nb);
>  		if (ret) {
>  			dev_err(dev, "reboot registration fail(%d)\n", ret);
> -			goto out;
> +			goto free_mbox_channel_tx;
>  		}
>  	}
> 
> @@ -3470,11 +3470,12 @@ static int ti_sci_probe(struct platform_device *pdev)
>  	mutex_unlock(&ti_sci_list_mutex);
> 
>  	return of_platform_populate(dev->of_node, NULL, NULL, dev);
> -out:
> -	if (!IS_ERR(info->chan_tx))
> -		mbox_free_channel(info->chan_tx);
> -	if (!IS_ERR(info->chan_rx))
> -		mbox_free_channel(info->chan_rx);
> +
> +free_mbox_channel_tx:
> +	mbox_free_channel(info->chan_tx);
> +free_mbox_channel_rx:
> +	mbox_free_channel(info->chan_rx);
> +remove_debugfs:
>  	debugfs_remove(info->d);
>  	return ret;
>  }
> --
> 2.40.0
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
