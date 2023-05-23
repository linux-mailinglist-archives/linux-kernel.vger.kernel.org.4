Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2003970D0DD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 04:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbjEWCMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 22:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjEWCMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 22:12:38 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDC9CA;
        Mon, 22 May 2023 19:12:37 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-76c5a225388so109165539f.1;
        Mon, 22 May 2023 19:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684807956; x=1687399956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=stI6HotysgUAEccaZJdD2JXeGYeJR4OEFUyKkR3kMOk=;
        b=QusAyHI64C46ry5WMaW7Y1pvGuOEhxkVuk9fedb9CiwSHgKcnWdyx3UuvK2oBJE86t
         clu0mYFeSk0uZFSnXjbswOiy3dfaZy5FJu6YAV778SmVbaEr+wAIWrUXobxC84QHwCWI
         H5V82YrUNaQM+sDdYNTUXhGtSotgWu0f7diSoHjazoqhTPU1HBI6tlMpZSB/z3ddBAem
         fXdxdJ6+SnTfckBBSeQeyHU91T2v7IL1OSvVW0wpnZcQP4rghxypylX/sA7IfHjtfZ+J
         5F31eZFWrd7XqgpzTeoR6AYaLaYLVql5wl1bQGXg3VnFCKToLog2mvta0LWc6w1Iaql8
         aGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684807956; x=1687399956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=stI6HotysgUAEccaZJdD2JXeGYeJR4OEFUyKkR3kMOk=;
        b=CdXbPOH0PH341HZrQQ33LAfgYH6oWxQ/9EaJLsVIXPbI/rX/uYEyG9lkX9oCnVd9FY
         j+xjcyY+ARqZgwHYU3AYHe3uSbRzk2mLA3MVBxbTqEtPrjvmDVmhazabc5t7bMzZaUbW
         XZJxF94LcdG8IQnzpViJHSiYRJ3TiL2XDlpi0aDJ1em/x2zTbLthMCbdRpSCTAUzjfRv
         SNER11FizCc8L3YCNm0Tbfi9NxNW/uBO/Qt5SSks6jYXCWXKGKI+A0KkS70rsfoP5rTh
         jGq0OONLCEfbWU4KC0xGHPMx/gs6i3+HxW8LVtOh8seAHDPQyoIwr2YkpmKdvPDgJPAU
         gYCQ==
X-Gm-Message-State: AC+VfDyFQfy5Y08WoWQsI8nFILgZ9aKzD2UG1AtP8Jwady0mlY1MeOOZ
        VW7U7bfRdMbioRxr1H0nptxiqx4bmK4JbA==
X-Google-Smtp-Source: ACHHUZ4oztlg9Svvs/LNYkqjS0KaGdjEj1nT9/r2tlVL/EeWYqymX2IE4UFxsrKVBgqhDOrUVihH8Q==
X-Received: by 2002:a92:c852:0:b0:32f:776d:711 with SMTP id b18-20020a92c852000000b0032f776d0711mr6886459ilq.30.1684807956403;
        Mon, 22 May 2023 19:12:36 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id dl9-20020a056638278900b004167410a9bcsm2094556jab.113.2023.05.22.19.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 19:12:36 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Jan-Simon Moeller <jansimon.moeller@gmx.de>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org
Subject: [PATCH] leds: blinkm: Replace all non-returning strlcpy with strscpy
Date:   Tue, 23 May 2023 02:12:28 +0000
Message-ID: <20230523021228.2406112-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
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
 drivers/leds/leds-blinkm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/leds-blinkm.c b/drivers/leds/leds-blinkm.c
index 37f2f32ae42d..8c2ae0798cfc 100644
--- a/drivers/leds/leds-blinkm.c
+++ b/drivers/leds/leds-blinkm.c
@@ -561,7 +561,7 @@ static int blinkm_detect(struct i2c_client *client, struct i2c_board_info *info)
 		return -ENODEV;
 	}
 
-	strlcpy(info->type, "blinkm", I2C_NAME_SIZE);
+	strscpy(info->type, "blinkm", I2C_NAME_SIZE);
 	return 0;
 }
 

