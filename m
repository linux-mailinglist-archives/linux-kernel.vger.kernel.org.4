Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF0A716984
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbjE3QbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbjE3Qan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:30:43 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6206CE62;
        Tue, 30 May 2023 09:30:22 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-33bb16ac2e9so1672085ab.3;
        Tue, 30 May 2023 09:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685464205; x=1688056205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/LWWk7OiWzrpThqhVbFLSrSU5nSLgFLiDPfrnxleCDY=;
        b=TQioqOjca+bUqcEeiDchD5sSjIHMiquSZWZJT8KvLIMJuKXOba+ePT3amyjsq1szBb
         XomhM5aSn25xJj9YFCrEHDaHIJ9a8CYBqvCgmVecdW2n2QrGE1SYr0RJ3arZZbSkIlZ4
         r+qL5UOPzAosqv9NxuFWeNQ5Kyv7sGOAWvAL7t5gkSzY09uctRXZE6cvXDXL53w1LmXv
         LiLIShHLUxBX7cA3TyXI0+UtLCMRx10Hn71KHDu5ir02UHa/w6dsnidk4VdyFxh4A+uf
         avDlFziEq+lNYzlRDrRWr9pOc/ZEANJ2CAkfuhDpIyJU1c4WLdSGvoNej98aNRlKMcTf
         j5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685464205; x=1688056205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/LWWk7OiWzrpThqhVbFLSrSU5nSLgFLiDPfrnxleCDY=;
        b=cu+JbS3NPoUt5EEXvzP1zpJictd//jZpUV48gx31dMLFU+NYjM2fo7PZFrNePj954H
         8r3f7PuUCq6c5dCHugeAu1OfWBwQB2l2SfEK/jxjjNi6fHDo3a29K6kJhAV+POM93pb4
         97FXgFW5cUK6+sTv1Q7veaO0tnmGCQUMGY473c3JcsTKdMIz6q5O3GmalJAQC+hE2/BF
         fUOdECI6H8lKGIubIVL/6BeC0WpXEHa3y1gex9zPux2hhTHTk5rCQIjegj7D2PsXiLwC
         rUh0UrhiaH+95TSURfnN05izRPiwtf1Ph/Hop2P4oqjtuhU+YfAIX9/Yb/UrPppPSsl4
         irGQ==
X-Gm-Message-State: AC+VfDxrS82npn5CJplV8CF9R10vIJ6Mdo0igDbb4GaoUlMuGehE2uEJ
        OW1OnbQatTTlSBqUenEuuHM=
X-Google-Smtp-Source: ACHHUZ7OZ/XmHPC+oA4bkbBkK/58E7h3zga5Zp5f5CGOKNu0KJV57R9RZY4X0bC9fRZO7Ib1vNvT0Q==
X-Received: by 2002:a92:d182:0:b0:335:3568:dc67 with SMTP id z2-20020a92d182000000b003353568dc67mr68169ilz.15.1685464205051;
        Tue, 30 May 2023 09:30:05 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id d8-20020a0566380d4800b0041a9cf6651asm771148jak.138.2023.05.30.09.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 09:30:04 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sparc64: Replace all non-returning strlcpy with strscpy
Date:   Tue, 30 May 2023 16:30:01 +0000
Message-ID: <20230530163001.985256-1-azeemshaikh38@gmail.com>
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
 arch/sparc/kernel/ioport.c   |    2 +-
 arch/sparc/kernel/setup_32.c |    2 +-
 arch/sparc/kernel/setup_64.c |    2 +-
 arch/sparc/prom/bootstr_32.c |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index 4e4f3d3263e4..a8cbe403301f 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -191,7 +191,7 @@ static void __iomem *_sparc_alloc_io(unsigned int busno, unsigned long phys,
 		tack += sizeof (struct resource);
 	}
 
-	strlcpy(tack, name, XNMLN+1);
+	strscpy(tack, name, XNMLN+1);
 	res->name = tack;
 
 	va = _sparc_ioremap(res, busno, phys, size);
diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index c8e0dd99f370..ace0e9adfd77 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -302,7 +302,7 @@ void __init setup_arch(char **cmdline_p)
 
 	/* Initialize PROM console and command line. */
 	*cmdline_p = prom_getbootargs();
-	strlcpy(boot_command_line, *cmdline_p, COMMAND_LINE_SIZE);
+	strscpy(boot_command_line, *cmdline_p, COMMAND_LINE_SIZE);
 	parse_early_param();
 
 	boot_flags_init(*cmdline_p);
diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index 48abee4eee29..6546ca9d4d3f 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -636,7 +636,7 @@ void __init setup_arch(char **cmdline_p)
 {
 	/* Initialize PROM console and command line. */
 	*cmdline_p = prom_getbootargs();
-	strlcpy(boot_command_line, *cmdline_p, COMMAND_LINE_SIZE);
+	strscpy(boot_command_line, *cmdline_p, COMMAND_LINE_SIZE);
 	parse_early_param();
 
 	boot_flags_init(*cmdline_p);
diff --git a/arch/sparc/prom/bootstr_32.c b/arch/sparc/prom/bootstr_32.c
index e3b731ff00f0..1c7cd258b0dc 100644
--- a/arch/sparc/prom/bootstr_32.c
+++ b/arch/sparc/prom/bootstr_32.c
@@ -52,7 +52,7 @@ prom_getbootargs(void)
 		 * V3 PROM cannot supply as with more than 128 bytes
 		 * of an argument. But a smart bootstrap loader can.
 		 */
-		strlcpy(barg_buf, *romvec->pv_v2bootargs.bootargs, sizeof(barg_buf));
+		strscpy(barg_buf, *romvec->pv_v2bootargs.bootargs, sizeof(barg_buf));
 		break;
 	default:
 		break;

