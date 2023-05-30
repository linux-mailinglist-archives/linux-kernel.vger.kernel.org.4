Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B61071697A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbjE3Q17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbjE3Q11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:27:27 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5013E11C;
        Tue, 30 May 2023 09:26:20 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-33b89956cccso8842635ab.2;
        Tue, 30 May 2023 09:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685463973; x=1688055973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bINww4BS9Q6hxqerWqXoOb0apgrSo5QFqqzYaEsD6HE=;
        b=MjX3/0w6ekjWWGcLGn9tr1TaBi4CybNxXDzzXBFtWRYXgboucEwWrJZJorQSHNBFZR
         8xY+IPe69+dq1vkIKsmw8QoLy+bR0IDcFCLQRp1qdCXmjrHZO+T4iiW1yTXac52YZPZD
         i8YPRtU9SP3ngHxSCMDT8HOe+TOw2bkcLqC4EL2HQpmYonYqZljzroaO6RH/Q4Y6BdFN
         dPI1wWouIeFmezuItohGf1wF0UYddRct9iRw0s/q1PO5rRNW9yCv2lfeVCb/jNRrEpDn
         ABjbjE2EGvyE2dhtxrV6ca3hWrivplnL2db1hoczt+wvlZPUnJcBo7N85dSt9iC007tt
         FdKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685463973; x=1688055973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bINww4BS9Q6hxqerWqXoOb0apgrSo5QFqqzYaEsD6HE=;
        b=Qx5iHOkU8NRGujd9kZUOEFFYJ95TH/busR9c7k3jQ+94c1gNa5QU/87/zAeNsWCHEq
         1QQ0Cr1bZFo6l2iCJSMglr1trhjqhpucroseChh5B1hNSlLDQ0BuK2ZJ95GFzXg0lnTe
         Aqd04MIyRjba8AkExXnHD+MSNyGExeMtHXmSdOE9uJbwKrDq0A3gWhmw1vQ8KRdpongM
         LT0XYaDMi6WYNppMk11dD7sI53dzYc50yL2cv6VQ3M8OWZPafs8bq+2yxu7w9O8G+id5
         rnjcS4/EA9udR5M7mbJADt/vE3v4INKiLaVGCFEDA27UnxalOtAF8syb9atDPOTD0I+N
         mibQ==
X-Gm-Message-State: AC+VfDz39VsPq4ZIN36k2s7CrhgXid6NU61fVtUAJh68bh7r2R/FPTbO
        bnkpGIAfaMfXaTak4OuMCCE=
X-Google-Smtp-Source: ACHHUZ6Sa2LY0fq1KzWhqJx0FPoMbV4zIs2N8ChrvMxcXLtbcJBVPnr5k/m0XvNGrD47uTLmvPneuA==
X-Received: by 2002:a92:cf43:0:b0:33b:7e4:167a with SMTP id c3-20020a92cf43000000b0033b07e4167amr77783ilr.15.1685463972964;
        Tue, 30 May 2023 09:26:12 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id x13-20020a026f0d000000b0041407c67451sm821769jab.165.2023.05.30.09.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 09:26:12 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Brian Cain <bcain@quicinc.com>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Hexagon: Replace all non-returning strlcpy with strscpy
Date:   Tue, 30 May 2023 16:26:08 +0000
Message-ID: <20230530162608.984333-1-azeemshaikh38@gmail.com>
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
 arch/hexagon/kernel/setup.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/hexagon/kernel/setup.c b/arch/hexagon/kernel/setup.c
index 1880d9beaf2b..621674e86232 100644
--- a/arch/hexagon/kernel/setup.c
+++ b/arch/hexagon/kernel/setup.c
@@ -66,9 +66,9 @@ void __init setup_arch(char **cmdline_p)
 		on_simulator = 0;
 
 	if (p[0] != '\0')
-		strlcpy(boot_command_line, p, COMMAND_LINE_SIZE);
+		strscpy(boot_command_line, p, COMMAND_LINE_SIZE);
 	else
-		strlcpy(boot_command_line, default_command_line,
+		strscpy(boot_command_line, default_command_line,
 			COMMAND_LINE_SIZE);
 
 	/*
@@ -76,7 +76,7 @@ void __init setup_arch(char **cmdline_p)
 	 * are both picked up by the init code. If no reason to
 	 * make them different, pass the same pointer back.
 	 */
-	strlcpy(cmd_line, boot_command_line, COMMAND_LINE_SIZE);
+	strscpy(cmd_line, boot_command_line, COMMAND_LINE_SIZE);
 	*cmdline_p = cmd_line;
 
 	parse_early_param();

