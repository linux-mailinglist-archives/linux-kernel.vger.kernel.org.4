Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB74E5EC8DA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbiI0QBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbiI0QBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:01:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D698D01C4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:01:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99F6961A8B
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 16:01:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5F1C433B5;
        Tue, 27 Sep 2022 16:01:32 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1odD2g-00G2og-1v;
        Tue, 27 Sep 2022 12:02:42 -0400
Message-ID: <20220927160242.207148054@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 27 Sep 2022 12:02:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        <mingo@redhat.com>, Zeng Heng <zengheng4@huawei.com>
Subject: [for-next][PATCH 03/20] rv/monitors: add static qualifier for local symbols
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

From: Zeng Heng <zengheng4@huawei.com>

The sparse tool complains as follows:

kernel/trace/rv/monitors/wwnr/wwnr.c:18:19:
warning: symbol 'rv_wwnr' was not declared. Should it be static?

The `rv_wwnr` symbol is not dereferenced by other extern files,
so add static qualifier for it.

So does wip module.

Link: https://lkml.kernel.org/r/20220824034357.2014202-2-zengheng4@huawei.com

Cc: <mingo@redhat.com>
Fixes:	ccc319dcb450 ("rv/monitor: Add the wwnr monitor")
Fixes:	8812d21219b9 ("rv/monitor: Add the wip monitor skeleton created by dot2k")
Signed-off-by: Zeng Heng <zengheng4@huawei.com>
Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/rv/monitors/wip/wip.c   | 4 ++--
 kernel/trace/rv/monitors/wwnr/wwnr.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/rv/monitors/wip/wip.c b/kernel/trace/rv/monitors/wip/wip.c
index 83cace53b9fa..1a989bc142f3 100644
--- a/kernel/trace/rv/monitors/wip/wip.c
+++ b/kernel/trace/rv/monitors/wip/wip.c
@@ -16,7 +16,7 @@
 
 #include "wip.h"
 
-struct rv_monitor rv_wip;
+static struct rv_monitor rv_wip;
 DECLARE_DA_MON_PER_CPU(wip, unsigned char);
 
 static void handle_preempt_disable(void *data, unsigned long ip, unsigned long parent_ip)
@@ -60,7 +60,7 @@ static void disable_wip(void)
 	da_monitor_destroy_wip();
 }
 
-struct rv_monitor rv_wip = {
+static struct rv_monitor rv_wip = {
 	.name = "wip",
 	.description = "wakeup in preemptive per-cpu testing monitor.",
 	.enable = enable_wip,
diff --git a/kernel/trace/rv/monitors/wwnr/wwnr.c b/kernel/trace/rv/monitors/wwnr/wwnr.c
index 599225d9cf38..a063b93c6a1d 100644
--- a/kernel/trace/rv/monitors/wwnr/wwnr.c
+++ b/kernel/trace/rv/monitors/wwnr/wwnr.c
@@ -15,7 +15,7 @@
 
 #include "wwnr.h"
 
-struct rv_monitor rv_wwnr;
+static struct rv_monitor rv_wwnr;
 DECLARE_DA_MON_PER_TASK(wwnr, unsigned char);
 
 static void handle_switch(void *data, bool preempt, struct task_struct *p,
@@ -59,7 +59,7 @@ static void disable_wwnr(void)
 	da_monitor_destroy_wwnr();
 }
 
-struct rv_monitor rv_wwnr = {
+static struct rv_monitor rv_wwnr = {
 	.name = "wwnr",
 	.description = "wakeup while not running per-task testing model.",
 	.enable = enable_wwnr,
-- 
2.35.1
