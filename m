Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18AA864D5FC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 05:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiLOEyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 23:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiLOEyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 23:54:09 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2E6537ED;
        Wed, 14 Dec 2022 20:54:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D40B7CE1BCF;
        Thu, 15 Dec 2022 04:54:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F604C433EF;
        Thu, 15 Dec 2022 04:54:04 +0000 (UTC)
Date:   Wed, 14 Dec 2022 23:54:02 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linyu Yuan <quic_linyyuan@quicinc.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] trace: allocate space from temparary trace
 sequence buffer
Message-ID: <20221214235402.5ea7489e@gandalf.local.home>
In-Reply-To: <1671078807-20748-2-git-send-email-quic_linyyuan@quicinc.com>
References: <1671078807-20748-1-git-send-email-quic_linyyuan@quicinc.com>
        <1671078807-20748-2-git-send-email-quic_linyyuan@quicinc.com>
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

On Thu, 15 Dec 2022 12:33:27 +0800
Linyu Yuan <quic_linyyuan@quicinc.com> wrote:

> there is one dwc3 trace event declare as below,
> DECLARE_EVENT_CLASS(dwc3_log_event,
> 	TP_PROTO(u32 event, struct dwc3 *dwc),
> 	TP_ARGS(event, dwc),
> 	TP_STRUCT__entry(
> 		__field(u32, event)
> 		__field(u32, ep0state)
> 		__dynamic_array(char, str, DWC3_MSG_MAX)
> 	),
> 	TP_fast_assign(
> 		__entry->event = event;
> 		__entry->ep0state = dwc->ep0state;
> 	),
> 	TP_printk("event (%08x): %s", __entry->event,
> 			dwc3_decode_event(__get_str(str), DWC3_MSG_MAX,
> 				__entry->event, __entry->ep0state))
> );
> the problem is when trace function called, it will allocate up to
> DWC3_MSG_MAX bytes from trace event buffer, but never fill the buffer
> during fast assignment, it only fill the buffer when output function are
> called, so this means if output function are not called, the buffer will
> never used.
> 
> add __get_buf(len) which allocate space from iter->tmp_seq when trace
> output function called, it allow user write any data to allocatd space.
> 
> the mentioned dwc3 trace event will changed as below,
> DECLARE_EVENT_CLASS(dwc3_log_event,
> 	TP_PROTO(u32 event, struct dwc3 *dwc),
> 	TP_ARGS(event, dwc),
> 	TP_STRUCT__entry(
> 		__field(u32, event)
> 		__field(u32, ep0state)
> 	),
> 	TP_fast_assign(
> 		__entry->event = event;
> 		__entry->ep0state = dwc->ep0state;
> 	),
> 	TP_printk("event (%08x): %s", __entry->event,
> 		dwc3_decode_event(__get_buf(DWC3_MSG_MAX), DWC3_MSG_MAX,
> 				__entry->event, __entry->ep0state))
> );.
> 
> Signed-off-by: Linyu Yuan <quic_linyyuan@quicinc.com>


No!

Here, I did it for you:

-- Steve

diff --git a/drivers/usb/dwc3/debug.h b/drivers/usb/dwc3/debug.h
index 48b44b88dc25..81abdcbfc660 100644
--- a/drivers/usb/dwc3/debug.h
+++ b/drivers/usb/dwc3/debug.h
@@ -11,6 +11,7 @@
 #ifndef __DWC3_DEBUG_H
 #define __DWC3_DEBUG_H
 
+#include <linux/trace_seq.h>
 #include "core.h"
 
 /**
@@ -381,6 +382,19 @@ static inline const char *dwc3_decode_event(char *str, size_t size, u32 event,
 		return dwc3_ep_event_string(str, size, &evt.depevt, ep0state);
 }
 
+static inline const char *dwc3_decode_event_seq(struct trace_seq *p,
+						u32 event, u32 ep0state)
+{
+	char *str = trace_seq_buffer_ptr(p);
+	int size = seq_buf_buffer_left(&p->seq);
+
+	dwc3_decode_event(str, size, event, ep0state);
+
+	seq_buf_commit(&p->seq, strlen(str));
+
+	return str;
+}
+
 static inline const char *dwc3_ep_cmd_status_string(int status)
 {
 	switch (status) {
diff --git a/drivers/usb/dwc3/trace.h b/drivers/usb/dwc3/trace.h
index 1975aec8d36d..bee2589e85a8 100644
--- a/drivers/usb/dwc3/trace.h
+++ b/drivers/usb/dwc3/trace.h
@@ -54,15 +54,13 @@ DECLARE_EVENT_CLASS(dwc3_log_event,
 	TP_STRUCT__entry(
 		__field(u32, event)
 		__field(u32, ep0state)
-		__dynamic_array(char, str, DWC3_MSG_MAX)
 	),
 	TP_fast_assign(
 		__entry->event = event;
 		__entry->ep0state = dwc->ep0state;
 	),
 	TP_printk("event (%08x): %s", __entry->event,
-			dwc3_decode_event(__get_str(str), DWC3_MSG_MAX,
-					__entry->event, __entry->ep0state))
+			dwc3_decode_event_seq(p, __entry->event, __entry->ep0state))
 );
 
 DEFINE_EVENT(dwc3_log_event, dwc3_event,
