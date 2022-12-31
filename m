Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCCC65A72A
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 22:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbiLaVua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 16:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiLaVu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 16:50:28 -0500
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [5.144.164.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDB46472
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 13:50:26 -0800 (PST)
Received: from localhost.localdomain (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 4E05D3ED63;
        Sat, 31 Dec 2022 22:50:18 +0100 (CET)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <swboyd@chromium.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Adam Skladowski <a39.skl@gmail.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/7] drm/msm/dpu: Implement tearcheck support on INTF block
Date:   Sat, 31 Dec 2022 22:49:59 +0100
Message-Id: <20221231215006.211860-1-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since DPU 5.0.0 the TEARCHECK registers and interrupts moved out of the
PINGPONG block and into the INTF.  Implement the necessary callbacks in
the INTF block, and use these callbacks together with the INTF_TEAR
interrupts.  Additionally, disable previous register writes and remove
unused interrupts in the PINGPONG and MDP_TOP blocks for these newer
platforms.

With these patches the devices on DPU >= 5.0.0 listed below now update
their panels at 60fps without tearing (nor sluggishness), and without
repeated timeouts in dmesg.

Tested on the following devices with command-mode panels and TE pins:

- Sony Xperia XZ3 (sdm845, DPU 4.0.0, cmdmode panel): no regressions on
  PINGPONG TE;
- Sony Xperia 5 (sm8150, DPU 5.0.0);
- Sony Xperia 10 II (sm6125, DPU 5.0.4).

Konrad Dybcio (1):
  drm/msm/dpu: Move dpu_hw_{tear_check,pp_vsync_info} to dpu_hw_mdss.h

Marijn Suijten (6):
  drm/msm/dpu: Remove unused INTF0 interrupt mask from sm6115/qcm2290
  drm/msm/dpu: Disable pingpong TE on DPU 5.0.0 and above
  drm/msm/dpu: Disable MDP vsync source selection on DPU 5.0.0 and above
  drm/msm/dpu: Document and enable TEAR interrupts on DSI interfaces
  drm/msm/dpu: Implement tearcheck support on INTF block
  drm/msm/dpu: Remove intr_rdptr from DPU >= 5.0.0 pingpong config

 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c   |  11 +
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h  |  10 +-
 .../drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c  | 108 +++++++--
 .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c    | 181 +++++++++------
 .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h    |   7 +-
 .../gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c |  12 +
 .../gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h |   2 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c   | 206 ++++++++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h   |  29 +++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h   |  48 ++++
 .../gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c   |  18 +-
 .../gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h   |  22 --
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.c    |  52 +++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_hwio.h      |   3 +
 14 files changed, 570 insertions(+), 139 deletions(-)

--
2.39.0

