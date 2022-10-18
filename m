Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FE9602B10
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 14:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbiJRMD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 08:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbiJRMCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 08:02:46 -0400
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D085BEAF0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 05:02:05 -0700 (PDT)
Received: by mail-pg1-f195.google.com with SMTP id 129so13106333pgc.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 05:02:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6NgxHUHmcB+8+FicHls6Uc9flxwUPewu/G78v6fq4ok=;
        b=x9ZfN5EnFBUMQrKZHyoN3AUeZXO45hvUj6B/Qo0CmstW88FKV7NHX5eJdcfSkMWjVR
         9E+iu1NfbHfmS7ihnVWxVQLwuOcsiyh8+ICvLNbAguT3v71NKB350fSJNKcJagpyxDVN
         Zgad6uUP/JwD//KqLXhd+FuDTZCTyQYczqVa0IYJ7X1/0hSFbXDUxYiUKzKx3gkX78WR
         9Xi4AQbTAan0Qfp5Vm5GQ7vtDMKdTHE2uqBDF1+sFksMJ1dPPZF1xYHF9eSm17sk3yWN
         zZOAFXdzFHf5TkbprB3vAec93qxsQ24Ras+RwQmmPaVPa6pf5a2Syl0S2DNaTZNHmz7g
         f/Hg==
X-Gm-Message-State: ACrzQf0Acc5871E8d5mgC9yZmrIBBsOTxTEwm4NzyNkJfPrVuEVpW8p1
        349zwuDsme2kH5ISkY4mvw==
X-Google-Smtp-Source: AMsMyM4RLpd428soF/UsWuvCNIkBQIztp19cpt1dIeWLev60b9OjlQ2522gIufrnPDpx4G1PhU6BZg==
X-Received: by 2002:a05:6a00:4093:b0:563:2d96:8f44 with SMTP id bw19-20020a056a00409300b005632d968f44mr2657668pfb.4.1666094524978;
        Tue, 18 Oct 2022 05:02:04 -0700 (PDT)
Received: from localhost.localdomain (ns1002484.ip-51-81-243.us. [51.81.243.185])
        by smtp.gmail.com with ESMTPSA id v18-20020a634812000000b0043b565cb57csm7893851pga.73.2022.10.18.05.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 05:02:04 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     rostedt@goodmis.org, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, kelulanainsley@gmail.com,
        sunliming <sunliming@kylinos.cn>
Subject: [PATCH 4/5] tracing: Delete timestamp_mode trace file
Date:   Tue, 18 Oct 2022 20:00:55 +0800
Message-Id: <20221018120056.1321426-5-sunliming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221018120056.1321426-1-sunliming@kylinos.cn>
References: <20221018120056.1321426-1-sunliming@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The timestamp_mode trace file is not necessary duo to the removing of
the absolute timestamp.

Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 Documentation/trace/ftrace.rst | 24 ------------------
 kernel/trace/trace.c           | 45 ----------------------------------
 2 files changed, 69 deletions(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 60bceb018d6a..9b4a4e9c1cbd 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -615,30 +615,6 @@ of ftrace. Here is a list of some of the key files:
 
 	See events.rst for more information.
 
-  timestamp_mode:
-
-	Certain tracers may change the timestamp mode used when
-	logging trace events into the event buffer.  Events with
-	different modes can coexist within a buffer but the mode in
-	effect when an event is logged determines which timestamp mode
-	is used for that event.  The default timestamp mode is
-	'delta'.
-
-	Usual timestamp modes for tracing:
-
-	  # cat timestamp_mode
-	  [delta] absolute
-
-	  The timestamp mode with the square brackets around it is the
-	  one in effect.
-
-	  delta: Default timestamp mode - timestamp is a delta against
-	         a per-buffer timestamp.
-
-	  absolute: The timestamp is a full timestamp, not a delta
-                 against some other value.  As such it takes up more
-                 space and is less efficient.
-
   hwlat_detector:
 
 	Directory for the Hardware Latency Detector.
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 47a44b055a1d..af8cbcad0bad 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5494,9 +5494,6 @@ static const char readme_msg[] =
 #ifdef CONFIG_X86_64
 	"     x86-tsc:   TSC cycle counter\n"
 #endif
-	"\n  timestamp_mode\t- view the mode used to timestamp events\n"
-	"       delta:   Delta difference against a buffer-wide timestamp\n"
-	"    absolute:   Absolute (standalone) timestamp\n"
 	"\n  trace_marker\t\t- Writes into this file writes into the kernel buffer\n"
 	"\n  trace_marker_raw\t\t- Writes into this file writes binary data into the kernel buffer\n"
 	"  tracing_cpumask\t- Limit which CPUs to trace\n"
@@ -7319,38 +7316,6 @@ static int tracing_clock_open(struct inode *inode, struct file *file)
 	return ret;
 }
 
-static int tracing_time_stamp_mode_show(struct seq_file *m, void *v)
-{
-	struct trace_array *tr = m->private;
-
-	mutex_lock(&trace_types_lock);
-
-	if (ring_buffer_time_stamp_abs(tr->array_buffer.buffer))
-		seq_puts(m, "delta [absolute]\n");
-	else
-		seq_puts(m, "[delta] absolute\n");
-
-	mutex_unlock(&trace_types_lock);
-
-	return 0;
-}
-
-static int tracing_time_stamp_mode_open(struct inode *inode, struct file *file)
-{
-	struct trace_array *tr = inode->i_private;
-	int ret;
-
-	ret = tracing_check_open_get_tr(tr);
-	if (ret)
-		return ret;
-
-	ret = single_open(file, tracing_time_stamp_mode_show, inode->i_private);
-	if (ret < 0)
-		trace_array_put(tr);
-
-	return ret;
-}
-
 u64 tracing_event_time_stamp(struct trace_buffer *buffer, struct ring_buffer_event *rbe)
 {
 	if (rbe == this_cpu_read(trace_buffered_event))
@@ -7643,13 +7608,6 @@ static const struct file_operations trace_clock_fops = {
 	.write		= tracing_clock_write,
 };
 
-static const struct file_operations trace_time_stamp_mode_fops = {
-	.open		= tracing_time_stamp_mode_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= tracing_single_release_tr,
-};
-
 #ifdef CONFIG_TRACER_SNAPSHOT
 static const struct file_operations snapshot_fops = {
 	.open		= tracing_snapshot_open,
@@ -9580,9 +9538,6 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 	trace_create_file("tracing_on", TRACE_MODE_WRITE, d_tracer,
 			  tr, &rb_simple_fops);
 
-	trace_create_file("timestamp_mode", TRACE_MODE_READ, d_tracer, tr,
-			  &trace_time_stamp_mode_fops);
-
 	tr->buffer_percent = 50;
 
 	trace_create_file("buffer_percent", TRACE_MODE_READ, d_tracer,
-- 
2.25.1

