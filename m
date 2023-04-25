Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD3E6EEAE1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 01:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236386AbjDYXMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 19:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbjDYXL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 19:11:58 -0400
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [IPv6:2001:4b7a:2000:18::162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F216817DE9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 16:11:29 -0700 (PDT)
Received: from Marijn-Arch-PC.localdomain (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 16EA21F887;
        Wed, 26 Apr 2023 01:11:09 +0200 (CEST)
From:   Marijn Suijten <marijn.suijten@somainline.org>
Subject: [PATCH v3 0/3] drm/msm/dpu: Drop useless for-loop HW block lookup
Date:   Wed, 26 Apr 2023 01:11:08 +0200
Message-Id: <20230418-dpu-drop-useless-for-lookup-v3-0-e8d869eea455@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAxeSGQC/5XOQQ6CMBQE0KuYrv2mFALFlfcwLtrygcbaNv1CN
 IS7W9i60eXM4s0sjDBZJHY+LCzhbMkGn0N5PDAzKj8g2C5nJrgoeVVI6OIEXQoRJkKHRNCHBC6
 E+xShkrLh3DSqqluWBa0IQSflzZgNPzmXy5iwt6998nrLebT0DOm9P5iLrf1tbC6Ag25l2xjUd
 V/ihcJDWe+sx1NIA9vwWfwBigwqo7lEKbAv2i9wXdcPk2c08zEBAAA=
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Doing a for loop in every DPU HW block driver init to find a catalog
entry matching the given ID is rather useless if the init function
called by RM already has that catalog entry pointer, and uses exactly
its ID to drive this init and for loop.  Remove all that machinery to
drop quite some lines of unnecessarily-complicated code, and the
fallibility that comes with it, by simply giving _init() the catalog
entry pointers straight away.

Also clean up some unused struct members, and assign a log_mask for WB.

---
Changes in v3:
- Return NULL from dpu_hw_intf_init() on INTF_NONE, and omit identical
  check in dpu_rm_init();
- Retitle patch 3/3.

v2: https://lore.kernel.org/r/20230418-dpu-drop-useless-for-lookup-v2-0-acb08e82ef19@somainline.org

Changes in v2:
- Replace "sysfs" with "debugfs" in patch 2/3 description;
- Reorder WB log_mask fix as patch 1;
- Drop Fixes: tags from "unused struct members removal";
- Replace dpu_mdss_cfg parameter in dpu_hw_sspp_init() with immediate
  dpu_ubwc_cfg pointer;
- Replace dpu_mdss_cfg parameter in dpu_hw_ctl_init() with immediate
  dpu_lm_cfg array pointer.

v1: https://lore.kernel.org/r/20230418-dpu-drop-useless-for-lookup-v1-0-b9897ceb6f3e@somainline.org

---
Marijn Suijten (3):
      drm/msm/dpu: Assign missing writeback log_mask
      drm/msm/dpu: Drop unused members from HW structs
      drm/msm/dpu: Pass catalog pointers in RM to replace for-loop ID lookups

 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c        | 37 +++++---------------
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h        | 14 ++++----
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.c        | 32 +++---------------
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h        | 11 +++---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dspp.c       | 38 ++++-----------------
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dspp.h       | 12 +++----
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h |  2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c       | 41 ++++++-----------------
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h       | 13 +++----
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c         | 38 ++++-----------------
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.h         | 10 +++---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_merge3d.c    | 33 +++---------------
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_merge3d.h    | 14 ++++----
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c   | 33 +++---------------
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h   | 14 ++++----
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c       | 40 ++++------------------
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h       | 14 ++++----
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_vbif.c       | 33 +++---------------
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_vbif.h       | 11 +++---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c         | 33 ++++--------------
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.h         | 16 +++------
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c           | 17 +++++-----
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c            | 22 +++++-------
 23 files changed, 139 insertions(+), 389 deletions(-)
---
base-commit: f600e0bbde8562a06bee31b3eb1b69d49acac4c5
change-id: 20230418-dpu-drop-useless-for-lookup-488700c7a469

Best regards,
-- 
Marijn Suijten <marijn.suijten@somainline.org>

