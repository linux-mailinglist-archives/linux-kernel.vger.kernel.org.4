Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9311968FDE5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 04:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbjBIDYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 22:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbjBIDYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 22:24:31 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA212712
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 19:24:28 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id rm7-20020a17090b3ec700b0022c05558d22so1003767pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 19:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YFDa6RzFjbYJQKnaADEQ469/RoyljuIaxBNPhmYoeo0=;
        b=Nn7SX3ixYjVrAo6eo2AYxJ79osyGC003C8QvKyqD4c079ZYifo5Hsbskj1nsoIiU6V
         CY1ePp2VQvoIQwN1a04RKC5y5RRz/xvI8xQgjFS1rh8Bi9Ggox3eOHqnuMy2r7ScjFrS
         2h6T9w5ltuHMESQlTQCbGuOVf9x2Kc5EbJhyIaqih396skv3yeqEsrS6rKwHIrE1yqBJ
         xv3qew1r3aPfx8zz8DKDC4o9u+Hu3epEz3VC3I26L4M5Fei8Qf66CS+YAIecOs3zJljX
         kT7T2rLsVm27XA/50qkOr+TuPkZ6BssD8g9bzj5DXyViTrE7csthf7kruq17KuqMQ32R
         BwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YFDa6RzFjbYJQKnaADEQ469/RoyljuIaxBNPhmYoeo0=;
        b=T8qRQY+gk7Lr8iewlaxc/f7j/u7SnpugLIqpS05tsyZqdVnBHB8v0vILYX6Rhf4EXh
         ooXoIoxF2xkzGPkEo01Yl2is7qicCRbbUaQpHa17bWkiDW5G9bNIYiTjJF2/dv1bpDj/
         Y5jVbQGLLjXNjuEm++0nmF51BC+zm3ZPj+93NdhldP0jeYXdP51bMG5hSq9CzYC28fje
         TzeaufjxdHXR00ENxbcALrSwbSh42ytoO6wFAnfdNO7ZcMaqAot3YK6aKeDgP9yHMCV1
         o8wVNX3FV49qr2N6C8pPeGMuUK9jS0KO9L+axQD0vpePZlhe0nf/DgmcGgvHnx3Wbgy/
         X4FA==
X-Gm-Message-State: AO0yUKVEZ0MuAYDC5KC4ufoFgLeFa0gj5UK5ORA1Nbkq3q20Ccjlve2M
        uRVLfNSuAmNyz7dNPmkanhU=
X-Google-Smtp-Source: AK7set/w65ft3z8q4/tgNHWVFMOSbMGckfkblII+ehcJ1tYMIssiV/23jVMzxd0SisfCwE8+LUMc4A==
X-Received: by 2002:a17:902:e807:b0:196:8d48:8760 with SMTP id u7-20020a170902e80700b001968d488760mr10677068plg.31.1675913067897;
        Wed, 08 Feb 2023 19:24:27 -0800 (PST)
Received: from localhost.localdomain ([112.20.108.204])
        by smtp.gmail.com with ESMTPSA id p5-20020a170902eac500b00192820d00d0sm216086pld.120.2023.02.08.19.24.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Feb 2023 19:24:27 -0800 (PST)
From:   chris.chenfeiyang@gmail.com
X-Google-Original-From: chenfeiyang@loongson.cn
To:     w@1wt.eu, paulmck@kernel.org
Cc:     Feiyang Chen <chenfeiyang@loongson.cn>, arnd@arndb.de,
        chenhuacai@kernel.org, jiaxun.yang@flygoat.com,
        chris.chenfeiyang@gmail.com, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] tools/nolibc: Include linux/fcntl.h and remove duplicate code
Date:   Thu,  9 Feb 2023 11:24:12 +0800
Message-Id: <cf503323a85a90dcc8040a1b07a6448b97cf6b5c.1675907639.git.chenfeiyang@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1675907639.git.chenfeiyang@loongson.cn>
References: <cover.1675907639.git.chenfeiyang@loongson.cn>
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

From: Feiyang Chen <chenfeiyang@loongson.cn>

Include linux/fcntl.h for O_* and AT_*. asm/fcntl.h is included
by linux/fcntl.h, so it can be safely removed.

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
---
 tools/include/nolibc/sys.h   | 2 +-
 tools/include/nolibc/types.h | 5 -----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index b5f8cd35c03b..c4818a9c8823 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -11,7 +11,6 @@
 #include "std.h"
 
 /* system includes */
-#include <asm/fcntl.h>   // for O_*
 #include <asm/unistd.h>
 #include <asm/signal.h>  // for SIGCHLD
 #include <asm/ioctls.h>
@@ -20,6 +19,7 @@
 #include <linux/loop.h>
 #include <linux/time.h>
 #include <linux/auxvec.h>
+#include <linux/fcntl.h> // for O_* and AT_*
 
 #include "arch.h"
 #include "errno.h"
diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index fbbc0e68c001..a3651c514e2f 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -60,11 +60,6 @@
 #define MAXPATHLEN     (PATH_MAX)
 #endif
 
-/* Special FD used by all the *at functions */
-#ifndef AT_FDCWD
-#define AT_FDCWD       (-100)
-#endif
-
 /* whence values for lseek() */
 #define SEEK_SET       0
 #define SEEK_CUR       1
-- 
2.39.0

