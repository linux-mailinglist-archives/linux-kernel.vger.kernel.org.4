Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2BFA7179D8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235190AbjEaIT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235145AbjEaITY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:19:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C17010E;
        Wed, 31 May 2023 01:19:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D098B637F4;
        Wed, 31 May 2023 08:19:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C410FC433D2;
        Wed, 31 May 2023 08:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685521160;
        bh=0HCQtl+r90qoo8vag/j4fmBsYtYN/bLTT76larf8Zh8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AXU+m6wUmO04i+P8FRRsQWmSDFaUGpTI8wLkyT496Wm6nPchKPS5Wa32z/mjLweic
         LWBL1gR289uyb9YbVtDBEkogCpNM0xV+41uYlwQcUZml2zZjU7TNN2Q7j0SuMyU8wQ
         Sd4SrG/Q/EiVAVthWxdfFO1WNbCwjVpFgJIatnMPfQ3eTnxALJvX2R4t2nQyqQgSW+
         nNH8cpv+2hFu510vTfmm+eK2ZohnviIo2+A1Rpo36HH6G4Ar2zlBugpwHHT/FlONa4
         vZvIG/2bebOosP2ljYuo+8dAk64rnFCLL7Ns5rU0blWMFDu9vwY4RXQGTDCCFoFKGc
         S192en2LAOZEQ==
Date:   Wed, 31 May 2023 10:19:17 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     lm0963 <lm0963hack@gmail.com>
Cc:     inki.dae@samsung.com, sw0312.kim@samsung.com,
        kyungmin.park@samsung.com, airlied@gmail.com, daniel@ffwll.ch,
        krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/exynos: fix race condition UAF in
 exynos_g2d_exec_ioctl
Message-ID: <20230531081917.grx3qqqm7usaqoa5@intel.intel>
References: <20230526130131.16521-1-lm0963hack@gmail.com>
 <20230530222150.24oogloda6wtvpvm@intel.intel>
 <CAAgLYK7FNrAYFRp7C3LDtqevFENQLw8YYAFR2Pk9wdfQ5RKVeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAgLYK7FNrAYFRp7C3LDtqevFENQLw8YYAFR2Pk9wdfQ5RKVeg@mail.gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Min,

> > > If it is async, runqueue_node is freed in g2d_runqueue_worker on another
> > > worker thread. So in extreme cases, if g2d_runqueue_worker runs first, and
> > > then executes the following if statement, there will be use-after-free.
> > >
> > > Signed-off-by: Min Li <lm0963hack@gmail.com>
> > > ---
> > >  drivers/gpu/drm/exynos/exynos_drm_g2d.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/exynos/exynos_drm_g2d.c b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
> > > index ec784e58da5c..414e585ec7dd 100644
> > > --- a/drivers/gpu/drm/exynos/exynos_drm_g2d.c
> > > +++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
> > > @@ -1335,7 +1335,7 @@ int exynos_g2d_exec_ioctl(struct drm_device *drm_dev, void *data,
> > >       /* Let the runqueue know that there is work to do. */
> > >       queue_work(g2d->g2d_workq, &g2d->runqueue_work);
> > >
> > > -     if (runqueue_node->async)
> > > +     if (req->async)
> >
> > did you actually hit this? If you did, then the fix is not OK.
> 
> No, I didn't actually hit this. I found it through code review. This
> is only a theoretical issue that can only be triggered in extreme
> cases.

first of all runqueue is used again two lines below this, which
means that if you don't hit the uaf here you will hit it
immediately after.

Second, if runqueue is freed, than we need to remove the part
where it's freed because it doesn't make sense to free runqueue
at this stage.

Finally, can you elaborate on the code review that you did so
that we all understand it?

Andi
