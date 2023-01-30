Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E3B6818A4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 19:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237988AbjA3SUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 13:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237691AbjA3STs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 13:19:48 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167C22E0D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:19:45 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id d10so5466879ilc.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5wxgSxSbB5Zk2REp2cxLJz/oBwzWiBxlC3Q9YLCtBp0=;
        b=U7mVx7EzS1yrwU2P3yJCFPbOxhUhYMyue5ugqwlqBzMAWGhJp/ZcnJ5LAvCCjChwqy
         47CGNCJ6W2hhzUKfjuleCoW0qvFzcmy96ylKq+qjamUZs0sP8W+lWn949ru912sUju2v
         kb6hb0iu6cc++EFMCnCck8CjESUAvMzyqlZq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5wxgSxSbB5Zk2REp2cxLJz/oBwzWiBxlC3Q9YLCtBp0=;
        b=bjq8b0Rd0DHKJxjTzwnxqSnyuQOaVSVUWVQ5r9J5xvO5V2GU2LLYvDSkmFpUP1cOpx
         eUgsBkSP9A4DR8Cehpk1EYQLDj/3ZjNOSbggrEGNHOZm0YQ0bub2nzOBebOZbOJotbgO
         ya2cz7YDICU4AfspAM6wF32m0v0vcAUTl82ZvXsSHn/a6dox0dERDzp3zop/IglLYbay
         bao2ajIqezL6iPSuDW3Ww4Gc0S0YDWzus9XQgJQVTzPRPaM100/1ILJNnImLvYjGhy/P
         pJC5e/CEh49vTfGuN0POwmd7BSVKs1Ax6WAijLiirRedT5VX4ABB8uP1DWbZYLKWGBIh
         NFMA==
X-Gm-Message-State: AO0yUKUcGoNxzXZqGQi5FEY6bcx11TA3TggFF+9efBrOF5EAcvPUTxXF
        C1sW0DIDIzCm2754ml+rZ7QibwCmR+W+kbzj
X-Google-Smtp-Source: AK7set9OTHPr7LKtPzs3v501iP4cToy0c5RMq+2KAtzEJ4vKLeWYV/L2SKkPk0ThRJGdjrofBXwgTg==
X-Received: by 2002:a05:6e02:1c83:b0:310:e1f6:4a73 with SMTP id w3-20020a056e021c8300b00310e1f64a73mr7318629ill.24.1675102784653;
        Mon, 30 Jan 2023 10:19:44 -0800 (PST)
Received: from ravnica.bld.corp.google.com ([2620:15c:183:200:fc8a:dd2f:5914:df14])
        by smtp.gmail.com with ESMTPSA id o16-20020a056e02115000b002f139ba4135sm4189801ill.86.2023.01.30.10.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 10:19:44 -0800 (PST)
From:   Ross Zwisler <zwisler@chromium.org>
X-Google-Original-From: Ross Zwisler <zwisler@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ross Zwisler <zwisler@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-kernel@vger.kernel.org,
        Todd E Brandt <todd.e.brandt@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, linux-pm@vger.kernel.org
Subject: [PATCH 5/9] tools/power: use canonical ftrace path
Date:   Mon, 30 Jan 2023 11:19:11 -0700
Message-Id: <20230130181915.1113313-6-zwisler@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
In-Reply-To: <20230130181915.1113313-1-zwisler@google.com>
References: <20230130181915.1113313-1-zwisler@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The canonical location for the tracefs filesystem is at /sys/kernel/tracing.

But, from Documentation/trace/ftrace.rst:

  Before 4.1, all ftrace tracing control files were within the debugfs
  file system, which is typically located at /sys/kernel/debug/tracing.
  For backward compatibility, when mounting the debugfs file system,
  the tracefs file system will be automatically mounted at:

  /sys/kernel/debug/tracing

A few scripts in tools/power still refer to this older debugfs path, so
let's update them to avoid confusion.

Signed-off-by: Ross Zwisler <zwisler@google.com>
---
 tools/power/pm-graph/sleepgraph.py                     |  4 ++--
 tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py  |  4 ++--
 .../x86/intel_pstate_tracer/intel_pstate_tracer.py     | 10 +++++-----
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/power/pm-graph/sleepgraph.py b/tools/power/pm-graph/sleepgraph.py
index cfe343306e08..eddf8101ddf6 100755
--- a/tools/power/pm-graph/sleepgraph.py
+++ b/tools/power/pm-graph/sleepgraph.py
@@ -120,9 +120,9 @@ class SystemValues:
 	cgexp = False
 	testdir = ''
 	outdir = ''
-	tpath = '/sys/kernel/debug/tracing/'
+	tpath = '/sys/kernel/tracing/'
 	fpdtpath = '/sys/firmware/acpi/tables/FPDT'
-	epath = '/sys/kernel/debug/tracing/events/power/'
+	epath = '/sys/kernel/tracing/events/power/'
 	pmdpath = '/sys/power/pm_debug_messages'
 	s0ixpath = '/sys/module/intel_pmc_core/parameters/warn_on_s0ix_failures'
 	s0ixres = '/sys/devices/system/cpu/cpuidle/low_power_idle_system_residency_us'
diff --git a/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py b/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
index 2dea4032ac56..904df0ea0a1e 100755
--- a/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
+++ b/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
@@ -248,7 +248,7 @@ def signal_handler(signal, frame):
         ipt.free_trace_buffer()
         sys.exit(0)
 
-trace_file = "/sys/kernel/debug/tracing/events/amd_cpu/enable"
+trace_file = "/sys/kernel/tracing/events/amd_cpu/enable"
 signal.signal(signal.SIGINT, signal_handler)
 
 interval = ""
@@ -319,7 +319,7 @@ print(cur_version)
 cleanup_data_files()
 
 if interval:
-    file_name = "/sys/kernel/debug/tracing/trace"
+    file_name = "/sys/kernel/tracing/trace"
     ipt.clear_trace_file()
     ipt.set_trace_buffer_size(memory)
     ipt.enable_trace(trace_file)
diff --git a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
index b46e9eb8f5aa..ec3323100e1a 100755
--- a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
+++ b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
@@ -373,7 +373,7 @@ def clear_trace_file():
     """ Clear trace file """
 
     try:
-        f_handle = open('/sys/kernel/debug/tracing/trace', 'w')
+        f_handle = open('/sys/kernel/tracing/trace', 'w')
         f_handle.close()
     except:
         print('IO error clearing trace file ')
@@ -401,7 +401,7 @@ def set_trace_buffer_size(memory):
     """ Set trace buffer size """
 
     try:
-       with open('/sys/kernel/debug/tracing/buffer_size_kb', 'w') as fp:
+       with open('/sys/kernel/tracing/buffer_size_kb', 'w') as fp:
           fp.write(memory)
     except:
        print('IO error setting trace buffer size ')
@@ -411,7 +411,7 @@ def free_trace_buffer():
     """ Free the trace buffer memory """
 
     try:
-       open('/sys/kernel/debug/tracing/buffer_size_kb'
+       open('/sys/kernel/tracing/buffer_size_kb'
                  , 'w').write("1")
     except:
         print('IO error freeing trace buffer ')
@@ -495,7 +495,7 @@ def signal_handler(signal, frame):
         sys.exit(0)
 
 if __name__ == "__main__":
-    trace_file = "/sys/kernel/debug/tracing/events/power/pstate_sample/enable"
+    trace_file = "/sys/kernel/tracing/events/power/pstate_sample/enable"
     signal.signal(signal.SIGINT, signal_handler)
 
     interval = ""
@@ -569,7 +569,7 @@ if __name__ == "__main__":
     cleanup_data_files()
 
     if interval:
-        filename = "/sys/kernel/debug/tracing/trace"
+        filename = "/sys/kernel/tracing/trace"
         clear_trace_file()
         set_trace_buffer_size(memory)
         enable_trace(trace_file)
-- 
2.39.1.456.gfc5497dd1b-goog

