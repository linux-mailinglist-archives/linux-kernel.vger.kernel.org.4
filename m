Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1925F78BA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 15:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiJGNPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 09:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiJGNPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 09:15:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E73784E7E;
        Fri,  7 Oct 2022 06:15:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED40BB822E4;
        Fri,  7 Oct 2022 13:15:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 311D1C433C1;
        Fri,  7 Oct 2022 13:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665148537;
        bh=qDQjV6c5Y6GnUrWjc3kbcVPC14TyP0441OSeC6p4DQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XxoCU85jZtz70BMnbtoU6br731dgFcwenXJ8AKlCa6yCCT45HZ4emadkfwtbf0AOa
         toktV6MSku47ocMv/Y0uiBQZAjd432DmelmNgC8IsGkan6jGhWagCf96WAt26OJlPJ
         /jqvHud+uzHd1Wc8K6vwUT89S7HxanKgoACJ3BJo8KEKKlt7mfIi/hderJVlJa9h74
         Wyh1SlZg/Eovvx7Rg5Kw+oopB7nChyQlGgjxasJcowMZamSizQOD71tN+nZn2azIHm
         TrOiz5Gk2XKwGBKxo6Flgcmm2xShM9NzXht465PIBpDKwBPTiKM5LJvHhk39rx+N1/
         +tsMloR27o6zw==
Date:   Fri, 7 Oct 2022 14:15:32 +0100
From:   Will Deacon <will@kernel.org>
To:     Sun Ke <sunke32@huawei.com>, catalin.marinas@arm.com
Cc:     mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        xueshuai@linux.alibaba.com
Subject: Re: [PATCH] drivers/perf: fix return value check in
 ali_drw_pmu_probe()
Message-ID: <20221007131531.GA26341@willie-the-truck>
References: <20220924032127.313156-1-sunke32@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220924032127.313156-1-sunke32@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 24, 2022 at 11:21:27AM +0800, Sun Ke wrote:
> In case of error, devm_ioremap_resource() returns ERR_PTR(),
> and never returns NULL. The NULL test in the return value
> check should be replaced with IS_ERR().
> 
> Fixes: cf7b61073e45 ("drivers/perf: add DDR Sub-System Driveway PMU driver for Yitian 710 SoC")
> Signed-off-by: Sun Ke <sunke32@huawei.com>
> ---
>  drivers/perf/alibaba_uncore_drw_pmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/perf/alibaba_uncore_drw_pmu.c b/drivers/perf/alibaba_uncore_drw_pmu.c
> index 82729b874f09..a7689fecb49d 100644
> --- a/drivers/perf/alibaba_uncore_drw_pmu.c
> +++ b/drivers/perf/alibaba_uncore_drw_pmu.c
> @@ -658,8 +658,8 @@ static int ali_drw_pmu_probe(struct platform_device *pdev)
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	drw_pmu->cfg_base = devm_ioremap_resource(&pdev->dev, res);
> -	if (!drw_pmu->cfg_base)
> -		return -ENOMEM;
> +	if (IS_ERR(drw_pmu->cfg_base))
> +		return PTR_ERR(drw_pmu->cfg_base);
>  
>  	name = devm_kasprintf(drw_pmu->dev, GFP_KERNEL, "ali_drw_%llx",
>  			      (u64) (res->start >> ALI_DRW_PMU_PA_SHIFT));

Acked-by: Will Deacon <will@kernel.org>

Catalin can pick this one up as a fix.

Cheers,

Will
