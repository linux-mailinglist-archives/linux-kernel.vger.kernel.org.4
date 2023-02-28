Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586FE6A5694
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 11:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjB1K0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 05:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjB1K0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 05:26:38 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B692D231D3;
        Tue, 28 Feb 2023 02:26:35 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E508D6602F90;
        Tue, 28 Feb 2023 10:26:32 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677579993;
        bh=VFa+f+8DW2e7D6mKpQUiXknzxxQ8s0Fg736RhJg9+aQ=;
        h=From:To:Cc:Subject:Date:From;
        b=BVlPG6TwFWfmWmTOzq+4wKLJpdKMTDcMH0Ykv43T1b18Qe+wluCePVdBBrXC6Hkbo
         pKhLkWY3No2PyYisZN6VmkvmMzEARzivyanq2TlND6V1DeTiWx7nhmJpMQ7z0YudGd
         XX54jwrGdvXTvdKTmWdCZQpPexKTo25vXwTCxUnTCF4jZeNHYHqP9JtUwDGCO0nc5b
         NlPFJbgfWAF9ESMNgHiN2wCmg2T6NiIQ30RlFzjtiGI8VSgX4O0L20Wv/lcgLstnHd
         JNl/rmRPgDRFZQfd+XYznZljh3Y/z1IXz0uoD2T2Ozf3iIABkcmc7PlSey5otRRNJ8
         OUXUvnB67Jb6Q==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     airlied@gmail.com
Cc:     daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com, matthias.bgg@gmail.com,
        robh@kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v4 00/12] Panfrost: Improve and add MediaTek SoCs support
Date:   Tue, 28 Feb 2023 11:25:58 +0100
Message-Id: <20230228102610.707605-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v4:
 - Refactored power-domains and power-domain-names exclusions as
   suggested by Krzysztof
 - Small changes in MT8192 bindings addition

Changes in v3:
 - Changed MT8186 bindings to declare only two power domains
 - Added a commit introducing MT8186 specific platform data to
   panfrost_drv

Changes in v2:
 - Add power-domain-names commit from Chen-Yu to the series
 - Kept sram-supply in base schema, overridden for non-MediaTek
 - Added Reviewed-by tags from Steven Price to the driver commits
   (as released in reply to v1's cover letter - thanks!)

This series adds support for new MediaTek SoCs (MT8186/MT8192/MT8195)
and improves MT8183 support: since the mtk-regulator-coupler driver
was picked, it is now useless for Panfrost to look for, and manage,
two regulators (GPU Vcore and GPU SRAM) on MediaTek;

The aforementioned driver will take care of keeping the voltage
relation (/constraints) of the two regulators on its own when a
voltage change request is sent to the Vcore, solving the old time
issue with not working DVFS on Panfrost+MediaTek (due to devfreq
supporting only single regulator).

In the specific case of MT8183, in order to not break the ABI, it
was necessary to add a new compatible for enabling DVFS.

Alyssa Rosenzweig (3):
  drm/panfrost: Increase MAX_PM_DOMAINS to 5
  drm/panfrost: Add the MT8192 GPU ID
  drm/panfrost: Add mediatek,mt8192-mali compatible

AngeloGioacchino Del Regno (9):
  dt-bindings: gpu: mali-bifrost: Split out MediaTek power-domains
    variation
  dt-bindings: gpu: mali-bifrost: Set power-domains maxItems to 5
  dt-bindings: gpu: mali-bifrost: Fix power-domain-names validation
  dt-bindings: gpu: mali-bifrost: Add sub-schema for MT8192's power
    domains
  dt-bindings: gpu: mali-bifrost: Add new MT8183 compatible
  dt-bindings: gpu: mali-bifrost: Add support for MediaTek MT8186
  dt-bindings: gpu: mali-bifrost: Add compatible for MT8195 SoC
  drm/panfrost: Add new compatible for Mali on the MT8183 SoC
  drm/panfrost: Add support for Mali on the MT8186 SoC

 .../bindings/gpu/arm,mali-bifrost.yaml        | 80 ++++++++++++++++++-
 drivers/gpu/drm/panfrost/panfrost_device.h    |  2 +-
 drivers/gpu/drm/panfrost/panfrost_drv.c       | 37 +++++++++
 drivers/gpu/drm/panfrost/panfrost_gpu.c       |  8 ++
 4 files changed, 123 insertions(+), 4 deletions(-)

-- 
2.39.2

