Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B55A72B23E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 16:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbjFKOGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 10:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234246AbjFKOFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 10:05:38 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1F03C06
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 07:04:35 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f6d38a140bso24798845e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 07:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686492256; x=1689084256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=697RImy8eLNpy0GJIxOnILvvWkZ6BuYm/dHlziJ3fW4=;
        b=TGqYsO6YbCL0lwNurycP5MqyZD5OBWqvK8bKxqfSs8Xuxf0fdM5qYLJ6Ip8eUXgb3x
         ZWnCu6tK+X76UC0gPu9RdYQd89oGm0Mqp25jVkNMcUHh4B15B9O1iuLmcw5iMC9AdyJn
         KPnE0ogThl/UfJtrwsEVcwyr3rHMn6LP8Vr15IYqmCcao9XpFhxC6iZ7JiMqwWrSqZ16
         OBePzDdiEHRCTo/sQuaxy/sA+nk1RSMgDdNtgpH9fC1p9DdaS8p+xGUGMaXbIWeFwO4t
         fiDsKU5T2lkobPvEA84tY68ES2E2uMLWR53XZxBojR984Fr8fPUoVLnSREZg+0rkomQf
         EGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686492256; x=1689084256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=697RImy8eLNpy0GJIxOnILvvWkZ6BuYm/dHlziJ3fW4=;
        b=g+Jxdye52K6FBbNo1S2aaZbLgesLJLaF06Ucw8vbdPdzAp8KeOPwOc2KrsfPysfmIw
         afTix8eaXFVg6/DESP52tWxVYZSWTipE2FZ5n2is0dGDHVf+tTocuy0NpW8z7OXxNIHp
         14H2CYCKnT5Rz/39VpiMb2bgme4PIZXLQF6DNjOD9BNyfZA1SJRXJUqwmX0WMs7izEuv
         IWAfFJqfrTXlytokfquTWHBo4vAQxeoM342RvJc4W+flOYl3vDRXDHInf7FhA7H5GsBn
         8SyNYzzr39/TMxkv5YWlIfRcrP1G+OtzZNGin5SVFNNl+l99s3B+sYuC3lbX74ttwdOC
         K/rQ==
X-Gm-Message-State: AC+VfDweMKWeVdBaqmVtFOeXSxinrNiZayD1REy9WUIpNv5ak3j8N0pi
        8bXkcu07gYeNRuhXcJqIcwNg1Q==
X-Google-Smtp-Source: ACHHUZ5jvD42QBq44uaMklN2jK1RvN3YD3ogjZ48fB95X9air8i087n9PJ9QqMt9qr2/Np1tu+1bGg==
X-Received: by 2002:a05:600c:218:b0:3f7:367a:bd28 with SMTP id 24-20020a05600c021800b003f7367abd28mr5601335wmi.4.1686492256348;
        Sun, 11 Jun 2023 07:04:16 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c28d100b003f080b2f9f4sm8567222wmd.27.2023.06.11.07.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 07:04:15 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 24/26] dt-bindings: nvmem: convert base example to use NVMEM fixed cells layout
Date:   Sun, 11 Jun 2023 15:03:28 +0100
Message-Id: <20230611140330.154222-25-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230611140330.154222-1-srinivas.kandagatla@linaro.org>
References: <20230611140330.154222-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

With support for the "fixed-layout" binding it's possible and preferred
now to define fixed NVMEM cells in the layout node. Do that for the
example binding.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/nvmem/nvmem.yaml      | 42 +++++++++++--------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
index b79f1bb795fb..980244100690 100644
--- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
+++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
@@ -68,24 +68,30 @@ examples:
 
           /* ... */
 
-          /* Data cells */
-          tsens_calibration: calib@404 {
-              reg = <0x404 0x10>;
-          };
-
-          tsens_calibration_bckp: calib_bckp@504 {
-              reg = <0x504 0x11>;
-              bits = <6 128>;
-          };
-
-          pvs_version: pvs-version@6 {
-              reg = <0x6 0x2>;
-              bits = <7 2>;
-          };
-
-          speed_bin: speed-bin@c{
-              reg = <0xc 0x1>;
-              bits = <2 3>;
+          nvmem-layout {
+              compatible = "fixed-layout";
+              #address-cells = <1>;
+              #size-cells = <1>;
+
+              /* Data cells */
+              tsens_calibration: calib@404 {
+                  reg = <0x404 0x10>;
+              };
+
+              tsens_calibration_bckp: calib_bckp@504 {
+                  reg = <0x504 0x11>;
+                  bits = <6 128>;
+              };
+
+              pvs_version: pvs-version@6 {
+                  reg = <0x6 0x2>;
+                  bits = <7 2>;
+              };
+
+              speed_bin: speed-bin@c{
+                  reg = <0xc 0x1>;
+                  bits = <2 3>;
+              };
           };
       };
 
-- 
2.25.1

