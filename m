Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91ED86ACE57
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 20:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjCFTms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 14:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjCFTmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 14:42:45 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF1742BC5;
        Mon,  6 Mar 2023 11:42:44 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id k10so19468121edk.13;
        Mon, 06 Mar 2023 11:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1678131762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FAuGjsD3YjXPSmXRNqq5neuVV5rzxkAVxoe9/cuaDU8=;
        b=gMg8Ztq7gcsPGSligxplddglJIR4jRc3VmdV6qWwyR7aJXUnu+KbOFa0tyhC9VmLCN
         /PBoOGB345nuH6q/57SPzmAf25HZ+4lNncybUkDBZcV0rWQpctVOLDp4wPJsDDnFd3ni
         h+wu9yNwqjKtIewqXoKqRGJ1D+R1JpYXXOYnpS2QOPUzT8AyIN+ZSO0j+3yapFa23frB
         dLKAokjsldKcjmJR3zl13eMZKD21u6iMA6ELfUx3kpv4BrJRlCwuJjLqEsJ340GvqGBi
         6id1CfRUttoVmY4G4Stbe/++WLf0Uo03S/9TSkMEcAfuU4gm4yq3kXTO7y7uKYjxWcWG
         8XnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678131762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FAuGjsD3YjXPSmXRNqq5neuVV5rzxkAVxoe9/cuaDU8=;
        b=MTI9UNtVvlPiyPr8+qIGJvp/xgRuUqy4RwHLxZE9F+bZ1/I+OHVU8DBRDoGMyu675a
         4GqgHKGtpp7/sSXHIUbSeDi+n/NQm7vsyIL5iOsZyasQa1j5euPG5gwW9WVNPq7tNp/K
         czavkp3/6GeLr/2AgzdCJmMCWjWlyEguXZCRm4ujceQ9t15uLLBv33/io4CQ+UHMGNjG
         jDTnfObYMTQPotQYVMxHu/XN759QJIrP+jNH6l6KOgfFifYEOAVgIWxPPmDiUJHp3rtv
         oIoF46T8QJsSMsWEgPdTYPsg7sb9s0wGzlz+bByBftFN6dWsLAJGc0mnG1WFDX5r5kuJ
         F2NQ==
X-Gm-Message-State: AO0yUKVP6IJ05Nd5cEqdw74o/+vHYYPx/+w2goOqmiGosvdxixBkWpCV
        jAIxw0DX65q8Ce1vaylKVbU=
X-Google-Smtp-Source: AK7set/vI81sU/bEE2xdggFmsoR+9XzbWFDXJj4M4FS2nSfJbOPBifs6jt9xxUd+fzvvBM5h4FCrRw==
X-Received: by 2002:aa7:d296:0:b0:4bd:6b93:1286 with SMTP id w22-20020aa7d296000000b004bd6b931286mr12532264edq.25.1678131762493;
        Mon, 06 Mar 2023 11:42:42 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c23-c405-5c00-0000-0000-0000-0e63.c23.pool.telefonica.de. [2a01:c23:c405:5c00::e63])
        by smtp.googlemail.com with ESMTPSA id e19-20020a170906315300b008f2b0c6052csm4951868eje.89.2023.03.06.11.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 11:42:42 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jirislaby@kernel.org, neil.armstrong@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        gregkh@linuxfoundation.org,
        Christian Hewitt <christianshewitt@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 1/3] dt-bindings: serial: amlogic,meson-uart: Add compatible string for G12A
Date:   Mon,  6 Mar 2023 20:42:21 +0100
Message-Id: <20230306194223.1869814-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230306194223.1869814-1-martin.blumenstingl@googlemail.com>
References: <20230306194223.1869814-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amlogic G12A SoCs gained a new "divide XTAL by 2" bit. Everything else
(we know about) is identical to the UART IP on GX (GXBB/GXL/GXM) SoCs.
Add a new compatible string for this SoC so this new bit can be managed
accordingly while keeping "amlogic,meson-gx-uart" as fallback compatible
string.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
Changes from v1 -> v2:
- make meson-gx-uart a valid compatible string for meson-g12a-uart


 .../bindings/serial/amlogic,meson-uart.yaml   | 28 +++++++++++++------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
index 3cbdde85ed71..f3af0da8edaf 100644
--- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
@@ -26,21 +26,31 @@ properties:
   compatible:
     oneOf:
       - description: Always-on power domain UART controller
-        items:
+        oneOf:
+          - items:
+              - enum:
+                  - amlogic,meson6-uart
+                  - amlogic,meson8-uart
+                  - amlogic,meson8b-uart
+                  - amlogic,meson-gx-uart
+                  - amlogic,meson-s4-uart
+              - const: amlogic,meson-ao-uart
+          - items:
+              - const: amlogic,meson-g12a-uart
+              - const: amlogic,meson-gx-uart
+              - const: amlogic,meson-ao-uart
+      - description: Everything-Else power domain UART controller
+        oneOf:
           - enum:
               - amlogic,meson6-uart
               - amlogic,meson8-uart
               - amlogic,meson8b-uart
               - amlogic,meson-gx-uart
+              - amlogic,meson-g12a-uart
               - amlogic,meson-s4-uart
-          - const: amlogic,meson-ao-uart
-      - description: Everything-Else power domain UART controller
-        enum:
-          - amlogic,meson6-uart
-          - amlogic,meson8-uart
-          - amlogic,meson8b-uart
-          - amlogic,meson-gx-uart
-          - amlogic,meson-s4-uart
+          - items:
+              - const: amlogic,meson-g12a-uart
+              - const: amlogic,meson-gx-uart
 
   reg:
     maxItems: 1
-- 
2.39.2

