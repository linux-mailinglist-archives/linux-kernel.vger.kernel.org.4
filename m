Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051F66C1424
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 14:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjCTN45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 09:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjCTN4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 09:56:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C053BDF0;
        Mon, 20 Mar 2023 06:55:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4CF6B80E97;
        Mon, 20 Mar 2023 13:55:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 742D3C4339B;
        Mon, 20 Mar 2023 13:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679320556;
        bh=C1Qh/WWAaSUHP1prYGquNRNsLHTSbT09WNuA4Tp6dX0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YM8ovJ9BCFM9YRI7fD52jsnPiQWlsiY2ma5zgSTUGycS5JNHIlAhTvKUpkgJPc91q
         9TGcf9UIThGTLh3ZsSwT1NNVUkeiRV+YUcxFo2UiRXVcV3XqFrgqs6jhfMLZrZLtHF
         x4ofq2gl0zt3Tm/2CfpFgE8jzAE92Jv+Ckw046UmlFzZ0pqA0NqrHy86bYHfupKaGU
         AoI5XbwntL8u94f0Ovk0RYw7mI2RqoNFYBZj0qWQwfo0p1ah2zNZyk83JiGL7AMCXy
         k36UD+xVTBPypDgKhiKjSQjE4g18qks9wmfpbkeU9fE/ymN3aswZuErLbOcJ3jCiCq
         BEgaJsMaYzbUg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1peG0j-0000WR-OP; Mon, 20 Mar 2023 14:57:17 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>, Lee Jones <lee@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 1/3] dt-bindings: nvmem: qcom,spmi-sdam: fix example 'reg' property
Date:   Mon, 20 Mar 2023 14:57:08 +0100
Message-Id: <20230320135710.1989-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230320135710.1989-1-johan+linaro@kernel.org>
References: <20230320135710.1989-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SPMI PMIC register region width is fixed and should not be encoded
in the devicetree.

Amend the example with a parent pmic node with the expected
'#address-cells' and '#size-cells' and fix up the 'reg' property.

Fixes: 9664a6b54c57 ("dt-bindings: nvmem: add binding for QTI SPMI SDAM")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../bindings/nvmem/qcom,spmi-sdam.yaml        | 31 +++++++++++--------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml b/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml
index e08504ef3b6e..4702f10ecca2 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml
@@ -42,17 +42,22 @@ unevaluatedProperties: false
 
 examples:
   - |
-      sdam_1: nvram@b000 {
-          #address-cells = <1>;
-          #size-cells = <1>;
-          compatible = "qcom,spmi-sdam";
-          reg = <0xb000 0x100>;
-          ranges = <0 0xb000 0x100>;
-
-          /* Data cells */
-          restart_reason: restart@50 {
-              reg = <0x50 0x1>;
-              bits = <6 2>;
-          };
-      };
+    pmic {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        sdam_1: nvram@b000 {
+            compatible = "qcom,spmi-sdam";
+            reg = <0xb000>;
+            #address-cells = <1>;
+            #size-cells = <1>;
+            ranges = <0 0xb000 0x100>;
+
+            /* Data cells */
+            restart_reason: restart@50 {
+                reg = <0x50 0x1>;
+                bits = <6 2>;
+            };
+        };
+    };
 ...
-- 
2.39.2

