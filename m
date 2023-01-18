Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F28671BB3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 13:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjARMQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 07:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjARMQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 07:16:05 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7387B875B6;
        Wed, 18 Jan 2023 03:37:53 -0800 (PST)
Date:   Wed, 18 Jan 2023 11:37:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674041871;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oc6LSVj5uaQ9n8lKpp69By84LMttGwGUBFJoT+Qh+9E=;
        b=ednBWYIGF63iNsMBPIBAy4uHwxgbk+WciCKC7rsJ1izsVMnELa/RF0AKmQ3Z8CpqtbAa4a
        H+Z/VfZaMBnMPeqBEjUVZaW5ebwmZN3Oulh1UdJjGRvoFn1dWvzlY5dW2baOw7R0I+rAX3
        sy+ulgqkUus185nNjHUsaBfx9dFlA6eaR+K0pPqBYNzRPBApogBLw86maa/xPHCy22VKXJ
        en2Nt8PtRljcfQAlF2Cz5BAChilkDBIvSGT5s+LWDuPXtG6S7sZZveZliArl7WIiHocTOO
        IGNOocALMQjj7WrB5MyFl/a14TG90faIuTP7IN4ZYnD9Z1u+Ej93a0aYPP5Mbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674041871;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oc6LSVj5uaQ9n8lKpp69By84LMttGwGUBFJoT+Qh+9E=;
        b=xZDr/NjExB8Lle79hTpslsVVdyFPbfTfPU9oSCYwNRAuQPFDuA7wf2g7Ctu8Nt6gsh6Wv4
        JJlnHIOai25ZMVDQ==
From:   "tip-bot2 for Namhyung Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Do not pass header for sample ID init
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Song Liu <song@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230118060559.615653-7-namhyung@kernel.org>
References: <20230118060559.615653-7-namhyung@kernel.org>
MIME-Version: 1.0
Message-ID: <167404187141.4906.14797462329290153602.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     a7c8d0daa87581cab8435c83cc6ecbfbcb8b60cf
Gitweb:        https://git.kernel.org/tip/a7c8d0daa87581cab8435c83cc6ecbfbcb8b60cf
Author:        Namhyung Kim <namhyung@kernel.org>
AuthorDate:    Tue, 17 Jan 2023 22:05:57 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 18 Jan 2023 11:57:20 +01:00

perf/core: Do not pass header for sample ID init

The only thing it does for header in __perf_event_header__init_id() is
to update the header size with event->id_header_size.  We can do this
outside and get rid of the argument for the later change.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Song Liu <song@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230118060559.615653-7-namhyung@kernel.org
---
 kernel/events/core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7135cb9..47bfd99 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7054,14 +7054,12 @@ out_put:
 			     PERF_SAMPLE_ID | PERF_SAMPLE_STREAM_ID |	\
 			     PERF_SAMPLE_CPU | PERF_SAMPLE_IDENTIFIER)
 
-static void __perf_event_header__init_id(struct perf_event_header *header,
-					 struct perf_sample_data *data,
+static void __perf_event_header__init_id(struct perf_sample_data *data,
 					 struct perf_event *event,
 					 u64 sample_type)
 {
 	data->type = event->attr.sample_type;
 	data->sample_flags |= data->type & PERF_SAMPLE_ID_ALL;
-	header->size += event->id_header_size;
 
 	if (sample_type & PERF_SAMPLE_TID) {
 		/* namespace issues */
@@ -7088,8 +7086,10 @@ void perf_event_header__init_id(struct perf_event_header *header,
 				struct perf_sample_data *data,
 				struct perf_event *event)
 {
-	if (event->attr.sample_id_all)
-		__perf_event_header__init_id(header, data, event, event->attr.sample_type);
+	if (event->attr.sample_id_all) {
+		header->size += event->id_header_size;
+		__perf_event_header__init_id(data, event, event->attr.sample_type);
+	}
 }
 
 static void __perf_event__output_id_sample(struct perf_output_handle *handle,
@@ -7577,7 +7577,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 	u64 filtered_sample_type;
 
 	header->type = PERF_RECORD_SAMPLE;
-	header->size = sizeof(*header) + event->header_size;
+	header->size = sizeof(*header) + event->header_size + event->id_header_size;
 
 	header->misc = 0;
 	header->misc |= perf_misc_flags(regs);
@@ -7595,7 +7595,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 					   PERF_SAMPLE_REGS_USER);
 	filtered_sample_type &= ~data->sample_flags;
 
-	__perf_event_header__init_id(header, data, event, filtered_sample_type);
+	__perf_event_header__init_id(data, event, filtered_sample_type);
 
 	if (filtered_sample_type & PERF_SAMPLE_IP) {
 		data->ip = perf_instruction_pointer(regs);
