Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3695B697E87
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 15:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjBOOjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 09:39:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjBOOje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 09:39:34 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2793224495
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 06:39:33 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id f18-20020a7bcd12000000b003e206711347so740767wmj.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 06:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yD/6wakyPf7JrmKHeHtinmHp6mBb9XsJjFS0GkJ6tz4=;
        b=BoSoAYbYFg8HdU2SNacDnaS+5CeQ0e207z74mrcLON9XyOg4vOWlNvHSHENHSz6AHS
         TXXPV6YKRrjTygMWgAH5NAsMBs8jkRVcXI6LfigB0xE0u5MZLmp8EkO8SHcrxWNVbu62
         dEn0JC0XCdThk6U+d9TbDA3VVwA2VC8IF6aM3dZElzHEGco7QFsuWyZ8ThCN/o0HWANB
         GpxRp3dCWcclSGpQlFOFRJ+0J1C17mGXIcCg06XWlyBsAgbWwbBTPlVe7R4fVdvNvWKd
         MPEmsaEiQRIQsIAsvMV3MeR3AIj3b88dHNxbEMFeSa1zGoYf4RYZYNcrFcougFJQPhtd
         atYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yD/6wakyPf7JrmKHeHtinmHp6mBb9XsJjFS0GkJ6tz4=;
        b=CGGueU0ToIkGA8d4THuM4+M6J7GnladCRG++sjwHVaei/cV96Wn/NCGkPfqa0QwgHb
         TPsbCFgaVuWcuE5D08tIU4zKkd4UsIpnYBRtUVgHJ6jSsoF4fKg76dTdiOLCBBbqGQ8V
         MvUlm3D8kHwnkZ3/BzzpuDGku/YW6adXeTHBQUvP5OGWwDj4+/GHxIxVt96dLbBnfyQo
         f43pQ5yA6ZTItSZ1Ous5EvrAtdU5+pSat6bThmtbmgu6zxIEvqnBjFGqxhPZEjLGSqn3
         nvqq782SkTmtKWM21fIuKCwSTgIUADSBQpubLK8mwCEqMcoQH3TXaHB7sRNT9GeRREBO
         bmLg==
X-Gm-Message-State: AO0yUKX6ZdTwxZEX95vDJEzJMD5Ilh1U8C9XyW0XbfVIGCasY9O02d+B
        86lHv3yaaRBj4IKKmRIWtX3gjfCintvChyUm
X-Google-Smtp-Source: AK7set8Tp8vvWaWc0e+MxOiR5cvSLBCg2Fe806RP1RqrzlGlekyMApRlk8+hhjLVM/Hil8sEckbm+Q==
X-Received: by 2002:a05:600c:2e89:b0:3e0:6c4:6a38 with SMTP id p9-20020a05600c2e8900b003e006c46a38mr2284134wmn.33.1676471971627;
        Wed, 15 Feb 2023 06:39:31 -0800 (PST)
Received: from alex-rivos.home (lfbn-lyo-1-450-160.w2-7.abo.wanadoo.fr. [2.7.42.160])
        by smtp.gmail.com with ESMTPSA id h8-20020a1ccc08000000b003e1202744f2sm2423115wmb.31.2023.02.15.06.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 06:39:31 -0800 (PST)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>
Subject: [PATCH v8 3/3] riscv: Check relocations at compile time
Date:   Wed, 15 Feb 2023 15:36:26 +0100
Message-Id: <20230215143626.453491-4-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230215143626.453491-1-alexghiti@rivosinc.com>
References: <20230215143626.453491-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Ghiti <alex@ghiti.fr>

Relocating kernel at runtime is done very early in the boot process, so
it is not convenient to check for relocations there and react in case a
relocation was not expected.

There exists a script in scripts/ that extracts the relocations from
vmlinux that is then used at postlink to check the relocations.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
Reviewed-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/Makefile.postlink     | 36 ++++++++++++++++++++++++++++++++
 arch/riscv/tools/relocs_check.sh | 26 +++++++++++++++++++++++
 2 files changed, 62 insertions(+)
 create mode 100644 arch/riscv/Makefile.postlink
 create mode 100755 arch/riscv/tools/relocs_check.sh

diff --git a/arch/riscv/Makefile.postlink b/arch/riscv/Makefile.postlink
new file mode 100644
index 000000000000..bf2b2bca1845
--- /dev/null
+++ b/arch/riscv/Makefile.postlink
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: GPL-2.0
+# ===========================================================================
+# Post-link riscv pass
+# ===========================================================================
+#
+# Check that vmlinux relocations look sane
+
+PHONY := __archpost
+__archpost:
+
+-include include/config/auto.conf
+include scripts/Kbuild.include
+
+quiet_cmd_relocs_check = CHKREL  $@
+cmd_relocs_check = 							\
+	$(CONFIG_SHELL) $(srctree)/arch/riscv/tools/relocs_check.sh "$(OBJDUMP)" "$(NM)" "$@"
+
+# `@true` prevents complaint when there is nothing to be done
+
+vmlinux: FORCE
+	@true
+ifdef CONFIG_RELOCATABLE
+	$(call if_changed,relocs_check)
+endif
+
+%.ko: FORCE
+	@true
+
+clean:
+	@true
+
+PHONY += FORCE clean
+
+FORCE:
+
+.PHONY: $(PHONY)
diff --git a/arch/riscv/tools/relocs_check.sh b/arch/riscv/tools/relocs_check.sh
new file mode 100755
index 000000000000..baeb2e7b2290
--- /dev/null
+++ b/arch/riscv/tools/relocs_check.sh
@@ -0,0 +1,26 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Based on powerpc relocs_check.sh
+
+# This script checks the relocations of a vmlinux for "suspicious"
+# relocations.
+
+if [ $# -lt 3 ]; then
+        echo "$0 [path to objdump] [path to nm] [path to vmlinux]" 1>&2
+        exit 1
+fi
+
+bad_relocs=$(
+${srctree}/scripts/relocs_check.sh "$@" |
+	# These relocations are okay
+	#	R_RISCV_RELATIVE
+	grep -F -w -v 'R_RISCV_RELATIVE'
+)
+
+if [ -z "$bad_relocs" ]; then
+	exit 0
+fi
+
+num_bad=$(echo "$bad_relocs" | wc -l)
+echo "WARNING: $num_bad bad relocations"
+echo "$bad_relocs"
-- 
2.37.2

