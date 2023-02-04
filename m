Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0361068A91E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 10:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbjBDJCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 04:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjBDJCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 04:02:20 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D354F2B61E
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 01:02:19 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id z1so5278002pfg.12
        for <linux-kernel@vger.kernel.org>; Sat, 04 Feb 2023 01:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W1MUjWfAsKwN3SdnMzVwXHWiAm+jPxdesCaacv1mxbY=;
        b=H0fu3e3yXWoEJSJOWKagnNj1laxY4kiR3BBqxlbctCO6GnyleNi1gsym7rLDR7cEeA
         Lz5MQKyoZGXSGOAqnnTFFJTFF6/I8sCWJ0/Egb00yGgNVdK4yBpu9hoGK0dgzOnNh2LG
         QPsbCB5o1g6L2UeZ7T3gBhJiitGgw28XvXiJMfTdlpYU4DyyDiobBGl6W97f4aXg4yJA
         CUjp46FmSuIpOu5oWOvJYcCqbi9IkG7hcTsuZqGzH0VPXR4njXiaPcSDuc9g28ClQd6Z
         XZMupdssc40hgSEI7OiAFYvZA/ITgw2dHZzLpys9g2YVURw1VbH+DHQBNwfz8ufYXVg/
         UBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W1MUjWfAsKwN3SdnMzVwXHWiAm+jPxdesCaacv1mxbY=;
        b=eWqNnlPZo1Q9tOpTw6Egy/MIQVTiNTJ0xdOT5jGjT1upUaXkpUst0LEDseN7D1kR8m
         GnI5EXb/EpP844G9bfIVscrNvYt5EKipwMbW+RPwB2OYOIsNQiTJLwLGz2pkIq+HU4pE
         9RuyHoMnteRj3La3W92yzMAi7X0x0R5qnGOKbaUwZ33aCd25Ee/eC1a9zFxU1mBNZqnt
         0Pfik4WKm1kx3wWf+ccZT1n8w6RH4lLENebY2PdOpSaxEHnDITfK4P0NA76TW80FxxwN
         +oRhGLtQmxJZaxa3OJf5ULhFBu+joyExHEgE9d2U3hZBckKWo1PFZI4dt0Y60Hr1o37K
         Im4Q==
X-Gm-Message-State: AO0yUKX0SYJj+wTYD4Mr1F3hkGvrLnmtoaC4e2Ey+psZzLnU130ucEoT
        w6T0BXWCX1p7rszREqvIDHY=
X-Google-Smtp-Source: AK7set/skOX98Z4uE3JOO+OqzHWRzt1gQKHweBsjZeLUdPhpC9yVLMwq8nZSbWbmM861qnaR0pHPZg==
X-Received: by 2002:a05:6a00:1ad2:b0:582:a212:d92c with SMTP id f18-20020a056a001ad200b00582a212d92cmr15149674pfv.10.1675501339228;
        Sat, 04 Feb 2023 01:02:19 -0800 (PST)
Received: from localhost.localdomain (34.116.241.35.bc.googleusercontent.com. [35.241.116.34])
        by smtp.gmail.com with ESMTPSA id y41-20020a056a00182900b00593a612515dsm3221846pfa.167.2023.02.04.01.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 01:02:17 -0800 (PST)
From:   Jeff Xie <xiehuan09@gmail.com>
To:     jan.kiszka@siemens.com, kbingham@kernel.org
Cc:     linux-kernel@vger.kernel.org, Jeff Xie <xiehuan09@gmail.com>
Subject: [PATCH] scripts/gdb: fix 'lx-current' for x86
Date:   Sat,  4 Feb 2023 17:01:39 +0800
Message-Id: <20230204090139.1789264-1-xiehuan09@gmail.com>
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

When printing the name of the current process, it will report an error:
(gdb) p $lx_current().comm
Python Exception <class 'gdb.error'> No symbol "current_task" in current context.: 
Error occurred in Python: No symbol "current_task" in current context.

Because the commit <e57ef2ed97c1> ("x86: Put hot per CPU variables into a struct") 
changed it.

Signed-off-by: Jeff Xie <xiehuan09@gmail.com>
---
 scripts/gdb/linux/cpus.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/gdb/linux/cpus.py b/scripts/gdb/linux/cpus.py
index 15fc4626d236..9ee99f9fae8d 100644
--- a/scripts/gdb/linux/cpus.py
+++ b/scripts/gdb/linux/cpus.py
@@ -163,7 +163,7 @@ def get_current_task(cpu):
     task_ptr_type = task_type.get_type().pointer()
 
     if utils.is_target_arch("x86"):
-         var_ptr = gdb.parse_and_eval("&current_task")
+         var_ptr = gdb.parse_and_eval("&pcpu_hot.current_task")
          return per_cpu(var_ptr, cpu).dereference()
     elif utils.is_target_arch("aarch64"):
          current_task_addr = gdb.parse_and_eval("$SP_EL0")
-- 
2.25.1

