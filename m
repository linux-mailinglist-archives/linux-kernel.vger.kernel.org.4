Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09904609D57
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 11:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiJXJB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 05:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJXJBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 05:01:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3AE3FA10;
        Mon, 24 Oct 2022 02:01:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 639AE61074;
        Mon, 24 Oct 2022 09:01:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6AF2C433D6;
        Mon, 24 Oct 2022 09:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666602097;
        bh=1R8yc2SvpelM4g9C9noqmpA7ytRQEi/9AxHWjzgCCh4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FJWz98zG/8SirD1vmMVimK6hokJbTYRDN0VAclAod/ETzOtagNFh2VhHILda7QLMs
         oPWmQYuqk8m9PRnQmJSeEZ7bCmSWYxpDgmCBVgCSVNYzJZHBUxB/nUNqhmy/aQmBfQ
         jmieLmOuebof374xYSluHKKyyr2QBVY1Dp9swfhilk+ApCTp53HOt0dbtkDgRTqSii
         0I2zmSi9zXwR7zsPCcjMnWFETweIUlH8FMkzg3kXoOx0P8G5TagNHPnRqUEDuC00lv
         LFUSaBrCGTF0ID/9gxTzsKk1Gcg2kytW1Wja1v2frAxPCGmafRntWunDKzbJZIX/5+
         sEvm4ASJddQWg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1omtKj-00056c-JS; Mon, 24 Oct 2022 11:01:21 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 07/10] dt-bindings: phy: qcom,qmp-ufs: rename current bindings
Date:   Mon, 24 Oct 2022 11:00:38 +0200
Message-Id: <20221024090041.19574-8-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221024090041.19574-1-johan+linaro@kernel.org>
References: <20221024090041.19574-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current QMP UFS PHY bindings are based on the original MSM8996 PCIe
PHY binding which provided multiple PHYs per IP block and these in turn
were described by child nodes.

The QMP UFS PHY block only provide a single PHY and the remnant child
node does not really reflect the hardware.

The original MSM8996 binding also ended up describing the individual
register blocks as belonging to either the wrapper node or the PHY child
nodes.

This is an unnecessary level of detail which has lead to problems when
later IP blocks using different register layouts have been forced to fit
the original mould rather than updating the binding. The bindings are
arguable also incomplete as they only the describe register blocks used
by the current Linux drivers.

In preparation for adding new bindings for SC8280XP which further
bindings can be based on, rename the current bindings after MSM8996 and
add a reference to the SC8280XP bindings.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 ...qcom,qmp-ufs-phy.yaml => qcom,msm8996-qmp-ufs-phy.yaml} | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)
 rename Documentation/devicetree/bindings/phy/{qcom,qmp-ufs-phy.yaml => qcom,msm8996-qmp-ufs-phy.yaml} (95%)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-ufs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-ufs-phy.yaml
similarity index 95%
rename from Documentation/devicetree/bindings/phy/qcom,qmp-ufs-phy.yaml
rename to Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-ufs-phy.yaml
index 815c375d0f7b..438f9606414a 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-ufs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-ufs-phy.yaml
@@ -1,10 +1,10 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/phy/qcom,qmp-ufs-phy.yaml#
+$id: http://devicetree.org/schemas/phy/qcom,msm8996-qmp-ufs-phy.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Qualcomm QMP PHY controller (UFS)
+title: Qualcomm QMP PHY controller (UFS, MSM8996)
 
 maintainers:
   - Vinod Koul <vkoul@kernel.org>
@@ -13,6 +13,9 @@ description:
   QMP PHY controller supports physical layer functionality for a number of
   controllers on Qualcomm chipsets, such as, PCIe, UFS, and USB.
 
+  Note that these bindings are for SoCs up to SC8180X. For newer SoCs, see
+  qcom,sc8280xp-qmp-ufs-phy.yaml.
+
 properties:
   compatible:
     enum:
-- 
2.37.3

