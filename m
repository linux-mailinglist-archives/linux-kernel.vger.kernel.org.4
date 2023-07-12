Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A8E7501E6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbjGLIly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjGLIlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:41:45 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168F495
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 01:41:44 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3128fcd58f3so7262803f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 01:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689151302; x=1691743302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RT/Vt3RRfMq4FWYr6OtGjxwm1ECt6aNXHT5BGeUxff0=;
        b=gYPnPU3NZw9utPGclL+789aHb3o31Fbn2cEUJggsFY2ACdfcnuBKWAjFigGD/0gpDO
         eHwKw0QqyK/YPRuyAOaFskMLIjkJhWDXb1jndmGbaM8cOK+RbjkgAYFEXALOoTKzUgcG
         qPgnErIFUSnExWOiZ+H3qDiANwpt1Ci0AYavvs8PtIWDR7ZE/beHvm1/MLJ83PyK7AnY
         rXIfuD8G2m+9o5uogS8UZDn+2kGx/XtM2NvqNVcfPnIlm8s1h4f8PgOlZVQJCaQRCZB0
         /5F/AMo1W/vzP5kQZX4jvCjTRrJgI4fLsP7XIbMnoo0cUjBLdps3vjVS8cgjlnSvAQMN
         l6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689151302; x=1691743302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RT/Vt3RRfMq4FWYr6OtGjxwm1ECt6aNXHT5BGeUxff0=;
        b=T4OAHFHANs6gkzLh+toHaU8+nALnGKM8tyYv3pfw+X2eoONXgFa2rO0Znwc/NQ5VKH
         1SKqjyAEG5+6LrAuOiXdhG+xZVBW3FvR5mHXXax9/kCJoekexuKaTHaE8kk0JnD8wX8w
         2gw9PCekAmORph25SygVtcXk+nZp8cHOFFe9Ip/sBlcFe00qOUOV4wZqFsuSVjgehz2s
         +RNQEYBxcJzQlsItC4lvHztAOgoiHI9Yx33VCtVTHpEwiG5TeTC3TeSpVKZQCcO1gVhY
         Uz1zw4r/uD3i12+lBkgh41UYj0egpF5Uiz3KoGxZ29vyNCxQaCF5wdlvjY+iFwbrEiUG
         6m+Q==
X-Gm-Message-State: ABy/qLazSKRjETJxCrLrf7vSDeVI9coFcFXfbAeHdfJrY9u0gQPHeOjn
        AVu5fSDSvddoiAmQiNzwY7OZMQ==
X-Google-Smtp-Source: APBJJlG5aEliuCg0Tzq/nowgmurWqSwaYDI+IB0QIjxf7737XRRWEo6xEPUUb76lZKABoel7Q4lrxQ==
X-Received: by 2002:adf:ec8e:0:b0:314:1ebc:6e19 with SMTP id z14-20020adfec8e000000b003141ebc6e19mr16442275wrn.64.1689151302320;
        Wed, 12 Jul 2023 01:41:42 -0700 (PDT)
Received: from vermeer.tail79c99.ts.net ([2a01:cb1d:81a9:dd00:b570:b34c:ffd4:c805])
        by smtp.gmail.com with ESMTPSA id z13-20020adfe54d000000b003143ac73fd0sm4496122wrm.1.2023.07.12.01.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 01:41:42 -0700 (PDT)
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
        Evan Green <evan@rivosinc.com>, devicetree@vger.kernel.org,
        sorear@fastmail.com
Subject: [PATCH v4 2/4] dt-bindings: riscv: Document the 1.0 scalar cryptography extensions
Date:   Wed, 12 Jul 2023 10:41:18 +0200
Message-ID: <20230712084134.1648008-3-sameo@rivosinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230712084134.1648008-1-sameo@rivosinc.com>
References: <20230712084134.1648008-1-sameo@rivosinc.com>
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

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Signed-off-by: Samuel Ortiz <sameo@rivosinc.com>
---
 .../devicetree/bindings/riscv/extensions.yaml | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index cc1f546fdbdc..3d3d0d2f71e7 100644
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
@@ -240,6 +258,75 @@ properties:
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
+            Systems with the Zkr extension enabled must set the MSECCFG SSEED
+            bit to 1 in order for the Linux kernel to access the SEED CSR.
+            As userspace access to the entropy source is usually carefully
+            controlled and exclusively managed by the Linux kernel, M-mode
+            should set USEED to 0.
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

