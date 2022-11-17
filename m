Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D807E62DCC6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 14:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240035AbiKQNaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 08:30:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbiKQNaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 08:30:06 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C61070A38;
        Thu, 17 Nov 2022 05:30:05 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 552A8660296C;
        Thu, 17 Nov 2022 13:30:03 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668691803;
        bh=gL1/jzQ586LM77xLd6YRSSstCi60nATAn4fYOVtBc14=;
        h=From:To:Cc:Subject:Date:From;
        b=lZ5eLGUlJwwnPIzSuu1BOj5WIqwShsthU5ODAIbQkHFTUpupzAl7Gu14OIRYOAZZM
         46nUx4r/tMufnDzAkQnQ2N1PDnCKFdq6WFKdM15JTUMdP6Pp1CLQMm73ok6z4ur9xM
         EXVhZNPyMHLoaNPznQ8KhXOOI7nYEA7gjgtplWqKLJfFFGZsBznwAU0RmlTxe/Q+KC
         9w7G0r3MC3mMIabpSmxqAhywacD6uJ3FIkDk2fSMayQntkA4eRFXCivCoP4VQhnnBu
         +j8jSdj4ntdd29+qu/ey3T3N2gAv4gTD5Gn8R8olIq8/VVEow4+ZVpkhc6qnJA61xm
         JJEFd5U5Gpzvw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, marijn.suijten@somainline.org,
        kernel@collabora.com
Subject: [PATCH v4 0/2] Qualcomm Ramp Controller and MSM8976 config
Date:   Thu, 17 Nov 2022 14:29:54 +0100
Message-Id: <20221117132956.169432-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.38.1
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

This series adds the Qualcomm Ramp Controller driver, necessary on
various legacy Qualcomm SoCs to enable CPU DVFS by programming said
controller with the right values, where the bootloader doesn't do
that before booting the kernel.

At least MSM8976 and MSM8956 require this initial programming to be
performed on Linux.

Changes in v4 (Dmitry's review):
 - Moved reg_sequence arrays to named constants
 - Added num_ramp_{en, dis} to desc structure
 - Replaced hardcoded constants with ARRAY_SIZE()
 - Merged cfg_ramp_{pre_en, en, post_en} in one array

Changes in v3:
 - Removed blank line at EOF on commit [1/2]
 - Changed example node name to cpu-power-controller

Changes in v2:
 - Fixed yaml issues as per Krzysztof's review
 - Reworded s/linking/link/g in both yaml and Kconfig help
 - Constified reg_sequence pointers
 - Removed spaces before defines
 - Added COMPILE_TEST to Kconfig entry

AngeloGioacchino Del Regno (2):
  dt-bindings: soc: qcom: Add bindings for Qualcomm Ramp Controller
  soc: qcom: Add Qualcomm Ramp Controller driver

 .../qcom/qcom,msm8976-ramp-controller.yaml    |  36 ++
 drivers/soc/qcom/Kconfig                      |   9 +
 drivers/soc/qcom/Makefile                     |   1 +
 drivers/soc/qcom/ramp_controller.c            | 342 ++++++++++++++++++
 4 files changed, 388 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,msm8976-ramp-controller.yaml
 create mode 100644 drivers/soc/qcom/ramp_controller.c

-- 
2.38.1

