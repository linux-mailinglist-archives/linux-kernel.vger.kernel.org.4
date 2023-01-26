Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387AE67CDF6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbjAZOX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbjAZOXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:23:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470283757B;
        Thu, 26 Jan 2023 06:23:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 08C04B81DF8;
        Thu, 26 Jan 2023 14:23:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D5FC4322F;
        Thu, 26 Jan 2023 14:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674742978;
        bh=2SM/Ui25AWvYpcR7rG/b1iY3k51zQ41f392BYri9b24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OMnTIpqGk9MS51mIXmtKCNcxlJaK26xH4GGnA1GIWjxMtOuQmnhywFbzqMZA7V5r9
         4IjElCUzoqhXP5eWBpGihE7DyWawK7G+AOVoExtB/D4fYAkaFUEkkt7MzEUKzWGM6E
         HjOA/tTLJiVdLjKU19LhpP9xFHccNde8LdfyfCEdGmzpk4VuUGuBt+xwENFPlvdg8A
         6lqZXgl6l6kYj8kXHVCnufDDHOV26iC6UhK+1uPwy0k2FpBAytyV9SJex8l23BJZlb
         zw1kf7ODFdKWUVg2/g2pu2cqzLEZdTNixRzQMY86Z7Elkd0oJzGfepOdbgDknO5mK9
         b1ls8j3EplOww==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pL39d-0006ir-9H; Thu, 26 Jan 2023 15:23:05 +0100
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
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 15/24] dt-bindings: rtc: qcom-pm8xxx: add nvmem-cell offset
Date:   Thu, 26 Jan 2023 15:20:48 +0100
Message-Id: <20230126142057.25715-16-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230126142057.25715-1-johan+linaro@kernel.org>
References: <20230126142057.25715-1-johan+linaro@kernel.org>
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

On many Qualcomm platforms the PMIC RTC control and time registers are
read-only so that the RTC time can not be updated. Instead an offset
needs be stored in some machine-specific non-volatile memory, which a
driver can take into account.

Add an 'offset' nvmem cell which can be used to store a 32-bit offset
from the Unix epoch so that the RTC time can be updated on such
platforms.

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

