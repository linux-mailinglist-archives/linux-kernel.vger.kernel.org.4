Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCB77102F8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 04:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237550AbjEYCmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 22:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237470AbjEYCl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 22:41:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D18E6;
        Wed, 24 May 2023 19:41:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5778E641C7;
        Thu, 25 May 2023 02:41:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8F8BC433EF;
        Thu, 25 May 2023 02:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684982515;
        bh=Lo0WBDv5SBGCOSEzfMDGCJroIZ+pRlkVidFrQmSKfLY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=apyuiFwb+iBikMNct1s2IUQYAidJ06qwTnOBbhz5ll9rRVcRVY6QdNFrncPi2HPYv
         rxp/i9IrQkvbGEnoBQNHo5LJHVODPPXhn+E+4FXKOxY0umIiihutLlQnLbG/9UOyT0
         wqeX/U9ridLMYk3uo2WLx6UOq3+1Rh98e9Qtj3VdTVl5wKNt9hTK38wT4pecIs0s3a
         dIO3QYpjhD5EgI7ww1j+sSAatzdHPDS2/shSkf6ctRFjftx26CiUO+O4cTAowrZ4PL
         h1LQQlCOqsl38jf9F+7cTsQ2GAWRD9iEYe4MF1ymL35qCdxtPhfmN3jjcGsMu0xpvM
         IfmdcEN4ItuuA==
Date:   Wed, 24 May 2023 19:45:46 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Maulik Shah <quic_mkshah@quicinc.com>, dianders@chromium.org,
        swboyd@chromium.org, wingers@google.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, sudeep.holla@arm.com,
        jwerner@chromium.org, quic_lsrao@quicinc.com,
        quic_rjendra@quicinc.com
Subject: Re: [PATCH v4 0/3] Use PSCI OS initiated mode for sc7280
Message-ID: <20230525024546.ug6nbrmkgx2alerc@ripper>
References: <20230424110933.3908-1-quic_mkshah@quicinc.com>
 <CAPDyKFqSY9HJgKwuOqJPU5aA=wcAtDp91s0hkQye+dm=Wk=YDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqSY9HJgKwuOqJPU5aA=wcAtDp91s0hkQye+dm=Wk=YDQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 11:56:28AM +0200, Ulf Hansson wrote:
> On Mon, 24 Apr 2023 at 13:09, Maulik Shah <quic_mkshah@quicinc.com> wrote:
> >
> > Changes in v4:
> > - Add missing s-o-b line and reviewed by in patch 1
> > - Address ulf's comments for error handling in patch 2
> >
> > Changes in v3:
> > - Add new change to provide helper function dt_idle_pd_remove_topology()
> > - Address ulf's comments for error handling
> > - Add reviewed by ulf for devicetree change
> >
> > Changes in v2:
> > - Add new change to Move enabling OSI mode after power domains creation
> > - Fix compatible string to domains-idle-states for cluster idle state.
> > - Update cover letter with some more details on OSI and PC mode
> >   comparision
> >
> > The dependency [2] is now merged in trustedfirmware project.
> >
> > Stats comparision between OSI and PC mode are captured at [3] with
> > usecase
> > details, where during multiple CPUs online the residency in cluster idle
> > state is better with OSI and also inline with single CPU mode. In PC
> > mode
> > with multiple CPUs cluster idle state residency is dropping compare to
> > single CPU mode.
> >
> > Recording of this meeting is also available at [4].
> >
> > This change adds power-domains for cpuidle states to use PSCI OS
> > initiated mode for sc7280.
> >
> > This change depends on external project changes [1] & [2] which are
> > under review/discussion to add PSCI os-initiated support in Arm Trusted
> > Firmware.
> >
> > I can update here once the dependency are in and change is ready to
> > merge.
> >
> > [1] https://review.trustedfirmware.org/q/topic:psci-osi
> > [2] https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/19487
> > [3] https://www.trustedfirmware.org/docs/PSCI-OS-initiated.pdf
> > [4] https://www.trustedfirmware.org/meetings/tf-a-technical-forum
> >
> > Maulik Shah (3):
> >   cpuidle: dt_idle_genpd: Add helper function to remove genpd topology
> >   cpuidle: psci: Move enabling OSI mode after power domains creation
> >   arm64: dts: qcom: sc7280: Add power-domains for cpuidle states
> >
> >  arch/arm64/boot/dts/qcom/sc7280.dtsi  | 98 ++++++++++++++++++++-------
> >  drivers/cpuidle/cpuidle-psci-domain.c | 39 ++++-------
> >  drivers/cpuidle/dt_idle_genpd.c       | 24 +++++++
> >  drivers/cpuidle/dt_idle_genpd.h       |  7 ++
> >  4 files changed, 117 insertions(+), 51 deletions(-)
> >
> 
> Looks like this series has not been queued up yet. Note that patch1
> and patch2 are needed for stable kernels too. Moreover, patch3 (Qcom
> DTS change) is dependent on patch 1 and patch2.
> 
> Therefore I suggest Bjorn to pick this up via the Qcom SoC tree.
> Bjorn, is that okay for you?
> 

Sorry, this fell between the chairs after you pointed me to it...

I can certainly pick the 3 patches through my tree, but are they fixing
any current regressions, or is it just that we need the first two
patches to land before the 3rd patch?

I also presume the 3rd patch is only needed when paired with the new
ATF?

Regards,
Bjorn
