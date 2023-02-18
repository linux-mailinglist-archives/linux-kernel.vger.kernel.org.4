Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A207069B75B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 02:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjBRBNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 20:13:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjBRBNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 20:13:14 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F31498B9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 17:13:10 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id r6so2419179qtx.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 17:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=efficientek-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dm9Zb3YfJUlOc5PhgLLXoOZzDF1VUioxKTXdg6kCPS8=;
        b=VX0dxnS3bxQ8apKWjmSnM/Y6dyWI+rGYDi5wAoVU2mJhsewVL3DIyBTVrCxSYBgQfI
         r4wVzef4cr02shYJCptswyE5fupUFcz2egk2B8U1SnICC2PAYt5uajMdiQmfdR18LNq0
         adI1HQQZbJ8v+9Q+LoVg5AiPl4ZaHU4JGZo/uvTmDM+pMR1gkZh8/jC+tgeNUoe+OOGC
         jKFb2JdtSxKU1yHqtJkQk7l4ITxgy8qMG7v31PwJAbsipavfA6zjmYYHnS8bsrBZ1ass
         l/HigO1JHOQy1U65SAEcDdlnoE7G0AmW7OnlT1uXTZKKQKgVPV1N3X3BNZedanFdwGbM
         CT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dm9Zb3YfJUlOc5PhgLLXoOZzDF1VUioxKTXdg6kCPS8=;
        b=p/3s655yrX4dApAoiY6aJqAOEgmBSk0eQkhlFKmE+4jmsRpnnewpRRDtX0Vg/L3j2i
         TvNsYHz6vNJXzAHzfRoSHbDYYRTAcswPQUPyoUV+cBRRRkU9ymN7F9gRgrTHQBQt9LRE
         9qnX374AuHUbv6/7IKIWWwoCUAkcpLCIb6/y6RugKsUlctiWTGergvxO/YvWudwc7sA6
         hf9R73LUGarSPxfmIeE2esUoiB0DaTp0QSANdquCqCRVkQlcSo7Cv60uhmUxRT3UFZ93
         luO9+hdV7Z/6eFxpLcwPtzlOYhCT5yt5QJ4Cs5+ZOdNBbfKBcSM9IZjkwdTaO1yzqjpR
         JHBA==
X-Gm-Message-State: AO0yUKXskwG2meS5hvkCZDLDxeQzBMzJ8/VFtW9RSRnCoI9mM7rTB3C7
        40PkORXu+sDI0wwqaTmCtlUiDg==
X-Google-Smtp-Source: AK7set/1upC9hp7XAoWby4OPDeqwKKo0xpIttNos16E1kCy9BoGydPVWMxUes09blyIpoaDpBpbzig==
X-Received: by 2002:ac8:5952:0:b0:3b9:bd8d:bb22 with SMTP id 18-20020ac85952000000b003b9bd8dbb22mr12636719qtz.14.1676682789178;
        Fri, 17 Feb 2023 17:13:09 -0800 (PST)
Received: from localhost.localdomain ([37.218.244.251])
        by smtp.gmail.com with ESMTPSA id q13-20020a05620a024d00b006f9ddaaf01esm4268119qkn.102.2023.02.17.17.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 17:13:08 -0800 (PST)
From:   Glenn Washburn <development@efficientek.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Glenn Washburn <development@efficientek.com>,
        linux-um <linux-um@lists.infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Johannes Berg <johannes@sipsolutions.net>,
        Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Subject: [PATCH v2 2/2] scripts/gdb: Support getting current task struct in UML
Date:   Fri, 17 Feb 2023 19:11:54 -0600
Message-Id: <683d10e752cd4852ac62ef3cc3e9a6972a017bdf.1676532759.git.development@efficientek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1676532759.git.development@efficientek.com>
References: <cover.1676532759.git.development@efficientek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A running x86 UML kernel reports with architecture "i386:x86-64" as
it is a sub-architecture. However, a difference with bare-metal x86
kernels is in how it manages tasks and the current task struct. To
identify that the inferior is a UML kernel and not bare-metal, check
for the existence of the UML specific symbol "cpu_tasks" which
contains the current task struct.

Signed-off-by: Glenn Washburn <development@efficientek.com>
Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 scripts/gdb/linux/cpus.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/scripts/gdb/linux/cpus.py b/scripts/gdb/linux/cpus.py
index 3e02a1866751..4b4ce6464dee 100644
--- a/scripts/gdb/linux/cpus.py
+++ b/scripts/gdb/linux/cpus.py
@@ -163,8 +163,14 @@ def get_current_task(cpu):
     task_ptr_type = task_type.get_type().pointer()
 
     if utils.is_target_arch("x86"):
-        var_ptr = gdb.parse_and_eval("&current_task")
-        return per_cpu(var_ptr, cpu).dereference()
+        if gdb.lookup_global_symbol("cpu_tasks"):
+            # This is a UML kernel, which stores the current task
+            # differently than other x86 sub architectures
+            var_ptr = gdb.parse_and_eval("(struct task_struct *)cpu_tasks[0].task")
+            return var_ptr.dereference()
+        else:
+            var_ptr = gdb.parse_and_eval("&current_task")
+            return per_cpu(var_ptr, cpu).dereference()
     elif utils.is_target_arch("aarch64"):
         current_task_addr = gdb.parse_and_eval("$SP_EL0")
         if (current_task_addr >> 63) != 0:
-- 
2.30.2

