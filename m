Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAC771964D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 11:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbjFAJCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 05:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbjFAJCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:02:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065E9E40;
        Thu,  1 Jun 2023 02:02:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A124864221;
        Thu,  1 Jun 2023 09:01:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F326EC433D2;
        Thu,  1 Jun 2023 09:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685610115;
        bh=4qQydQYRMrUOcNRnymjEdMYj9KOx6NIt5j1b1rQ06po=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SHPCH/armNDPorE+cc3Xb3TXoWoApNaKS29MS+NEXf6sQ/2Mz8KZnELAt6eo0JkFI
         vHBkYpsSVnV5qsc0rMP3PF5pfX7oUL4Sfp9fguKwNwff4N5gBx4XOB+fpR37F7VWEI
         h/3NZIwevah72IbNwlMfIC4R/Uwma5mW+3xUZYQ67/9WKX78D/AJ/NZYs/6PXnohCa
         dLsDaKPh6+A3FgQUiZh3lngNpdPts4aiXMMvaM5cUb5Xb028NhIneDbyKjdQXmPq3k
         2JNyFfB1YzWXNVxBn4xbmVN+b0BifFzs70E0o30zjeC6VMTHBZO8doYnpQXnrLw+u1
         QFoHrgiDb3iAg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q4eC0-0007BU-Sj; Thu, 01 Jun 2023 11:02:00 +0200
Date:   Thu, 1 Jun 2023 11:02:00 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Doug Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     'Johan Hovold <johan+linaro@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] drm/msm/a6xx: fix uninitialised lock in init error path
Message-ID: <ZHheiJfdp7-597XT@hovoldconsulting.com>
References: <20230531075854.703-1-johan+linaro@kernel.org>
 <CAD=FV=UtyMSekPYfamMkswC=mSRnBpQUygMxZ+Wgf6Y2dB2Qhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=UtyMSekPYfamMkswC=mSRnBpQUygMxZ+Wgf6Y2dB2Qhw@mail.gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 07:22:49AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Wed, May 31, 2023 at 1:00 AM Johan Hovold <johan+linaro@kernel.org> wrote:
> >
> > A recent commit started taking the GMU lock in the GPU destroy path,
> > which on GPU initialisation failure is called before the GMU and its
> > lock have been initialised.
> >
> > Make sure that the GMU has been initialised before taking the lock in
> > a6xx_destroy() and drop the now redundant check from a6xx_gmu_remove().
> >
> > Fixes: 4cd15a3e8b36 ("drm/msm/a6xx: Make GPU destroy a bit safer")
> > Cc: stable@vger.kernel.org      # 6.3
> > Cc: Douglas Anderson <dianders@chromium.org>
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 3 ---
> >  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 9 ++++++---
> >  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> I think Dmitry already posted a patch 1.5 months ago to fix this.
> 
> https://lore.kernel.org/r/20230410165908.3094626-1-dmitry.baryshkov@linaro.org

Bah, I checked if Bjorn had hit this with his recent A690 v3 series and
posted a fix, but did not look further than that.

> Can you confirm that works for you?

That looks like it would work too, but I think I prefer my version which
keeps the initialisation of the GMU struct in a6xx_gmu_init().

Dmitry or Rob, could you see to that either version gets merged soon so
that we don't end up with even more people having to debug and fix the
same issue?

Johan
