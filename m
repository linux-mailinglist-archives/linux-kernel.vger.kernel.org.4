Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286F7716932
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbjE3QYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbjE3QYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:24:24 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90515132;
        Tue, 30 May 2023 09:24:04 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-33b5dba8c6cso4403135ab.2;
        Tue, 30 May 2023 09:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685463843; x=1688055843;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=18Rx5u4bYoedCB7FUTPJjIW5KUc8fkOVW8VkhMEmwMc=;
        b=Pt2QR9GKwJnfOKVsNc06DVCxrBJdTrqsM0LQrm5pL3xNvXI0BLAsIeJQGDY5naUaSo
         Iqw6GHhvi7qUE8vOxDE571tu07xo9GJ1+sYQqjtasMT/FQDFGgO/zwfp1BoPdH9gamoM
         TFFGowdtajQhT8LBNy4xMHStxE2k4bmQ4C2qN5unZIkZZ85xRe+r9mvYAO9Mqk8A3Z4s
         28S5vDq4+easiqubvm8G9P3FPlt7zMOF4/sFkeyDFlBf15O9W0K+bmSfLp+yPXqalhK+
         KGUR/mMT9HbOgXobNsWuYkfmvjqDziQ4BHjF9K/Cp0OUmU5gPEeJC/cXv0wXF4jt1smu
         BJMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685463843; x=1688055843;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=18Rx5u4bYoedCB7FUTPJjIW5KUc8fkOVW8VkhMEmwMc=;
        b=lZSuXScSeVchGJDMBzrQAiLdJpi0BbGvCcqXerk4HQaSFfrdttNYTWZzbZj9D4E8Ub
         2r38FtoseUKpRVBrOdsQGmiTWNeEvWgTy5qNYVNKCimn3nGJS3wm/RkhilvKhcMP1gLi
         TXZp+0ahjpU/Cxmy6ajkklFJkeZeZwWQEg7ZW5SQlrUb14lEYthnUfPrQQU+3/elVFJz
         vbxhDa2PMqcWOUEbZc3KWQ3HS5z1EeNUq0pwKdCoirl6odwDQik4zO9QjDt2x1x4pGGZ
         gVFe5XutBSeccax2HzwwJy4It+sbnVK45tKWT8PpwVUjKN1jEyuzdR7qhDiufyRxA08/
         Zxbg==
X-Gm-Message-State: AC+VfDwmNm6qk7eqOTPUi7sz8K9bkdjZgVuz4TC7C3jVLBtUNBylX2Xr
        Be+wo9lxwkQqBtuIMp4QdVAhf7PpOEGYIQ==
X-Google-Smtp-Source: ACHHUZ5hhenSCmaM/4FGcLbSsNHbhWBxT7uPUiv4Snj95W8BU5o0Hp4Q4oKn/k+kYxRtD/PKQxaiZA==
X-Received: by 2002:a92:c6cb:0:b0:33b:76a8:cb80 with SMTP id v11-20020a92c6cb000000b0033b76a8cb80mr29207ilm.27.1685463843557;
        Tue, 30 May 2023 09:24:03 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id r5-20020a92c505000000b003381b902199sm2542860ilg.39.2023.05.30.09.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 09:24:02 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] nios2: Replace all non-returning strlcpy with strscpy
Date:   Tue, 30 May 2023 16:23:58 +0000
Message-ID: <20230530162358.984149-1-azeemshaikh38@gmail.com>
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
 arch/nios2/kernel/cpuinfo.c |    2 +-
 arch/nios2/kernel/setup.c   |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/nios2/kernel/cpuinfo.c b/arch/nios2/kernel/cpuinfo.c
index 203870c4b86d..338849c430a5 100644
--- a/arch/nios2/kernel/cpuinfo.c
+++ b/arch/nios2/kernel/cpuinfo.c
@@ -47,7 +47,7 @@ void __init setup_cpuinfo(void)
 
 	str = of_get_property(cpu, "altr,implementation", &len);
 	if (str)
-		strlcpy(cpuinfo.cpu_impl, str, sizeof(cpuinfo.cpu_impl));
+		strscpy(cpuinfo.cpu_impl, str, sizeof(cpuinfo.cpu_impl));
 	else
 		strcpy(cpuinfo.cpu_impl, "<unknown>");
 
diff --git a/arch/nios2/kernel/setup.c b/arch/nios2/kernel/setup.c
index 40bc8fb75e0b..8582ed965844 100644
--- a/arch/nios2/kernel/setup.c
+++ b/arch/nios2/kernel/setup.c
@@ -121,7 +121,7 @@ asmlinkage void __init nios2_boot_init(unsigned r4, unsigned r5, unsigned r6,
 		dtb_passed = r6;
 
 		if (r7)
-			strlcpy(cmdline_passed, (char *)r7, COMMAND_LINE_SIZE);
+			strscpy(cmdline_passed, (char *)r7, COMMAND_LINE_SIZE);
 	}
 #endif
 
@@ -129,10 +129,10 @@ asmlinkage void __init nios2_boot_init(unsigned r4, unsigned r5, unsigned r6,
 
 #ifndef CONFIG_CMDLINE_FORCE
 	if (cmdline_passed[0])
-		strlcpy(boot_command_line, cmdline_passed, COMMAND_LINE_SIZE);
+		strscpy(boot_command_line, cmdline_passed, COMMAND_LINE_SIZE);
 #ifdef CONFIG_NIOS2_CMDLINE_IGNORE_DTB
 	else
-		strlcpy(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
+		strscpy(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
 #endif
 #endif
 

