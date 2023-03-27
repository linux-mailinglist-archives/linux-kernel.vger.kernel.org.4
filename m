Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5073A6CAAA1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 18:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbjC0Qcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 12:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbjC0Qc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:32:26 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BDE2701
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 09:32:25 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id ix20so8971708plb.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 09:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1679934745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DS7/SOsXai4Z1GKznU9FqGZtfi0arBEE5QT+dGbkbBE=;
        b=3lMM3H8U18ZqUbaeF2VJRt0lHe7jyqdRt37VFG5QO2VrYaw8TBsbbgAiIX12YxDlxl
         REAoc3qfyltvjObTtNm8Zzd5zMmT65U9utSxdOO6yJWzGvjnD2IKq9WtNkDq4I3TkSEb
         lg2XTMMR6QYYh85ZN2xD9Q1WyTQ1nNvDwNiE00WrFI25lDU8xOw0l6MKR9PW8OqemJKa
         JuOAqmnvJIa6aMNFJnZ29YIfezY3Tx3BW1NAsy/kyYdwqAHqNPvrt+YSW6WdplM2YxJS
         NYmZUwF9OFQ4cX41uS9kM/3qo8UfPoWDNw+XLURqvvvLZGZU/O/k7E70urDAOCXa74am
         ajGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679934745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DS7/SOsXai4Z1GKznU9FqGZtfi0arBEE5QT+dGbkbBE=;
        b=eXPMhOfIHX8vV/u3rZbjWZOgVyc1pU077Ip1jINYBRZKVoO9L8fQGJKPQ8qH8nrDa2
         w8iNpJKzygOKN61vKlaS9K2u9P2KrTD6PKc1ZpIxmxyTioennWxfLUqUqAaz8WWR4Tik
         QyEigYRFx6n43x06n73aOzWPFbJaimTAWIZ9LeIZB6gB0YurgmAIfd4CPxaieYp8M+hP
         pYHoq8WlMz0c0SK9EnIlwFrb3jWMpPDNNSvNN6WrzViaGLCEAwp7Z+RNrBT347j8SUip
         J14eYBq4AOpLxpmvH60zUbUf/EpaW5nDQpTRa9APDNkJw9oHIFGnVJvgXrgWup0Qm+Ll
         Kj2g==
X-Gm-Message-State: AAQBX9c0lr42qoztDN+0NqcrIeP8rzxnXVQD8oDhCfCE1Xd6es72YbQa
        VXViB5WxG+KcEUh/8gcBQejYSg==
X-Google-Smtp-Source: AKy350Z6lmWh84+PK+zp0auYZJ6hFzt64IzvMQMXjMMnQ1plLYt7qTpC7cqYDdnYX4Y4tnRTo4K85A==
X-Received: by 2002:a17:903:94:b0:1a1:b506:6fe with SMTP id o20-20020a170903009400b001a1b50606femr9617322pld.29.1679934745233;
        Mon, 27 Mar 2023 09:32:25 -0700 (PDT)
Received: from evan.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id io20-20020a17090312d400b001a1faeac240sm8963524plb.186.2023.03.27.09.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 09:32:24 -0700 (PDT)
From:   Evan Green <evan@rivosinc.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     slewis@rivosinc.com, vineetg@rivosinc.com, heiko@sntech.de,
        Conor Dooley <conor@kernel.org>,
        Evan Green <evan@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        Guo Ren <guoren@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v5 3/6] RISC-V: hwprobe: Add support for RISCV_HWPROBE_BASE_BEHAVIOR_IMA
Date:   Mon, 27 Mar 2023 09:32:00 -0700
Message-Id: <20230327163203.2918455-4-evan@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230327163203.2918455-1-evan@rivosinc.com>
References: <20230327163203.2918455-1-evan@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have an implicit set of base behaviors that userspace depends on,
which are mostly defined in various ISA specifications.

Co-developed-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Evan Green <evan@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Tested-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
---

Changes in v5:
 - Fixed misuse of ISA_EXT_c as bitmap, changed to use
   riscv_isa_extension_available() (Heiko, Conor)

Changes in v4:
 - More newlines in BASE_BEHAVIOR_IMA documentation (Conor)

Changes in v3:
 - Refactored base ISA behavior probe to allow kernel probing as well,
   in prep for vDSO data initialization.
 - Fixed doc warnings in IMA text list, use :c:macro:.

 Documentation/riscv/hwprobe.rst       | 24 ++++++++++++++++++++++++
 arch/riscv/include/asm/hwprobe.h      |  2 +-
 arch/riscv/include/uapi/asm/hwprobe.h |  5 +++++
 arch/riscv/kernel/sys_riscv.c         | 20 ++++++++++++++++++++
 4 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/Documentation/riscv/hwprobe.rst b/Documentation/riscv/hwprobe.rst
index 211828f706e3..945d44683c40 100644
--- a/Documentation/riscv/hwprobe.rst
+++ b/Documentation/riscv/hwprobe.rst
@@ -39,3 +39,27 @@ The following keys are defined:
 
 * :c:macro:`RISCV_HWPROBE_KEY_MIMPLID`: Contains the value of ``mimplid``, as
   defined by the RISC-V privileged architecture specification.
+
+* :c:macro:`RISCV_HWPROBE_KEY_BASE_BEHAVIOR`: A bitmask containing the base
+  user-visible behavior that this kernel supports.  The following base user ABIs
+  are defined:
+
+  * :c:macro:`RISCV_HWPROBE_BASE_BEHAVIOR_IMA`: Support for rv32ima or
+    rv64ima, as defined by version 2.2 of the user ISA and version 1.10 of the
+    privileged ISA, with the following known exceptions (more exceptions may be
+    added, but only if it can be demonstrated that the user ABI is not broken):
+
+    * The :fence.i: instruction cannot be directly executed by userspace
+      programs (it may still be executed in userspace via a
+      kernel-controlled mechanism such as the vDSO).
+
+* :c:macro:`RISCV_HWPROBE_KEY_IMA_EXT_0`: A bitmask containing the extensions
+  that are compatible with the :c:macro:`RISCV_HWPROBE_BASE_BEHAVIOR_IMA`:
+  base system behavior.
+
+  * :c:macro:`RISCV_HWPROBE_IMA_FD`: The F and D extensions are supported, as
+    defined by commit cd20cee ("FMIN/FMAX now implement
+    minimumNumber/maximumNumber, not minNum/maxNum") of the RISC-V ISA manual.
+
+  * :c:macro:`RISCV_HWPROBE_IMA_C`: The C extension is supported, as defined
+    by version 2.2 of the RISC-V ISA manual.
diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hwprobe.h
index 08d1c3bdd78a..7e52f1e1fe10 100644
--- a/arch/riscv/include/asm/hwprobe.h
+++ b/arch/riscv/include/asm/hwprobe.h
@@ -8,6 +8,6 @@
 
 #include <uapi/asm/hwprobe.h>
 
-#define RISCV_HWPROBE_MAX_KEY 2
+#define RISCV_HWPROBE_MAX_KEY 4
 
 #endif
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index 591802047460..fc5665411782 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -20,6 +20,11 @@ struct riscv_hwprobe {
 #define RISCV_HWPROBE_KEY_MVENDORID	0
 #define RISCV_HWPROBE_KEY_MARCHID	1
 #define RISCV_HWPROBE_KEY_MIMPID	2
+#define RISCV_HWPROBE_KEY_BASE_BEHAVIOR	3
+#define		RISCV_HWPROBE_BASE_BEHAVIOR_IMA	(1 << 0)
+#define RISCV_HWPROBE_KEY_IMA_EXT_0	4
+#define		RISCV_HWPROBE_IMA_FD		(1 << 0)
+#define		RISCV_HWPROBE_IMA_C		(1 << 1)
 /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
 
 #endif
diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
index 981d23457f13..c83218a0db02 100644
--- a/arch/riscv/kernel/sys_riscv.c
+++ b/arch/riscv/kernel/sys_riscv.c
@@ -9,6 +9,7 @@
 #include <asm/cacheflush.h>
 #include <asm/hwprobe.h>
 #include <asm/sbi.h>
+#include <asm/switch_to.h>
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
 #include <asm-generic/mman-common.h>
@@ -125,6 +126,25 @@ static void hwprobe_one_pair(struct riscv_hwprobe *pair,
 	case RISCV_HWPROBE_KEY_MIMPID:
 		hwprobe_arch_id(pair, cpus);
 		break;
+	/*
+	 * The kernel already assumes that the base single-letter ISA
+	 * extensions are supported on all harts, and only supports the
+	 * IMA base, so just cheat a bit here and tell that to
+	 * userspace.
+	 */
+	case RISCV_HWPROBE_KEY_BASE_BEHAVIOR:
+		pair->value = RISCV_HWPROBE_BASE_BEHAVIOR_IMA;
+		break;
+
+	case RISCV_HWPROBE_KEY_IMA_EXT_0:
+		pair->value = 0;
+		if (has_fpu())
+			pair->value |= RISCV_HWPROBE_IMA_FD;
+
+		if (riscv_isa_extension_available(NULL, c))
+			pair->value |= RISCV_HWPROBE_IMA_C;
+
+		break;
 
 	/*
 	 * For forward compatibility, unknown keys don't fail the whole
-- 
2.25.1

