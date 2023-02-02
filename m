Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24B4688372
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbjBBPzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbjBBPzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:55:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296FF6384A;
        Thu,  2 Feb 2023 07:54:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A165261C28;
        Thu,  2 Feb 2023 15:54:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE46FC4323C;
        Thu,  2 Feb 2023 15:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675353285;
        bh=8WuJFfnUpK90ylTPuREpqxZk3Bc9oC9nAf9c/rnnkIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FeD7H3IzV+I+4XrgT+v/Klglf9+0UO6heJbbtpxEb48QRurjJWnQ5m0V4dWzGxALV
         TdlG3waIZZz+m2P7W2wMBNCTaONXLjiip45k7HF3vQuiWDkLn2Dx2zUqe/7Kduy7Oz
         qVs3O04JEl3WcNkqVjBaZmSXqAjT8Lj/z8QDwNz1c6flzJtmUt9Wzt1ULYRQQwJUW7
         4Gsa/6aBhSprNfJdH3zC07e/8hitp7xdmWsTqGoyYZHIIbzK/Nga31kVHQEc2AMuZ/
         r5G/AxfPGMvnsF67r3XZcDzI9a92DQT21tdsfRunNnRYj2VC+eEx9oDAJWPApsGzAg
         B2z8dnujugTKQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pNbvZ-0001mR-U0; Thu, 02 Feb 2023 16:55:09 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 16/22] dt-bindings: rtc: qcom-pm8xxx: add nvmem-cell offset
Date:   Thu,  2 Feb 2023 16:54:42 +0100
Message-Id: <20230202155448.6715-17-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230202155448.6715-1-johan+linaro@kernel.org>
References: <20230202155448.6715-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On many Qualcomm platforms the PMIC RTC control and time registers are
read-only so that the RTC time can not be updated. Instead an offset
needs be stored in some machine-specific non-volatile memory, which a
driver can take into account.

Add an 'offset' nvmem cell which can be used to store a 32-bit offset
from the Unix epoch so that the RTC time can be updated on such
platforms.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml     | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml b/Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml
index 21c8ea08ff0a..b95a69cc9ae0 100644
--- a/Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml
@@ -40,6 +40,16 @@ properties:
     description:
       Indicates that the setting of RTC time is allowed by the host CPU.
 
+  nvmem-cells:
+    items:
+      - description:
+          four-byte nvmem cell holding a little-endian offset from the Unix
+          epoch representing the time when the RTC timer was last reset
+
+  nvmem-cell-names:
+    items:
+      - const: offset
+
   wakeup-source: true
 
 required:
@@ -69,6 +79,8 @@ examples:
           compatible = "qcom,pm8921-rtc";
           reg = <0x11d>;
           interrupts = <0x27 0>;
+          nvmem-cells = <&rtc_offset>;
+          nvmem-cell-names = "offset";
         };
       };
     };
-- 
2.39.1

