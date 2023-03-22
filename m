Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10CF6C446F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 08:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjCVHxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 03:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjCVHx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 03:53:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F2B5BC86;
        Wed, 22 Mar 2023 00:53:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A24261F32;
        Wed, 22 Mar 2023 07:53:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B16C4C433D2;
        Wed, 22 Mar 2023 07:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679471606;
        bh=6us+L/XQm1baJWcqSucEebFsFr6/7LTQQTA45/1sK9w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V4b2fGg2pHM3FPEW87yN8n2hsakjJoVAowHip1XmWw9BlkHBJnQTwMUcrtY/RTApR
         NBxyBX1jk0AXYSSfcc+SK/cOziReWXUJTz56jIsU3m2LovjxjDOpZDHuLFkrOpr3UR
         WFAEbz6J6SzyEVvYklOVKrpYcKhYoTDfBwsidTwWX3RWP2rbJKLfG1+0h3fgvxKUDT
         b9yEnkojuNKFSnSNFfii3Chzy+3S0neYSnNKMDh8lDqOau12JKTdFG9sIQFL9BupPQ
         HNmBUEECqb+cfaT5yZXOXtXmiyfvk+3QEwSjdu+5BKkGsuyD+vyyurvs4rdJF9Cu1u
         o5hROj9r5DsBg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1petJ7-0002VJ-38; Wed, 22 Mar 2023 08:54:53 +0100
Date:   Wed, 22 Mar 2023 08:54:53 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] drm/msm: fix bind error handling
Message-ID: <ZBq0TaDON8iJ3/Rh@hovoldconsulting.com>
References: <20230306100722.28485-1-johan+linaro@kernel.org>
 <ZBmq12uP+TY4EaE3@hovoldconsulting.com>
 <6b2f4d0d-ba39-dd2b-e41e-b5accb4df1a2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b2f4d0d-ba39-dd2b-e41e-b5accb4df1a2@linaro.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 05:21:56PM +0200, Dmitry Baryshkov wrote:
> On 21/03/2023 15:02, Johan Hovold wrote:
> > On Mon, Mar 06, 2023 at 11:07:12AM +0100, Johan Hovold wrote:
> >> I had reasons to look closer at the MSM DRM driver error handling and
> >> realised that it had suffered from a fair amount of bit rot over the
> >> years.
> >>
> >> Unfortunately, I started fixing this in my 6.2 branch and failed to
> >> notice two partial and, as it turned out, broken attempts to address
> >> this that are now in 6.3-rc1.
> >>
> >> Instead of trying to salvage this incrementally, I'm reverting the two
> >> broken commits so that clean and backportable fixes can be added in
> >> their place.
> >>
> >> Included are also two related cleanups.
> > 
> > Any further comments to these patches (except for 9/10, which should be
> > dropped)?
> > 
> > As the patches being reverted here were first added in 6.3-rc1 there is
> > still time to get this into 6.3-rc (e.g. before AUTOSEL starts trying to
> > backport them).
> 
> I will take a look at the patches. Additional question, as you have been 
> looking into this area. We have plenty of code which is only called 
> under the `if (kms)` condition. Could you hopefully move these parts to 
> separate functions, so that the error handling is also simpler? If not, 
> I'll put this to my todo list, but it might take some time before I have 
> time for that.

There's definitely room for cleaning up the bind/unbind paths further,
but for this series I focus on correctness while maintaining symmetry
(e.g. if an allocation was done under if (kms), then the release should
be done under the same).

I don't think I will have time to look at this further for a few weeks
either, but I'll add it to my list of future work as well and I'll check
in with you before actually working on it.

Johan
