Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7238C74120D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 15:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjF1NPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 09:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjF1NPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 09:15:07 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446D81705
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 06:15:06 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fb10fd9ae9so32150695e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 06:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687958105; x=1690550105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5WQhI98ezKCFPxc8g2DPgXVepDNDhyJRf7FBEyv5Qs=;
        b=V6/t/L7Qg8TbNvDbaSKMi5CBE0vgOMmNaF8Gh7gEc7wPTWsByhJ2fGmWxJuTe6Tf96
         yi+22POylm9GD1ftzzzZotnOy29DAMtbSUnUAdF0k4USA2XG/Y5Eh3A6ns76ENSbIEcS
         MrCPkwY1jqumU9Vnxmb74/1Mhdzx0MUPsxvex5mUgPQ5FDGvs+MgrK4Cu243ZfHOmGwS
         +2+9yf4VG6Ol+tql27xVpaNLGeMCdYv9J+X+zRPRMaP3AAMFCWAleaGYs0Vvz0JGH346
         SPyryuttUColNeElp4vLd79Wz/qxp+IR58eEFW3Oy6r3CQjlZOzSOrV3k4Jpue+guTZn
         OQHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687958105; x=1690550105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y5WQhI98ezKCFPxc8g2DPgXVepDNDhyJRf7FBEyv5Qs=;
        b=Na7ubvCM3GG5zD/D8DSN2kxQgrqqwCAmzsxIIgP/UAbHL7YEbcfAQlgX+DAEfsHS+A
         Zo0Ph1Xz3f3WBPcWi8eSFbRZDpXfL9GG4reQSGW/RWwecMlbh4n/Lbpvjjks5n5cGjPl
         TilGLXx8S/WzrEzKpwBfSPmJ4j10Yp6bWkC6kEaWc6y4HHOeLXU2jeunWxSCztuUm9QU
         LDDrrxt7HTKw/o7uWG+0/uc7NsY8Pmok6opJHoj1Dp3JEbDJCjNHuMjcDU35DC790V59
         85LbwiWcRhd/i9HtNOs+gx3ym+awD49FPcI4LGzTVQFhmHIpO+lrhhla6BxuntuNsHBV
         nLQA==
X-Gm-Message-State: AC+VfDyzC4x5Z/bT0xBXMtfAEHNfGQslDOw2ou3JTUAZXSC76xVAUzoH
        Pe+aJI83flGSgMPyDLjdXHp2Dw==
X-Google-Smtp-Source: ACHHUZ72UjUk9K2xY2Tl5qDmcGGA0pdpq6ru9xVr2kzaKo2tPx+JOxM1eGTeAG3Vp8boNA+zJziJfg==
X-Received: by 2002:a5d:514c:0:b0:311:3fdc:109d with SMTP id u12-20020a5d514c000000b003113fdc109dmr20913067wrt.1.1687958104584;
        Wed, 28 Jun 2023 06:15:04 -0700 (PDT)
Received: from vermeer.tail79c99.ts.net ([2a01:cb1d:81a9:dd00:b570:b34c:ffd4:c805])
        by smtp.gmail.com with ESMTPSA id a11-20020a056000050b00b003110dc7f408sm13456946wrf.41.2023.06.28.06.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 06:15:04 -0700 (PDT)
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
Subject: [PATCH v2 2/3] RISC-V: hwprobe: Expose Zbc and the scalar crypto extensions
Date:   Wed, 28 Jun 2023 15:14:34 +0200
Message-ID: <20230628131442.3022772-3-sameo@rivosinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628131442.3022772-1-sameo@rivosinc.com>
References: <20230628131442.3022772-1-sameo@rivosinc.com>
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

Reviewed-by: Evan Green <evan@rivosinc.com>
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

