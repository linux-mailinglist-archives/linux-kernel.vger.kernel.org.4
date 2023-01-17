Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4C366D9A9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 10:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236391AbjAQJRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 04:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236561AbjAQJQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 04:16:56 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64667305D1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 01:11:22 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id z4-20020a17090a170400b00226d331390cso33507808pjd.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 01:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nwlc/zHfPMoeWz/D3fuMtC8w9MBFuYRkpHYLyLdZQ7A=;
        b=lU1i1BUrqv7UTW79S+LtO2HzhuPbZMBgUQ6Xu1WW89eMCALtY3vfyDeWmlM7eM9mYa
         crzDEVdJCPJrD5yajjVMYCGfuA2ZewZIQzTuKnGZBGGOySHB+bclCNu2YhdfucND07LD
         grmcq9X7GNNHSLFg5rn8aBfQzCIE5IoCw03h/jDJOugsYqzazvw0hjczGMmlqmvzOj4q
         V7WtCx5Matex0+ElMO4XLAMB0TYXVVIsxbtWZgfgvv+vAUhrTWVvrXPgp/ssljiSv+jH
         OvxY+lylwHw2WD2tnAirGZK3mqwJY7gu9e6+8b+jHD4QRDuC824+Zszd9PKmJG51tdT+
         AAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nwlc/zHfPMoeWz/D3fuMtC8w9MBFuYRkpHYLyLdZQ7A=;
        b=ygXMYkIvt8vHlDK+Q+AXpDSqhBOQuPdLl+vsQ2rRWC+TGaX+3qPOMu92SuUPH88wKB
         93C+C4f4NOO6NUsk2C+ahYB+rH+0BHjSW66X0IFWPgVU/4y0skikTsyQEmcj1vDDBTex
         Ofa7ilI63zx9PsTTXIEvSsIvz7tH5tiWGnaaQLT7FCY4e/31orPTP2uhA/0Z5pMe8Vwb
         PFErNLssSzzAQn9qfXPzUQeM7SwUMuZR6wgZtBng2ni5kDF0i4cnGyMkEt7CeR+sGYyt
         +Lnh03YV3XUPHp1s+XagkosC9l05Gn5lZf2QXE1ylPYpcpztdP9TJpg3W9cNk+5wtFNz
         zwog==
X-Gm-Message-State: AFqh2kqXMeZlyXLQIO0WD2/NSzkxOcjfM4dOXiwkKbDSUICmtvUSkQED
        D0t9/Vj/th2J3cuRjA+GTxPlemutr9pbpw==
X-Google-Smtp-Source: AMrXdXtQdQ23TXzqPiblINa+EFfqM4r0Es7QTTGq6yj75OCDWJBxZWI8IYcSFmm03WiJPQhRSif0EA==
X-Received: by 2002:a05:6a20:6f61:b0:b5:a231:107f with SMTP id gu33-20020a056a206f6100b000b5a231107fmr2184504pzb.12.1673946681919;
        Tue, 17 Jan 2023 01:11:21 -0800 (PST)
Received: from localhost.localdomain ([58.240.82.166])
        by smtp.gmail.com with ESMTPSA id j22-20020a63cf16000000b0047899d0d62csm17026274pgg.52.2023.01.17.01.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 01:11:21 -0800 (PST)
From:   Song Shuai <suagrfillet@gmail.com>
To:     peterz@infradead.org, jpoimboe@kernel.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Song Shuai <suagrfillet@gmail.com>
Subject: [PATCH] samples: ftrace: Pick a more reasonable function to trace
Date:   Tue, 17 Jan 2023 17:11:01 +0800
Message-Id: <20230117091101.3669996-1-suagrfillet@gmail.com>
X-Mailer: git-send-email 2.20.1
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

In ftrace-direct-multi*.c, the direct_caller - my_tramp works as
the mcount for functions with one parameter declared.

But schedule() actually has no parameter declared, so when it was
traced, the tracing function - my_direct_func will print a senseless
address.

Here replaces schedule() with kick_process() to make these samples
more reasonable and deletes the unnecessary including of mm.h.

Signed-off-by: Song Shuai <suagrfillet@gmail.com>
---
 samples/ftrace/ftrace-direct-multi-modify.c | 2 +-
 samples/ftrace/ftrace-direct-multi.c        | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/samples/ftrace/ftrace-direct-multi-modify.c b/samples/ftrace/ftrace-direct-multi-modify.c
index 63f92451f38b..ea8b6fef3032 100644
--- a/samples/ftrace/ftrace-direct-multi-modify.c
+++ b/samples/ftrace/ftrace-direct-multi-modify.c
@@ -176,7 +176,7 @@ static int __init ftrace_direct_multi_init(void)
 	int ret;
 
 	ftrace_set_filter_ip(&direct, (unsigned long) wake_up_process, 0, 0);
-	ftrace_set_filter_ip(&direct, (unsigned long) schedule, 0, 0);
+	ftrace_set_filter_ip(&direct, (unsigned long) kick_process, 0, 0);
 
 	ret = register_ftrace_direct_multi(&direct, my_tramp);
 
diff --git a/samples/ftrace/ftrace-direct-multi.c b/samples/ftrace/ftrace-direct-multi.c
index 08442d631b48..2b850c3593d5 100644
--- a/samples/ftrace/ftrace-direct-multi.c
+++ b/samples/ftrace/ftrace-direct-multi.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/module.h>
 
-#include <linux/mm.h> /* for handle_mm_fault() */
 #include <linux/ftrace.h>
 #include <linux/sched/stat.h>
 #include <asm/asm-offsets.h>
@@ -93,7 +92,7 @@ static struct ftrace_ops direct;
 static int __init ftrace_direct_multi_init(void)
 {
 	ftrace_set_filter_ip(&direct, (unsigned long) wake_up_process, 0, 0);
-	ftrace_set_filter_ip(&direct, (unsigned long) schedule, 0, 0);
+	ftrace_set_filter_ip(&direct, (unsigned long) kick_process, 0, 0);
 
 	return register_ftrace_direct_multi(&direct, (unsigned long) my_tramp);
 }
-- 
2.20.1

