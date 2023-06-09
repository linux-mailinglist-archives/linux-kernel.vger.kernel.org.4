Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272C17296E5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 12:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241477AbjFIKbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 06:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241143AbjFIKbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 06:31:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C105B5599
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 03:23:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54DA865674
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 10:23:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86858C433EF;
        Fri,  9 Jun 2023 10:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686306203;
        bh=jokXRQ/Afrc/Il5mpiYP/ZSsYCJK2XP/mW2BduDXGRo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=odWF9annpoAePCQk9W5fYJzKk1nOlX0qTIzryocOT3UuFvJ2w+ZSn8x51I40zgOrY
         Gxpifiqr4Xfa5Ux18Vh5m36FfEuWKQreeDyVHZzkrcADV4qsQ5WYukSPVJxjubFuVo
         Q42LNL7su5ETj3ou9/6QwORZtG/ZQFqAd5TQfEMX9qxpHyXuSPEKt+Li++0BYpTiSY
         GovVrAF5ilDE77N5q0PaeIUYAJosnK7cmPrGxUIvdTiNd7c0bP5IkgspPb4LTsMC++
         6IZJRAQv+HaNdr/l0JL5JVaNnJ+296JWPgmGzsbiA1f+DZRkyQTmUxfYPNDyEn54pI
         3b832VHPcromw==
Date:   Fri, 9 Jun 2023 11:23:16 +0100
From:   Will Deacon <will@kernel.org>
To:     Song Shuai <songshuaishuai@tinylab.org>
Cc:     catalin.marinas@arm.com, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, chris@zankel.net,
        jcmvbkbc@gmail.com, steven.price@arm.com,
        vincenzo.frascino@arm.com, leyfoon.tan@starfivetech.com,
        mason.huo@starfivetech.com, jeeheng.sia@starfivetech.com,
        conor.dooley@microchip.com, ajones@ventanamicro.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH V2 2/4] arm64: hibernate: remove WARN_ON in
 save_processor_state
Message-ID: <20230609102315.GA3847@willie-the-truck>
References: <20230609075049.2651723-1-songshuaishuai@tinylab.org>
 <20230609075049.2651723-3-songshuaishuai@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609075049.2651723-3-songshuaishuai@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 03:50:47PM +0800, Song Shuai wrote:
> During hibernation or restoration, freeze_secondary_cpus
> checks num_online_cpus via BUG_ON, and the subsequent
> save_processor_state also does the checking with WARN_ON.
> 
> In the case of CONFIG_PM_SLEEP_SMP=n, freeze_secondary_cpus
> is not defined, but the sole possible condition to disable
> CONFIG_PM_SLEEP_SMP is !SMP where num_online_cpus is always 1.
> We also don't have to check it in save_processor_state.
> 
> So remove the unnecessary checking in save_processor_state.
> 
> Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
> ---
>  arch/arm64/kernel/hibernate.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
> index 788597a6b6a2..02870beb271e 100644
> --- a/arch/arm64/kernel/hibernate.c
> +++ b/arch/arm64/kernel/hibernate.c
> @@ -99,7 +99,6 @@ int pfn_is_nosave(unsigned long pfn)
>  
>  void notrace save_processor_state(void)
>  {
> -	WARN_ON(num_online_cpus() != 1);
>  }
>  
>  void notrace restore_processor_state(void)

Acked-by: Will Deacon <will@kernel.org>

Thanks!

Will
