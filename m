Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9619D5FB8DC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 19:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiJKRCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 13:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiJKRCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 13:02:33 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2740E43AC7;
        Tue, 11 Oct 2022 10:02:32 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id t10-20020a17090a4e4a00b0020af4bcae10so13771897pjl.3;
        Tue, 11 Oct 2022 10:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8eRz9lupDvDdx3arCB9zqmOVqRgcbX6KAfstA0H6aeE=;
        b=H93cQgxKhWvRmxhNCyPVUJ0JihVjsjM9VYphS6RAehXSGKKG3m/DC7W9mffVNn/pqQ
         aTq45+gyvzY0A8AvN/kZw4ZKR4qG+GrBPDpyfVLCvHYGHxu8MHYaSruImPjns902FG0y
         +kHDLZSD5VcrQYK1p+DjyIm3EOSg3HsypzNIIWFnfd6UUFLTmVhZ0iGBprYTWY8yG4Jw
         RGzVkmwqq2+DjEYeLn7EfNg1daDE9kqN4y2bG3wejSwVvENGXPHLE8Mr2jkdNJV72UG8
         qZeB1bF+GlfqgHYc2ACJSOVebUG/MPStUnXmbsMR0AOAV4ish0uqH8Vwdo+dL563BzhJ
         5J6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8eRz9lupDvDdx3arCB9zqmOVqRgcbX6KAfstA0H6aeE=;
        b=5BCKsi4jzMnVRW/7JwSDuqdNiNnGpj7mrPGO77TkMgSMRbVjhRqKUW0jb2t8lYKHoE
         Mr6T0t3s7tMiRC5YYeFCfjFQuf9zEzeaKjGHGaqvN1GLtrjOazGPafa4CtqRgjqA5xro
         aWMMR41OiAnwNkraVOimnq54m7ROcze9CCnLuBmYkgSF2BjR89GQahlpziVR0bs153Ge
         dByUNWkKMLfhNt/PnG7BdTGZpTjTjm6Nn//4YCDTkr699qBKND8+M7sB7QynilJP21aR
         kqatviUDCqT1LRC10TMEnDdroiTkshXacCfssZ51wk8u5ff/u7/VVXoK7Kw85r8Wg7C3
         Uibw==
X-Gm-Message-State: ACrzQf0I9lNf6lE+S5Q06bypp8k98xDr3+b/iY3xFHTZgqQGyfmS0jOF
        yCuycXd6XFSsS92r8K6bFm4=
X-Google-Smtp-Source: AMsMyM7s7/eOhf2xT24hBT6++YnR4amW46bPXSBch6LK2z+6SxfxKBgWKDjgQH0Gq21wTGo+Kk+Stg==
X-Received: by 2002:a17:902:6b81:b0:182:df88:e6ce with SMTP id p1-20020a1709026b8100b00182df88e6cemr9030343plk.173.1665507752185;
        Tue, 11 Oct 2022 10:02:32 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id y8-20020a17090322c800b00176b63535adsm8951512plg.260.2022.10.11.10.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 10:02:31 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 11 Oct 2022 07:02:30 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next 4/5] blk-iocost: bypass if only one cgroup issues io
Message-ID: <Y0WhpuqK/8CEZAGc@slm.duckdns.org>
References: <20221011083547.1831389-1-yukuai1@huaweicloud.com>
 <20221011083547.1831389-5-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011083547.1831389-5-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 04:35:46PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> In this special case, there is no need to throttle io.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/blk-iocost.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index 5acc5f13bbd6..32e7e416d67c 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -2564,8 +2564,13 @@ static void ioc_rqos_throttle(struct rq_qos *rqos, struct bio *bio)
>  	bool use_debt, ioc_locked;
>  	unsigned long flags;
>  
> -	/* bypass IOs if disabled, still initializing, or for root cgroup */
> -	if (!ioc->enabled || !iocg || !iocg->level)
> +	/*
> +	 * bypass IOs if disabled, still initializing, for root cgroup,
> +	 * or the cgroup is the only cgroup with io.
> +	 */
> +	if (!ioc->enabled || !iocg || !iocg->level ||
> +	    (iocg->hweight_inuse == WEIGHT_ONE &&
> +	     atomic_read(&ioc->hweight_gen) == iocg->hweight_gen))

I'm not sure about this one. Bypassing here means that we lose track of how
much IO it's issuing which can affect future throttling decisions, right?

Thanks.

-- 
tejun
