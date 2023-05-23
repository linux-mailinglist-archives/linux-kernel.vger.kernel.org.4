Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8BFD70E05E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237280AbjEWPYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbjEWPYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:24:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B1AFA;
        Tue, 23 May 2023 08:24:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C3B762391;
        Tue, 23 May 2023 15:24:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B18AC433D2;
        Tue, 23 May 2023 15:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684855440;
        bh=id6Ze6Hu+PqRUZZVVqJiBhbnqqCMbcdVAtw6ZAFwtmo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mlMhs2i3JhpqXBZbookXDxEtR7hNMdrz5dLT2v8fhPzPvPy+X9NTq89QUWil82lVF
         NaibKJtMgxicJACKlir1mQaPE0fbnKy30qodJinOqxbkWU34QPQ7rWj4J5u1Qt4Ili
         IRMl6oOiC+EePCNmK+Ibr2LnISsHo+l9NCF9aN5o1PVDNRtNlo/L86BSRY4Vkrxub/
         e8fr8Q3cx3an4alHxD8hJko8U6av/pHEwuS4yIAWeQJ6Fm07mNHaFUVsjrt7AdwRZu
         soz6vppYmVHO+kMOn2keN6Sx/pECMxOwbUEH4+cG62/OsEZTFgFR5AHYZqbXdVQKr2
         41XeN1uxRyvbQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q1Tro-0007Qn-8f; Tue, 23 May 2023 17:24:04 +0200
Date:   Tue, 23 May 2023 17:24:04 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, quic_jesszhan@quicinc.com,
        swboyd@chromium.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dp: add module parameter for PSR
Message-ID: <ZGzalLjTvUfzEADU@hovoldconsulting.com>
References: <20230427232848.5200-1-quic_abhinavk@quicinc.com>
 <053819bd-b3c4-a72c-9316-85d974082ad6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <053819bd-b3c4-a72c-9316-85d974082ad6@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 09:13:04PM +0300, Dmitry Baryshkov wrote:
> On 28/04/2023 02:28, Abhinav Kumar wrote:
> > On sc7280 where eDP is the primary display, PSR is causing
> > IGT breakage even for basic test cases like kms_atomic and
> > kms_atomic_transition. Most often the issue starts with below
> > stack so providing that as reference
> > 
> > Call trace:
> >   dpu_encoder_assign_crtc+0x64/0x6c
> >   dpu_crtc_enable+0x188/0x204
> >   drm_atomic_helper_commit_modeset_enables+0xc0/0x274
> >   msm_atomic_commit_tail+0x1a8/0x68c
> >   commit_tail+0xb0/0x160
> >   drm_atomic_helper_commit+0x11c/0x124
> >   drm_atomic_commit+0xb0/0xdc
> >   drm_atomic_connector_commit_dpms+0xf4/0x110
> >   drm_mode_obj_set_property_ioctl+0x16c/0x3b0
> >   drm_connector_property_set_ioctl+0x4c/0x74
> >   drm_ioctl_kernel+0xec/0x15c
> >   drm_ioctl+0x264/0x408
> >   __arm64_sys_ioctl+0x9c/0xd4
> >   invoke_syscall+0x4c/0x110
> >   el0_svc_common+0x94/0xfc
> >   do_el0_svc+0x3c/0xb0
> >   el0_svc+0x2c/0x7c
> >   el0t_64_sync_handler+0x48/0x114
> >   el0t_64_sync+0x190/0x194
> > ---[ end trace 0000000000000000 ]---
> > [drm-dp] dp_ctrl_push_idle: PUSH_IDLE pattern timedout
> > 
> > Other basic use-cases still seem to work fine hence add a
> > a module parameter to allow toggling psr enable/disable till
> > PSR related issues are hashed out with IGT.
> 
> For the reference: Bjorn reported that he has issues with VT on a 
> PSR-enabled laptops. This patch fixes the issue for him

Module parameters are almost never warranted, and it is definitely not
the right way to handle a broken implementation.

I've just sent a revert that unconditionally disables PSR support until
the implementation has been fixed:

	https://lore.kernel.org/lkml/20230523151646.28366-1-johan+linaro@kernel.org/

Johan
