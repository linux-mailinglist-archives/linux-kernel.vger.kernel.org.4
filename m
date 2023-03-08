Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA2C6B0F7A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 17:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjCHQ7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 11:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjCHQ6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 11:58:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C63960A5;
        Wed,  8 Mar 2023 08:57:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C18E61852;
        Wed,  8 Mar 2023 16:56:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E1CC433D2;
        Wed,  8 Mar 2023 16:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678294606;
        bh=mSiziORV5JOTz/dmr0twQJK+pWs676MExklouuLQSu4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TJJX9gQkCIR0opXes4eHqs5uTOE9Y9L7OqpcXEXaCkzPlUyPcnFfIQgJlEiPCW3Lu
         PpZscyFSSKIlryX5jP9682maJ20mVnI9p8SzClO438O2QWCnSX+BQgty2R0+Hyv5jY
         /EoOdCdKUtQIB+W9lRqWjC4w/101WiLe9e57NLNbccfUz55fZBMS3avpuGodcfpkyi
         hak+5qcsgwfnTSjFTUOgmfblvACWaI7ETIoIUG9bcNysnHoJbadxLcVndj82JLs9tu
         0v1/keyeB2AvlGRn7HHU1CnXTRGLbSSmUv3lRIq2/JcCYc+17KJWsJiEBTmUQrC0v0
         T93cFl2467BdQ==
Date:   Wed, 8 Mar 2023 09:56:44 -0700
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
Message-ID: <20230308165644.GA1181835@dev-arch.thelio-3990X>
References: <20230127221418.2522612-1-arnd@kernel.org>
 <Y/eULFO4jbivQ679@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/eULFO4jbivQ679@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping? This warning is now in 6.3-rc1.

On Thu, Feb 23, 2023 at 09:28:28AM -0700, Nathan Chancellor wrote:
> Hi Thierry, Daniel, and David,
> 
> On Fri, Jan 27, 2023 at 11:14:00PM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > The error handling for platform_get_irq() failing no longer
> > works after a recent change, clang now points this out with
> > a warning:
> > 
> > drivers/gpu/host1x/dev.c:520:6: error: variable 'syncpt_irq' is uninitialized when used here [-Werror,-Wuninitialized]
> >         if (syncpt_irq < 0)
> >             ^~~~~~~~~~
> > 
> > Fix this by removing the variable and checking the correct
> > error status.
> > 
> > Fixes: 625d4ffb438c ("gpu: host1x: Rewrite syncpoint interrupt handling")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/gpu/host1x/dev.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
> > index 4872d183d860..aae2efeef503 100644
> > --- a/drivers/gpu/host1x/dev.c
> > +++ b/drivers/gpu/host1x/dev.c
> > @@ -487,7 +487,6 @@ static int host1x_get_resets(struct host1x *host)
> >  static int host1x_probe(struct platform_device *pdev)
> >  {
> >  	struct host1x *host;
> > -	int syncpt_irq;
> >  	int err;
> >  
> >  	host = devm_kzalloc(&pdev->dev, sizeof(*host), GFP_KERNEL);
> > @@ -517,8 +516,8 @@ static int host1x_probe(struct platform_device *pdev)
> >  	}
> >  
> >  	host->syncpt_irq = platform_get_irq(pdev, 0);
> > -	if (syncpt_irq < 0)
> > -		return syncpt_irq;
> > +	if (host->syncpt_irq < 0)
> > +		return host->syncpt_irq;
> >  
> >  	mutex_init(&host->devices_lock);
> >  	INIT_LIST_HEAD(&host->devices);
> > -- 
> > 2.39.0
> > 
> 
> Apologies if this has been reported already or has a solution in
> progress but mainline is now broken because this change got separated
> from the change it is fixing:
> 
> https://github.com/ClangBuiltLinux/continuous-integration2/actions/runs/4249931209/jobs/7391912774
> https://storage.tuxsuite.com/public/clangbuiltlinux/continuous-integration2/builds/2M7y9HpiXB13qiC2mkHMyeZOcLW/build.log
> 
> I see this change sitting in the drm-tegra tree [1], which is getting
> merged into -next, so it is fixed there, which is why we did not notice
> any issues until the drm-next tree was merged into mainline. Can this be
> fast tracked to Linus to unbreak clang builds with -Werror?
> 
> [1]: https://gitlab.freedesktop.org/drm/tegra/-/commit/b9930311641cf2ed905a84aabe27e8f3868aee4a
