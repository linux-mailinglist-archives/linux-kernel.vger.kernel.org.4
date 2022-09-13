Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73FB85B6A1E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 10:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbiIMI7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 04:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbiIMI6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 04:58:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F575A3C6;
        Tue, 13 Sep 2022 01:58:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FA9061350;
        Tue, 13 Sep 2022 08:58:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E5DC43143;
        Tue, 13 Sep 2022 08:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663059499;
        bh=KswN/Rt5UU5A7Axr80OgM7IYEAkBKA4wabmt2H+hrcE=;
        h=From:To:Cc:Subject:Date:From;
        b=fum8cPHXs4LMz0OQZjJEGgCAU85uep6zYWOw6zUKl2x+aQ/vfr0aK12YvarkP1kAM
         GA6+zqm3Go1ZbD/5Lprhy61w1vjpAVTG41MnRyOpfelInUfLV+dn9iGh9ROv6MKomt
         H9ry9YKwgk5XYSbWmcUsyWMlrhxKXUtMJ3dOPGYNPd0A/FjZ+c4cVWQfBxEF+VxfVY
         m9eAt9HtL43DEptMs+CVoRwy4YFEZdAgkBOpuIxkL59kv49ql+L80NApVmqUPvDTXn
         ccbkmWbOar04dwf1IrmS5/WC4A9WMt8cSp/l0IlKbczu2/+3kRSPR0kZ2S5bTH8REs
         IkJtX9ex0nnyA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oY1kI-0002H0-8Q; Tue, 13 Sep 2022 10:58:18 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Steev Klimaszewski <steev@kali.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 00/10] drm/msm: probe deferral fixes
Date:   Tue, 13 Sep 2022 10:53:10 +0200
Message-Id: <20220913085320.8577-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MSM DRM driver is currently broken in multiple ways with respect to
probe deferral. Not only does the driver currently fail to probe again
after a late deferral, but due to a related use-after-free bug this also
triggers NULL-pointer dereferences.

These bugs are not new but have become critical with the release of
5.19 where probe is deferred in case the aux-bus EP panel driver has not
yet been loaded.

The underlying problem is lifetime issues due to careless use of
device-managed resources.

Specifically, device-managed resources allocated post component bind
must be tied to the lifetime of the aggregate DRM device or they will
not necessarily be released when binding of the aggregate device is
deferred.

The following call chain and pseudo code serves as an illustration of
the problem:

 - platform_probe(pdev1)
   - dp_display_probe()
     - component_add()

 - platform_probe(pdev2) 				// last component
   - dp_display_probe()					// d0
       - component_add()
         - try_to_bring_up_aggregate_device()
	   - devres_open_group(adev->parent)		// d1

	   - msm_drm_bind()
	     - msm_drm_init()
	       - component_bind_all()
	         - for_each_component()
		   - component_bind()
		     - devres_open_group(&pdev->dev)	// d2
	             - dp_display_bind()
		       - devm_kzalloc(&pdev->dev)	// a1, OK
		     - devres_close_group(&pdev->dev)	// d3

	       - dpu_kms_hw_init()
	         - for_each_panel()
	           - msm_dp_modeset_init()
		     - dp_display_request_irq()
		       - devm_request_irq(&pdev->dev)	// a2, BUG
		     - if (pdev == pdev2 && condition)
		       - return -EPROBE_DEFER;

	      - if (error)
 	        - component_unbind_all()
	          - for_each_component()
		    - component_unbind()
		      - dp_display_unbind()
		      - devres_release_group(&pdev->dev) // d4, only a1 is freed

           - if (error)
	     - devres_release_group(adev->parent)	// d5

The device-managed allocation a2 is buggy as its lifetime is tied to the
component platform device and will not be released when the aggregate
device bind fails (e.g. due to a probe deferral).

When pdev2 is later probed again, the attempt to allocate the IRQ a
second time will fail for pdev1 (which is still bound to its platform
driver).

This series fixes the lifetime issues by tying the lifetime of a2 (and
similar allocations) to the lifetime of the aggregate device so that a2
is released at d5.

In some cases, such has for the DP IRQ, the above situation can also be
avoided by moving the allocation in question to the platform driver
probe (d0) or component bind (between d2 and d3). But as doing so is not
a general fix, this can be done later as a cleanup/optimisation.

Johan

Changes in v2
 - use a custom devres action instead of amending the AUX bus interface
   (Doug)
 - split sanity check fixes and cleanups per bridge type (Dmitry)
 - add another Fixes tag for the missing bridge counter reset (Dmitry)


Johan Hovold (10):
  drm/msm: fix use-after-free on probe deferral
  drm/msm/dp: fix memory corruption with too many bridges
  drm/msm/dsi: fix memory corruption with too many bridges
  drm/msm/hdmi: fix memory corruption with too many bridges
  drm/msm/dp: fix IRQ lifetime
  drm/msm/dp: fix aux-bus EP lifetime
  drm/msm/dp: fix bridge lifetime
  drm/msm/hdmi: fix IRQ lifetime
  drm/msm/dp: drop modeset sanity checks
  drm/msm/dsi: drop modeset sanity checks

 drivers/gpu/drm/msm/dp/dp_display.c | 26 +++++++++++++++++++-------
 drivers/gpu/drm/msm/dp/dp_parser.c  |  6 +++---
 drivers/gpu/drm/msm/dp/dp_parser.h  |  5 +++--
 drivers/gpu/drm/msm/dsi/dsi.c       |  9 +++++----
 drivers/gpu/drm/msm/hdmi/hdmi.c     |  7 ++++++-
 drivers/gpu/drm/msm/msm_drv.c       |  1 +
 6 files changed, 37 insertions(+), 17 deletions(-)

-- 
2.35.1

