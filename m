Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A44869B26E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 19:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjBQSjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 13:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBQSjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 13:39:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B391A5C0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 10:39:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B7C0B82D54
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 18:39:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09FBC4339C;
        Fri, 17 Feb 2023 18:39:38 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pT5dx-000snf-2q;
        Fri, 17 Feb 2023 13:39:37 -0500
Message-ID: <20230217183937.692994896@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 17 Feb 2023 13:39:13 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jianlin Lv <iecedge@gmail.com>
Subject: [for-next][PATCH 2/3] tracepoint: Allow livepatch module add trace event
References: <20230217183911.775065402@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jianlin Lv <iecedge@gmail.com>

In the case of keeping the system running, the preferred method for
tracing the kernel is dynamic tracing (kprobe), but the drawback of
this method is that events are lost, especially when tracing packages
in the network stack.

Livepatching provides a potential solution, which is to reimplement the
function you want to replace and insert a static tracepoint.
In such a way, custom stable static tracepoints can be expanded without
rebooting the system.

Link: https://lkml.kernel.org/r/20221102160236.11696-1-iecedge@gmail.com

Signed-off-by: Jianlin Lv <iecedge@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/tracepoint.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index f23144af5743..8d1507dd0724 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -571,8 +571,8 @@ static void for_each_tracepoint_range(
 bool trace_module_has_bad_taint(struct module *mod)
 {
 	return mod->taints & ~((1 << TAINT_OOT_MODULE) | (1 << TAINT_CRAP) |
-			       (1 << TAINT_UNSIGNED_MODULE) |
-			       (1 << TAINT_TEST));
+				(1 << TAINT_UNSIGNED_MODULE) | (1 << TAINT_TEST) |
+				(1 << TAINT_LIVEPATCH));
 }
 
 static BLOCKING_NOTIFIER_HEAD(tracepoint_notify_list);
-- 
2.39.1
