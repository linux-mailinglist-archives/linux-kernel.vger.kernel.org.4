Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3676ABB1F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 11:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjCFKJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 05:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjCFKJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 05:09:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE21222EF;
        Mon,  6 Mar 2023 02:09:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC88FB80D1F;
        Mon,  6 Mar 2023 10:09:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 864EAC4339E;
        Mon,  6 Mar 2023 10:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678097358;
        bh=rgz7DkiR3NGSdYC6VIDyJIROjaHJdAcLrZHovIKQqTY=;
        h=From:To:Cc:Subject:Date:From;
        b=rt0Rn6T3lEfqba/Z5G+GS52LAph5WQwapMERJL+R1JUS7rpu7cd5CAr+ebFzIQbAE
         c/LoQffAl8hgg1QxEPWeVyefKugN4sPCm2Zw+MNdySXEXaIOyNa3RxQJ6nI0/7FFd0
         Inbw+1NarVhguGtegVLtK3JhG5pkOyCuxa9LcsjUpujzRmMyOhS4hNodFtAWAkJF9l
         XJxI4QPpAa+9jP2V/8Hv6Y1hHlyvAcvRz8RVnuCEEi6y31AOiwLRpUt0/eILMF/838
         pF19Hfx5ScWRpvIG6EJ+Vl1qf9dvvAhNGEnl7TgzGQTZ9BxnSLlLYJDsDfN/jy6HHV
         DS3dcArX4gpzQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pZ7n4-0007QY-TO; Mon, 06 Mar 2023 11:09:58 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 00/10] drm/msm: fix bind error handling
Date:   Mon,  6 Mar 2023 11:07:12 +0100
Message-Id: <20230306100722.28485-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I had reasons to look closer at the MSM DRM driver error handling and
realised that it had suffered from a fair amount of bit rot over the
years.

Unfortunately, I started fixing this in my 6.2 branch and failed to
notice two partial and, as it turned out, broken attempts to address
this that are now in 6.3-rc1.

Instead of trying to salvage this incrementally, I'm reverting the two
broken commits so that clean and backportable fixes can be added in
their place.

Included are also two related cleanups.

Johan


Johan Hovold (10):
  Revert "drm/msm: Add missing check and destroy for
    alloc_ordered_workqueue"
  Revert "drm/msm: Fix failure paths in msm_drm_init()"
  drm/msm: fix NULL-deref on snapshot tear down
  drm/msm: fix NULL-deref on irq uninstall
  drm/msm: fix drm device leak on bind errors
  drm/msm: fix vram leak on bind errors
  drm/msm: fix missing wq allocation error handling
  drm/msm: fix workqueue leak on bind errors
  drm/msm: use drmm_mode_config_init()
  drm/msm: move include directive

 drivers/gpu/drm/msm/disp/msm_disp_snapshot.c |  3 -
 drivers/gpu/drm/msm/msm_drv.c                | 67 +++++++++++++-------
 2 files changed, 44 insertions(+), 26 deletions(-)

-- 
2.39.2

