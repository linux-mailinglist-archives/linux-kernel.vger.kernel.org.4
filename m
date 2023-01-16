Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6B066CDEE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 18:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbjAPRuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 12:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235074AbjAPRuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 12:50:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E19E3D080
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 09:32:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0BB4B810A1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 17:32:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC23C433D2;
        Mon, 16 Jan 2023 17:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673890321;
        bh=2GR85MBuqs9vE7Za6dHRX2H1EOHPAUnhojuYunISfnI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B1T16ntPN+ehulGd9XjbKZ5eozUsdnpcrrfEM8xQQV+2T5M5tGfjj4O9XisV8ehJ9
         yA7/04+JZc6Ln4Z4DhCGfQ6xm934Y92s4N+qFJCbvaBjqEBvpbbrWr0Dle05pL3BHv
         sEcrPeGxHx4tAnf7rjnv4wvDr+2pZetg9OZAFrhI4svhpgCROzotybTraN48gD72UO
         lUKP9eCRej5/5XDZF17GTPIG4pSqpcRHN48iRmYKE3c8QZeP/8EjM5kxSV0krvSCJL
         oYQTVMdpzXSBq/7OgMFwScaFXqbWiTQt/Jj0i+IMOWkPghhicYaWtvgPh3DSqi+qSD
         c0DsGbHuMlenQ==
From:   SeongJae Park <sj@kernel.org>
To:     Huaisheng Ye <huaisheng.ye@intel.com>
Cc:     sj@kernel.org, akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/core: skip apply schemes if empty
Date:   Mon, 16 Jan 2023 17:31:59 +0000
Message-Id: <20230116173159.23307-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230116062347.1148553-1-huaisheng.ye@intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Huaisheng,

On Mon, 16 Jan 2023 14:23:47 +0800 Huaisheng Ye <huaisheng.ye@intel.com> wrote:

> Sometimes there is no scheme in damon's context, for example
> just use damo record to monitor workload's data access pattern.
> 
> If current damon context doesn't have any scheme in the list,
> kdamond has no need to iterate over list of all targets and regions
> but do nothing.
> 
> So, skip apply schemes when ctx->schemes is empty.

Good finding, thanks!

> 
> Signed-off-by: Huaisheng Ye <huaisheng.ye@intel.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
>  mm/damon/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index ceec75b88ef9..f338691e4591 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1230,7 +1230,8 @@ static int kdamond_fn(void *data)
>  			if (ctx->callback.after_aggregation &&
>  					ctx->callback.after_aggregation(ctx))
>  				break;
> -			kdamond_apply_schemes(ctx);
> +			if (!list_empty(&ctx->schemes))
> +				kdamond_apply_schemes(ctx);
>  			kdamond_reset_aggregated(ctx);
>  			kdamond_split_regions(ctx);
>  			if (ctx->ops.reset_aggregated)
> -- 
> 2.31.1
> 
> 
