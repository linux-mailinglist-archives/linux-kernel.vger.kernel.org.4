Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B4D64C06D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 00:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236995AbiLMXWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 18:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236990AbiLMXWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 18:22:21 -0500
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [5.144.164.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C52E1B1FF
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 15:22:19 -0800 (PST)
Received: from localhost.localdomain (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id B691E1F99C;
        Wed, 14 Dec 2022 00:22:16 +0100 (CET)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Jani Nikula <jani.nikula@intel.com>,
        sunliming <sunliming@kylinos.cn>,
        Sam Ravnborg <sam@ravnborg.org>,
        Haowen Bai <baihaowen@meizu.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/6] drm/msm: DSC Electric Boogaloo for sm8[12]50
Date:   Wed, 14 Dec 2022 00:22:01 +0100
Message-Id: <20221213232207.113607-1-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This preliminary Display Stream Compression support package for
(initially tested on) sm8[12]50 is based on comparing DSC behaviour
between downstream and mainline.  Some new callbacks are added (for
binding blocks on active CTLs), logic bugs are corrected, zeroed struct
members are now assigned proper values, and RM allocation and hw block
retrieval now hand out (or not) DSC blocks without causing null-pointer
dereferences.

Unfortunately it is not yet enough to get rid of completely corrupted
display output on the boards I tested here:
- Sony Xperia 1 (sm8150), 1644x3840 or 1096x2560 pixels;
- Sony Xperia 5II (sm8250), 1080x2520, at 60 or 120Hz;
- (can include more Xperia boards if desired)

Both devices use the DUALPIPE_DSCMERGE topology downstream: dual LM, PP
and DSC, but only a single INTF/encoder/DSI-link.

Hopefully this spawns some community/upstream interest to help rootcause
our corruption issues (after we open a drm/msm report on GitLab for more
appropriate tracking).

The Sony Xperia XZ3 (sdm845) was fully tested and validated with this
series to not cause any regressions (an one of the math fixes now allows
us to change slice_count in the panel driver, which would corrupt
previously).

Marijn Suijten (6):
  drm/msm/dpu1: Implement DSC binding to PP block for CTL V1
  drm/msm/dpu1: Add DSC config for sm8150 and sm8250
  drm/msm/dpu1: Wire up DSC mask for active CTL configuration
  drm/msm/dsi: Use DSC slice(s) packet size to compute word count
  drm/msm/dsi: Flip greater-than check for slice_count and
    slice_per_intf
  drm/msm/dpu: Disallow unallocated (DSC) resources to be returned

 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c   |  3 +++
 .../drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c  |  1 +
 .../drm/msm/disp/dpu1/dpu_encoder_phys_vid.c  |  1 +
 .../drm/msm/disp/dpu1/dpu_encoder_phys_wb.c   |  2 ++
 .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c    | 23 +++++++++++-----
 .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h    |  9 +++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.c    | 27 +++++++++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h    |  4 +++
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c        | 10 +++++++
 drivers/gpu/drm/msm/dsi/dsi_host.c            |  6 ++---
 10 files changed, 77 insertions(+), 9 deletions(-)

--
2.38.1

