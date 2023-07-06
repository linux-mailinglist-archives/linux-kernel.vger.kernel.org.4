Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C8A749442
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 05:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbjGFDcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 23:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjGFDco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 23:32:44 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635071BCB
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 20:32:43 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-668711086f4so157472b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 20:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688614362; x=1691206362;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1tlqEDwtRwx6uylosFQCtOuy8lBa96SgAwEz93e0NjI=;
        b=dgvUiTH0tF+IXJGUSbU/qOy8YrB08kHgQ8/arUCFTyddQbneanC9tezL8lXIpoOByK
         g4/tb/g6cLn8nAqGWrq699W04LhdinFbnL00Oi0d0C7PnQWyyThCRxydAeh0ujC94vdJ
         qVxv39E/siIKroL1TPStJTyP6bnLrwui9rdstp7Eik75uddLnX5ozwjWUSVnhoAv6sRB
         mU/SBpAJz005Ec7YqsWPrJh1dmlIgHWUKj8dBGrYGZEdWb6AjCcxfrmaihF00HVpZUMK
         ltoeoi84WmR6i5+ls9KsvIduAfSHUHBhS4f8ktnIJECF7lvQp7ZIITS+IoBFm2Yn+XfI
         aCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688614363; x=1691206363;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1tlqEDwtRwx6uylosFQCtOuy8lBa96SgAwEz93e0NjI=;
        b=M3/9IEAizMXVc4GjbaPZYiQIH6G+K5r8ZMiPgdP6/8Xmr1p8JzdiGm088oY8VQTw+0
         +gGLqg4YiVSgZ8wbljD9+/held3nTYVuuDeU7Z8tIxWlDQyl0FUk8r+dW7lybFAKw8Z7
         THX0LdC2EvCLLpeoH6cEY1K6L7SCMY3mHIqzbB8WeoK26hClgYrEiJ9hL7PfYAW0kWsa
         m7Ii2pDxQ1FMdnKXQnqTxbqlFAXRkX2r1s0I7tXrvwzbfSYnpTfpGqfNgyN66abnOE4q
         ZUdPz/jNg/ivGWAxaIT9NAafSWYD2D6/SxG0ADdqPcleDzyVncjaRnY8RfHlrcR4QPwT
         pSxw==
X-Gm-Message-State: ABy/qLalXtOF95QiHA9nehjsnJsUcOCObOTx3QbJHCPNBb90Vfn5wl8h
        Cihpy8Cex4SDEX0cMI/8+tG+d1i4Qwl8quvPu3k=
X-Google-Smtp-Source: APBJJlHRoO3OOf/Yu8KIk2dz7/z/aRnJLFW/TkOd0McK/ZFZgWFWJTIVEe3mL+IgCv3DGUL326qHIA==
X-Received: by 2002:a05:6a00:3a0a:b0:678:7744:31fd with SMTP id fj10-20020a056a003a0a00b00678774431fdmr6980140pfb.0.1688614362670;
        Wed, 05 Jul 2023 20:32:42 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id fk13-20020a056a003a8d00b006589cf6d88bsm239785pfb.145.2023.07.05.20.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 20:32:42 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Wed, 05 Jul 2023 20:30:17 -0700
Subject: [PATCH 1/3] RISC-V: Framework for vendor extensions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230705-thead_vendor_extensions-v1-1-ad6915349c4d@rivosinc.com>
References: <20230705-thead_vendor_extensions-v1-0-ad6915349c4d@rivosinc.com>
In-Reply-To: <20230705-thead_vendor_extensions-v1-0-ad6915349c4d@rivosinc.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>, charlie@rivosinc.com,
        evan@rivosinc.com, heiko@sntech.de, linux-doc@vger.kernel.org
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create Kconfig files, Makefiles, and functions to enable vendors to
provide information via the riscv_hwprobe syscall about which vendor
extensions are available.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/Kbuild                     |  1 +
 arch/riscv/Kconfig                    |  1 +
 arch/riscv/Kconfig.vendor             |  3 +++
 arch/riscv/include/asm/hwprobe.h      |  1 +
 arch/riscv/kernel/sys_riscv.c         | 40 ++++++++++++++++++++++++++++++++---
 arch/riscv/vendor_extensions/Makefile |  3 +++
 6 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/Kbuild b/arch/riscv/Kbuild
index afa83e307a2e..bea38010d9db 100644
--- a/arch/riscv/Kbuild
+++ b/arch/riscv/Kbuild
@@ -3,6 +3,7 @@
 obj-y += kernel/ mm/ net/
 obj-$(CONFIG_BUILTIN_DTB) += boot/dts/
 obj-y += errata/
+obj-y += vendor_extensions/
 obj-$(CONFIG_KVM) += kvm/
 
 obj-$(CONFIG_ARCH_HAS_KEXEC_PURGATORY) += purgatory/
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index c1505c7729ec..19404ede0ee3 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -276,6 +276,7 @@ config AS_HAS_OPTION_ARCH
 
 source "arch/riscv/Kconfig.socs"
 source "arch/riscv/Kconfig.errata"
+source "arch/riscv/Kconfig.vendor"
 
 menu "Platform type"
 
diff --git a/arch/riscv/Kconfig.vendor b/arch/riscv/Kconfig.vendor
new file mode 100644
index 000000000000..213ac3e6fed5
--- /dev/null
+++ b/arch/riscv/Kconfig.vendor
@@ -0,0 +1,3 @@
+menu "Vendor extensions selection"
+
+endmenu # "Vendor extensions selection"
diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hwprobe.h
index 78936f4ff513..fadb38b83243 100644
--- a/arch/riscv/include/asm/hwprobe.h
+++ b/arch/riscv/include/asm/hwprobe.h
@@ -9,5 +9,6 @@
 #include <uapi/asm/hwprobe.h>
 
 #define RISCV_HWPROBE_MAX_KEY 5
+#define RISCV_HWPROBE_VENDOR_EXTENSION_SPACE (UL(1)<<63)
 
 #endif
diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
index 26ef5526bfb4..2351a5f7b8b1 100644
--- a/arch/riscv/kernel/sys_riscv.c
+++ b/arch/riscv/kernel/sys_riscv.c
@@ -188,9 +188,35 @@ static u64 hwprobe_misaligned(const struct cpumask *cpus)
 	return perf;
 }
 
+static int hwprobe_vendor(__u64 mvendorid, struct riscv_hwprobe *pair,
+			 const struct cpumask *cpus)
+{
+	switch (mvendorid) {
+	default:
+		return -1;
+	}
+
+	return 0;
+}
+
 static void hwprobe_one_pair(struct riscv_hwprobe *pair,
 			     const struct cpumask *cpus)
 {
+	int err;
+
+	if (((unsigned long) pair->key) >= RISCV_HWPROBE_VENDOR_EXTENSION_SPACE) {
+		struct riscv_hwprobe mvendorid = {
+			.key = RISCV_HWPROBE_KEY_MVENDORID,
+			.value = 0
+		};
+
+		hwprobe_arch_id(&mvendorid, cpus);
+		if (mvendorid.value != -1ULL)
+			err = hwprobe_vendor(mvendorid.value, pair, cpus);
+		else
+			err = -1;
+	}
+
 	switch (pair->key) {
 	case RISCV_HWPROBE_KEY_MVENDORID:
 	case RISCV_HWPROBE_KEY_MARCHID:
@@ -217,13 +243,21 @@ static void hwprobe_one_pair(struct riscv_hwprobe *pair,
 
 	/*
 	 * For forward compatibility, unknown keys don't fail the whole
-	 * call, but get their element key set to -1 and value set to 0
-	 * indicating they're unrecognized.
+	 * call, instead an error is raised to indicate the element key
+	 * is unrecognized.
 	 */
 	default:
+		err = -1;
+		break;
+	}
+
+	/*
+	 * Setting the element key to -1 and value to 0 indicates that
+	 * hwprobe was unable to find the requested key.
+	 */
+	if (err != 0) {
 		pair->key = -1;
 		pair->value = 0;
-		break;
 	}
 }
 
diff --git a/arch/riscv/vendor_extensions/Makefile b/arch/riscv/vendor_extensions/Makefile
new file mode 100644
index 000000000000..e815895e9372
--- /dev/null
+++ b/arch/riscv/vendor_extensions/Makefile
@@ -0,0 +1,3 @@
+ifdef CONFIG_RELOCATABLE
+KBUILD_CFLAGS += -fno-pie
+endif

-- 
2.41.0

