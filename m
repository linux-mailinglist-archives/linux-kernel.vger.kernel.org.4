Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6235BE1DB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiITJZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiITJZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:25:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4178B6A4A3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 02:25:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F26FAB810C6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 09:25:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D1CC433D7;
        Tue, 20 Sep 2022 09:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663665951;
        bh=jH9tPdmENT1ypJcsWfFwGyWxcRYiaiJsZh880baFBwc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h1Ovh98HVYdVY50jzNK/a7igF/eY495zWoCoViIRB6zv4hNZ969O5VS5/jR4e5g++
         6iH9WGF/IpnkXfqUcjbg48GhQtZdIvQjgflwBMn7yEqRwehnOKwwhnYoFiJwOaUiy6
         U29CzeSSO6ugCKaZtpXPRMZl7QOSkdCQUGMZzjEpFpMtxWR+XIWy2pTAHvaPZKPoXZ
         QLOAYsL8flNuBlbGMujtEvybCRvb5H707FS6u5LtwSgwhuWywr5VObXaS8aTcUzZn9
         LrVXsLNmRxU9ucJTik0BMGo12UbzN7obF8OOMDYuiCcL13zz/Qco8rouu66wpcS67e
         2fY9507MSea+Q==
Date:   Tue, 20 Sep 2022 10:25:47 +0100
From:   Lee Jones <lee@kernel.org>
To:     Sebastian Urban <surban@surban.net>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: take OF node reference for MFD cell platform device
Message-ID: <YymHG4OmMktrRqof@google.com>
References: <20220917094132.458194-1-surban@surban.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220917094132.458194-1-surban@surban.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Sep 2022, Sebastian Urban wrote:

> Properly increase OF node reference count when assigning it to a
> platform device created for an MFD cell.
> 
> Signed-off-by: Sebastian Urban <surban@surban.net>
> ---
>  drivers/mfd/mfd-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> index 16d1861e9682..8e57f67719cf 100644
> --- a/drivers/mfd/mfd-core.c
> +++ b/drivers/mfd/mfd-core.c
> @@ -161,7 +161,7 @@ static int mfd_match_of_node_to_dev(struct platform_device *pdev,
>  	of_entry->np = np;
>  	list_add_tail(&of_entry->list, &mfd_of_node_list);
>  
> -	pdev->dev.of_node = np;
> +	pdev->dev.of_node = of_node_get(np);

Doesn't this cause an imbalance?

Or is there already a put somewhere?

>  	pdev->dev.fwnode = &np->fwnode;
>  #endif
>  	return 0;

-- 
Lee Jones [李琼斯]
