Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B26E6DFDDB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 20:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjDLSp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 14:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjDLSpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 14:45:17 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B946188
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:45:13 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id bm45so2703794oib.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681325112; x=1683917112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRQeRpa+j7z3VGaqIAViY07xGVHNoffmRva1Ftuz2yI=;
        b=M+LxblnK1w1qQ2r8lojLBxu14Yd2MIrwnR53z51Tt9mgYjQBLuhPe/wJe0bQrPC3Au
         0Viu5nBqadDJwBJIWVCxHREKg3rAiXZvJDrQzEevjg0zPme3Zq+xyM6CF59cJm1htHm9
         8IhlTGbzlTu3vO9Vw1BARy9Zf+/DU2ImMBCDAI6YaL6I9k7jYaaEwC3n9XiSWK/vXpGi
         8XrQLlC9EU4n+JbN+36vb4CC2OJDSpIj78FaHxZFxEypwFkHuIVtNyW9bFM55H3746pc
         C9UqPNRy/xhqEUJ2F/Xk59HnqIjV4APPQATAIFs5FBFayCev0TxJZTDN6ftHOx2/O+C+
         8qDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681325112; x=1683917112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PRQeRpa+j7z3VGaqIAViY07xGVHNoffmRva1Ftuz2yI=;
        b=WlTJbOyaftJp8F5Jv/b40bjIxpIioWIwBbj9F7ClnovqeBQ+vT6UxccsOB2oi3Efsm
         /ad/h1BmK1Dy9MNG+IupK2CIymxLgX79fkRZeQIvSZG8Az/l7mOJwdfJ8qI3qF8C/Dqz
         FSlg4rIk2C0C9OPT/vRyj5ISZaaUfU3ehnysPci9wvWnvm2ylmEfApf+x0BXYHWbRebP
         d4oJpKJVdeA087dhSDzwSjvdAbGafpp6ST14maN9vndmEAc598zEm9NRmcuiODxi0gJx
         opcbqvU2Prxg8ro5362JR4ohPl4XiKjDc4oCrs9Ud0yhs4qxn/rpMVFpkqmxBO1pnnxr
         NHnw==
X-Gm-Message-State: AAQBX9cqfYKTEIoz7cNKWA6H8f7SUxsihIJY+JJ+av3q7/qw3aw+DLEF
        f4Kh4cHuwtWdPtkOZa9RPezQ8kZj3Q==
X-Google-Smtp-Source: AKy350aXOl5QGXWROTPG7eWOsFz3wZvizVTKy9Z0zZW5CwTsjwM7f5sDhasT1u5WsXwuzToDvKq6NA==
X-Received: by 2002:a05:6808:2a02:b0:389:1c19:f684 with SMTP id ez2-20020a0568082a0200b003891c19f684mr1436523oib.23.1681325112348;
        Wed, 12 Apr 2023 11:45:12 -0700 (PDT)
Received: from citadel.. (075-129-116-198.res.spectrum.com. [75.129.116.198])
        by smtp.gmail.com with ESMTPSA id w24-20020a9d77d8000000b00690e990e61asm6706020otl.14.2023.04.12.11.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 11:45:12 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 3/6] x86/boot: Clean up get_cmd_line_ptr()
Date:   Wed, 12 Apr 2023 14:44:59 -0400
Message-Id: <20230412184502.145289-4-brgerst@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230412184502.145289-1-brgerst@gmail.com>
References: <20230412184502.145289-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pass in the boot_params pointer, and use the appropriate return type.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/kernel/head64.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 6e0f53a66678..08ea521041bf 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -434,19 +434,18 @@ void __init clear_bss(void)
 	       (unsigned long) __brk_limit - (unsigned long) __brk_base);
 }
 
-static unsigned long get_cmd_line_ptr(void)
+static char *get_cmd_line_ptr(struct boot_params *bp)
 {
-	unsigned long cmd_line_ptr = boot_params.hdr.cmd_line_ptr;
+	unsigned long cmd_line_ptr = bp->hdr.cmd_line_ptr;
 
-	cmd_line_ptr |= (u64)boot_params.ext_cmd_line_ptr << 32;
+	cmd_line_ptr |= (u64)bp->ext_cmd_line_ptr << 32;
 
-	return cmd_line_ptr;
+	return (char *)cmd_line_ptr;
 }
 
 static void __init copy_bootdata(char *real_mode_data)
 {
-	char * command_line;
-	unsigned long cmd_line_ptr;
+	char *cmd_line_ptr;
 
 	/*
 	 * If SME is active, this will create decrypted mappings of the
@@ -455,11 +454,9 @@ static void __init copy_bootdata(char *real_mode_data)
 	sme_map_bootdata(real_mode_data);
 
 	memcpy(&boot_params, real_mode_data, sizeof(boot_params));
-	cmd_line_ptr = get_cmd_line_ptr();
-	if (cmd_line_ptr) {
-		command_line = __va(cmd_line_ptr);
-		memcpy(boot_command_line, command_line, COMMAND_LINE_SIZE);
-	}
+	cmd_line_ptr = get_cmd_line_ptr(&boot_params);
+	if (cmd_line_ptr)
+		memcpy(boot_command_line, __va(cmd_line_ptr), COMMAND_LINE_SIZE);
 
 	/*
 	 * The old boot data is no longer needed and won't be reserved,
-- 
2.39.2

