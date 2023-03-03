Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993036A9350
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 10:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjCCJCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 04:02:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjCCJB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 04:01:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B2B580DF;
        Fri,  3 Mar 2023 01:01:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFF8F61797;
        Fri,  3 Mar 2023 09:00:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2DA3C4339E;
        Fri,  3 Mar 2023 09:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677834028;
        bh=qSU8P9ovgaEGbL9TP5hSM/7JR+YjdJKAQCgDYun/ZRU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YmqRqQasWdcB54Bd9GBHehqhhOl1Y1FGmyGrAgz2Fs8EmOJKB3tXsFv+0A+rrk0dL
         mPozdeisZfFiHZaJ5qHInyKgxRXfpF+sPaTIOgaz5LDdxoBAefS3d/hjZ30xLV/j+w
         RLZNuS1aM2ekwaZWCsSum8ZvebK72w3axfpjJtH4gYi9oJFedf+0ZGBFR1KMHnLvvD
         r3VeGItQ5EA/pys7NELt+JjDsvmZnaYEETw5GEY0400uNj3J6RM3jARI17IiPnNMDb
         PqVM1saWDaVZ2guFWzCq/N1bO78xMY868r5NIrG/fkOfpcxd7C4vbf2rVnVOWu1qDE
         /Y4yWZ1WqJzvg==
Date:   Fri, 3 Mar 2023 09:00:23 +0000
From:   Lee Jones <lee@kernel.org>
To:     Deepak R Varma <drv@mailo.com>
Cc:     Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: Re: [PATCH] leds: qcom-lpg: Release node reference before returning
Message-ID: <20230303090023.GJ2303077@google.com>
References: <Y+dw/0DA+j6xFiHR@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y+dw/0DA+j6xFiHR@ubun2204.myguest.virtualbox.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Feb 2023, Deepak R Varma wrote:

> The iterator for_each_available_child_of_node() increments the refcount
> of the child node it is processing. Release such a reference when the
> loop needs to breaks due to en error during its execution.
> Issue identified using for_each_child.cocci Coccinelle semantic patch.
> 
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
> Please note: The proposed change is compile tested only. I do not have the
> necessary hardware to perform additional testing. Please suggest if there is an
> alternate means available to further test this change.

Please send this again and include the authors.

Perhaps they would be kind enough to test it or provide guidance.
 
>  drivers/leds/rgb/leds-qcom-lpg.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
> index 67f48f222109..993fb9cf0204 100644
> --- a/drivers/leds/rgb/leds-qcom-lpg.c
> +++ b/drivers/leds/rgb/leds-qcom-lpg.c
> @@ -1112,8 +1112,10 @@ static int lpg_add_led(struct lpg *lpg, struct device_node *np)
>  		i = 0;
>  		for_each_available_child_of_node(np, child) {
>  			ret = lpg_parse_channel(lpg, child, &led->channels[i]);
> -			if (ret < 0)
> +			if (ret < 0) {
> +				of_node_put(child);
>  				return ret;
> +			}
>  
>  			info[i].color_index = led->channels[i]->color;
>  			info[i].intensity = 0;
> @@ -1291,8 +1293,10 @@ static int lpg_probe(struct platform_device *pdev)
>  
>  	for_each_available_child_of_node(pdev->dev.of_node, np) {
>  		ret = lpg_add_led(lpg, np);
> -		if (ret)
> +		if (ret) {
> +			of_node_put(np);
>  			return ret;
> +		}
>  	}
>  
>  	for (i = 0; i < lpg->num_channels; i++)
> -- 
> 2.34.1
> 
> 
> 

-- 
Lee Jones [李琼斯]
