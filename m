Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CC16BAC0E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 10:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjCOJXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 05:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbjCOJXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 05:23:07 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3826A23316;
        Wed, 15 Mar 2023 02:23:06 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-17683b570b8so20251273fac.13;
        Wed, 15 Mar 2023 02:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678872185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YIlDmOhHfzUv00AnBDlY+LrTEjW0fV7JmMX/NObYM/0=;
        b=jMwS04iE8sVc508yTw9rVt892u9Rx8nIWzDE5QGMJFsTaUDANTrUlNIsCG6yP5o3pu
         LDq2LfysPHaMkjGL3j9ODWL1DA3syFL55sDXFj70tGRHmR6FlSiD87AkrDjb3TPJqvjH
         NyvgT/ZmlxD/mplejH8J3tRK9SroSe/gXIiUXr4kjiN6w3+4Js+9XZjU4XRY1TGZtfC1
         V/xY2lkfNuaU6Xzsb1UT4vH9MPGKqL5KAkCNxKTSgucGvV3ratbp1Bn1e8d04rpmfE5j
         V49tuMg/Be72TYhgkZymUVkjjrEPICEUok0rFpXWcTx1OGVG8kIQctvpTa934wxhR7Bt
         nlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678872185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YIlDmOhHfzUv00AnBDlY+LrTEjW0fV7JmMX/NObYM/0=;
        b=gIKUIOQziX+Bz1UmAvZXa6PyuqTOniZxiM4fYUfghOWML3TRanmMuRRXc05naYmeJG
         Vc22KcyWcUEQh0TzsQs7asFkx5feTdGj62WDrpwvjCEOAeohxQKLjXFESQYOPxOKcWyn
         F4KcuM2vsjiUcuXku0Y+1DBOG/tZ/t4sLWnqmSViPvQsWwd6IHBD0Xh6hoTailx7aC1R
         BdzR2LiNWFXSldLGMiZwPVt9ob9AiGI5DxXq9J2Koj5GBhRqPO1Q2nBFW2hAGiEJFxHB
         U78yTESruFn/fhlO1d0gdYT57C+MDyh1eRf5vpokQJ535fxVfJLq0OIVHQoA+/YQ79C6
         R55g==
X-Gm-Message-State: AO0yUKXC9nIaXvxw7swIpef2iG7GeJEb5zQckBJbQg9Wj2RW51xVHbKP
        qlHhK6wHwyQLvO/JokV2RN8=
X-Google-Smtp-Source: AK7set8yMP0V/w7VMNSJFYtaq7Neq+UbYjbv3HegPrjxBGGWs99G4sBOjg56b7JQRhAyGxJeYGeFJw==
X-Received: by 2002:a05:6870:a446:b0:17a:c38e:823f with SMTP id n6-20020a056870a44600b0017ac38e823fmr1205376oal.51.1678872185553;
        Wed, 15 Mar 2023 02:23:05 -0700 (PDT)
Received: from chcpu13.cse.ust.hk (191host119.mobilenet.cse.ust.hk. [143.89.191.119])
        by smtp.gmail.com with ESMTPSA id v5-20020a056870e28500b00176209a6d6asm2037335oad.10.2023.03.15.02.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 02:23:05 -0700 (PDT)
From:   Wei Chen <harperchen1110@gmail.com>
To:     deller@gmx.de
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Wei Chen <harperchen1110@gmail.com>
Subject: [PATCH] fbdev: au1200fb: Fix potential divide by zero
Date:   Wed, 15 Mar 2023 09:22:54 +0000
Message-Id: <20230315092254.1042615-1-harperchen1110@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

var->pixclock can be assigned to zero by user. Without
proper check, divide by zero would occur when invoking
macro PICOS2KHZ in au1200fb_fb_check_var.

Error out if var->pixclock is zero.

Signed-off-by: Wei Chen <harperchen1110@gmail.com>
---
 drivers/video/fbdev/au1200fb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/fbdev/au1200fb.c b/drivers/video/fbdev/au1200fb.c
index 81c315454428..b6b22fa4a8a0 100644
--- a/drivers/video/fbdev/au1200fb.c
+++ b/drivers/video/fbdev/au1200fb.c
@@ -1040,6 +1040,9 @@ static int au1200fb_fb_check_var(struct fb_var_screeninfo *var,
 	u32 pixclock;
 	int screen_size, plane;
 
+	if (!var->pixclock)
+		return -EINVAL;
+
 	plane = fbdev->plane;
 
 	/* Make sure that the mode respect all LCD controller and
-- 
2.25.1

