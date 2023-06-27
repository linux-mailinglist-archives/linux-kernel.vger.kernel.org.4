Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67B873FE6F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 16:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbjF0Ojf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 10:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjF0Oi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 10:38:59 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85B935A6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 07:38:28 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f9bdb01ec0so55289025e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 07:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687876704; x=1690468704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHx3gYl8Iw0W58X86iiLjYiqWHDrUKQgdW58J9hMNFo=;
        b=FTtFb9NUP/FASOPS8uXn1Ce/tmrUwlVuNX2PR/86vGMwUod6PgNIRCWP1uks54i4F9
         Pds5XWsywwWck3JhyC7zwYuKbYWBMfHYS7NhW/0MxwH43Z0rMp3SZBfMINhwqXsRt4L6
         BWZmF2mpKAqelz1kMm0/Yj8eR4jfqKpL8uwKGeoRP5lR2L5B5PGvVb2gjqs/RMdgaK/d
         /sT1/2lEtasaKEJFEFOhWdgkU8Rp/mrpkfYXUUqBEPQ5cMOyet5zVpa5fnfkbIEnEycp
         lZCJkbMpt+mAYj8wvVyGSxpqwxMFwfWu5ihjRrR/qR8Jvq0F/W9OCbTmCKmjyg8oAnRg
         rkzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687876704; x=1690468704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WHx3gYl8Iw0W58X86iiLjYiqWHDrUKQgdW58J9hMNFo=;
        b=d88kbnNHnGXTPvETc8YNlImYXJ/F/ZrP0I3ZyFZw8bguGzQ2kzrhSDPZ1aBxjfX/Mx
         DB59GqSNwMe+O/uxljS7wZ2c/A5zQhrTddcbJLT+sPIEn9fnMdNPv5pi8yWf6ThJ9t7w
         Ib6fwf459glSE4vXnQs2DxUwYDIVhymIgorX+jZP/KtrgQJCJur1sbQvcuODDmAoS+F+
         gTuOz9mmly5009YjgMwQcVhFjKzFwmD13Mst3IEmS+vHfgQUyTJpN0FLUJJ9mWpwab6+
         WUgUhsK/6IfWlotBVABzw0C9wr4vuOzfDnJLQb5e8vDa3U5ZwbQ68oguYkFmWzLIa+b/
         YNfw==
X-Gm-Message-State: AC+VfDwVKnINtjyP5loxU0vTlLVddC3vWm4LPST1PZJL75pqtvL5ag8I
        5Llui7pXL+me996wQ3dFucahNA==
X-Google-Smtp-Source: ACHHUZ4nqjMHBfhSsc2aV/a4aCgpIz8HXNz9mgF/6ym4aPv0kI9lcEjphKs7zOHhm0vLztzwNlDDTA==
X-Received: by 2002:a7b:cd1a:0:b0:3fb:7184:53eb with SMTP id f26-20020a7bcd1a000000b003fb718453ebmr2396351wmj.18.1687876704481;
        Tue, 27 Jun 2023 07:38:24 -0700 (PDT)
Received: from vermeer.tail79c99.ts.net ([2a01:cb1d:81a9:dd00:b570:b34c:ffd4:c805])
        by smtp.gmail.com with ESMTPSA id c21-20020a7bc855000000b003f8fac0ad4bsm10894793wml.17.2023.06.27.07.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 07:38:24 -0700 (PDT)
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
        Evan Green <evan@rivosinc.com>
Subject: [PATCH 2/3] RISC-V: hwprobe: Expose Zbc and the scalar crypto extensions
Date:   Tue, 27 Jun 2023 16:37:43 +0200
Message-ID: <20230627143747.1599218-3-sameo@rivosinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230627143747.1599218-1-sameo@rivosinc.com>
References: <20230627143747.1599218-1-sameo@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zbc was missing from a previous Bit-Manipulation extension hwprobe
patch.

Add all scalar crypto extensions bits, and define a macro for setting
the hwprobe key/pair in a more readable way.

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

