Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCDD67CDD5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbjAZOXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbjAZOXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:23:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF7A17166;
        Thu, 26 Jan 2023 06:23:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23D026184D;
        Thu, 26 Jan 2023 14:22:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8139C43615;
        Thu, 26 Jan 2023 14:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674742978;
        bh=kGIY8BsCOcAUuz4rUJvWx7AsZas3uSRgZ9e8CL6ualY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eHPvLL5BRkmGEBfeV0iCFJ3m0Iy4byK3gJD3+Hddcma5Ep/xVtAEUO/0qwXqvwaZo
         magytMcxv9mNvnSd6TFYB/fxbtTjvpzjN7hlSsA+jo6yO+LDjYDhlonTkaZfVWI3Dx
         wpeYT2zFfGcjZOeCcIZbT7vWFYKz4ghVcEcnSPHJhHXKTtSeW7WVpjQkaXwJ53xPhb
         fwr8m7ENW8IdVTy6XQxMcZFZgC89DcB1mD2k1SIXAVFHajUm0B81w+NjoOxvyIaHcD
         1qnfPvntsA3zL2SnMDHS+c0HKZFIGTtSQ6m+WFdVVXE4yLWLUW2H+QGAhXhD++AmOl
         MHSYrWJ2zBi0A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pL39d-0006j1-Hw; Thu, 26 Jan 2023 15:23:05 +0100
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
Subject: [RFC 18/24] dt-bindings: rtc: qcom-pm8xxx: add uefi-variable offset
Date:   Thu, 26 Jan 2023 15:20:51 +0100
Message-Id: <20230126142057.25715-19-johan+linaro@kernel.org>
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

Add a 'qcom,uefi-rtc-info' boolean flag which indicates that the RTC
offset is stored in a Qualcomm specific UEFI variable so that the RTC
time can be updated on such platforms.

The UEFI variable is

	882f8c2b-9646-435f-8de5-f208ff80c1bd-RTCInfo

and holds a 12-byte structure where the first four bytes is a GPS time
offset in little-endian byte order.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml b/Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml
index b95a69cc9ae0..774c34c3f8f6 100644
--- a/Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml
@@ -50,6 +50,12 @@ properties:
     items:
       - const: offset
 
+  qcom,uefi-rtc-info:
+    type: boolean
+    description:
+      RTC offset is stored as a four-byte GPS time offset in a 12-byte UEFI
+      variable 882f8c2b-9646-435f-8de5-f208ff80c1bd-RTCInfo
+
   wakeup-source: true
 
 required:
-- 
2.39.1

