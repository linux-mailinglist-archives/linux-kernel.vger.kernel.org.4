Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53FBC5EC8EA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbiI0QCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbiI0QBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:01:44 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0889B856
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:01:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0515ACE189A
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 16:01:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60485C433C1;
        Tue, 27 Sep 2022 16:01:39 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1odD2n-00G2vl-2h;
        Tue, 27 Sep 2022 12:02:49 -0400
Message-ID: <20220927160249.405813022@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 27 Sep 2022 12:02:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: [for-next][PATCH 15/20] rv/monitor: Add __init/__exit annotations to module init/exit funcs
References: <20220927160216.349640304@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiu Jianfeng <xiujianfeng@huawei.com>

Add missing __init/__exit annotations to module init/exit funcs.

Link: https://lkml.kernel.org/r/20220922103208.162869-1-xiujianfeng@huawei.com

Fixes: 24bce201d798 ("tools/rv: Add dot2k")
Fixes: 8812d21219b9 ("rv/monitor: Add the wip monitor skeleton created by dot2k")
Fixes: ccc319dcb450 ("rv/monitor: Add the wwnr monitor")
Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/rv/monitors/wip/wip.c                      | 4 ++--
 kernel/trace/rv/monitors/wwnr/wwnr.c                    | 4 ++--
 tools/verification/dot2/dot2k_templates/main_global.c   | 4 ++--
 tools/verification/dot2/dot2k_templates/main_per_cpu.c  | 4 ++--
 tools/verification/dot2/dot2k_templates/main_per_task.c | 4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/rv/monitors/wip/wip.c b/kernel/trace/rv/monitors/wip/wip.c
index 1a989bc142f3..b2b49a27e886 100644
--- a/kernel/trace/rv/monitors/wip/wip.c
+++ b/kernel/trace/rv/monitors/wip/wip.c
@@ -69,13 +69,13 @@ static struct rv_monitor rv_wip = {
 	.enabled = 0,
 };
 
-static int register_wip(void)
+static int __init register_wip(void)
 {
 	rv_register_monitor(&rv_wip);
 	return 0;
 }
 
-static void unregister_wip(void)
+static void __exit unregister_wip(void)
 {
 	rv_unregister_monitor(&rv_wip);
 }
diff --git a/kernel/trace/rv/monitors/wwnr/wwnr.c b/kernel/trace/rv/monitors/wwnr/wwnr.c
index a063b93c6a1d..0e43dd2db685 100644
--- a/kernel/trace/rv/monitors/wwnr/wwnr.c
+++ b/kernel/trace/rv/monitors/wwnr/wwnr.c
@@ -68,13 +68,13 @@ static struct rv_monitor rv_wwnr = {
 	.enabled = 0,
 };
 
-static int register_wwnr(void)
+static int __init register_wwnr(void)
 {
 	rv_register_monitor(&rv_wwnr);
 	return 0;
 }
 
-static void unregister_wwnr(void)
+static void __exit unregister_wwnr(void)
 {
 	rv_unregister_monitor(&rv_wwnr);
 }
diff --git a/tools/verification/dot2/dot2k_templates/main_global.c b/tools/verification/dot2/dot2k_templates/main_global.c
index dcd1162dced8..a5658bfb9044 100644
--- a/tools/verification/dot2/dot2k_templates/main_global.c
+++ b/tools/verification/dot2/dot2k_templates/main_global.c
@@ -72,13 +72,13 @@ static struct rv_monitor rv_MODEL_NAME = {
 	.enabled = 0,
 };
 
-static int register_MODEL_NAME(void)
+static int __init register_MODEL_NAME(void)
 {
 	rv_register_monitor(&rv_MODEL_NAME);
 	return 0;
 }
 
-static void unregister_MODEL_NAME(void)
+static void __exit unregister_MODEL_NAME(void)
 {
 	rv_unregister_monitor(&rv_MODEL_NAME);
 }
diff --git a/tools/verification/dot2/dot2k_templates/main_per_cpu.c b/tools/verification/dot2/dot2k_templates/main_per_cpu.c
index 8f877e86a22f..03539a97633f 100644
--- a/tools/verification/dot2/dot2k_templates/main_per_cpu.c
+++ b/tools/verification/dot2/dot2k_templates/main_per_cpu.c
@@ -72,13 +72,13 @@ static struct rv_monitor rv_MODEL_NAME = {
 	.enabled = 0,
 };
 
-static int register_MODEL_NAME(void)
+static int __init register_MODEL_NAME(void)
 {
 	rv_register_monitor(&rv_MODEL_NAME);
 	return 0;
 }
 
-static void unregister_MODEL_NAME(void)
+static void __exit unregister_MODEL_NAME(void)
 {
 	rv_unregister_monitor(&rv_MODEL_NAME);
 }
diff --git a/tools/verification/dot2/dot2k_templates/main_per_task.c b/tools/verification/dot2/dot2k_templates/main_per_task.c
index 8c2fdb824634..ffd92af87a86 100644
--- a/tools/verification/dot2/dot2k_templates/main_per_task.c
+++ b/tools/verification/dot2/dot2k_templates/main_per_task.c
@@ -72,13 +72,13 @@ static struct rv_monitor rv_MODEL_NAME = {
 	.enabled = 0,
 };
 
-static int register_MODEL_NAME(void)
+static int __init register_MODEL_NAME(void)
 {
 	rv_register_monitor(&rv_MODEL_NAME);
 	return 0;
 }
 
-static void unregister_MODEL_NAME(void)
+static void __exit unregister_MODEL_NAME(void)
 {
 	rv_unregister_monitor(&rv_MODEL_NAME);
 }
-- 
2.35.1
