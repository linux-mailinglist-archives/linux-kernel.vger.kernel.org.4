Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5066DC76C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 15:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjDJNpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 09:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjDJNpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 09:45:35 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C47E8A48
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 06:45:24 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id e127so4582952ybf.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 06:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681134323; x=1683726323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eD7AdRCE8zafC8jVXcCcW+Uty+9+QQrtzQ+INtx0vrg=;
        b=AL1x70kZJTpNU6R4rsQaY49ByF+m7ET7tPw6YclzijjPSsQxe87XY4nXBO1TptNkBf
         4H8fS/KqVnonE2b5EeVcRD2jm1mK26TxIg+gMHs1Q8/X1Qw5udtVcAG5yBJk+1N8Pnnl
         kxk2lkI1lmRAEZVVd1GDczh8VrNrBfPnZqFctAozrmI7h4TE8Sl/gjo7qbHCLNUzsaUR
         sHRRbqj0wmDW12uoYAkGtB3+IVojoyw5QYuCj1BXARvZfRsuucR13HhJ2sWl/yRDzUCc
         WkYqB965ssk6CxdJdBGhF/Zm4ke1EMDJFNNitMrpNjqu3k6oAhYu/nLnQfVKrgP5YJTx
         t/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681134323; x=1683726323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eD7AdRCE8zafC8jVXcCcW+Uty+9+QQrtzQ+INtx0vrg=;
        b=vqurGtWNX3cOr597h6tGMZUYR5eXhGLHwto/609/d/8geiHJVjbFVSIqWu2HPbAZtZ
         rR/X6MZwT+ER1yLzbUOx0k/yMcKy6E88aYV6i8xJpzhPUjjZu9HtyaBERbolC8chiKYh
         0dBmaq2X1vEi0Ae1MAGFSmveCBZ6Aa/y/Kvv8pL7EAA9eX4DNj43P+/fm0Tof2aqqivw
         4G6uMrtm+0iYvumpHSlr/8AJaCEKAp5WZTGuKxX6hag16b9Hh9nnfFvIWR8xdb+2s1ZK
         PIo/ga0YXlrURPQBE8CjosQ5ax9seUnHVLhz2XQ2crLHp2J0bjHrJCyAI0q3K9MHQ3Mo
         Ap2Q==
X-Gm-Message-State: AAQBX9cAnVD6KM8odJG1axYIMQRpKNcZFUKh19qsLQkdJ99y/KOdtvnM
        AO19U4scvlwIfAVctAvHtoSD8ma3PUXRAPSX+uAUAw==
X-Google-Smtp-Source: AKy350bdO4uCyK22tYhLhGPfgkrumQX1i8mJNo1GoSxKl6A5Pc4FvBA9M+fMiI6yNtsDQxl8iyTYZA==
X-Received: by 2002:a25:408b:0:b0:a27:3ecc:ffeb with SMTP id n133-20020a25408b000000b00a273eccffebmr12619041yba.18.1681134323600;
        Mon, 10 Apr 2023 06:45:23 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id o16-20020a256b50000000b00b8bda3b0cecsm2934966ybm.29.2023.04.10.06.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 06:45:23 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH] counter: 104-quad-8: Remove reference in Kconfig to 25-bit counter value
Date:   Mon, 10 Apr 2023 09:45:16 -0400
Message-Id: <20230410134516.102886-1-william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support for 25-bit counter values was removed in commit 4aa3b75c7460
("counter: 104-quad-8: Fix race condition between FLAG and CNTR reads").
Adjust the Kconfig description of CONFIG_104_QUAD_8 to remove reference
of 25-bit counter values.

Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/counter/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
index b5ba8fb02cf7..47494b3e9f9c 100644
--- a/drivers/counter/Kconfig
+++ b/drivers/counter/Kconfig
@@ -21,9 +21,9 @@ config 104_QUAD_8
 	  encoder counter/interface device family (104-QUAD-8, 104-QUAD-4).
 
 	  A counter's respective error flag may be cleared by performing a write
-	  operation on the respective count value attribute. Although the
-	  104-QUAD-8 counters have a 25-bit range, only the lower 24 bits may be
-	  set, either directly or via the counter's preset attribute.
+	  operation on the respective count value attribute. The 104-QUAD-8
+	  counters may be set either directly or via the counter's preset
+	  attribute.
 
 	  The base port addresses for the devices may be configured via the base
 	  array module parameter. The interrupt line numbers for the devices may

base-commit: 09a9639e56c01c7a00d6c0ca63f4c7c41abe075d
-- 
2.39.2

