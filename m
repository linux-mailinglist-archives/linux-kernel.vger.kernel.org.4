Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E65B6566DB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 03:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiL0CcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 21:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbiL0Cb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 21:31:26 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6617E63FD
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 18:30:55 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id hd14-20020a17090b458e00b0021909875bccso13577217pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 18:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yF/RCAm9t4WU+SnTtfg7uF5BF4LZjOgAhiX2hd2wX/4=;
        b=C5WwR3mhPyjHzEJ0/Os0JQZUyDAt+bGBvC9eFADQ71Q+XUC+XCk8/WSIsuTglj8avg
         uMGW9yTnWZBcZciNSfbpVGz+xlNdvOO4mVznq74+hWB8ojpaGv/fLMXhCU1FBPRsyeft
         bgjqWwwmOM81B4OXYyQIP6+DH0n1GUzE92HW0mcYKK+TOfp5f0b5/mumWMF3oxuq1r+n
         nqFh4SFmOVcCpv6cI7yPqlqiGM7s/xWtF5l0rrrpdyI/F37OX8xlrPb91O76Xou8mPP5
         +9dc7KE8w16lhOiGSEhNiU3Kb1/sri7le3egAwlWeJ+kURf988rlQe/XGs2BkydEcEfh
         bbqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yF/RCAm9t4WU+SnTtfg7uF5BF4LZjOgAhiX2hd2wX/4=;
        b=ejyA/sWIib8GjaLqBHHBv3zog+8Vv6/m5TxKxpjqZcW0+O5XtL2P6y5/UFx1XYqDNe
         TatUkyAldwJT4xmrX+u820GDfow2JlndmZtdfvkn9K9IyXNRkpfOKX0IuT6FVh2Ksx/L
         7r84OgBPSBWyeNOkMHjdIkkBa6Pcu0CFs/Q+OYECsuhqS9Yo3FfGXRizGA6w5ejV58Lo
         flXEqIYVlRSbxJibEWuHbv9zwvmuDDgQ016cQZnQ/LRDDUnXEszSjRbhfE9zIBnlSwwx
         JVUkyUaNt/UAvvDJiey7L/6ygyqW/J7q3g9ZIDxu3LUOwpguBT8yQyThnc7t5F1UWGqJ
         lgPg==
X-Gm-Message-State: AFqh2kqC87uQq0hkGZACNgrRjQx6DvPKwF1YUKrertIrKeqyGIH9Mz7U
        AxNUb0+w3w73asMbdcoCUravXSzifTg=
X-Google-Smtp-Source: AMrXdXvgQmP3uyZznsnUWQ/fd6HxAJzf5kbrRhwfgSN0+9qjPp2AuYlS6x+Qww3UXuvS0ATiXFPX6Q==
X-Received: by 2002:a17:90a:d910:b0:213:9bf5:6a10 with SMTP id c16-20020a17090ad91000b002139bf56a10mr36780839pjv.49.1672108254547;
        Mon, 26 Dec 2022 18:30:54 -0800 (PST)
Received: from localhost.localdomain ([47.242.114.172])
        by smtp.gmail.com with ESMTPSA id j9-20020a17090aeb0900b00218b32f6a9esm7072531pjz.18.2022.12.26.18.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 18:30:53 -0800 (PST)
From:   Chuang Wang <nashuiliang@gmail.com>
Cc:     Chuang Wang <nashuiliang@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tracing/osnoise: Use built-in RCU list checking
Date:   Tue, 27 Dec 2022 10:30:36 +0800
Message-Id: <20221227023036.784337-1-nashuiliang@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

list_for_each_entry_rcu() has built-in RCU and lock checking.

Pass cond argument to list_for_each_entry_rcu() to silence false lockdep
warning when CONFIG_PROVE_RCU_LIST is enabled.

Execute as follow:

 [tracing]# echo osnoise > current_tracer
 [tracing]# echo 1 > tracing_on
 [tracing]# echo 0 > tracing_on

The trace_types_lock is held when osnoise_tracer_stop() or
timerlat_tracer_stop() are called in the non-RCU read side section.
So, pass lockdep_is_held(&trace_types_lock) to silence false lockdep
warning.

Fixes: dae181349f1e ("tracing/osnoise: Support a list of trace_array *tr")
Signed-off-by: Chuang Wang <nashuiliang@gmail.com>
---
 kernel/trace/trace_osnoise.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 94c1b5eb1dc0..210e1f168392 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -147,9 +147,8 @@ static void osnoise_unregister_instance(struct trace_array *tr)
 	 * register/unregister serialization is provided by trace's
 	 * trace_types_lock.
 	 */
-	lockdep_assert_held(&trace_types_lock);
-
-	list_for_each_entry_rcu(inst, &osnoise_instances, list) {
+	list_for_each_entry_rcu(inst, &osnoise_instances, list,
+				lockdep_is_held(&trace_types_lock)) {
 		if (inst->tr == tr) {
 			list_del_rcu(&inst->list);
 			found = 1;
-- 
2.37.2

