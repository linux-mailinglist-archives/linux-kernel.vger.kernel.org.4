Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC36669F00
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 18:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjAMRDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 12:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjAMRDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 12:03:13 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898255585F
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 09:03:12 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id jr10so12259419qtb.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 09:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pefoley.com; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bROfxi87SKGtnuGyOOLeoMUpo9EzYYApKxrmMtTM9wU=;
        b=LDrSoesyD8KnwWxhmjqrU4fg/5CkN6ucQbUQ7x4RSB1p7qC7NPYiMAjuFMCd4JSg6m
         B4LcwAN/i6ydMhqVzJkOCE125tantDDz8ToY4onW7V7TQfMmJQt1nfvthpcM6oPZQMVz
         pM0PJfDD4C5XkKB90uz4Ymc48p36s6OpjPEMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bROfxi87SKGtnuGyOOLeoMUpo9EzYYApKxrmMtTM9wU=;
        b=1X4AuFPfWEcSnkKHSRoqi2hWtWCDd2K9VncVQa6xaMw0C0uAIbvpyR+6zsF/3wfye5
         2KD+5400cALuxn/WZxJYOT+t5+z2qSJ7wsoXZsuWHdgDUd/gKBSkgmYLg2CBKLmvc44t
         TwFd3jCeSxZajwcLEiZV3BYvDqn8BObi9cf5UDe6CSMS9Kdn4vJ1ZtFgt0K55mmMgvzO
         GqneiGwRBmVc64TCA8i2VkheBwpkxFLadciN3+WNZemWxFwRDxszZIpi398hWrkgWNrp
         Y2JClf3GbaHavTqQH0j0Ll4+SAGzVa1IN4b0KD8TZRaFL6i9+MNu93IET+hz1zTX6vJp
         cTkQ==
X-Gm-Message-State: AFqh2koxoJL5M6y+i8HuJhWRwBQlvclmZVW4TzPN40pA0Rctvvx8jOmW
        RRr9WX9zqaLzWEmIkR4SxIoa2w==
X-Google-Smtp-Source: AMrXdXtmxOnHo7PGMg9shJkUouga7bPa4NewH/ugJgs+Ify+0IpDXF6lcm2iNVILj5PiF9Q3nl2pzQ==
X-Received: by 2002:ac8:4e44:0:b0:3a9:8842:5854 with SMTP id e4-20020ac84e44000000b003a988425854mr148872960qtw.52.1673629391435;
        Fri, 13 Jan 2023 09:03:11 -0800 (PST)
Received: from [192.168.1.3] ([2600:4040:29fb:d300:887b:7eff:fe74:68b2])
        by smtp.gmail.com with ESMTPSA id o7-20020ac841c7000000b003a82562c90fsm10716775qtm.62.2023.01.13.09.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 09:03:10 -0800 (PST)
From:   Peter Foley <pefoley2@pefoley.com>
Date:   Fri, 13 Jan 2023 12:03:00 -0500
Subject: [PATCH] um: Support LTO
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230113-umlto-v1-1-9795842411e7@pefoley.com>
X-B4-Tracking: v=1; b=H4sIAMSOwWMC/x2NQQqAIBAAvxJ7TtCEhL4SHcy2WiiL3YpA+nvWc
 ZiBSSDIhAJNkYDxIqEtZjBlAWH2cUJFQ2aodGW1MVad63JsKrixdtZYXaOD3PZeUPXsY5i/evVy
 IH9iZxzp/gdt9zwv5qhYb3AAAAA=
To:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peter Foley <pefoley2@pefoley.com>
X-Mailer: b4 0.11.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1673629390; l=2027;
 i=pefoley2@pefoley.com; s=20230111; h=from:subject:message-id;
 bh=r37o6W2X7xYahpb4XmGtj5Z76NOt8ozSLJ+BNIEJYA0=;
 b=ewHzEg53qWxOptgtg7+hrYdRUvKjiJ+M+Hb6RM7u3+898hGzrBx/hT7YCM4mnNVQrQ4lsOOepN8R
 ooM0pqCXAaAjuR51JlN7ajMsGnw1nkPoaEXV9V31CbSX/EG/59Ko
X-Developer-Key: i=pefoley2@pefoley.com; a=ed25519;
 pk=DCQqIdN6rHnvfQH58WQiQzJFfGUo1HyWSvdYG8vnO5o=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only a handful of changes are necessary to get it to work.

Signed-off-by: Peter Foley <pefoley2@pefoley.com>
---
 arch/um/Kconfig           | 2 ++
 arch/um/Makefile          | 2 +-
 arch/x86/um/vdso/Makefile | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index ad4ff3b0e91e..7c94ca7ff758 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -25,6 +25,8 @@ config UML
 	select GENERIC_IRQ_SHOW
 	select GENERIC_CPU_DEVICES
 	select HAVE_GCC_PLUGINS
+	select ARCH_SUPPORTS_LTO_CLANG
+	select ARCH_SUPPORTS_LTO_CLANG_THIN
 	select TRACE_IRQFLAGS_SUPPORT
 	select TTY # Needed for line.c
 	select HAVE_ARCH_VMAP_STACK
diff --git a/arch/um/Makefile b/arch/um/Makefile
index f1d4d67157be..a41dde204b08 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -142,7 +142,7 @@ endif
 LD_FLAGS_CMDLINE = $(foreach opt,$(KBUILD_LDFLAGS),-Wl,$(opt))
 
 # Used by link-vmlinux.sh which has special support for um link
-export CFLAGS_vmlinux := $(LINK-y) $(LINK_WRAPS) $(LD_FLAGS_CMDLINE)
+export CFLAGS_vmlinux := $(LINK-y) $(LINK_WRAPS) $(LD_FLAGS_CMDLINE) $(CC_FLAGS_LTO)
 export LDFLAGS_vmlinux := $(LDFLAGS_EXECSTACK)
 
 # When cleaning we don't include .config, so we don't include
diff --git a/arch/x86/um/vdso/Makefile b/arch/x86/um/vdso/Makefile
index 6fbe97c52c99..6825e146a62f 100644
--- a/arch/x86/um/vdso/Makefile
+++ b/arch/x86/um/vdso/Makefile
@@ -61,7 +61,7 @@ CFLAGS_REMOVE_um_vdso.o = -pg -fprofile-arcs -ftest-coverage
 #
 quiet_cmd_vdso = VDSO    $@
       cmd_vdso = $(CC) -nostdlib -o $@ \
-		       $(VDSO_LDFLAGS) $(VDSO_LDFLAGS_$(filter %.lds,$(^F))) \
+		       $(CC_FLAGS_LTO) $(VDSO_LDFLAGS) $(VDSO_LDFLAGS_$(filter %.lds,$(^F))) \
 		       -Wl,-T,$(filter %.lds,$^) $(filter %.o,$^) && \
 		 sh $(srctree)/$(src)/checkundef.sh '$(NM)' '$@'
 

---
base-commit: d9fc1511728c15df49ff18e49a494d00f78b7cd4
change-id: 20230113-umlto-c7f6731306e7

Best regards,
-- 
Peter Foley <pefoley2@pefoley.com>
