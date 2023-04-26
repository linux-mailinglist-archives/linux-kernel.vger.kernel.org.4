Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A82E6EF920
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 19:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234837AbjDZRR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 13:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbjDZRRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 13:17:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8D955B1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 10:17:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 395F863153
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 17:17:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97BECC4339C;
        Wed, 26 Apr 2023 17:17:50 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1prim5-005KYD-1v;
        Wed, 26 Apr 2023 13:17:49 -0400
Message-ID: <20230426171749.416626191@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 26 Apr 2023 13:17:05 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: [for-next][PATCH 02/11] tracing/user_events: Set event filter_type from type
References: <20230426171703.202523909@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Beau Belgrave <beaub@linux.microsoft.com>

Users expect that events can be filtered by the kernel. User events
currently sets all event fields as FILTER_OTHER which limits to binary
filters only. When strings are being used, functionality is reduced.

Use filter_assign_type() to find the most appropriate filter
type for each field in user events to ensure full kernel capabilities.

Link: https://lkml.kernel.org/r/20230419214140.4158-2-beaub@linux.microsoft.com

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_user.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index cc8c6d8b69b5..eadb58a3efba 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -918,6 +918,9 @@ static int user_event_add_field(struct user_event *user, const char *type,
 	field->is_signed = is_signed;
 	field->filter_type = filter_type;
 
+	if (filter_type == FILTER_OTHER)
+		field->filter_type = filter_assign_type(type);
+
 	list_add(&field->link, &user->fields);
 
 	/*
-- 
2.39.2
