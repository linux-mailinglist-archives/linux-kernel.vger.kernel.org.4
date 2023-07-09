Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9549874C3EC
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 13:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbjGIL4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 07:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbjGIL4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 07:56:11 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D64194
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 04:56:07 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fbc6ab5ff5so37118835e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jul 2023 04:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688903766; x=1691495766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c4NrSWdfkQConL7+u+EjtZsZVwzL9nmXD1mG1ZJ9TfY=;
        b=gGErSPtgLPy6x3QcjTO9ihDSZdy/aVsvR+9LUXP9w35GvCQK/dEYLpn105rVbIqBc8
         +18R1EytxDIVrNhkwNz6Pl3N6SwAISeJoBs+loB3/as4ySb6iWwISoCYlRB7PITmumfq
         j76ygvXv2Tjvo5k8+ueZbNYYoYXgoGFpQXiEk9wmRUPVsf+dF7p1KEayAgVFddZBKFEO
         okDWVVI2lTNuvoVYGAlyCeH5//SzIX55VKkzTzcsotmXxG0ZBh1By+eq/vhpOAFtbzCo
         1ESwQeZ1F87Rxyzo0EuaqeKl2XjPiwhjKvVYcyrx9K7BZxZhMRPNKdWA53E0dbDGmZpa
         TYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688903766; x=1691495766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c4NrSWdfkQConL7+u+EjtZsZVwzL9nmXD1mG1ZJ9TfY=;
        b=EXwQS1x+aIRULS8PAS+Ez18hWbzo4AUMXtqkH3k4WMvqkWiSnoPu1KSZMvaHbRo0NU
         pALpPuQ3fQuLClrgBGDuUvlyU5ci0RpEajJe+ASqElru3OUUQW1OM/LGVmyGeCAWh8MQ
         uZQQa4JwJZOLdXD5rgp1/62n8CY2Hgc8CmQ3tSgWBe5RIpyOwpktMhqpHehq5zxeivih
         tJhSw+5gpNCRvHLt6KPVKzvflcTg3U0ruB7ZTA/rRYRYVOV+5AKHDOOiDyWCzg5tH/+L
         cPig1D7zUT/IE2d0r6OXwyQm/1qT5mcWOLFdAq9IMfWO6ysupq9KEW2n6U4USCeqs3Ct
         YBtQ==
X-Gm-Message-State: ABy/qLbgWpUP1b5tMIksMAzev7euhYOmCKwRxwl6pOcXzp+EMkpkY4wr
        GSrEwh6z1UNAA+KdbfMFhqmqKg==
X-Google-Smtp-Source: APBJJlHNoMHnR5MVnGyTr9v8LRSO8l0h1aOQEh1iG9yvoXdfPhZzDiwOzx2P01aZQ9KpzP1sFWyq4w==
X-Received: by 2002:a7b:c8c9:0:b0:3fc:80a:9948 with SMTP id f9-20020a7bc8c9000000b003fc080a9948mr3637025wml.19.1688903766204;
        Sun, 09 Jul 2023 04:56:06 -0700 (PDT)
Received: from vermeer.tail79c99.ts.net ([2a01:cb1d:81a9:dd00:b570:b34c:ffd4:c805])
        by smtp.gmail.com with ESMTPSA id 2-20020a05600c02c200b003fc007d8a92sm6194101wmn.45.2023.07.09.04.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jul 2023 04:56:05 -0700 (PDT)
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
Subject: [PATCH v3 3/4] RISC-V: hwprobe: Expose Zbc and the scalar crypto extensions
Date:   Sun,  9 Jul 2023 13:55:45 +0200
Message-ID: <20230709115549.2666557-4-sameo@rivosinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709115549.2666557-1-sameo@rivosinc.com>
References: <20230709115549.2666557-1-sameo@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zbc was missing from a previous Bit-Manipulation extension hwprobe
patch.

Add all scalar crypto extensions bits, and define a macro for setting
the hwprobe key/pair in a more readable way.

Reviewed-by: Evan Green <evan@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Tested-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Signed-off-by: Samuel Ortiz <sameo@rivosinc.com>
---
 Documentation/riscv/hwprobe.rst       | 33 ++++++++++++++++++++++++
 arch/riscv/include/uapi/asm/hwprobe.h | 11 ++++++++
 arch/riscv/kernel/sys_riscv.c         | 36 ++++++++++++++++-----------
 3 files changed, 66 insertions(+), 14 deletions(-)

diff --git a/Documentation/riscv/hwprobe.rst b/Documentation/riscv/hwprobe.rst
index 19165ebd82ba..3177550106e0 100644
--- a/Documentation/riscv/hwprobe.rst
+++ b/Documentation/riscv/hwprobe.rst
@@ -72,11 +72,44 @@ The following keys are defined:
        extensions.
 
   * :c:macro:`RISCV_HWPROBE_EXT_ZBB`: The Zbb extension is supported, as defined
+      in version 1.0 of the Bit-Manipulation ISA extensions.
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZBC`: The Zbc extension is supported, as defined
        in version 1.0 of the Bit-Manipulation ISA extensions.
 
   * :c:macro:`RISCV_HWPROBE_EXT_ZBS`: The Zbs extension is supported, as defined
        in version 1.0 of the Bit-Manipulation ISA extensions.
 
+  * :c:macro:`RISCV_HWPROBE_EXT_ZBKB`: The Zbkb extension is supported, as defined
+    in version 1.0 of the Scalar Cryptography ISA extensions.
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZBKC`: The Zbkc extension is supported, as defined
+    in version 1.0 of the Scalar Cryptography ISA extensions.
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZBKX`: The Zbkx extension is supported, as defined
+    in version 1.0 of the Scalar Cryptography ISA extensions.
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZKND`: The Zknd extension is supported, as defined
+    in version 1.0 of the Scalar Cryptography ISA extensions.
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZKNE`: The Zkne extension is supported, as defined
+    in version 1.0 of the Scalar Cryptography ISA extensions.
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZKNH`: The Zknh extension is supported, as defined
+    in version 1.0 of the Scalar Cryptography ISA extensions.
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZKR`: The Zkr extension is supported, as defined
+    in version 1.0 of the Scalar Cryptography ISA extensions.
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZKSED`: The Zksed extension is supported, as defined
+    in version 1.0 of the Scalar Cryptography ISA extensions.
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZKSH`: The Zksh extension is supported, as defined
+    in version 1.0 of the Scalar Cryptography ISA extensions.
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZKT`: The Zkt extension is supported, as defined
+    in version 1.0 of the Scalar Cryptography ISA extensions.
+
 * :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A bitmask that contains performance
   information about the selected set of processors.
 
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index 006bfb48343d..8357052061b3 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -29,6 +29,17 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZBA		(1 << 3)
 #define		RISCV_HWPROBE_EXT_ZBB		(1 << 4)
 #define		RISCV_HWPROBE_EXT_ZBS		(1 << 5)
+#define		RISCV_HWPROBE_EXT_ZBC		(1 << 6)
+#define		RISCV_HWPROBE_EXT_ZBKB		(1 << 7)
+#define		RISCV_HWPROBE_EXT_ZBKC		(1 << 8)
+#define		RISCV_HWPROBE_EXT_ZBKX		(1 << 9)
+#define		RISCV_HWPROBE_EXT_ZKND		(1 << 10)
+#define		RISCV_HWPROBE_EXT_ZKNE		(1 << 11)
+#define		RISCV_HWPROBE_EXT_ZKNH		(1 << 12)
+#define		RISCV_HWPROBE_EXT_ZKR		(1 << 13)
+#define		RISCV_HWPROBE_EXT_ZKSED		(1 << 14)
+#define		RISCV_HWPROBE_EXT_ZKSH		(1 << 15)
+#define		RISCV_HWPROBE_EXT_ZKT		(1 << 16)
 #define RISCV_HWPROBE_KEY_CPUPERF_0	5
 #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
index 26ef5526bfb4..df15926196b6 100644
--- a/arch/riscv/kernel/sys_riscv.c
+++ b/arch/riscv/kernel/sys_riscv.c
@@ -145,20 +145,28 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 	for_each_cpu(cpu, cpus) {
 		struct riscv_isainfo *isainfo = &hart_isa[cpu];
 
-		if (riscv_isa_extension_available(isainfo->isa, ZBA))
-			pair->value |= RISCV_HWPROBE_EXT_ZBA;
-		else
-			missing |= RISCV_HWPROBE_EXT_ZBA;
-
-		if (riscv_isa_extension_available(isainfo->isa, ZBB))
-			pair->value |= RISCV_HWPROBE_EXT_ZBB;
-		else
-			missing |= RISCV_HWPROBE_EXT_ZBB;
-
-		if (riscv_isa_extension_available(isainfo->isa, ZBS))
-			pair->value |= RISCV_HWPROBE_EXT_ZBS;
-		else
-			missing |= RISCV_HWPROBE_EXT_ZBS;
+#define SET_HWPROBE_EXT_PAIR(ext)					\
+		do {							\
+			if (riscv_isa_extension_available(isainfo->isa, ext)) \
+				pair->value |= RISCV_HWPROBE_EXT_## ext; \
+			else						\
+				missing |= RISCV_HWPROBE_EXT_## ext;	\
+		} while (false)						\
+
+		SET_HWPROBE_EXT_PAIR(ZBA);
+		SET_HWPROBE_EXT_PAIR(ZBB);
+		SET_HWPROBE_EXT_PAIR(ZBC);
+		SET_HWPROBE_EXT_PAIR(ZBS);
+		SET_HWPROBE_EXT_PAIR(ZBKB);
+		SET_HWPROBE_EXT_PAIR(ZBKC);
+		SET_HWPROBE_EXT_PAIR(ZBKX);
+		SET_HWPROBE_EXT_PAIR(ZKND);
+		SET_HWPROBE_EXT_PAIR(ZKNE);
+		SET_HWPROBE_EXT_PAIR(ZKNH);
+		SET_HWPROBE_EXT_PAIR(ZKR);
+		SET_HWPROBE_EXT_PAIR(ZKSED);
+		SET_HWPROBE_EXT_PAIR(ZKSH);
+		SET_HWPROBE_EXT_PAIR(ZKT);
 	}
 
 	/* Now turn off reporting features if any CPU is missing it. */
-- 
2.41.0

