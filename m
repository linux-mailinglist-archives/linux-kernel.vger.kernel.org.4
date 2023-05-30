Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7634D716829
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 17:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbjE3Pzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 11:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbjE3PzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 11:55:21 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13475C5;
        Tue, 30 May 2023 08:55:20 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-77749d2613bso54105039f.2;
        Tue, 30 May 2023 08:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685462119; x=1688054119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HzLXJzmyM6ehvjxPhXBctuD6pzz/uhWxjF9MwpFFoX8=;
        b=sV0vVcLuN/c8aFPDkzIKiJQGt1mMSPXwASTgM7ibpdqLu4XwGviCTR0sJaE6Y85YEg
         Bk7z2RgujlJJ+T1mrbGiKUMJfbJNJ6WluHksu1/z3i5GqWa4L2bcSE97wFUpz7xqde+f
         E7lUcUasW1cgj0yw2wQW10mE5LRvZB3IiOmCEBespXbVIN+QAJi6naMhwHctPslZorCN
         q+Hl9sDTFvNL+xYcyznfDt9/xiTcXZQ8NYW1lZy55pfHhzvDuKKt+mYd0B1Jj2SwjUuH
         ArEfKy+j/WGPnA5tlsZybGYerz7mnNAIlT8PG6qSpI7cVgTtBY4Kw9W//qEHQwLRHKkz
         S0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685462119; x=1688054119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HzLXJzmyM6ehvjxPhXBctuD6pzz/uhWxjF9MwpFFoX8=;
        b=Qt9z5yYKQKo6TCddR1hg3c/UPLIWE+ACIAOCQFw8BwcvH4uOUdLrhGjFnvBQjTHEZd
         gx6DEP3usbDKHNef3jJQpwlFVyRDTpL+0UKjLnSfUA0ZzcDapnDGdNJVAgSzr3AhS2as
         7XTPTvUnNXWuMqF+6yoqqIRNiPfR2GDPPG4HYwo1rajgpm/rMx970oTMLUtTr1gTdhyZ
         UF5gh4Mnet0hhQXRYPVJO9Zc3nl5dcBdKi56jRoFZVCKzEG5rBumiUqdL8J+hr8jBEjU
         X7e/XiF6zJM40ZFhMDZznPgjJpsLPeDtdnul3hl/SLDyR+s4RvHkDfXHbqpuEXgp37Z/
         ZobQ==
X-Gm-Message-State: AC+VfDzQUEHjZqBk8OCm30V7qVX1FaNUKQI46956EcIKV7s/r28KFN2P
        C3DPffgRJ7MDOM6EFOEvX34W8NVPGkc=
X-Google-Smtp-Source: ACHHUZ7VhLgjsIrOf3C7o216L4H7FCwqt2jO/nkrPwsRA1lUmBkSD3bXhTcVhfW939LXCv3HpK/z0g==
X-Received: by 2002:a5e:dd07:0:b0:76c:89de:ba47 with SMTP id t7-20020a5edd07000000b0076c89deba47mr2064040iop.19.1685462119157;
        Tue, 30 May 2023 08:55:19 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id ct13-20020a056638488d00b0041ceadd5f4dsm743187jab.70.2023.05.30.08.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 08:55:18 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Russell King <linux@armlinux.org.uk>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] ARM: Replace all non-returning strlcpy with strscpy
Date:   Tue, 30 May 2023 15:55:01 +0000
Message-ID: <20230530155501.222213-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().
No return values were used, so direct replacement is safe.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 arch/arm/kernel/atags_parse.c |    4 ++--
 arch/arm/kernel/setup.c       |    2 +-
 arch/arm/kernel/vdso.c        |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/atags_parse.c b/arch/arm/kernel/atags_parse.c
index 373b61f9a4f0..33f6eb5213a5 100644
--- a/arch/arm/kernel/atags_parse.c
+++ b/arch/arm/kernel/atags_parse.c
@@ -127,7 +127,7 @@ static int __init parse_tag_cmdline(const struct tag *tag)
 #elif defined(CONFIG_CMDLINE_FORCE)
 	pr_warn("Ignoring tag cmdline (using the default kernel command line)\n");
 #else
-	strlcpy(default_command_line, tag->u.cmdline.cmdline,
+	strscpy(default_command_line, tag->u.cmdline.cmdline,
 		COMMAND_LINE_SIZE);
 #endif
 	return 0;
@@ -224,7 +224,7 @@ setup_machine_tags(void *atags_vaddr, unsigned int machine_nr)
 	}
 
 	/* parse_early_param needs a boot_command_line */
-	strlcpy(boot_command_line, from, COMMAND_LINE_SIZE);
+	strscpy(boot_command_line, from, COMMAND_LINE_SIZE);
 
 	return mdesc;
 }
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 75cd4699e7b3..3048a685ea79 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -1142,7 +1142,7 @@ void __init setup_arch(char **cmdline_p)
 	setup_initial_init_mm(_text, _etext, _edata, _end);
 
 	/* populate cmd_line too for later use, preserving boot_command_line */
-	strlcpy(cmd_line, boot_command_line, COMMAND_LINE_SIZE);
+	strscpy(cmd_line, boot_command_line, COMMAND_LINE_SIZE);
 	*cmdline_p = cmd_line;
 
 	early_fixmap_init();
diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
index 3408269d19c7..f297d66a8a76 100644
--- a/arch/arm/kernel/vdso.c
+++ b/arch/arm/kernel/vdso.c
@@ -135,7 +135,7 @@ static Elf32_Sym * __init find_symbol(struct elfinfo *lib, const char *symname)
 
 		if (lib->dynsym[i].st_name == 0)
 			continue;
-		strlcpy(name, lib->dynstr + lib->dynsym[i].st_name,
+		strscpy(name, lib->dynstr + lib->dynsym[i].st_name,
 			MAX_SYMNAME);
 		c = strchr(name, '@');
 		if (c)

