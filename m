Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEE469887C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 00:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjBOXCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 18:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjBOXCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 18:02:36 -0500
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [IPv6:2001:4b7a:2000:18::164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B8039286;
        Wed, 15 Feb 2023 15:02:32 -0800 (PST)
Received: from Marijn-Arch-PC.localdomain (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 7D2B81F544;
        Thu, 16 Feb 2023 00:02:24 +0100 (CET)
From:   Marijn Suijten <marijn.suijten@somainline.org>
Subject: [PATCH 0/3] drm/msm/dpu: Initialize SSPP scaler version (from
 register read)
Date:   Thu, 16 Feb 2023 00:02:22 +0100
Message-Id: <20230215-sspp-scaler-version-v1-0-416b1500b85b@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH9k7WMC/x2NwQrCMBBEf6Xs2YUmElB/RTykcWoXQgy7WAql/
 +7q8c3MY3YyqMDoNuykWMXk3RzCaaCy5PYCy9OZ4hjPYwyJzXpnK7lCeYX+9hyuc/TukkoCuTl
 lA0+aW1ncbZ9aPeyKWbb/1f1xHF+RhmoWegAAAA==
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Archit Taneja <architt@codeaurora.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        Sravanthi Kollukuduru <skolluku@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        phone-devel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Random inspection of the SSPP code surfaced that the version field of
dpu_scaler_blk was never assigned in the catalog, resulting in wrong
codepaths to be taken within dpu_hw_setup_scaler3 based on a 0 version.
Rectify this by reading an accurate value from a register (that is not
equal to the values represented by DPU_SSPP_SCALER_QSEEDx enum
variants) and deleting dead code around QSEED versioning.

Future changes should likely get rid of the distinction between QSEED3
and up, as these are now purely determined from the register value.
Furthermore implementations could look at the scaler subblk .id field
rather than the SSPP feature bits, which currently hold redundant
information.

---
Marijn Suijten (3):
      drm/msm/dpu: Read previously-uninitialized SSPP scaler version from hw
      drm/msm/dpu: Drop unused get_scaler_ver callback from SSPP
      drm/msm/dpu: Drop unused qseed_type from catalog dpu_caps

 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c | 12 ------------
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h |  4 ----
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c    | 12 ++++++++----
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h    |  9 +++------
 4 files changed, 11 insertions(+), 26 deletions(-)
---
base-commit: 9d9019bcea1aac7eed64a1a4966282b6b7b141c8
change-id: 20230215-sspp-scaler-version-19f221585c5e

Best regards,
-- 
Marijn Suijten <marijn.suijten@somainline.org>

