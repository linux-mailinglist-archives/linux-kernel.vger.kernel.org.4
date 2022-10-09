Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1115F8D4C
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 20:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbiJISsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 14:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbiJISsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 14:48:38 -0400
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [5.144.164.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B074B29377
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 11:48:37 -0700 (PDT)
Received: from localhost.localdomain (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 775AD1F939;
        Sun,  9 Oct 2022 20:48:34 +0200 (CEST)
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
        Douglas Anderson <dianders@chromium.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/10] drm/msm: Fix math issues in MSM DSC implementation
Date:   Sun,  9 Oct 2022 20:48:14 +0200
Message-Id: <20221009184824.457416-1-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various removals of complex yet unnecessary math, fixing all uses of
drm_dsc_config::bits_per_pixel to deal with the fact that this field
includes four fractional bits, and finally making sure that
range_bpg_offset contains values 6-bits wide to prevent overflows in
drm_dsc_pps_payload_pack().

Altogether this series is responsible for solving _all_ Display Stream
Compression issues and artifacts on the Sony Tama (sdm845) Akatsuki
smartphone (2880x1440p).

Changes since v2:
- Generalize mux_word_size setting depending on bits_per_component;
- Migrate DSI's DSC calculations to drm_dsc_compute_rc_parameters(),
  implicitly addressing existing math issues;
- Disallow any bits_per_component other than 8, until hardcoded values
  are updated and tested to support such cases.

v2: https://lore.kernel.org/linux-arm-msm/20221005181657.784375-1-marijn.suijten@somainline.org/T/#u

Changes since v1:

- Propagate r-b's, except (obviously) in patches that were (heavily)
  modified;
- Remove accidental debug code in dsi_cmd_dma_add;
- Move Range BPG Offset masking out of DCS PPS packing, back into the
  DSI driver when it is assigned to drm_dsc_config (this series is now
  strictly focusing on drm/msm again);
- Replace modulo-check resulting in conditional increment with
  DIV_ROUND_UP;
- Remove repeated calculation of slice_chunk_size;
- Use u16 instead of int when handling bits_per_pixel;
- Use DRM_DEV_ERROR instead of pr_err in DSI code;
- Also remove redundant target_bpp_x16 variable.

v1: https://lore.kernel.org/linux-arm-msm/20221001190807.358691-1-marijn.suijten@somainline.org/T/#u

Marijn Suijten (10):
  drm/msm/dsi: Remove useless math in DSC calculations
  drm/msm/dsi: Remove repeated calculation of slice_per_intf
  drm/msm/dsi: Use DIV_ROUND_UP instead of conditional increment on
    modulo
  drm/msm/dsi: Reuse earlier computed dsc->slice_chunk_size
  drm/msm/dsi: Appropriately set dsc->mux_word_size based on bpc
  drm/msm/dsi: Migrate to drm_dsc_compute_rc_parameters()
  drm/msm/dsi: Disallow 8 BPC DSC configuration for alternative BPC
    values
  drm/msm/dsi: Account for DSC's bits_per_pixel having 4 fractional bits
  drm/msm/dpu1: Account for DSC's bits_per_pixel having 4 fractional
    bits
  drm/msm/dsi: Prevent signed BPG offsets from bleeding into adjacent
    bits

 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.c |  11 +-
 drivers/gpu/drm/msm/dsi/dsi_host.c         | 121 ++++++---------------
 2 files changed, 37 insertions(+), 95 deletions(-)

--
2.38.0

