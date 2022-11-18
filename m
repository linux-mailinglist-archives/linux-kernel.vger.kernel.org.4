Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B51162FA0A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 17:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241571AbiKRQTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 11:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235084AbiKRQTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 11:19:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F766B3AF;
        Fri, 18 Nov 2022 08:19:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC555B8243D;
        Fri, 18 Nov 2022 16:19:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7428C433C1;
        Fri, 18 Nov 2022 16:19:41 +0000 (UTC)
Date:   Fri, 18 Nov 2022 11:19:40 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Rafael Mendonca <rafaelmendsr@gmail.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH] tracing/eprobe: Update cond flag before enabling
 trigger
Message-ID: <20221118111940.1268da2b@gandalf.local.home>
In-Reply-To: <Y3eJ8GiGnEvVd8/N@macondo>
References: <20221116192552.1066630-1-rafaelmendsr@gmail.com>
        <20221117211726.4bbbb96a@gandalf.local.home>
        <20221117213109.6119750e@gandalf.local.home>
        <Y3d9KcpcwrEUUYKT@macondo>
        <Y3eJ8GiGnEvVd8/N@macondo>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Nov 2022 10:34:40 -0300
Rafael Mendonca <rafaelmendsr@gmail.com> wrote:

> It did not trigger the NULL pointer issue to be more specific. When
> creating event probe for all events I was unable to create any event for
> the xhci-hcd system:
> 
> root@localhost:/sys/kernel/tracing# echo 'e xhci-hcd/xhci_add_endpoint' > dynamic_events 
> -bash: echo: write error: Invalid argument
> 
> Debugging the issue it seems that the problem is in the is_good_name()
> check, which returns false for "xhci-hcd". Should we sanitize it by

Ouch. I didn't realize that.

> converting '-' into '_'?

Actually, it's just the system name that's an issue. I tested this patch
and it appears to work.

-- Steve


diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 54ee5711c729..a16fb4c9642e 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1955,17 +1955,30 @@ static __always_inline void trace_iterator_reset(struct trace_iterator *iter)
 }
 
 /* Check the name is good for event/group/fields */
-static inline bool is_good_name(const char *name)
+static inline bool __is_good_name(const char *name, bool hash_ok)
 {
-	if (!isalpha(*name) && *name != '_')
+	if (!isalpha(*name) && *name != '_' && (!hash_ok || *name != '-'))
 		return false;
 	while (*++name != '\0') {
-		if (!isalpha(*name) && !isdigit(*name) && *name != '_')
+		if (!isalpha(*name) && !isdigit(*name) && *name != '_' &&
+		    (!hash_ok || *name != '-'))
 			return false;
 	}
 	return true;
 }
 
+/* Check the name is good for event/group/fields */
+static inline bool is_good_name(const char *name)
+{
+	return __is_good_name(name, false);
+}
+
+/* Check the name is good for system */
+static inline bool is_good_system_name(const char *name)
+{
+	return __is_good_name(name, true);
+}
+
 /* Convert certain expected symbols into '_' when generating event names */
 static inline void sanitize_event_name(char *name)
 {
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 36dff277de46..bb2f95d7175c 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -246,7 +246,7 @@ int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
 			return -EINVAL;
 		}
 		strlcpy(buf, event, slash - event + 1);
-		if (!is_good_name(buf)) {
+		if (!is_good_system_name(buf)) {
 			trace_probe_log_err(offset, BAD_GROUP_NAME);
 			return -EINVAL;
 		}
