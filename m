Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E7F6A0E09
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 17:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234296AbjBWQ27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 11:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234612AbjBWQ2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 11:28:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFD71732;
        Thu, 23 Feb 2023 08:28:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9C3661752;
        Thu, 23 Feb 2023 16:28:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD26C433EF;
        Thu, 23 Feb 2023 16:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677169710;
        bh=QNtwL+3aQI5NX8KHQuxRVNJuJdxCfz9xgbVF4PuC1B4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ecOScmMnD4FY54PQcTo/sUh3wM/bq5x1gw2ldgd1gw3GsMiqGMHcx0hQYQ6U4hBej
         JmDyZ/Tx/1Qq6N0Hg17t9W2gweAb3BddapdcI/ALIUxvRBHfrvLcAJBSsOWAbu0fnC
         W14+vs8BlJ71JMPpCahFLIAWbKCnPLUmMkEAtp5w6825yBsUda4LMq9B4bG9xNMfcw
         CVVgYVBhmI4PeoxciEBACllNI08VRVitgE7xwwY2RSeLpNshH0H6Q/1qGVi8gTEhuA
         qunB88ExeofQLMfkFWy/9ZOpGNkuYSTulZCZOf2e0uu2yRzsX+EEqYlLb/zFlYUlnW
         2q/C8GezC7vtw==
Date:   Thu, 23 Feb 2023 09:28:28 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Robin Murphy <robin.murphy@arm.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] gpu: host1x: fix uninitialized variable use
Message-ID: <Y/eULFO4jbivQ679@dev-arch.thelio-3990X>
References: <20230127221418.2522612-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127221418.2522612-1-arnd@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry, Daniel, and David,

On Fri, Jan 27, 2023 at 11:14:00PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The error handling for platform_get_irq() failing no longer
> works after a recent change, clang now points this out with
> a warning:
> 
> drivers/gpu/host1x/dev.c:520:6: error: variable 'syncpt_irq' is uninitialized when used here [-Werror,-Wuninitialized]
>         if (syncpt_irq < 0)
>             ^~~~~~~~~~
> 
> Fix this by removing the variable and checking the correct
> error status.
> 
> Fixes: 625d4ffb438c ("gpu: host1x: Rewrite syncpoint interrupt handling")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/host1x/dev.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
> index 4872d183d860..aae2efeef503 100644
> --- a/drivers/gpu/host1x/dev.c
> +++ b/drivers/gpu/host1x/dev.c
> @@ -487,7 +487,6 @@ static int host1x_get_resets(struct host1x *host)
>  static int host1x_probe(struct platform_device *pdev)
>  {
>  	struct host1x *host;
> -	int syncpt_irq;
>  	int err;
>  
>  	host = devm_kzalloc(&pdev->dev, sizeof(*host), GFP_KERNEL);
> @@ -517,8 +516,8 @@ static int host1x_probe(struct platform_device *pdev)
>  	}
>  
>  	host->syncpt_irq = platform_get_irq(pdev, 0);
> -	if (syncpt_irq < 0)
> -		return syncpt_irq;
> +	if (host->syncpt_irq < 0)
> +		return host->syncpt_irq;
>  
>  	mutex_init(&host->devices_lock);
>  	INIT_LIST_HEAD(&host->devices);
> -- 
> 2.39.0
> 

Apologies if this has been reported already or has a solution in
progress but mainline is now broken because this change got separated
from the change it is fixing:

https://github.com/ClangBuiltLinux/continuous-integration2/actions/runs/4249931209/jobs/7391912774
https://storage.tuxsuite.com/public/clangbuiltlinux/continuous-integration2/builds/2M7y9HpiXB13qiC2mkHMyeZOcLW/build.log

I see this change sitting in the drm-tegra tree [1], which is getting
merged into -next, so it is fixed there, which is why we did not notice
any issues until the drm-next tree was merged into mainline. Can this be
fast tracked to Linus to unbreak clang builds with -Werror?

[1]: https://gitlab.freedesktop.org/drm/tegra/-/commit/b9930311641cf2ed905a84aabe27e8f3868aee4a

Cheers,
Nathan
