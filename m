Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85356629DEC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 16:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238427AbiKOPqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 10:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236873AbiKOPqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 10:46:05 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B7C2657F;
        Tue, 15 Nov 2022 07:46:00 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 08DB966029B0;
        Tue, 15 Nov 2022 15:45:58 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668527159;
        bh=tnniZiVJY7xBZ5WD5I7gy0UTPhCI/2A5r5o/6SEqiSc=;
        h=From:To:Cc:Subject:Date:From;
        b=X870VwmoY+ndoiroLAzp0nUMhWstHUYL1te1W9Tn3mMaVbVgFqzl7DNJ1q4oVHJLo
         XL3eWJZTMuYv9li73FvNEzsKyP8eXX3HHiWqvoWoq/Ssq3wsLn5ro8/b8tjiII/fL7
         MzdJqIKUSOrVuNcPeb6QBTCwwZlb9hkucLNEI3NLALDSqF8V8AV1FxJwjtwyKpBFEE
         bGqKzCVm6HENSiSJyxNgysvQfByPu7rhCbGpgMzbNsalPD4hPETvLnM4WMjH7rmnlL
         1PS9FNtL+CN3OAhVKSMX1I166+197ZeN0+UAw1v0JMf0IuCVHin+ZIJo2XWU7tIV6u
         Sfr0tON8/Ua/A==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, marijn.suijten@somainline.org,
        kernel@collabora.com
Subject: [PATCH v3 0/2] Qualcomm Ramp Controller and MSM8976 config
Date:   Tue, 15 Nov 2022 16:45:53 +0100
Message-Id: <20221115154555.324437-1-angelogioacchino.delregno@collabora.com>
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
 drivers/soc/qcom/ramp_controller.c            | 331 ++++++++++++++++++
 4 files changed, 377 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,msm8976-ramp-controller.yaml
 create mode 100644 drivers/soc/qcom/ramp_controller.c

-- 
2.38.1

