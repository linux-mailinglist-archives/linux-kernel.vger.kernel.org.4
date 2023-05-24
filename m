Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63AC70F2B6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 11:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240663AbjEXJZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 05:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236395AbjEXJZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 05:25:56 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3ACA1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 02:25:51 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64d2f99c8c3so495900b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 02:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1684920351; x=1687512351;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RvHr5LmWlOAwH72dKmpy22b0i7NyoTobA4QHfY56YqY=;
        b=ciC8y7QAPHbykBqQcM730+HPORFRKmlNjUKYf9ifW40ENmc67orcf+Yp9oZihPOc8X
         BcMXx+0qOVQxl4OmO7rSqvWyUf4beB3vtMxAirZ4T6DpPfGF/aW2T1nJEKuXkHHGU2oQ
         w5UsCgQfPco1m516CCV6Us7B+x4c44gpw3XQf48rOAwTyVPnN8KYn5Qwi2/pj9/ShqhO
         K8vhDvFSBOdIbeO8jNHOILoijJ6zBZzr9ZHMf9DnajaAjd7LklYtg+ITNOORHr4HUEQv
         9LV8IYcBMSo10gyEBdLrrT0EfH7m7TGVZyJK/VqOQxGJdduKLTI/jEno0p93gQvDJaOD
         gDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684920351; x=1687512351;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RvHr5LmWlOAwH72dKmpy22b0i7NyoTobA4QHfY56YqY=;
        b=di5ooxcVdpU+haU13gfj4ggw5R+H1DmvCM20Es0+y/G5vVEEbDROrGeT89y51pYGkY
         sh3/vImwrV5DRoN6wm3Z6Oxas2X6tV83kwQkWNA4RMrOaoISUZ58gBsrt6ZSN2JzU9Tc
         FtBjkCXkZ512hU4AfQ2qxdwzVOmAtR48O3KEmkZcYAXcz3UwE+pLScaQDwZn4fmZixwW
         cdfnddlOq9+3CNFaBTL/hjlhkgOLw4hhwZkbM0SsiHLhkeagAFW+q5tpChxQuJSBqW35
         6DDY/QFeWKMnSRrB5z79DLb4MPNTyo5GcwJrn8zGhkZlEFFXnvMGJgwV/+ByUZCM+rGe
         nNtA==
X-Gm-Message-State: AC+VfDyxFXBq+4zFl4DWY7f3wfU0l5Nvy/3mqRU+4ZX4SkgTSingvLoV
        V8MzXDg0iyFibhi185Iq+CLEhAiFBZvpkAid9LMnDQ==
X-Google-Smtp-Source: ACHHUZ4yigSzUbkNGJIFZ403kPHhDrOx8fj3JMeflq0CzrSnTyB/03UP4L2tSWv7WQHKQIa/QKD22A==
X-Received: by 2002:a05:6a21:99a6:b0:10b:f980:18d3 with SMTP id ve38-20020a056a2199a600b0010bf98018d3mr9336670pzb.1.1684920351146;
        Wed, 24 May 2023 02:25:51 -0700 (PDT)
Received: from hsinchu25.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id t14-20020a17090b018e00b002532eef4fc5sm925013pjs.34.2023.05.24.02.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 02:25:50 -0700 (PDT)
From:   Andy Chiu <andy.chiu@sifive.com>
To:     palmer@dabbelt.com
Cc:     andy.chiu@sifive.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, remi@remlab.net
Subject: Re: [PATCH -next v20 20/26] riscv: Add prctl controls for userspace vector management
Date:   Wed, 24 May 2023 09:25:30 +0000
Message-Id: <20230524092530.7773-1-andy.chiu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <mhng-52f8af07-f3fc-4674-94ea-abbe2108907a@palmer-ri-x1c9a>
References: <mhng-52f8af07-f3fc-4674-94ea-abbe2108907a@palmer-ri-x1c9a>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

How about adding the following 2 patches to deal with the problem.
However, I am concerned if this makes ELF_HWCAP too complicated. e.g.
Future extensions may as well want to do something here after we create
an entry here.

Thanks,
Andy

[-- Attachment #1: patch.diff --]
From: Andy Chiu <andy.chiu@sifive.com>
Date: Wed, 24 May 2023 08:00:11 +0000
Subject: [PATCH 1/2] riscv: hwcap: change ELF_HWCAP to a function

Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
---
 arch/riscv/include/asm/elf.h   | 2 +-
 arch/riscv/include/asm/hwcap.h | 2 ++
 arch/riscv/kernel/cpufeature.c | 5 +++++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
index ca23c4f6c440..c24280774caf 100644
--- a/arch/riscv/include/asm/elf.h
+++ b/arch/riscv/include/asm/elf.h
@@ -66,7 +66,7 @@ extern bool compat_elf_check_arch(Elf32_Ehdr *hdr);
  * via a bitmap that coorespends to each single-letter ISA extension.  This is
  * essentially defunct, but will remain for compatibility with userspace.
  */
-#define ELF_HWCAP	(elf_hwcap & ((1UL << RISCV_ISA_EXT_BASE) - 1))
+#define ELF_HWCAP	riscv_get_elf_hwcap()
 extern unsigned long elf_hwcap;
 
 /*
diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 574385930ba7..e6c288ac4581 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -61,6 +61,8 @@
 
 #include <linux/jump_label.h>
 
+unsigned long riscv_get_elf_hwcap(void);
+
 struct riscv_isa_ext_data {
 	/* Name of the extension displayed to userspace via /proc/cpuinfo */
 	char uprop[RISCV_ISA_EXT_NAME_LEN_MAX];
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 28032b083463..29c0680652a0 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -293,6 +293,11 @@ void __init riscv_fill_hwcap(void)
 	pr_info("riscv: ELF capabilities %s\n", print_str);
 }
 
+unsigned long riscv_get_elf_hwcap(void)
+{
+	return (elf_hwcap & ((1UL << RISCV_ISA_EXT_BASE) - 1));
+}
+
 #ifdef CONFIG_RISCV_ALTERNATIVE
 /*
  * Alternative patch sites consider 48 bits when determining when to patch
-- 
2.17.1

[-- Attachment #2: patch2.diff --]
From: Andy Chiu <andy.chiu@sifive.com>
Date: Wed, 24 May 2023 08:00:11 +0000
Subject: [PATCH 1/2] riscv: hwcap: change ELF_HWCAP to a function

Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
---
 arch/riscv/include/asm/elf.h   | 2 +-
 arch/riscv/include/asm/hwcap.h | 2 ++
 arch/riscv/kernel/cpufeature.c | 5 +++++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
index ca23c4f6c440..c24280774caf 100644
--- a/arch/riscv/include/asm/elf.h
+++ b/arch/riscv/include/asm/elf.h
@@ -66,7 +66,7 @@ extern bool compat_elf_check_arch(Elf32_Ehdr *hdr);
  * via a bitmap that coorespends to each single-letter ISA extension.  This is
  * essentially defunct, but will remain for compatibility with userspace.
  */
-#define ELF_HWCAP	(elf_hwcap & ((1UL << RISCV_ISA_EXT_BASE) - 1))
+#define ELF_HWCAP	riscv_get_elf_hwcap()
 extern unsigned long elf_hwcap;
 
 /*
diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 574385930ba7..e6c288ac4581 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -61,6 +61,8 @@
 
 #include <linux/jump_label.h>
 
+unsigned long riscv_get_elf_hwcap(void);
+
 struct riscv_isa_ext_data {
 	/* Name of the extension displayed to userspace via /proc/cpuinfo */
 	char uprop[RISCV_ISA_EXT_NAME_LEN_MAX];
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 28032b083463..29c0680652a0 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -293,6 +293,11 @@ void __init riscv_fill_hwcap(void)
 	pr_info("riscv: ELF capabilities %s\n", print_str);
 }
 
+unsigned long riscv_get_elf_hwcap(void)
+{
+	return (elf_hwcap & ((1UL << RISCV_ISA_EXT_BASE) - 1));
+}
+
 #ifdef CONFIG_RISCV_ALTERNATIVE
 /*
  * Alternative patch sites consider 48 bits when determining when to patch
-- 
2.17.1


