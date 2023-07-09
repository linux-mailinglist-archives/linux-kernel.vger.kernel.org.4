Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECF174C3E8
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 13:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbjGIL4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 07:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbjGIL4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 07:56:07 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF566DB
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 04:56:05 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fc03aa6e04so14105455e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jul 2023 04:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688903764; x=1691495764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrXt7YogW8FbMMz7Y1nQxUHIxrZPDPVRkQgMwIsvUkc=;
        b=fjI5WO3rKzCRsUWPODWUh4Slpz8bGAKClyp1xQ0jeQjKwv64uNdT4ynm2g3Jnyf5/S
         eEcFPy1E+dq8fgHehaeaiCqjBs1TTuHJvNXdizOMBG7B6781lXEn6enVqKMPRTOT8d+Y
         XEPfKSaBNW6cHVluSHL+zVZBbF7xUnREb0Vb96UJ17fIkHl5tTNlH6CznuVH6Ve9VuRJ
         r7u5aE7pKw7KwIq7zV4bUH497HPmP/dOPfQQf5AGDdg6oLbXBWB6oVjKVY015zIB1i50
         T8RKeUptfDEKVqxdlo6qFEalSsxCme3rWA5XbPlBN9mACwKgSBOsBaruvNhrm89BgvdI
         rIdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688903764; x=1691495764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hrXt7YogW8FbMMz7Y1nQxUHIxrZPDPVRkQgMwIsvUkc=;
        b=YUvDcJNPE3AwxCgMSw+L8gam/5YH914YOeUAD7dPhoETpBbdEbbqrb3+ZL6GfIsLoA
         aKcoWpQM2ZNiOBxM/MLOMxcS04FqAHoEo5xK4PeT0C1TrsVESRzrTN61CuSlEmdAYiO/
         T5BT2smRLl2hrJydG2h1zt3HpQ/D3RTl6bZNXFzk/MUrjuGSVmIJb1HsqaJLFnBm/94U
         ftxwzTkgP87jypUIvKmCAgEGfV2lPtaCT7bVcMr5DDd10e7hmRj/LpU/IuXhRYvAzpC0
         PLvO4LzGbV/+KHJuqYFEAkoYLHpRLpX9hMPRBZZjEZro0pvdIhn37zYOUjc/9elp/Blu
         L0vQ==
X-Gm-Message-State: ABy/qLagBTYGMgq9iZvr6ix0qWSq0DXZqfFB0r6eWOB/Yx89RpIiNttS
        TngA8PxY2WKV1GXs/I53Y6FsGA==
X-Google-Smtp-Source: APBJJlHTlU5RW9sJy2jgsJURFY6KnfamT/IBVAIg4n2jwBNNXN62dwt+LG7UvIXTtLT2iDmFeK9BSQ==
X-Received: by 2002:a05:600c:2247:b0:3fc:8a:7c08 with SMTP id a7-20020a05600c224700b003fc008a7c08mr6031433wmm.35.1688903764223;
        Sun, 09 Jul 2023 04:56:04 -0700 (PDT)
Received: from vermeer.tail79c99.ts.net ([2a01:cb1d:81a9:dd00:b570:b34c:ffd4:c805])
        by smtp.gmail.com with ESMTPSA id 2-20020a05600c02c200b003fc007d8a92sm6194101wmn.45.2023.07.09.04.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jul 2023 04:56:03 -0700 (PDT)
From:   Samuel Ortiz <sameo@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     Samuel Ortiz <sameo@rivosinc.com>, linux@rivosinc.com,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-kernel@vger.kernel.org,
        "Hongren (Zenithal) Zheng" <i@zenithal.me>,
        Guo Ren <guoren@kernel.org>, Atish Patra <atishp@rivosinc.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Evan Green <evan@rivosinc.com>, devicetree@vger.kernel.org
Subject: [PATCH v3 2/4] dt-bindings: riscv: Document the 1.0 scalar cryptography extensions
Date:   Sun,  9 Jul 2023 13:55:44 +0200
Message-ID: <20230709115549.2666557-3-sameo@rivosinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709115549.2666557-1-sameo@rivosinc.com>
References: <20230709115549.2666557-1-sameo@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RISC-V cryptography extensions define a set of instructions, CSR
definitions, architectural interfaces and also extension shorthands for
running scalar and vector based cryptography operations on RISC-V
systems.

This documents all the dt-bindings for the scalar cryptography
extensions, including the Zk, Zkn and Zks shorthands.

Signed-off-by: Samuel Ortiz <sameo@rivosinc.com>
---
 .../devicetree/bindings/riscv/extensions.yaml | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index cc1f546fdbdc..361756978da1 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -190,6 +190,24 @@ properties:
             instructions as ratified at commit 6d33919 ("Merge pull request #158
             from hirooih/clmul-fix-loop-end-condition") of riscv-bitmanip.
 
+        - const: zbkb
+          description: |
+            The standard Zbkb cryptography extension for bit-manipulation
+            instructions, as ratified at commit 73de909
+            ("Zvk: Update AES instruction specs") of riscv-crypto.
+
+        - const: zbkc
+          description: |
+            The standard Zbkc cryptography extension for carry-less multiply
+            instructions, as ratified at commit 73de909
+            ("Zvk: Update AES instruction specs") of riscv-crypto.
+
+        - const: zbkx
+          description: |
+            The standard Zbkx cryptography extension for crossbar permutation
+            instructions, as ratified at commit 73de909
+            ("Zvk: Update AES instruction specs") of riscv-crypto.
+
         - const: zicbom
           description:
             The standard Zicbom extension for base cache management operations as
@@ -240,6 +258,70 @@ properties:
             ratified in the 20191213 version of the unprivileged ISA
             specification.
 
+        - const: zk
+          description: |
+            The standard Zk cryptography extension is a shorthand for the
+            union of the Zkn, Zkr and Zkt cryptography extensions, as ratified
+            at commit 73de909 ("Zvk: Update AES instruction specs") of
+            riscv-crypto.
+
+        - const: zkn
+          description: |
+            The standard Zkn cryptography extension covers the NIST algorithm
+            suite that other cryptography extensions support. It is the union of
+            the Zbkb, Zbkc, Zbkx, Zknd, Zkne and Zknh extensions, as ratified at
+            commit 73de909 ("Zvk: Update AES instruction specs") of riscv-crypto.
+
+        - const: zknd
+          description: |
+            The standard Zknd cryptography extension for AES block cipher
+            decryption acceleration instructions, as ratified at commit 73de909
+            ("Zvk: Update AES instruction specs") of riscv-crypto.
+
+        - const: zkne
+          description: |
+            The standard Zkne cryptography extension for AES block cipher
+            encryption acceleration instructions, as ratified at commit 73de909
+            ("Zvk: Update AES instruction specs") of riscv-crypto.
+
+        - const: zknh
+          description: |
+            The standard Zknh cryptography extension for SHA2 hash algorithm
+            functions acceleration instructions as ratified at commit 73de909
+            ("Zvk: Update AES instruction specs") of riscv-crypto.
+
+        - const: zkr
+          description: |
+            The standard Zkr cryptography extension for the entropy source CSR
+            definitions, as ratified at commit 73de909
+            ("Zvk: Update AES instruction specs") of riscv-crypto.
+
+        - const: zks
+          description: |
+            The standard Zks cryptography extension covers the ShangMi algorithm
+            suite that other cryptography extensions support. It is the union of
+            the Zbkb, Zbkc, Zbkx, Zksed and Zksh extensions, as ratified at
+            commit 73de909 ("Zvk: Update AES instruction specs") of riscv-crypto.
+
+        - const: zksed
+          description: |
+            The standard Zksed cryptography extension for SM4 block cipher
+            acceleration instructions, as ratified at commit 73de909
+            ("Zvk: Update AES instruction specs") of riscv-crypto.
+
+        - const: zksh
+          description: |
+            The standard Zksh cryptography extension for SM3 hash algorithm
+            funstions acceleration instructions, as ratified at commit 73de909
+            ("Zvk: Update AES instruction specs") of riscv-crypto.
+
+        - const: zkt
+          description: |
+            The standard Zkt cryptography extension for data independent
+            execution latency attestation, for a safe subset of instructions,
+            as ratified at commit 73de909 ("Zvk: Update AES instruction specs")
+            of riscv-crypto.
+
         - const: ztso
           description:
             The standard Ztso extension for total store ordering, as ratified
-- 
2.41.0

