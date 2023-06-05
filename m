Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726DD7222D6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 12:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbjFEKCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 06:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbjFEKCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 06:02:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A863E9;
        Mon,  5 Jun 2023 03:02:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC3216145F;
        Mon,  5 Jun 2023 10:02:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32815C433EF;
        Mon,  5 Jun 2023 10:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685959330;
        bh=5abGnYlpGeIkAbmWOgFaqsPnq9GUfYv18EA1sRFxf0o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ks5F/7ZsXGFzvQYZkRtnA2uNecgZ73F6IwjUmpD7XAD38sPGLyy7BBTrNpEva1D/z
         ggXUOAtJ5VJYMufV+7FEXksc92u6nFd6nANf1AWy53Ysh4q2DrerwLPml8KN3Ti94j
         ckF2yIETt4QXljbFoh4CRE0/bF2eMPgVHhH4fRePhHhmP4VJW17UBpOThf/8PDalcO
         lVa7FcCmpssWJQE07mdlWlFrRMzy1hICOKUbgKniepMEcl91r4WtBZi/TvBl6YNEy1
         b0HDFg1cJuMDXrJWrV8j1eOTk6m+SOT6zHkxwQlx0NrNsSHTP+sbYejxW85OUGIpgg
         EQzmGCEwlD94Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q672h-0005ky-7p; Mon, 05 Jun 2023 12:02:27 +0200
Date:   Mon, 5 Jun 2023 12:02:27 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Johan Hovold <johan@kernel.org>, regressions@lists.linux.dev
Subject: Re: [PATCH] Revert "drm/msm/dp: set self refresh aware based on PSR
 support"
Message-ID: <ZH2ys6dVeL02JLCU@hovoldconsulting.com>
References: <20230523151646.28366-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523151646.28366-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ +CC: Thorsten and regzbot so they can help with tracking this
regression ]

#regzbot introduced: v6.3..v6.4-rc1

On Tue, May 23, 2023 at 05:16:46PM +0200, Johan Hovold wrote:
> This reverts commit 1844e680d56bb0c4e0489138f2b7ba2dc1c988e3.
> 
> PSR support clearly is not ready for mainline and specifically breaks
> virtual terminals which are no longer updated when PSR is enabled (e.g.
> no keyboard input is echoed, no cursor blink).
> 
> Disable PSR support for now by reverting commit 1844e680d56b
> ("drm/msm/dp: set self refresh aware based on PSR support").
> 
> Cc: Vinod Polimera <quic_vpolimer@quicinc.com>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
> 
> Bjorn reported that PSR support broke virtual terminals two months ago, 
> but this is still broken in 6.4-rc3:
> 
> 	https://lore.kernel.org/lkml/20230326162723.3lo6pnsfdwzsvbhj@ripper/
> 
> despite the following series that claimed to address this:
> 
> 	https://lore.kernel.org/lkml/1680271114-1534-1-git-send-email-quic_vpolimer@quicinc.com
> 
> Let's revert until this has been fixed properly.

Virtual terminals are still broken with 6.4-rc5 on the Lenovo ThinkPad
X13s two weeks after I reported this, and there has been no indication
of any progress in the other related thread:

	https://lore.kernel.org/lkml/ZHYPHnWoDbXB-fqe@hovoldconsulting.com

Seems like it is time to merge this revert to get this sorted.

Rob, Abhinav, Dmitry, can either of you merge this one and get it into
6.4-rc6?

Johan
