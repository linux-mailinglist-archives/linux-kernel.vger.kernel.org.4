Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBFE71691E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbjE3QWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjE3QWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:22:07 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A934AA1;
        Tue, 30 May 2023 09:22:06 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-33b3f679cafso17607465ab.1;
        Tue, 30 May 2023 09:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685463726; x=1688055726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zxhN0qPpdQSTFxCBrSpe3bOMX6N3aA/hCAkqqF2hhts=;
        b=iVQjFOwUYDObnFFjWGAvxprrQ9VTrw+faNNgCUDjt+53SYpuVJZEmoyoB3NUVUq2I8
         x/DpGh7sPSgYkBshiOg8MvlfIyEbKeyBu1oOWYapFw+ba1xbvs5udcESK15t5AixhlsF
         f+nGi5vfH2N0NkhitkXP+TrdW+3ylxvGu/LlRlHDm99wHGDDwOAsiDexB0ZP+JEm4Osw
         oBHk50w+onT2U3CELAFqCEbiiXTH0Sm48s3AdV4OFrirbPTjh1hRRfPJmlOll2QlXneT
         2HSujSjAmw3pTfPQGJyqjba+tFkstjAdFBXzV7BMRFUL1oSsu7hNHEFrOr6JONpJUjL1
         7WWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685463726; x=1688055726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zxhN0qPpdQSTFxCBrSpe3bOMX6N3aA/hCAkqqF2hhts=;
        b=DIq/Gl6HvTnlVms/KKrJrHojfpxzfQCK5kzxHNrXgfg8LEo1pYelrnSROfUJJ1OAdC
         MCYzpMDMR3G6jRTlr3uU7JdehOTtTrM3kma5y6h7Qd0q8fY38sX4kXEMZfnlzxR6fhiK
         RViSd1Qkp0ONvwTyGcrHQNZ07f2xJ168SE4GKr1rtKNn1IJxsp9lHOboO4UJOCQKOYsH
         KEjLEGWeVJ+DrRnpPc+S+ePvKlYwiTd1N29cXdaCoFNcaBJZHL36bdPH+uB3lTlM/sDK
         1oPY/DokbfMrK3zFWpaZj9kMJE/U1pGDyKAh1eqfP1Z4iRLDDA2tNxOzUVGi1ZOxE+vi
         jWmw==
X-Gm-Message-State: AC+VfDybnOM1ga1q0ZMVvttKX5EeGkkkrz5K5JmUV20lYQOWFOqD8yBe
        bKOLAgulArjiG1ZiG3kv3JqhqZo8FAGMfg==
X-Google-Smtp-Source: ACHHUZ6hlWhurCehcldvUE17VX0+CWGtT13GrAsEtyZ8HjeqOWBWR5ktWF6cYAJaGsP2l6xYMuD3vA==
X-Received: by 2002:a92:d1c4:0:b0:32b:75bc:cda2 with SMTP id u4-20020a92d1c4000000b0032b75bccda2mr5562ilg.22.1685463725837;
        Tue, 30 May 2023 09:22:05 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id c13-20020a92cf4d000000b003312915e615sm2553689ilr.28.2023.05.30.09.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 09:22:05 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Michal Simek <monstr@monstr.eu>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] of/flattree: Replace all non-returning strlcpy with strscpy
Date:   Tue, 30 May 2023 16:22:02 +0000
Message-ID: <20230530162202.983558-1-azeemshaikh38@gmail.com>
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
 arch/microblaze/kernel/prom.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/microblaze/kernel/prom.c b/arch/microblaze/kernel/prom.c
index c5c6186a7e8b..e424c796e297 100644
--- a/arch/microblaze/kernel/prom.c
+++ b/arch/microblaze/kernel/prom.c
@@ -20,7 +20,7 @@ void __init early_init_devtree(void *params)
 
 	early_init_dt_scan(params);
 	if (!strlen(boot_command_line))
-		strlcpy(boot_command_line, cmd_line, COMMAND_LINE_SIZE);
+		strscpy(boot_command_line, cmd_line, COMMAND_LINE_SIZE);
 
 	memblock_allow_resize();
 

