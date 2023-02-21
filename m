Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD46B69DDD0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 11:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbjBUK0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 05:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbjBUK0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 05:26:21 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D46B23DB5;
        Tue, 21 Feb 2023 02:26:15 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id h14so4636201plf.10;
        Tue, 21 Feb 2023 02:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ljVhImvcLF+Ojqa7MdWT2Dnen0EtitZFEgmDZZT9xPw=;
        b=ckRmb82V9MfoS3qYWuqDAQS0ANbzDPmwch7/Tn7QZIgCRT9brQAjIK1yIk2rUPSTsi
         92GFDZbDvLTbMl/xjgsMmygceYFxECL2FqvogCmJRBmECufCwsLwXVTT47x7rV4oY9Kv
         donIK17W3P2I5k1fc4aJ59FlFM8KqynZ+VHRjxMiGUYtTmpGN7YhcCC8R5hBr4ESckg6
         xLfo1i83PPn7PviaEFEvYS3gC8ymGI8Ae1b8QTTF6dyTK3zmYdZ+vdu9mEDxezjtHCIQ
         vPAvanCHr2910hGVnH9auryiJ+fe8At4b04o+faPhZK0VfOSztAhQe+Of8o4KsLgeEo5
         cXug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ljVhImvcLF+Ojqa7MdWT2Dnen0EtitZFEgmDZZT9xPw=;
        b=XFCf7ZM3JIyLMpsHxtfyVyVv11ZDAV+khvmu1E4N6LG8Hn4uZPFft7hNgitO1Us0du
         kmfa5mayY8UIdyFsdtCO1WcSdpeShN0TvDf56+3w9CBm8aeZAjXG3xwEXGXvF3u9uTMU
         L+oXgk3HOWOXVU9FWD+BAcbARbMYvtYThA7fNaS0FZnQFC4N7q6uJQUWtDOiu7Sf71Uv
         twszrBly1mtwDOL+Fxk9V8BRdEz65znXYq3h9Ta8pmh2BypCcr9pTrx8shlJBHxO/5CV
         qd9U4+6sAzEv3fV9pJ5bwfWKppXUfzM/k3i/jqlp2B4QrfJwrR9TGoRvgYfDB8+rm6cG
         9kIg==
X-Gm-Message-State: AO0yUKVJYHGotMyVwFnDdwOPdWMGXFOdBN0S6EctI/YcVb2toalp47j5
        TuYsIN+oeKE5T8DRXnfp/nNmf54KoZoFdA==
X-Google-Smtp-Source: AK7set90xkQuqGsx8vG+OOMbtzt7NjXVh1LWRyRU3NxoqvGYKgagDZsqfSPC+xyNi70V/n2go/kX4A==
X-Received: by 2002:a05:6a21:3287:b0:cb:7e8b:d4d7 with SMTP id yt7-20020a056a21328700b000cb7e8bd4d7mr1977024pzb.1.1676975174373;
        Tue, 21 Feb 2023 02:26:14 -0800 (PST)
Received: from kelvin-ThinkPad-L14-Gen-1.. (94.130.220.35.bc.googleusercontent.com. [35.220.130.94])
        by smtp.gmail.com with ESMTPSA id u13-20020aa7848d000000b005a8db4e3ecesm9235486pfn.69.2023.02.21.02.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 02:26:13 -0800 (PST)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH v2] dt-bindings: mips: loongson: Add Loongson-1 based boards
Date:   Tue, 21 Feb 2023 18:26:05 +0800
Message-Id: <20230221102605.2103657-1-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two Loongson-1 based boards: LSGZ 1B and Smartloong 1C.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
V1 -> V2: Add the according vendor prefix
          Change the board string to enum
          Modify the board description
---
 .../devicetree/bindings/mips/loongson/devices.yaml   | 12 ++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml         |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/mips/loongson/devices.yaml b/Documentation/devicetree/bindings/mips/loongson/devices.yaml
index f13ce386f42c..15a43ce51bbf 100644
--- a/Documentation/devicetree/bindings/mips/loongson/devices.yaml
+++ b/Documentation/devicetree/bindings/mips/loongson/devices.yaml
@@ -37,6 +37,18 @@ properties:
         items:
           - const: loongson,loongson64v-4core-virtio
 
+      - description: LS1B based boards
+        items:
+          - enum:
+              - loongson,lsgz-1b-dev
+          - const: loongson,ls1b
+
+      - description: LS1C based boards
+        items:
+          - enum:
+              - loongsonclub,smartloong-1c
+          - const: loongson,ls1c
+
 additionalProperties: true
 
 ...
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 0e57ae744199..47565ebae4d1 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -757,6 +757,8 @@ patternProperties:
     description: Lontium Semiconductor Corporation
   "^loongson,.*":
     description: Loongson Technology Corporation Limited
+  "^loongsonclub,.*":
+    description: Loongson Club
   "^lsi,.*":
     description: LSI Corp. (LSI Logic)
   "^lwn,.*":

base-commit: 39459ce717b863556d7d75466fcbd904a6fbbbd8
-- 
2.34.1

