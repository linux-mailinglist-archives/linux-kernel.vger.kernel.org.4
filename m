Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C2D6199A0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 15:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbiKDOYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 10:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbiKDOXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 10:23:52 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8832FC1B;
        Fri,  4 Nov 2022 07:22:17 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1C025660000F;
        Fri,  4 Nov 2022 14:22:10 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667571730;
        bh=aM8xMNup66x8oVT/mAiIKFJc1+sC1lQPAgMH2KVbj4s=;
        h=From:To:Cc:Subject:Date:From;
        b=SYyLj4I7YHR7vnn686wYWa8v5K1ld982Q+CfqDmjyyjWczKpIg9amhydQ6CA6YsUd
         ueRBNBtxxWUE1Et+satECE22knUBQW3oBcqONV2g0G9qB/7nN+0cLZIGV2ef+lP3iW
         WYcW7OCUjLZ4beM+FNOemGSj6s75wOqTTdI/67AJ0YJL7Ivwp0tlhAhpQxEvBpAgb7
         VYWyKnIpjYQFBjkXC508EVXgYnKOgO4vwLf06IH4S7dubAkn7oqhIQs6o1gEFFpPrR
         hjOk+V+P/4GFMy3BkRedcp2J259cDjd8C2pT7wrVQppWJ+hnatgh2z0ZgSVtQ1Qvtj
         kwMJrAi22V4Pw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, marijn.suijten@somainline.org,
        kernel@collabora.com
Subject: [PATCH v2 0/2] Qualcomm Ramp Controller and MSM8976 config
Date:   Fri,  4 Nov 2022 15:22:02 +0100
Message-Id: <20221104142204.156333-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
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

Changes in v2:
 - Fixed yaml issues as per Krzysztof's review
 - Reworded s/linking/link/g in both yaml and Kconfig help
 - Constified reg_sequence pointers
 - Removed spaces before defines
 - Added COMPILE_TEST to Kconfig entry

AngeloGioacchino Del Regno (2):
  dt-bindings: soc: qcom: Add bindings for Qualcomm Ramp Controller
  soc: qcom: Add Qualcomm Ramp Controller driver

 .../qcom/qcom,msm8976-ramp-controller.yaml    |  37 ++
 drivers/soc/qcom/Kconfig                      |   9 +
 drivers/soc/qcom/Makefile                     |   1 +
 drivers/soc/qcom/ramp_controller.c            | 331 ++++++++++++++++++
 4 files changed, 378 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,msm8976-ramp-controller.yaml
 create mode 100644 drivers/soc/qcom/ramp_controller.c

-- 
2.37.2

