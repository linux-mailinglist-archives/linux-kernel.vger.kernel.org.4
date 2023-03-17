Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E316BE46A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjCQIza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbjCQIzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:55:02 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49ED267817;
        Fri, 17 Mar 2023 01:54:41 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso8428647pjb.0;
        Fri, 17 Mar 2023 01:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679043279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZZGTAPsI0PVagU4SLwgIUrsBDZ0+vMYKA5E/MTQZzw=;
        b=D/MunO7+pL8frzOVKYdT3mHEg1LVUzaooOSBapTGYXSyC12731q9fNEsVrxBJCJdzR
         OLqCAE2Q7N/FnBHB5+akvqFOzX5IkDuI4lNSe3lVV7+gUGnveS+EHzx5kIqC4Io3dei9
         8HLEG2z4EeDvZ7/l7+WGKogni0dmsfzxhS6vYeI2f4H4Ah3PsNtZ5AVq+Us0d3i1pM4r
         E7+We3mmsjQeUzKFoHcdD2kf4Q67AXEMdfF0+ikqiMr8gdSev/hzTnmXkI42kuq1GZ4X
         wk5K/i44WiGnTMuHb7fGuArC3MxTjy2y8sqVU5wp+dLsYEN4Wu+l+zfhmkzIJjBtVG7r
         36BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679043279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fZZGTAPsI0PVagU4SLwgIUrsBDZ0+vMYKA5E/MTQZzw=;
        b=PTTlaiXYawGa3CFHmxCSEaeoUldRafTYMk8igQ+x7iI8sg1mcEY19fcuxsLSsWJeUv
         Dz0OfOTobwhMDkdPJ9cxCwvO0O2nH+v6TM6ZKevS34vMK8obBrugTTdZdUH+ag5vrUPD
         ym4VAgJibu8BTJoqODNvnOm6NQYnScVfWr6vXv/yv4ZMVkKfwm9LjKajBeEbETjjqlEy
         t+FfGtxEYcuHr9CEPdVQdizWvocBU4kcGDR58noN25Pdh5L3dfbm0HIYauiUPyp44NK2
         wKbJngOdHCKT1Yrnx6xqSsJrwmRWGSKbtNSyWrRGczzGkwTFTJJMjqPMpxZTTGGSfpmU
         IP5Q==
X-Gm-Message-State: AO0yUKU3rGv4R2dk8Dg80sMUMs5mHyL/kLYV2OM/ny0oYhIesJryrwme
        MA2nhXl3W8hBn7u70YG1clQ=
X-Google-Smtp-Source: AK7set/TIf0pkP6qGFwfBRT3rvezlG4gxBXIUl4HjW5iuNZkPCLdMwASJp22Rd3Bs+NyPjJzTsghvQ==
X-Received: by 2002:a17:903:3012:b0:1a0:6852:16dd with SMTP id o18-20020a170903301200b001a0685216ddmr5107731pla.12.1679043279120;
        Fri, 17 Mar 2023 01:54:39 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.204])
        by smtp.gmail.com with ESMTPSA id jh17-20020a170903329100b0019a96a6543esm1030775plb.184.2023.03.17.01.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 01:54:38 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
Cc:     David Yang <mmyangfl@gmail.com>, Wei Xu <xuwei5@hisilicon.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v2 4/4] dt-bindings: arm: hisilicon: Add Hi37xx SoCs
Date:   Fri, 17 Mar 2023 16:53:47 +0800
Message-Id: <20230317085347.10147-5-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317085347.10147-1-mmyangfl@gmail.com>
References: <20230317085347.10147-1-mmyangfl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for Hisilicon Hi37xx SoCs.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 .../bindings/arm/hisilicon/hisilicon.yaml     | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.yaml b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.yaml
index 540876322..0e0fcb1c7 100644
--- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.yaml
+++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.yaml
@@ -25,11 +25,39 @@ properties:
           - const: hisilicon,hi3670-hikey970
           - const: hisilicon,hi3670
 
+      - description: Hi3716cv200 based boards.
+        items:
+          - const: hisilicon,hi3716cv200
+
+      - description: Hi3716mv410 based boards.
+        items:
+          - const: hisilicon,hi3716mv410
+
+      - description: Hi3796cv200 based boards.
+        items:
+          - const: hisilicon,hi3796cv200
+
+      - description: Hi3796mv200 based boards.
+        items:
+          - const: hisilicon,hi3796mv200
+
       - description: Hi3798cv200 based boards.
         items:
           - const: hisilicon,hi3798cv200-poplar
           - const: hisilicon,hi3798cv200
 
+      - description: Hi3798mv100 based boards.
+        items:
+          - const: hisilicon,hi3798mv100
+
+      - description: Hi3798mv200 based boards.
+        items:
+          - const: hisilicon,hi3798mv200
+
+      - description: Hi3798mv300 based boards.
+        items:
+          - const: hisilicon,hi3798mv300
+
       - description: Hi4511 Board
         items:
           - const: hisilicon,hi3620-hi4511
-- 
2.39.2

