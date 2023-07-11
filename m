Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2692574F132
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbjGKOH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbjGKOHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:07:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081B8BC;
        Tue, 11 Jul 2023 07:07:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4ABC861519;
        Tue, 11 Jul 2023 14:07:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5057C433C7;
        Tue, 11 Jul 2023 14:07:17 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qJE1M-0007nN-2Q;
        Tue, 11 Jul 2023 10:07:16 -0400
Message-ID: <20230711140716.561714719@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 11 Jul 2023 10:06:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org, Beau Belgrave <beaub@linux.microsoft.com>
Subject: [for-linus][PATCH 5/5] tracing/user_events: Fix struct arg size match check
References: <20230711140652.217008556@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Beau Belgrave <beaub@linux.microsoft.com>

When users register an event the name of the event and it's argument are
checked to ensure they match if the event already exists. Normally all
arguments are in the form of "type name", except for when the type
starts with "struct ". In those cases, the size of the struct is passed
in addition to the name, IE: "struct my_struct a 20" for an argument
that is of type "struct my_struct" with a field name of "a" and has the
size of 20 bytes.

The current code does not honor the above case properly when comparing
a match. This causes the event register to fail even when the same
string was used for events that contain a struct argument within them.
The example above "struct my_struct a 20" generates a match string of
"struct my_struct a" omitting the size field.

Add the struct size of the existing field when generating a comparison
string for a struct field to ensure proper match checking.

Link: https://lkml.kernel.org/r/20230629235049.581-2-beaub@linux.microsoft.com

Cc: stable@vger.kernel.org
Fixes: e6f89a149872 ("tracing/user_events: Ensure user provided strings are safely formatted")
Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_user.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index dbb14705d0d3..83c0536ff41c 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1223,6 +1223,9 @@ static int user_field_set_string(struct ftrace_event_field *field,
 	pos += snprintf(buf + pos, LEN_OR_ZERO, " ");
 	pos += snprintf(buf + pos, LEN_OR_ZERO, "%s", field->name);
 
+	if (str_has_prefix(field->type, "struct "))
+		pos += snprintf(buf + pos, LEN_OR_ZERO, " %d", field->size);
+
 	if (colon)
 		pos += snprintf(buf + pos, LEN_OR_ZERO, ";");
 
-- 
2.40.1
