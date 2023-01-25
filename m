Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29A067BE9B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 22:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236031AbjAYVdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 16:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235303AbjAYVdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 16:33:36 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28605FFB
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 13:33:10 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id 203so9041090iou.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 13:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b1I6Hg4nYrP1/rcU3F2JphiqW/FCnBFjNqh7XhQYD4Q=;
        b=TQlV428v+81xT11mDlqR+6Qy2eSE/Ugz+njVEdEmsboUctSe79sNCCrFt9zF38rPQM
         wTKfOD5VI0Jhjt90pKHUOoBhQpbQBomG58aPmbLbuN7fuQ79PtWUCMN5mQBqeqlLCihx
         BAciwksuIDKRRZqhobxL3ujc3x/8I83UvkzJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b1I6Hg4nYrP1/rcU3F2JphiqW/FCnBFjNqh7XhQYD4Q=;
        b=fo0HmLkDiRTHUleLCJotIpkGefJPd1uwwcLuHGTQZUph/qiRtrH8E6lS3e45j25DY+
         CVpEf8mhWYA2zYlXylZXdSj/lxS//t5qCVdMRZcxMAqB1kl0G26pswwyn6gvTSpfZjNm
         hRCDvorURx9BOdCeSkCCpDZsoSi+ojDLxE36hrxcoxnmp4g2CJJPDoBaSyZeEftR9bHw
         9pYhGCNt8RcX9lGxffUm/yt+VtncDGUREnvzeS+XN5i+V9KAbtG3Nn5dYKTpq2E2WkKh
         GBUErlFIflmYieoAebuICxDTTlazcH8Wp8+QuOUNjkqmjXCDUp0k5S+al/6K5XyCoRU2
         DNPA==
X-Gm-Message-State: AFqh2kr7qNcFI5Hd2AO2FgIu44iItw3NieklRlmN9KuYd+RV+owlmTfd
        LzPrEhkrI4j52H/NiypfNYQQYg==
X-Google-Smtp-Source: AMrXdXvz2Hr9piZWfnnh6Xr+pXVMP4mwwb/8b41xBVAykBK5tZZ8Lu3erDtHbXTGH5tXC//Qla0cfA==
X-Received: by 2002:a5d:9c8a:0:b0:704:5940:203e with SMTP id p10-20020a5d9c8a000000b007045940203emr19907280iop.7.1674682389098;
        Wed, 25 Jan 2023 13:33:09 -0800 (PST)
Received: from ravnica.bld.corp.google.com ([2620:15c:183:200:5b71:b8f:889c:515e])
        by smtp.gmail.com with ESMTPSA id f3-20020a02cac3000000b0039decb5b452sm2000025jap.65.2023.01.25.13.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 13:33:08 -0800 (PST)
From:   Ross Zwisler <zwisler@chromium.org>
X-Google-Original-From: Ross Zwisler <zwisler@google.com>
To:     Linux Trace Devel <linux-trace-devel@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Ross Zwisler <zwisler@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH] docs: ftrace: always use canonical ftrace path
Date:   Wed, 25 Jan 2023 14:32:51 -0700
Message-Id: <20230125213251.2013791-1-zwisler@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Many parts of Documentation still reference this older debugfs path, so
let's update them to avoid confusion.

Signed-off-by: Ross Zwisler <zwisler@google.com>
---
 .../admin-guide/kernel-parameters.txt         |   4 +-
 .../admin-guide/kernel-per-CPU-kthreads.rst   |   2 +-
 Documentation/admin-guide/pm/intel_pstate.rst |   4 +-
 Documentation/core-api/workqueue.rst          |   4 +-
 Documentation/hid/intel-ish-hid.rst           |   4 +-
 .../device_drivers/ethernet/mellanox/mlx5.rst |  92 ++++-----
 Documentation/sound/hd-audio/notes.rst        |   6 +-
 Documentation/trace/events-msr.rst            |   4 +-
 Documentation/trace/events-nmi.rst            |   6 +-
 Documentation/trace/events.rst                |  74 +++----
 Documentation/trace/ftrace.rst                |   6 +-
 Documentation/trace/histogram-design.rst      |  12 +-
 Documentation/trace/histogram.rst             | 190 +++++++++---------
 Documentation/trace/kprobetrace.rst           |  26 +--
 Documentation/trace/mmiotrace.rst             |  20 +-
 .../trace-pagealloc-postprocess.pl            |   4 +-
 .../postprocess/trace-vmscan-postprocess.pl   |   4 +-
 Documentation/trace/tracepoint-analysis.rst   |   8 +-
 Documentation/trace/uprobetracer.rst          |  22 +-
 Documentation/trace/user_events.rst           |  18 +-
 .../translations/zh_CN/core-api/workqueue.rst |   4 +-
 Documentation/x86/resctrl.rst                 |  18 +-
 22 files changed, 266 insertions(+), 266 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 42af9ca0127e..690486ac6dc7 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6247,7 +6247,7 @@
 			that can be enabled or disabled just as if you were
 			to echo the option name into
 
-			    /sys/kernel/debug/tracing/trace_options
+			    /sys/kernel/tracing/trace_options
 
 			For example, to enable stacktrace option (to dump the
 			stack trace of each event), add to the command line:
@@ -6261,7 +6261,7 @@
 			[FTRACE] enable this option to disable tracing when a
 			warning is hit. This turns off "tracing_on". Tracing can
 			be enabled again by echoing '1' into the "tracing_on"
-			file located in /sys/kernel/debug/tracing/
+			file located in /sys/kernel/tracing/
 
 			This option is useful, as it disables the trace before
 			the WARNING dump is called, which prevents the trace to
diff --git a/Documentation/admin-guide/kernel-per-CPU-kthreads.rst b/Documentation/admin-guide/kernel-per-CPU-kthreads.rst
index e4a5fc26f1a9..993c2a05f5ee 100644
--- a/Documentation/admin-guide/kernel-per-CPU-kthreads.rst
+++ b/Documentation/admin-guide/kernel-per-CPU-kthreads.rst
@@ -25,7 +25,7 @@ References
 
 -	In order to locate kernel-generated OS jitter on CPU N:
 
-		cd /sys/kernel/debug/tracing
+		cd /sys/kernel/tracing
 		echo 1 > max_graph_depth # Increase the "1" for more detail
 		echo function_graph > current_tracer
 		# run workload
diff --git a/Documentation/admin-guide/pm/intel_pstate.rst b/Documentation/admin-guide/pm/intel_pstate.rst
index d5043cd8d2f5..bf13ad25a32f 100644
--- a/Documentation/admin-guide/pm/intel_pstate.rst
+++ b/Documentation/admin-guide/pm/intel_pstate.rst
@@ -712,7 +712,7 @@ it works in the `active mode <Active Mode_>`_.
 The following sequence of shell commands can be used to enable them and see
 their output (if the kernel is generally configured to support event tracing)::
 
- # cd /sys/kernel/debug/tracing/
+ # cd /sys/kernel/tracing/
  # echo 1 > events/power/pstate_sample/enable
  # echo 1 > events/power/cpu_frequency/enable
  # cat trace
@@ -732,7 +732,7 @@ The ``ftrace`` interface can be used for low-level diagnostics of
 P-state is called, the ``ftrace`` filter can be set to
 :c:func:`intel_pstate_set_pstate`::
 
- # cd /sys/kernel/debug/tracing/
+ # cd /sys/kernel/tracing/
  # cat available_filter_functions | grep -i pstate
  intel_pstate_set_pstate
  intel_pstate_cpu_init
diff --git a/Documentation/core-api/workqueue.rst b/Documentation/core-api/workqueue.rst
index 3b22ed137662..8ec4d6270b24 100644
--- a/Documentation/core-api/workqueue.rst
+++ b/Documentation/core-api/workqueue.rst
@@ -370,8 +370,8 @@ of possible problems:
 
 The first one can be tracked using tracing: ::
 
-	$ echo workqueue:workqueue_queue_work > /sys/kernel/debug/tracing/set_event
-	$ cat /sys/kernel/debug/tracing/trace_pipe > out.txt
+	$ echo workqueue:workqueue_queue_work > /sys/kernel/tracing/set_event
+	$ cat /sys/kernel/tracing/trace_pipe > out.txt
 	(wait a few secs)
 	^C
 
diff --git a/Documentation/hid/intel-ish-hid.rst b/Documentation/hid/intel-ish-hid.rst
index 7a851252267a..53763a2e74ba 100644
--- a/Documentation/hid/intel-ish-hid.rst
+++ b/Documentation/hid/intel-ish-hid.rst
@@ -344,8 +344,8 @@ Documentation/ABI/testing/sysfs-bus-iio for IIO ABIs to user space.
 
 To debug ISH, event tracing mechanism is used. To enable debug logs::
 
-  echo 1 > /sys/kernel/debug/tracing/events/intel_ish/enable
-  cat /sys/kernel/debug/tracing/trace
+  echo 1 > /sys/kernel/tracing/events/intel_ish/enable
+  cat /sys/kernel/tracing/trace
 
 3.8 ISH IIO sysfs Example on Lenovo thinkpad Yoga 260
 -----------------------------------------------------
diff --git a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5.rst b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5.rst
index 5edf50d7dbd5..ae5d39f7fa3b 100644
--- a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5.rst
+++ b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5.rst
@@ -564,42 +564,42 @@ mlx5 tracepoints
 mlx5 driver provides internal trace points for tracking and debugging using
 kernel tracepoints interfaces (refer to Documentation/trace/ftrace.rst).
 
-For the list of support mlx5 events check /sys/kernel/debug/tracing/events/mlx5/
+For the list of support mlx5 events check /sys/kernel/tracing/events/mlx5/
 
 tc and eswitch offloads tracepoints:
 
 - mlx5e_configure_flower: trace flower filter actions and cookies offloaded to mlx5::
 
-    $ echo mlx5:mlx5e_configure_flower >> /sys/kernel/debug/tracing/set_event
-    $ cat /sys/kernel/debug/tracing/trace
+    $ echo mlx5:mlx5e_configure_flower >> /sys/kernel/tracing/set_event
+    $ cat /sys/kernel/tracing/trace
     ...
     tc-6535  [019] ...1  2672.404466: mlx5e_configure_flower: cookie=0000000067874a55 actions= REDIRECT
 
 - mlx5e_delete_flower: trace flower filter actions and cookies deleted from mlx5::
 
-    $ echo mlx5:mlx5e_delete_flower >> /sys/kernel/debug/tracing/set_event
-    $ cat /sys/kernel/debug/tracing/trace
+    $ echo mlx5:mlx5e_delete_flower >> /sys/kernel/tracing/set_event
+    $ cat /sys/kernel/tracing/trace
     ...
     tc-6569  [010] .N.1  2686.379075: mlx5e_delete_flower: cookie=0000000067874a55 actions= NULL
 
 - mlx5e_stats_flower: trace flower stats request::
 
-    $ echo mlx5:mlx5e_stats_flower >> /sys/kernel/debug/tracing/set_event
-    $ cat /sys/kernel/debug/tracing/trace
+    $ echo mlx5:mlx5e_stats_flower >> /sys/kernel/tracing/set_event
+    $ cat /sys/kernel/tracing/trace
     ...
     tc-6546  [010] ...1  2679.704889: mlx5e_stats_flower: cookie=0000000060eb3d6a bytes=0 packets=0 lastused=4295560217
 
 - mlx5e_tc_update_neigh_used_value: trace tunnel rule neigh update value offloaded to mlx5::
 
-    $ echo mlx5:mlx5e_tc_update_neigh_used_value >> /sys/kernel/debug/tracing/set_event
-    $ cat /sys/kernel/debug/tracing/trace
+    $ echo mlx5:mlx5e_tc_update_neigh_used_value >> /sys/kernel/tracing/set_event
+    $ cat /sys/kernel/tracing/trace
     ...
     kworker/u48:4-8806  [009] ...1 55117.882428: mlx5e_tc_update_neigh_used_value: netdev: ens1f0 IPv4: 1.1.1.10 IPv6: ::ffff:1.1.1.10 neigh_used=1
 
 - mlx5e_rep_neigh_update: trace neigh update tasks scheduled due to neigh state change events::
 
-    $ echo mlx5:mlx5e_rep_neigh_update >> /sys/kernel/debug/tracing/set_event
-    $ cat /sys/kernel/debug/tracing/trace
+    $ echo mlx5:mlx5e_rep_neigh_update >> /sys/kernel/tracing/set_event
+    $ cat /sys/kernel/tracing/trace
     ...
     kworker/u48:7-2221  [009] ...1  1475.387435: mlx5e_rep_neigh_update: netdev: ens1f0 MAC: 24:8a:07:9a:17:9a IPv4: 1.1.1.10 IPv6: ::ffff:1.1.1.10 neigh_connected=1
 
@@ -608,14 +608,14 @@ Bridge offloads tracepoints:
 - mlx5_esw_bridge_fdb_entry_init: trace bridge FDB entry offloaded to mlx5::
 
     $ echo mlx5:mlx5_esw_bridge_fdb_entry_init >> set_event
-    $ cat /sys/kernel/debug/tracing/trace
+    $ cat /sys/kernel/tracing/trace
     ...
     kworker/u20:9-2217    [003] ...1   318.582243: mlx5_esw_bridge_fdb_entry_init: net_device=enp8s0f0_0 addr=e4:fd:05:08:00:02 vid=0 flags=0 used=0
 
 - mlx5_esw_bridge_fdb_entry_cleanup: trace bridge FDB entry deleted from mlx5::
 
     $ echo mlx5:mlx5_esw_bridge_fdb_entry_cleanup >> set_event
-    $ cat /sys/kernel/debug/tracing/trace
+    $ cat /sys/kernel/tracing/trace
     ...
     ip-2581    [005] ...1   318.629871: mlx5_esw_bridge_fdb_entry_cleanup: net_device=enp8s0f0_1 addr=e4:fd:05:08:00:03 vid=0 flags=0 used=16
 
@@ -623,7 +623,7 @@ Bridge offloads tracepoints:
   mlx5::
 
     $ echo mlx5:mlx5_esw_bridge_fdb_entry_refresh >> set_event
-    $ cat /sys/kernel/debug/tracing/trace
+    $ cat /sys/kernel/tracing/trace
     ...
     kworker/u20:8-3849    [003] ...1       466716: mlx5_esw_bridge_fdb_entry_refresh: net_device=enp8s0f0_0 addr=e4:fd:05:08:00:02 vid=3 flags=0 used=0
 
@@ -631,7 +631,7 @@ Bridge offloads tracepoints:
   representor::
 
     $ echo mlx5:mlx5_esw_bridge_vlan_create >> set_event
-    $ cat /sys/kernel/debug/tracing/trace
+    $ cat /sys/kernel/tracing/trace
     ...
     ip-2560    [007] ...1   318.460258: mlx5_esw_bridge_vlan_create: vid=1 flags=6
 
@@ -639,7 +639,7 @@ Bridge offloads tracepoints:
   representor::
 
     $ echo mlx5:mlx5_esw_bridge_vlan_cleanup >> set_event
-    $ cat /sys/kernel/debug/tracing/trace
+    $ cat /sys/kernel/tracing/trace
     ...
     bridge-2582    [007] ...1   318.653496: mlx5_esw_bridge_vlan_cleanup: vid=2 flags=8
 
@@ -647,7 +647,7 @@ Bridge offloads tracepoints:
   device::
 
     $ echo mlx5:mlx5_esw_bridge_vport_init >> set_event
-    $ cat /sys/kernel/debug/tracing/trace
+    $ cat /sys/kernel/tracing/trace
     ...
     ip-2560    [007] ...1   318.458915: mlx5_esw_bridge_vport_init: vport_num=1
 
@@ -655,7 +655,7 @@ Bridge offloads tracepoints:
   device::
 
     $ echo mlx5:mlx5_esw_bridge_vport_cleanup >> set_event
-    $ cat /sys/kernel/debug/tracing/trace
+    $ cat /sys/kernel/tracing/trace
     ...
     ip-5387    [000] ...1       573713: mlx5_esw_bridge_vport_cleanup: vport_num=1
 
@@ -663,43 +663,43 @@ Eswitch QoS tracepoints:
 
 - mlx5_esw_vport_qos_create: trace creation of transmit scheduler arbiter for vport::
 
-    $ echo mlx5:mlx5_esw_vport_qos_create >> /sys/kernel/debug/tracing/set_event
-    $ cat /sys/kernel/debug/tracing/trace
+    $ echo mlx5:mlx5_esw_vport_qos_create >> /sys/kernel/tracing/set_event
+    $ cat /sys/kernel/tracing/trace
     ...
     <...>-23496   [018] .... 73136.838831: mlx5_esw_vport_qos_create: (0000:82:00.0) vport=2 tsar_ix=4 bw_share=0, max_rate=0 group=000000007b576bb3
 
 - mlx5_esw_vport_qos_config: trace configuration of transmit scheduler arbiter for vport::
 
-    $ echo mlx5:mlx5_esw_vport_qos_config >> /sys/kernel/debug/tracing/set_event
-    $ cat /sys/kernel/debug/tracing/trace
+    $ echo mlx5:mlx5_esw_vport_qos_config >> /sys/kernel/tracing/set_event
+    $ cat /sys/kernel/tracing/trace
     ...
     <...>-26548   [023] .... 75754.223823: mlx5_esw_vport_qos_config: (0000:82:00.0) vport=1 tsar_ix=3 bw_share=34, max_rate=10000 group=000000007b576bb3
 
 - mlx5_esw_vport_qos_destroy: trace deletion of transmit scheduler arbiter for vport::
 
-    $ echo mlx5:mlx5_esw_vport_qos_destroy >> /sys/kernel/debug/tracing/set_event
-    $ cat /sys/kernel/debug/tracing/trace
+    $ echo mlx5:mlx5_esw_vport_qos_destroy >> /sys/kernel/tracing/set_event
+    $ cat /sys/kernel/tracing/trace
     ...
     <...>-27418   [004] .... 76546.680901: mlx5_esw_vport_qos_destroy: (0000:82:00.0) vport=1 tsar_ix=3
 
 - mlx5_esw_group_qos_create: trace creation of transmit scheduler arbiter for rate group::
 
-    $ echo mlx5:mlx5_esw_group_qos_create >> /sys/kernel/debug/tracing/set_event
-    $ cat /sys/kernel/debug/tracing/trace
+    $ echo mlx5:mlx5_esw_group_qos_create >> /sys/kernel/tracing/set_event
+    $ cat /sys/kernel/tracing/trace
     ...
     <...>-26578   [008] .... 75776.022112: mlx5_esw_group_qos_create: (0000:82:00.0) group=000000008dac63ea tsar_ix=5
 
 - mlx5_esw_group_qos_config: trace configuration of transmit scheduler arbiter for rate group::
 
-    $ echo mlx5:mlx5_esw_group_qos_config >> /sys/kernel/debug/tracing/set_event
-    $ cat /sys/kernel/debug/tracing/trace
+    $ echo mlx5:mlx5_esw_group_qos_config >> /sys/kernel/tracing/set_event
+    $ cat /sys/kernel/tracing/trace
     ...
     <...>-27303   [020] .... 76461.455356: mlx5_esw_group_qos_config: (0000:82:00.0) group=000000008dac63ea tsar_ix=5 bw_share=100 max_rate=20000
 
 - mlx5_esw_group_qos_destroy: trace deletion of transmit scheduler arbiter for group::
 
-    $ echo mlx5:mlx5_esw_group_qos_destroy >> /sys/kernel/debug/tracing/set_event
-    $ cat /sys/kernel/debug/tracing/trace
+    $ echo mlx5:mlx5_esw_group_qos_destroy >> /sys/kernel/tracing/set_event
+    $ cat /sys/kernel/tracing/trace
     ...
     <...>-27418   [006] .... 76547.187258: mlx5_esw_group_qos_destroy: (0000:82:00.0) group=000000007b576bb3 tsar_ix=1
 
@@ -707,56 +707,56 @@ SF tracepoints:
 
 - mlx5_sf_add: trace addition of the SF port::
 
-    $ echo mlx5:mlx5_sf_add >> /sys/kernel/debug/tracing/set_event
-    $ cat /sys/kernel/debug/tracing/trace
+    $ echo mlx5:mlx5_sf_add >> /sys/kernel/tracing/set_event
+    $ cat /sys/kernel/tracing/trace
     ...
     devlink-9363    [031] ..... 24610.188722: mlx5_sf_add: (0000:06:00.0) port_index=32768 controller=0 hw_id=0x8000 sfnum=88
 
 - mlx5_sf_free: trace freeing of the SF port::
 
-    $ echo mlx5:mlx5_sf_free >> /sys/kernel/debug/tracing/set_event
-    $ cat /sys/kernel/debug/tracing/trace
+    $ echo mlx5:mlx5_sf_free >> /sys/kernel/tracing/set_event
+    $ cat /sys/kernel/tracing/trace
     ...
     devlink-9830    [038] ..... 26300.404749: mlx5_sf_free: (0000:06:00.0) port_index=32768 controller=0 hw_id=0x8000
 
 - mlx5_sf_hwc_alloc: trace allocating of the hardware SF context::
 
-    $ echo mlx5:mlx5_sf_hwc_alloc >> /sys/kernel/debug/tracing/set_event
-    $ cat /sys/kernel/debug/tracing/trace
+    $ echo mlx5:mlx5_sf_hwc_alloc >> /sys/kernel/tracing/set_event
+    $ cat /sys/kernel/tracing/trace
     ...
     devlink-9775    [031] ..... 26296.385259: mlx5_sf_hwc_alloc: (0000:06:00.0) controller=0 hw_id=0x8000 sfnum=88
 
 - mlx5_sf_hwc_free: trace freeing of the hardware SF context::
 
-    $ echo mlx5:mlx5_sf_hwc_free >> /sys/kernel/debug/tracing/set_event
-    $ cat /sys/kernel/debug/tracing/trace
+    $ echo mlx5:mlx5_sf_hwc_free >> /sys/kernel/tracing/set_event
+    $ cat /sys/kernel/tracing/trace
     ...
     kworker/u128:3-9093    [046] ..... 24625.365771: mlx5_sf_hwc_free: (0000:06:00.0) hw_id=0x8000
 
 - mlx5_sf_hwc_deferred_free : trace deferred freeing of the hardware SF context::
 
-    $ echo mlx5:mlx5_sf_hwc_deferred_free >> /sys/kernel/debug/tracing/set_event
-    $ cat /sys/kernel/debug/tracing/trace
+    $ echo mlx5:mlx5_sf_hwc_deferred_free >> /sys/kernel/tracing/set_event
+    $ cat /sys/kernel/tracing/trace
     ...
     devlink-9519    [046] ..... 24624.400271: mlx5_sf_hwc_deferred_free: (0000:06:00.0) hw_id=0x8000
 
 - mlx5_sf_vhca_event: trace SF vhca event and state::
 
-    $ echo mlx5:mlx5_sf_vhca_event >> /sys/kernel/debug/tracing/set_event
-    $ cat /sys/kernel/debug/tracing/trace
+    $ echo mlx5:mlx5_sf_vhca_event >> /sys/kernel/tracing/set_event
+    $ cat /sys/kernel/tracing/trace
     ...
     kworker/u128:3-9093    [046] ..... 24625.365525: mlx5_sf_vhca_event: (0000:06:00.0) hw_id=0x8000 sfnum=88 vhca_state=1
 
 - mlx5_sf_dev_add : trace SF device add event::
 
-    $ echo mlx5:mlx5_sf_dev_add>> /sys/kernel/debug/tracing/set_event
-    $ cat /sys/kernel/debug/tracing/trace
+    $ echo mlx5:mlx5_sf_dev_add>> /sys/kernel/tracing/set_event
+    $ cat /sys/kernel/tracing/trace
     ...
     kworker/u128:3-9093    [000] ..... 24616.524495: mlx5_sf_dev_add: (0000:06:00.0) sfdev=00000000fc5d96fd aux_id=4 hw_id=0x8000 sfnum=88
 
 - mlx5_sf_dev_del : trace SF device delete event::
 
-    $ echo mlx5:mlx5_sf_dev_del >> /sys/kernel/debug/tracing/set_event
-    $ cat /sys/kernel/debug/tracing/trace
+    $ echo mlx5:mlx5_sf_dev_del >> /sys/kernel/tracing/set_event
+    $ cat /sys/kernel/tracing/trace
     ...
     kworker/u128:3-9093    [044] ..... 24624.400749: mlx5_sf_dev_del: (0000:06:00.0) sfdev=00000000fc5d96fd aux_id=4 hw_id=0x8000 sfnum=88
diff --git a/Documentation/sound/hd-audio/notes.rst b/Documentation/sound/hd-audio/notes.rst
index d118b6fe269b..4c414a63de3a 100644
--- a/Documentation/sound/hd-audio/notes.rst
+++ b/Documentation/sound/hd-audio/notes.rst
@@ -651,14 +651,14 @@ via power-saving behavior.
 Enabling all tracepoints can be done like
 ::
 
-    # echo 1 > /sys/kernel/debug/tracing/events/hda/enable
+    # echo 1 > /sys/kernel/tracing/events/hda/enable
 
 then after some commands, you can traces from
-/sys/kernel/debug/tracing/trace file.  For example, when you want to
+/sys/kernel/tracing/trace file.  For example, when you want to
 trace what codec command is sent, enable the tracepoint like:
 ::
 
-    # cat /sys/kernel/debug/tracing/trace
+    # cat /sys/kernel/tracing/trace
     # tracer: nop
     #
     #       TASK-PID    CPU#    TIMESTAMP  FUNCTION
diff --git a/Documentation/trace/events-msr.rst b/Documentation/trace/events-msr.rst
index 810481e530b6..35d06dc66bc2 100644
--- a/Documentation/trace/events-msr.rst
+++ b/Documentation/trace/events-msr.rst
@@ -8,7 +8,7 @@ at https://www.intel.com/sdm (Volume 3)
 
 Available trace points:
 
-/sys/kernel/debug/tracing/events/msr/
+/sys/kernel/tracing/events/msr/
 
 Trace MSR reads:
 
@@ -34,7 +34,7 @@ rdpmc
 
 The trace data can be post processed with the postprocess/decode_msr.py script::
 
-  cat /sys/kernel/debug/tracing/trace | decode_msr.py /usr/src/linux/include/asm/msr-index.h
+  cat /sys/kernel/tracing/trace | decode_msr.py /usr/src/linux/include/asm/msr-index.h
 
 to add symbolic MSR names.
 
diff --git a/Documentation/trace/events-nmi.rst b/Documentation/trace/events-nmi.rst
index 9e0a7289d80a..22ac1be0ea6f 100644
--- a/Documentation/trace/events-nmi.rst
+++ b/Documentation/trace/events-nmi.rst
@@ -4,7 +4,7 @@ NMI Trace Events
 
 These events normally show up here:
 
-	/sys/kernel/debug/tracing/events/nmi
+	/sys/kernel/tracing/events/nmi
 
 
 nmi_handler
@@ -31,13 +31,13 @@ really hogging a lot of CPU time, like a millisecond at a time.
 Note that the kernel's output is in milliseconds, but the input
 to the filter is in nanoseconds!  You can filter on 'delta_ns'::
 
-	cd /sys/kernel/debug/tracing/events/nmi/nmi_handler
+	cd /sys/kernel/tracing/events/nmi/nmi_handler
 	echo 'handler==0xffffffff81625600 && delta_ns>1000000' > filter
 	echo 1 > enable
 
 Your output would then look like::
 
-	$ cat /sys/kernel/debug/tracing/trace_pipe
+	$ cat /sys/kernel/tracing/trace_pipe
 	<idle>-0     [000] d.h3   505.397558: nmi_handler: perf_event_nmi_handler() delta_ns: 3236765 handled: 1
 	<idle>-0     [000] d.h3   505.805893: nmi_handler: perf_event_nmi_handler() delta_ns: 3174234 handled: 1
 	<idle>-0     [000] d.h3   506.158206: nmi_handler: perf_event_nmi_handler() delta_ns: 3084642 handled: 1
diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
index c47f381d0c00..2ed0c997921d 100644
--- a/Documentation/trace/events.rst
+++ b/Documentation/trace/events.rst
@@ -24,27 +24,27 @@ tracing information should be printed.
 ---------------------------------
 
 The events which are available for tracing can be found in the file
-/sys/kernel/debug/tracing/available_events.
+/sys/kernel/tracing/available_events.
 
 To enable a particular event, such as 'sched_wakeup', simply echo it
-to /sys/kernel/debug/tracing/set_event. For example::
+to /sys/kernel/tracing/set_event. For example::
 
-	# echo sched_wakeup >> /sys/kernel/debug/tracing/set_event
+	# echo sched_wakeup >> /sys/kernel/tracing/set_event
 
 .. Note:: '>>' is necessary, otherwise it will firstly disable all the events.
 
 To disable an event, echo the event name to the set_event file prefixed
 with an exclamation point::
 
-	# echo '!sched_wakeup' >> /sys/kernel/debug/tracing/set_event
+	# echo '!sched_wakeup' >> /sys/kernel/tracing/set_event
 
 To disable all events, echo an empty line to the set_event file::
 
-	# echo > /sys/kernel/debug/tracing/set_event
+	# echo > /sys/kernel/tracing/set_event
 
 To enable all events, echo ``*:*`` or ``*:`` to the set_event file::
 
-	# echo *:* > /sys/kernel/debug/tracing/set_event
+	# echo *:* > /sys/kernel/tracing/set_event
 
 The events are organized into subsystems, such as ext4, irq, sched,
 etc., and a full event name looks like this: <subsystem>:<event>.  The
@@ -53,29 +53,29 @@ file.  All of the events in a subsystem can be specified via the syntax
 ``<subsystem>:*``; for example, to enable all irq events, you can use the
 command::
 
-	# echo 'irq:*' > /sys/kernel/debug/tracing/set_event
+	# echo 'irq:*' > /sys/kernel/tracing/set_event
 
 2.2 Via the 'enable' toggle
 ---------------------------
 
-The events available are also listed in /sys/kernel/debug/tracing/events/ hierarchy
+The events available are also listed in /sys/kernel/tracing/events/ hierarchy
 of directories.
 
 To enable event 'sched_wakeup'::
 
-	# echo 1 > /sys/kernel/debug/tracing/events/sched/sched_wakeup/enable
+	# echo 1 > /sys/kernel/tracing/events/sched/sched_wakeup/enable
 
 To disable it::
 
-	# echo 0 > /sys/kernel/debug/tracing/events/sched/sched_wakeup/enable
+	# echo 0 > /sys/kernel/tracing/events/sched/sched_wakeup/enable
 
 To enable all events in sched subsystem::
 
-	# echo 1 > /sys/kernel/debug/tracing/events/sched/enable
+	# echo 1 > /sys/kernel/tracing/events/sched/enable
 
 To enable all events::
 
-	# echo 1 > /sys/kernel/debug/tracing/events/enable
+	# echo 1 > /sys/kernel/tracing/events/enable
 
 When reading one of these enable files, there are four results:
 
@@ -126,7 +126,7 @@ is the size of the data item, in bytes.
 For example, here's the information displayed for the 'sched_wakeup'
 event::
 
-	# cat /sys/kernel/debug/tracing/events/sched/sched_wakeup/format
+	# cat /sys/kernel/tracing/events/sched/sched_wakeup/format
 
 	name: sched_wakeup
 	ID: 60
@@ -215,19 +215,19 @@ to the 'filter' file for the given event.
 
 For example::
 
-	# cd /sys/kernel/debug/tracing/events/sched/sched_wakeup
+	# cd /sys/kernel/tracing/events/sched/sched_wakeup
 	# echo "common_preempt_count > 4" > filter
 
 A slightly more involved example::
 
-	# cd /sys/kernel/debug/tracing/events/signal/signal_generate
+	# cd /sys/kernel/tracing/events/signal/signal_generate
 	# echo "((sig >= 10 && sig < 15) || sig == 17) && comm != bash" > filter
 
 If there is an error in the expression, you'll get an 'Invalid
 argument' error when setting it, and the erroneous string along with
 an error message can be seen by looking at the filter e.g.::
 
-	# cd /sys/kernel/debug/tracing/events/signal/signal_generate
+	# cd /sys/kernel/tracing/events/signal/signal_generate
 	# echo "((sig >= 10 && sig < 15) || dsig == 17) && comm != bash" > filter
 	-bash: echo: write error: Invalid argument
 	# cat filter
@@ -277,7 +277,7 @@ above points:
 
 Clear the filters on all events in the sched subsystem::
 
-	# cd /sys/kernel/debug/tracing/events/sched
+	# cd /sys/kernel/tracing/events/sched
 	# echo 0 > filter
 	# cat sched_switch/filter
 	none
@@ -287,7 +287,7 @@ Clear the filters on all events in the sched subsystem::
 Set a filter using only common fields for all events in the sched
 subsystem (all events end up with the same filter)::
 
-	# cd /sys/kernel/debug/tracing/events/sched
+	# cd /sys/kernel/tracing/events/sched
 	# echo common_pid == 0 > filter
 	# cat sched_switch/filter
 	common_pid == 0
@@ -298,7 +298,7 @@ Attempt to set a filter using a non-common field for all events in the
 sched subsystem (all events but those that have a prev_pid field retain
 their old filters)::
 
-	# cd /sys/kernel/debug/tracing/events/sched
+	# cd /sys/kernel/tracing/events/sched
 	# echo prev_pid == 0 > filter
 	# cat sched_switch/filter
 	prev_pid == 0
@@ -313,7 +313,7 @@ exists, will filter all events from tracing any task that does not have the
 PID listed in the set_event_pid file.
 ::
 
-	# cd /sys/kernel/debug/tracing
+	# cd /sys/kernel/tracing
 	# echo $$ > set_event_pid
 	# echo 1 > events/enable
 
@@ -409,14 +409,14 @@ The following commands are supported:
   specifies that this enablement happens only once::
 
 	  # echo 'enable_event:kmem:kmalloc:1' > \
-	      /sys/kernel/debug/tracing/events/syscalls/sys_enter_read/trigger
+	      /sys/kernel/tracing/events/syscalls/sys_enter_read/trigger
 
   The following trigger causes kmalloc events to stop being traced
   when a read system call exits.  This disablement happens on every
   read system call exit::
 
 	  # echo 'disable_event:kmem:kmalloc' > \
-	      /sys/kernel/debug/tracing/events/syscalls/sys_exit_read/trigger
+	      /sys/kernel/tracing/events/syscalls/sys_exit_read/trigger
 
   The format is::
 
@@ -426,10 +426,10 @@ The following commands are supported:
   To remove the above commands::
 
 	  # echo '!enable_event:kmem:kmalloc:1' > \
-	      /sys/kernel/debug/tracing/events/syscalls/sys_enter_read/trigger
+	      /sys/kernel/tracing/events/syscalls/sys_enter_read/trigger
 
 	  # echo '!disable_event:kmem:kmalloc' > \
-	      /sys/kernel/debug/tracing/events/syscalls/sys_exit_read/trigger
+	      /sys/kernel/tracing/events/syscalls/sys_exit_read/trigger
 
   Note that there can be any number of enable/disable_event triggers
   per triggering event, but there can only be one trigger per
@@ -448,13 +448,13 @@ The following commands are supported:
   kmalloc tracepoint is hit::
 
 	  # echo 'stacktrace' > \
-		/sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
+		/sys/kernel/tracing/events/kmem/kmalloc/trigger
 
   The following trigger dumps a stacktrace the first 5 times a kmalloc
   request happens with a size >= 64K::
 
 	  # echo 'stacktrace:5 if bytes_req >= 65536' > \
-		/sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
+		/sys/kernel/tracing/events/kmem/kmalloc/trigger
 
   The format is::
 
@@ -463,16 +463,16 @@ The following commands are supported:
   To remove the above commands::
 
 	  # echo '!stacktrace' > \
-		/sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
+		/sys/kernel/tracing/events/kmem/kmalloc/trigger
 
 	  # echo '!stacktrace:5 if bytes_req >= 65536' > \
-		/sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
+		/sys/kernel/tracing/events/kmem/kmalloc/trigger
 
   The latter can also be removed more simply by the following (without
   the filter)::
 
 	  # echo '!stacktrace:5' > \
-		/sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
+		/sys/kernel/tracing/events/kmem/kmalloc/trigger
 
   Note that there can be only one stacktrace trigger per triggering
   event.
@@ -488,20 +488,20 @@ The following commands are supported:
   capture those events when the trigger event occurred::
 
 	  # echo 'snapshot if nr_rq > 1' > \
-		/sys/kernel/debug/tracing/events/block/block_unplug/trigger
+		/sys/kernel/tracing/events/block/block_unplug/trigger
 
   To only snapshot once::
 
 	  # echo 'snapshot:1 if nr_rq > 1' > \
-		/sys/kernel/debug/tracing/events/block/block_unplug/trigger
+		/sys/kernel/tracing/events/block/block_unplug/trigger
 
   To remove the above commands::
 
 	  # echo '!snapshot if nr_rq > 1' > \
-		/sys/kernel/debug/tracing/events/block/block_unplug/trigger
+		/sys/kernel/tracing/events/block/block_unplug/trigger
 
 	  # echo '!snapshot:1 if nr_rq > 1' > \
-		/sys/kernel/debug/tracing/events/block/block_unplug/trigger
+		/sys/kernel/tracing/events/block/block_unplug/trigger
 
   Note that there can be only one snapshot trigger per triggering
   event.
@@ -519,20 +519,20 @@ The following commands are supported:
   trigger event::
 
 	  # echo 'traceoff:1 if nr_rq > 1' > \
-		/sys/kernel/debug/tracing/events/block/block_unplug/trigger
+		/sys/kernel/tracing/events/block/block_unplug/trigger
 
   To always disable tracing when nr_rq  > 1::
 
 	  # echo 'traceoff if nr_rq > 1' > \
-		/sys/kernel/debug/tracing/events/block/block_unplug/trigger
+		/sys/kernel/tracing/events/block/block_unplug/trigger
 
   To remove the above commands::
 
 	  # echo '!traceoff:1 if nr_rq > 1' > \
-		/sys/kernel/debug/tracing/events/block/block_unplug/trigger
+		/sys/kernel/tracing/events/block/block_unplug/trigger
 
 	  # echo '!traceoff if nr_rq > 1' > \
-		/sys/kernel/debug/tracing/events/block/block_unplug/trigger
+		/sys/kernel/tracing/events/block/block_unplug/trigger
 
   Note that there can be only one traceon or traceoff trigger per
   triggering event.
diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 60bceb018d6a..83149f16d87f 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -830,10 +830,10 @@ Error conditions
   The extended error information and usage takes the form shown in
   this example::
 
-    # echo xxx > /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
+    # echo xxx > /sys/kernel/tracing/events/sched/sched_wakeup/trigger
     echo: write error: Invalid argument
 
-    # cat /sys/kernel/debug/tracing/error_log
+    # cat /sys/kernel/tracing/error_log
     [ 5348.887237] location: error: Couldn't yyy: zzz
       Command: xxx
                ^
@@ -843,7 +843,7 @@ Error conditions
 
   To clear the error log, echo the empty string into it::
 
-    # echo > /sys/kernel/debug/tracing/error_log
+    # echo > /sys/kernel/tracing/error_log
 
 Examples of using the tracer
 ----------------------------
diff --git a/Documentation/trace/histogram-design.rst b/Documentation/trace/histogram-design.rst
index 088c8cce738b..5765eb3e9efa 100644
--- a/Documentation/trace/histogram-design.rst
+++ b/Documentation/trace/histogram-design.rst
@@ -14,7 +14,7 @@ tracing_map.c.
 Note: All the ftrace histogram command examples assume the working
       directory is the ftrace /tracing directory. For example::
 
-	# cd /sys/kernel/debug/tracing
+	# cd /sys/kernel/tracing
 
 Also, the histogram output displayed for those commands will be
 generally be truncated - only enough to make the point is displayed.
@@ -905,7 +905,7 @@ means it will be automatically converted into a field variable::
 
   # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0: \
           onmatch(sched.sched_waking).wakeup_latency($wakeup_lat,next_pid)' >>
-	  /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
+	  /sys/kernel/tracing/events/sched/sched_switch/trigger
 
 The diagram for the sched_switch event is similar to previous examples
 but shows the additional field_vars[] array for hist_data and shows
@@ -1112,7 +1112,7 @@ sched_switch event fields, next_pid and next_comm, to generate a
 wakeup_latency trace event.  The next_pid and next_comm event fields
 are automatically converted into field variables for this purpose::
 
-  # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0:onmatch(sched.sched_waking).wakeup_latency($wakeup_lat,next_pid,next_comm)' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
+  # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0:onmatch(sched.sched_waking).wakeup_latency($wakeup_lat,next_pid,next_comm)' >> /sys/kernel/tracing/events/sched/sched_switch/trigger
 
 The sched_waking hist_debug output shows the same data as in the
 previous test example::
@@ -1305,7 +1305,7 @@ and event name for the onmatch() handler::
 
 The commands below can be used to clean things up for the next test::
 
-  # echo '!hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0:onmatch(sched.sched_waking).wakeup_latency($wakeup_lat,next_pid,next_comm)' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
+  # echo '!hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0:onmatch(sched.sched_waking).wakeup_latency($wakeup_lat,next_pid,next_comm)' >> /sys/kernel/tracing/events/sched/sched_switch/trigger
 
   # echo '!hist:keys=pid:ts0=common_timestamp.usecs' >> events/sched/sched_waking/trigger
 
@@ -1363,13 +1363,13 @@ with the save() and snapshot() actions.  For example::
 
   # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0: \
           onmax($wakeup_lat).save(next_comm,prev_pid,prev_prio,prev_comm)' >>
-          /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
+          /sys/kernel/tracing/events/sched/sched_switch/trigger
 
 or::
 
   # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0: \
           onmax($wakeup_lat).snapshot()' >>
-          /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
+          /sys/kernel/tracing/events/sched/sched_switch/trigger
 
 save() action field variable test
 ---------------------------------
diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
index 87bd772836c0..f135a068df75 100644
--- a/Documentation/trace/histogram.rst
+++ b/Documentation/trace/histogram.rst
@@ -100,12 +100,12 @@ Documentation written by Tom Zanussi
   trigger, read its current contents, and then turn it off::
 
     # echo 'hist:keys=skbaddr.hex:vals=len' > \
-      /sys/kernel/debug/tracing/events/net/netif_rx/trigger
+      /sys/kernel/tracing/events/net/netif_rx/trigger
 
-    # cat /sys/kernel/debug/tracing/events/net/netif_rx/hist
+    # cat /sys/kernel/tracing/events/net/netif_rx/hist
 
     # echo '!hist:keys=skbaddr.hex:vals=len' > \
-      /sys/kernel/debug/tracing/events/net/netif_rx/trigger
+      /sys/kernel/tracing/events/net/netif_rx/trigger
 
   The trigger file itself can be read to show the details of the
   currently attached hist trigger.  This information is also displayed
@@ -161,13 +161,13 @@ Documentation written by Tom Zanussi
   aggregation on and off when conditions of interest are hit::
 
    # echo 'hist:keys=skbaddr.hex:vals=len:pause' > \
-      /sys/kernel/debug/tracing/events/net/netif_receive_skb/trigger
+      /sys/kernel/tracing/events/net/netif_receive_skb/trigger
 
     # echo 'enable_hist:net:netif_receive_skb if filename==/usr/bin/wget' > \
-      /sys/kernel/debug/tracing/events/sched/sched_process_exec/trigger
+      /sys/kernel/tracing/events/sched/sched_process_exec/trigger
 
     # echo 'disable_hist:net:netif_receive_skb if comm==wget' > \
-      /sys/kernel/debug/tracing/events/sched/sched_process_exit/trigger
+      /sys/kernel/tracing/events/sched/sched_process_exit/trigger
 
   The above sets up an initially paused hist trigger which is unpaused
   and starts aggregating events when a given program is executed, and
@@ -210,7 +210,7 @@ Extended error information
   event.  The fields that can be used for the hist trigger are listed
   in the kmalloc event's format file::
 
-    # cat /sys/kernel/debug/tracing/events/kmem/kmalloc/format
+    # cat /sys/kernel/tracing/events/kmem/kmalloc/format
     name: kmalloc
     ID: 374
     format:
@@ -230,7 +230,7 @@ Extended error information
   the kernel that made one or more calls to kmalloc::
 
     # echo 'hist:key=call_site:val=bytes_req.buckets=32' > \
-            /sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
+            /sys/kernel/tracing/events/kmem/kmalloc/trigger
 
   This tells the tracing system to create a 'hist' trigger using the
   call_site field of the kmalloc event as the key for the table, which
@@ -244,7 +244,7 @@ Extended error information
   file in the kmalloc event's subdirectory (for readability, a number
   of entries have been omitted)::
 
-    # cat /sys/kernel/debug/tracing/events/kmem/kmalloc/hist
+    # cat /sys/kernel/tracing/events/kmem/kmalloc/hist
     # trigger info: hist:keys=call_site:vals=bytes_req:sort=hitcount:size=2048 [active]
 
     { call_site: 18446744072106379007 } hitcount:          1  bytes_req:        176
@@ -284,7 +284,7 @@ Extended error information
   the trigger info, which can also be displayed by reading the
   'trigger' file::
 
-    # cat /sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
+    # cat /sys/kernel/tracing/events/kmem/kmalloc/trigger
     hist:keys=call_site:vals=bytes_req:sort=hitcount:size=2048 [active]
 
   At the end of the output are a few lines that display the overall
@@ -315,7 +315,7 @@ Extended error information
   command history and re-execute it with a '!' prepended::
 
     # echo '!hist:key=call_site:val=bytes_req' > \
-           /sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
+           /sys/kernel/tracing/events/kmem/kmalloc/trigger
 
   Finally, notice that the call_site as displayed in the output above
   isn't really very useful.  It's an address, but normally addresses
@@ -323,9 +323,9 @@ Extended error information
   value, simply append '.hex' to the field name in the trigger::
 
     # echo 'hist:key=call_site.hex:val=bytes_req' > \
-           /sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
+           /sys/kernel/tracing/events/kmem/kmalloc/trigger
 
-    # cat /sys/kernel/debug/tracing/events/kmem/kmalloc/hist
+    # cat /sys/kernel/tracing/events/kmem/kmalloc/hist
     # trigger info: hist:keys=call_site.hex:vals=bytes_req:sort=hitcount:size=2048 [active]
 
     { call_site: ffffffffa026b291 } hitcount:          1  bytes_req:        433
@@ -368,9 +368,9 @@ Extended error information
   trigger::
 
     # echo 'hist:key=call_site.sym:val=bytes_req' > \
-           /sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
+           /sys/kernel/tracing/events/kmem/kmalloc/trigger
 
-    # cat /sys/kernel/debug/tracing/events/kmem/kmalloc/hist
+    # cat /sys/kernel/tracing/events/kmem/kmalloc/hist
     # trigger info: hist:keys=call_site.sym:vals=bytes_req:sort=hitcount:size=2048 [active]
 
     { call_site: [ffffffff810adcb9] syslog_print_all                              } hitcount:          1  bytes_req:       1024
@@ -418,9 +418,9 @@ Extended error information
   the 'sort' parameter, along with the 'descending' modifier::
 
     # echo 'hist:key=call_site.sym:val=bytes_req:sort=bytes_req.descending' > \
-           /sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
+           /sys/kernel/tracing/events/kmem/kmalloc/trigger
 
-    # cat /sys/kernel/debug/tracing/events/kmem/kmalloc/hist
+    # cat /sys/kernel/tracing/events/kmem/kmalloc/hist
     # trigger info: hist:keys=call_site.sym:vals=bytes_req:sort=bytes_req.descending:size=2048 [active]
 
     { call_site: [ffffffffa046041c] i915_gem_execbuffer2 [i915]                   } hitcount:       2186  bytes_req:    3397464
@@ -459,9 +459,9 @@ Extended error information
   name, just use 'sym-offset' instead::
 
     # echo 'hist:key=call_site.sym-offset:val=bytes_req:sort=bytes_req.descending' > \
-           /sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
+           /sys/kernel/tracing/events/kmem/kmalloc/trigger
 
-    # cat /sys/kernel/debug/tracing/events/kmem/kmalloc/hist
+    # cat /sys/kernel/tracing/events/kmem/kmalloc/hist
     # trigger info: hist:keys=call_site.sym-offset:vals=bytes_req:sort=bytes_req.descending:size=2048 [active]
 
     { call_site: [ffffffffa046041c] i915_gem_execbuffer2+0x6c/0x2c0 [i915]                  } hitcount:       4569  bytes_req:    3163720
@@ -498,9 +498,9 @@ Extended error information
   allocated in a descending order::
 
     # echo 'hist:keys=call_site.sym:values=bytes_req,bytes_alloc:sort=bytes_alloc.descending' > \
-           /sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
+           /sys/kernel/tracing/events/kmem/kmalloc/trigger
 
-    # cat /sys/kernel/debug/tracing/events/kmem/kmalloc/hist
+    # cat /sys/kernel/tracing/events/kmem/kmalloc/hist
     # trigger info: hist:keys=call_site.sym:vals=bytes_req,bytes_alloc:sort=bytes_alloc.descending:size=2048 [active]
 
     { call_site: [ffffffffa046041c] i915_gem_execbuffer2 [i915]                   } hitcount:       7403  bytes_req:    4084360  bytes_alloc:    5958016
@@ -541,7 +541,7 @@ Extended error information
   value 'stacktrace' for the key parameter::
 
     # echo 'hist:keys=stacktrace:values=bytes_req,bytes_alloc:sort=bytes_alloc' > \
-           /sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
+           /sys/kernel/tracing/events/kmem/kmalloc/trigger
 
   The above trigger will use the kernel stack trace in effect when an
   event is triggered as the key for the hash table.  This allows the
@@ -551,7 +551,7 @@ Extended error information
   every callpath in the system that led up to a kmalloc (in this case
   every callpath to a kmalloc for a kernel compile)::
 
-    # cat /sys/kernel/debug/tracing/events/kmem/kmalloc/hist
+    # cat /sys/kernel/tracing/events/kmem/kmalloc/hist
     # trigger info: hist:keys=stacktrace:vals=bytes_req,bytes_alloc:sort=bytes_alloc:size=2048 [active]
 
     { stacktrace:
@@ -650,9 +650,9 @@ Extended error information
   keeps a per-process sum of total bytes read::
 
     # echo 'hist:key=common_pid.execname:val=count:sort=count.descending' > \
-           /sys/kernel/debug/tracing/events/syscalls/sys_enter_read/trigger
+           /sys/kernel/tracing/events/syscalls/sys_enter_read/trigger
 
-    # cat /sys/kernel/debug/tracing/events/syscalls/sys_enter_read/hist
+    # cat /sys/kernel/tracing/events/syscalls/sys_enter_read/hist
     # trigger info: hist:keys=common_pid.execname:vals=count:sort=count.descending:size=2048 [active]
 
     { common_pid: gnome-terminal  [      3196] } hitcount:        280  count:    1093512
@@ -691,9 +691,9 @@ Extended error information
   counts for the system during the run::
 
     # echo 'hist:key=id.syscall:val=hitcount' > \
-           /sys/kernel/debug/tracing/events/raw_syscalls/sys_enter/trigger
+           /sys/kernel/tracing/events/raw_syscalls/sys_enter/trigger
 
-    # cat /sys/kernel/debug/tracing/events/raw_syscalls/sys_enter/hist
+    # cat /sys/kernel/tracing/events/raw_syscalls/sys_enter/hist
     # trigger info: hist:keys=id.syscall:vals=hitcount:sort=hitcount:size=2048 [active]
 
     { id: sys_fsync                     [ 74] } hitcount:          1
@@ -745,9 +745,9 @@ Extended error information
   hitcount sum as the secondary key::
 
     # echo 'hist:key=id.syscall,common_pid.execname:val=hitcount:sort=id,hitcount' > \
-           /sys/kernel/debug/tracing/events/raw_syscalls/sys_enter/trigger
+           /sys/kernel/tracing/events/raw_syscalls/sys_enter/trigger
 
-    # cat /sys/kernel/debug/tracing/events/raw_syscalls/sys_enter/hist
+    # cat /sys/kernel/tracing/events/raw_syscalls/sys_enter/hist
     # trigger info: hist:keys=id.syscall,common_pid.execname:vals=hitcount:sort=id.syscall,hitcount:size=2048 [active]
 
     { id: sys_read                      [  0], common_pid: rtkit-daemon    [      1877] } hitcount:          1
@@ -795,9 +795,9 @@ Extended error information
   can use that to filter out all the other syscalls::
 
     # echo 'hist:key=id.syscall,common_pid.execname:val=hitcount:sort=id,hitcount if id == 16' > \
-           /sys/kernel/debug/tracing/events/raw_syscalls/sys_enter/trigger
+           /sys/kernel/tracing/events/raw_syscalls/sys_enter/trigger
 
-    # cat /sys/kernel/debug/tracing/events/raw_syscalls/sys_enter/hist
+    # cat /sys/kernel/tracing/events/raw_syscalls/sys_enter/hist
     # trigger info: hist:keys=id.syscall,common_pid.execname:vals=hitcount:sort=id.syscall,hitcount:size=2048 if id == 16 [active]
 
     { id: sys_ioctl                     [ 16], common_pid: gmain           [      2769] } hitcount:          1
@@ -838,9 +838,9 @@ Extended error information
   each process::
 
     # echo 'hist:key=common_pid.execname,size:val=hitcount:sort=common_pid,size' > \
-           /sys/kernel/debug/tracing/events/syscalls/sys_enter_recvfrom/trigger
+           /sys/kernel/tracing/events/syscalls/sys_enter_recvfrom/trigger
 
-    # cat /sys/kernel/debug/tracing/events/syscalls/sys_enter_recvfrom/hist
+    # cat /sys/kernel/tracing/events/syscalls/sys_enter_recvfrom/hist
     # trigger info: hist:keys=common_pid.execname,size:vals=hitcount:sort=common_pid.execname,size:size=2048 [active]
 
     { common_pid: smbd            [       784], size:          4 } hitcount:          1
@@ -891,9 +891,9 @@ Extended error information
   much smaller number, say 256::
 
     # echo 'hist:key=child_comm:val=hitcount:size=256' > \
-           /sys/kernel/debug/tracing/events/sched/sched_process_fork/trigger
+           /sys/kernel/tracing/events/sched/sched_process_fork/trigger
 
-    # cat /sys/kernel/debug/tracing/events/sched/sched_process_fork/hist
+    # cat /sys/kernel/tracing/events/sched/sched_process_fork/hist
     # trigger info: hist:keys=child_comm:vals=hitcount:sort=hitcount:size=256 [active]
 
     { child_comm: dconf worker                        } hitcount:          1
@@ -927,9 +927,9 @@ Extended error information
   displays as [paused]::
 
     # echo 'hist:key=child_comm:val=hitcount:size=256:pause' >> \
-           /sys/kernel/debug/tracing/events/sched/sched_process_fork/trigger
+           /sys/kernel/tracing/events/sched/sched_process_fork/trigger
 
-    # cat /sys/kernel/debug/tracing/events/sched/sched_process_fork/hist
+    # cat /sys/kernel/tracing/events/sched/sched_process_fork/hist
     # trigger info: hist:keys=child_comm:vals=hitcount:sort=hitcount:size=256 [paused]
 
     { child_comm: dconf worker                        } hitcount:          1
@@ -964,9 +964,9 @@ Extended error information
   again, and the data has changed::
 
     # echo 'hist:key=child_comm:val=hitcount:size=256:cont' >> \
-           /sys/kernel/debug/tracing/events/sched/sched_process_fork/trigger
+           /sys/kernel/tracing/events/sched/sched_process_fork/trigger
 
-    # cat /sys/kernel/debug/tracing/events/sched/sched_process_fork/hist
+    # cat /sys/kernel/tracing/events/sched/sched_process_fork/hist
     # trigger info: hist:keys=child_comm:vals=hitcount:sort=hitcount:size=256 [active]
 
     { child_comm: dconf worker                        } hitcount:          1
@@ -1018,7 +1018,7 @@ Extended error information
   netif_receive_skb event::
 
     # echo 'hist:key=stacktrace:vals=len:pause' > \
-           /sys/kernel/debug/tracing/events/net/netif_receive_skb/trigger
+           /sys/kernel/tracing/events/net/netif_receive_skb/trigger
 
   Next, we set up an 'enable_hist' trigger on the sched_process_exec
   event, with an 'if filename==/usr/bin/wget' filter.  The effect of
@@ -1029,7 +1029,7 @@ Extended error information
   hash table keyed on stacktrace::
 
     # echo 'enable_hist:net:netif_receive_skb if filename==/usr/bin/wget' > \
-           /sys/kernel/debug/tracing/events/sched/sched_process_exec/trigger
+           /sys/kernel/tracing/events/sched/sched_process_exec/trigger
 
   The aggregation continues until the netif_receive_skb is paused
   again, which is what the following disable_hist event does by
@@ -1037,7 +1037,7 @@ Extended error information
   filter 'comm==wget'::
 
     # echo 'disable_hist:net:netif_receive_skb if comm==wget' > \
-           /sys/kernel/debug/tracing/events/sched/sched_process_exit/trigger
+           /sys/kernel/tracing/events/sched/sched_process_exit/trigger
 
   Whenever a process exits and the comm field of the disable_hist
   trigger filter matches 'comm==wget', the netif_receive_skb hist
@@ -1050,7 +1050,7 @@ Extended error information
 
     $ wget https://www.kernel.org/pub/linux/kernel/v3.x/patch-3.19.xz
 
-    # cat /sys/kernel/debug/tracing/events/net/netif_receive_skb/hist
+    # cat /sys/kernel/tracing/events/net/netif_receive_skb/hist
     # trigger info: hist:keys=stacktrace:vals=len:sort=hitcount:size=2048 [paused]
 
     { stacktrace:
@@ -1134,12 +1134,12 @@ Extended error information
   again, we can just clear the histogram first::
 
     # echo 'hist:key=stacktrace:vals=len:clear' >> \
-           /sys/kernel/debug/tracing/events/net/netif_receive_skb/trigger
+           /sys/kernel/tracing/events/net/netif_receive_skb/trigger
 
   Just to verify that it is in fact cleared, here's what we now see in
   the hist file::
 
-    # cat /sys/kernel/debug/tracing/events/net/netif_receive_skb/hist
+    # cat /sys/kernel/tracing/events/net/netif_receive_skb/hist
     # trigger info: hist:keys=stacktrace:vals=len:sort=hitcount:size=2048 [paused]
 
     Totals:
@@ -1154,21 +1154,21 @@ Extended error information
   sched_process_exit events as such::
 
     # echo 'enable_event:net:netif_receive_skb if filename==/usr/bin/wget' > \
-           /sys/kernel/debug/tracing/events/sched/sched_process_exec/trigger
+           /sys/kernel/tracing/events/sched/sched_process_exec/trigger
 
     # echo 'disable_event:net:netif_receive_skb if comm==wget' > \
-           /sys/kernel/debug/tracing/events/sched/sched_process_exit/trigger
+           /sys/kernel/tracing/events/sched/sched_process_exit/trigger
 
   If you read the trigger files for the sched_process_exec and
   sched_process_exit triggers, you should see two triggers for each:
   one enabling/disabling the hist aggregation and the other
   enabling/disabling the logging of events::
 
-    # cat /sys/kernel/debug/tracing/events/sched/sched_process_exec/trigger
+    # cat /sys/kernel/tracing/events/sched/sched_process_exec/trigger
     enable_event:net:netif_receive_skb:unlimited if filename==/usr/bin/wget
     enable_hist:net:netif_receive_skb:unlimited if filename==/usr/bin/wget
 
-    # cat /sys/kernel/debug/tracing/events/sched/sched_process_exit/trigger
+    # cat /sys/kernel/tracing/events/sched/sched_process_exit/trigger
     enable_event:net:netif_receive_skb:unlimited if comm==wget
     disable_hist:net:netif_receive_skb:unlimited if comm==wget
 
@@ -1184,7 +1184,7 @@ Extended error information
   saw in the last run, but this time you should also see the
   individual events in the trace file::
 
-    # cat /sys/kernel/debug/tracing/trace
+    # cat /sys/kernel/tracing/trace
 
     # tracer: nop
     #
@@ -1218,15 +1218,15 @@ Extended error information
   other things::
 
     # echo 'hist:keys=skbaddr.hex:vals=len if len < 0' >> \
-           /sys/kernel/debug/tracing/events/net/netif_receive_skb/trigger
+           /sys/kernel/tracing/events/net/netif_receive_skb/trigger
     # echo 'hist:keys=skbaddr.hex:vals=len if len > 4096' >> \
-           /sys/kernel/debug/tracing/events/net/netif_receive_skb/trigger
+           /sys/kernel/tracing/events/net/netif_receive_skb/trigger
     # echo 'hist:keys=skbaddr.hex:vals=len if len == 256' >> \
-           /sys/kernel/debug/tracing/events/net/netif_receive_skb/trigger
+           /sys/kernel/tracing/events/net/netif_receive_skb/trigger
     # echo 'hist:keys=skbaddr.hex:vals=len' >> \
-           /sys/kernel/debug/tracing/events/net/netif_receive_skb/trigger
+           /sys/kernel/tracing/events/net/netif_receive_skb/trigger
     # echo 'hist:keys=len:vals=common_preempt_count' >> \
-           /sys/kernel/debug/tracing/events/net/netif_receive_skb/trigger
+           /sys/kernel/tracing/events/net/netif_receive_skb/trigger
 
   The above set of commands create four triggers differing only in
   their filters, along with a completely different though fairly
@@ -1238,7 +1238,7 @@ Extended error information
   Displaying the contents of the 'hist' file for the event shows the
   contents of all five histograms::
 
-    # cat /sys/kernel/debug/tracing/events/net/netif_receive_skb/hist
+    # cat /sys/kernel/tracing/events/net/netif_receive_skb/hist
 
     # event histogram
     #
@@ -1359,15 +1359,15 @@ Extended error information
   field in the shared 'foo' histogram data::
 
     # echo 'hist:name=foo:keys=skbaddr.hex:vals=len' > \
-           /sys/kernel/debug/tracing/events/net/netif_receive_skb/trigger
+           /sys/kernel/tracing/events/net/netif_receive_skb/trigger
     # echo 'hist:name=foo:keys=skbaddr.hex:vals=len' > \
-           /sys/kernel/debug/tracing/events/net/netif_rx/trigger
+           /sys/kernel/tracing/events/net/netif_rx/trigger
 
   You can see that they're updating common histogram data by reading
   each event's hist files at the same time::
 
-    # cat /sys/kernel/debug/tracing/events/net/netif_receive_skb/hist;
-      cat /sys/kernel/debug/tracing/events/net/netif_rx/hist
+    # cat /sys/kernel/tracing/events/net/netif_receive_skb/hist;
+      cat /sys/kernel/tracing/events/net/netif_rx/hist
 
     # event histogram
     #
@@ -1480,15 +1480,15 @@ Extended error information
   couple of triggers named 'bar' using those fields::
 
     # echo 'hist:name=bar:key=stacktrace:val=hitcount' > \
-           /sys/kernel/debug/tracing/events/sched/sched_process_fork/trigger
+           /sys/kernel/tracing/events/sched/sched_process_fork/trigger
     # echo 'hist:name=bar:key=stacktrace:val=hitcount' > \
-          /sys/kernel/debug/tracing/events/net/netif_rx/trigger
+          /sys/kernel/tracing/events/net/netif_rx/trigger
 
   And displaying the output of either shows some interesting if
   somewhat confusing output::
 
-    # cat /sys/kernel/debug/tracing/events/sched/sched_process_fork/hist
-    # cat /sys/kernel/debug/tracing/events/net/netif_rx/hist
+    # cat /sys/kernel/tracing/events/sched/sched_process_fork/hist
+    # cat /sys/kernel/tracing/events/net/netif_rx/hist
 
     # event histogram
     #
@@ -1818,19 +1818,19 @@ variable reference to a variable on another event::
           u64 lat; \
           pid_t pid; \
 	  int prio' >> \
-	  /sys/kernel/debug/tracing/synthetic_events
+	  /sys/kernel/tracing/synthetic_events
 
 Reading the tracing/synthetic_events file lists all the currently
 defined synthetic events, in this case the event defined above::
 
-  # cat /sys/kernel/debug/tracing/synthetic_events
+  # cat /sys/kernel/tracing/synthetic_events
     wakeup_latency u64 lat; pid_t pid; int prio
 
 An existing synthetic event definition can be removed by prepending
 the command that defined it with a '!'::
 
   # echo '!wakeup_latency u64 lat pid_t pid int prio' >> \
-    /sys/kernel/debug/tracing/synthetic_events
+    /sys/kernel/tracing/synthetic_events
 
 At this point, there isn't yet an actual 'wakeup_latency' event
 instantiated in the event subsystem - for this to happen, a 'hist
@@ -1842,20 +1842,20 @@ done, the 'wakeup_latency' synthetic event instance is created.
 The new event is created under the tracing/events/synthetic/ directory
 and looks and behaves just like any other event::
 
-  # ls /sys/kernel/debug/tracing/events/synthetic/wakeup_latency
+  # ls /sys/kernel/tracing/events/synthetic/wakeup_latency
         enable  filter  format  hist  id  trigger
 
 A histogram can now be defined for the new synthetic event::
 
   # echo 'hist:keys=pid,prio,lat.log2:sort=lat' >> \
-        /sys/kernel/debug/tracing/events/synthetic/wakeup_latency/trigger
+        /sys/kernel/tracing/events/synthetic/wakeup_latency/trigger
 
 The above shows the latency "lat" in a power of 2 grouping.
 
 Like any other event, once a histogram is enabled for the event, the
 output can be displayed by reading the event's 'hist' file.
 
-  # cat /sys/kernel/debug/tracing/events/synthetic/wakeup_latency/hist
+  # cat /sys/kernel/tracing/events/synthetic/wakeup_latency/hist
 
   # event histogram
   #
@@ -1903,7 +1903,7 @@ The latency values can also be grouped linearly by a given size with
 the ".buckets" modifier and specify a size (in this case groups of 10).
 
   # echo 'hist:keys=pid,prio,lat.buckets=10:sort=lat' >> \
-        /sys/kernel/debug/tracing/events/synthetic/wakeup_latency/trigger
+        /sys/kernel/tracing/events/synthetic/wakeup_latency/trigger
 
   # event histogram
   #
@@ -2031,9 +2031,9 @@ The following commonly-used handler.action pairs are available:
     event::
 
       # echo 'wakeup_new_test pid_t pid' >> \
-             /sys/kernel/debug/tracing/synthetic_events
+             /sys/kernel/tracing/synthetic_events
 
-      # cat /sys/kernel/debug/tracing/synthetic_events
+      # cat /sys/kernel/tracing/synthetic_events
             wakeup_new_test pid_t pid
 
     The following hist trigger both defines the missing testpid
@@ -2044,26 +2044,26 @@ The following commonly-used handler.action pairs are available:
 
       # echo 'hist:keys=$testpid:testpid=pid:onmatch(sched.sched_wakeup_new).\
               wakeup_new_test($testpid) if comm=="cyclictest"' >> \
-              /sys/kernel/debug/tracing/events/sched/sched_wakeup_new/trigger
+              /sys/kernel/tracing/events/sched/sched_wakeup_new/trigger
 
     Or, equivalently, using the 'trace' keyword syntax:
 
     # echo 'hist:keys=$testpid:testpid=pid:onmatch(sched.sched_wakeup_new).\
             trace(wakeup_new_test,$testpid) if comm=="cyclictest"' >> \
-            /sys/kernel/debug/tracing/events/sched/sched_wakeup_new/trigger
+            /sys/kernel/tracing/events/sched/sched_wakeup_new/trigger
 
     Creating and displaying a histogram based on those events is now
     just a matter of using the fields and new synthetic event in the
     tracing/events/synthetic directory, as usual::
 
       # echo 'hist:keys=pid:sort=pid' >> \
-             /sys/kernel/debug/tracing/events/synthetic/wakeup_new_test/trigger
+             /sys/kernel/tracing/events/synthetic/wakeup_new_test/trigger
 
     Running 'cyclictest' should cause wakeup_new events to generate
     wakeup_new_test synthetic events which should result in histogram
     output in the wakeup_new_test event's hist file::
 
-      # cat /sys/kernel/debug/tracing/events/synthetic/wakeup_new_test/hist
+      # cat /sys/kernel/tracing/events/synthetic/wakeup_new_test/hist
 
     A more typical usage would be to use two events to calculate a
     latency.  The following example uses a set of hist triggers to
@@ -2072,14 +2072,14 @@ The following commonly-used handler.action pairs are available:
     First, we define a 'wakeup_latency' synthetic event::
 
       # echo 'wakeup_latency u64 lat; pid_t pid; int prio' >> \
-              /sys/kernel/debug/tracing/synthetic_events
+              /sys/kernel/tracing/synthetic_events
 
     Next, we specify that whenever we see a sched_waking event for a
     cyclictest thread, save the timestamp in a 'ts0' variable::
 
       # echo 'hist:keys=$saved_pid:saved_pid=pid:ts0=common_timestamp.usecs \
               if comm=="cyclictest"' >> \
-	      /sys/kernel/debug/tracing/events/sched/sched_waking/trigger
+	      /sys/kernel/tracing/events/sched/sched_waking/trigger
 
     Then, when the corresponding thread is actually scheduled onto the
     CPU by a sched_switch event (saved_pid matches next_pid), calculate
@@ -2089,19 +2089,19 @@ The following commonly-used handler.action pairs are available:
       # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0:\
               onmatch(sched.sched_waking).wakeup_latency($wakeup_lat,\
 	              $saved_pid,next_prio) if next_comm=="cyclictest"' >> \
-	      /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
+	      /sys/kernel/tracing/events/sched/sched_switch/trigger
 
     We also need to create a histogram on the wakeup_latency synthetic
     event in order to aggregate the generated synthetic event data::
 
       # echo 'hist:keys=pid,prio,lat:sort=pid,lat' >> \
-              /sys/kernel/debug/tracing/events/synthetic/wakeup_latency/trigger
+              /sys/kernel/tracing/events/synthetic/wakeup_latency/trigger
 
     Finally, once we've run cyclictest to actually generate some
     events, we can see the output by looking at the wakeup_latency
     synthetic event's hist file::
 
-      # cat /sys/kernel/debug/tracing/events/synthetic/wakeup_latency/hist
+      # cat /sys/kernel/tracing/events/synthetic/wakeup_latency/hist
 
   - onmax(var).save(field,..	.)
 
@@ -2127,19 +2127,19 @@ The following commonly-used handler.action pairs are available:
 
       # echo 'hist:keys=pid:ts0=common_timestamp.usecs \
               if comm=="cyclictest"' >> \
-              /sys/kernel/debug/tracing/events/sched/sched_waking/trigger
+              /sys/kernel/tracing/events/sched/sched_waking/trigger
 
       # echo 'hist:keys=next_pid:\
               wakeup_lat=common_timestamp.usecs-$ts0:\
               onmax($wakeup_lat).save(next_comm,prev_pid,prev_prio,prev_comm) \
               if next_comm=="cyclictest"' >> \
-              /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
+              /sys/kernel/tracing/events/sched/sched_switch/trigger
 
     When the histogram is displayed, the max value and the saved
     values corresponding to the max are displayed following the rest
     of the fields::
 
-      # cat /sys/kernel/debug/tracing/events/sched/sched_switch/hist
+      # cat /sys/kernel/tracing/events/sched/sched_switch/hist
         { next_pid:       2255 } hitcount:        239
           common_timestamp-ts0:          0
           max:         27
@@ -2185,17 +2185,17 @@ The following commonly-used handler.action pairs are available:
     the scheduler events are also enabled, which are the events that
     will show up in the snapshot when it is taken at some point:
 
-    # echo 1 > /sys/kernel/debug/tracing/events/sched/enable
+    # echo 1 > /sys/kernel/tracing/events/sched/enable
 
     # echo 'hist:keys=pid:ts0=common_timestamp.usecs \
             if comm=="cyclictest"' >> \
-            /sys/kernel/debug/tracing/events/sched/sched_waking/trigger
+            /sys/kernel/tracing/events/sched/sched_waking/trigger
 
     # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0: \
             onmax($wakeup_lat).save(next_prio,next_comm,prev_pid,prev_prio, \
 	    prev_comm):onmax($wakeup_lat).snapshot() \
 	    if next_comm=="cyclictest"' >> \
-	    /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
+	    /sys/kernel/tracing/events/sched/sched_switch/trigger
 
     When the histogram is displayed, for each bucket the max value
     and the saved values corresponding to the max are displayed
@@ -2204,7 +2204,7 @@ The following commonly-used handler.action pairs are available:
     If a snapshot was taken, there is also a message indicating that,
     along with the value and event that triggered the global maximum:
 
-    # cat /sys/kernel/debug/tracing/events/sched/sched_switch/hist
+    # cat /sys/kernel/tracing/events/sched/sched_switch/hist
       { next_pid:       2101 } hitcount:        200
 	max:         52  next_prio:        120  next_comm: cyclictest \
         prev_pid:          0  prev_prio:        120  prev_comm: swapper/6
@@ -2239,7 +2239,7 @@ The following commonly-used handler.action pairs are available:
     sched_switch events, which should match the time displayed in the
     global maximum)::
 
-     # cat /sys/kernel/debug/tracing/snapshot
+     # cat /sys/kernel/tracing/snapshot
 
          <...>-2103  [005] d..3   309.873125: sched_switch: prev_comm=cyclictest prev_pid=2103 prev_prio=19 prev_state=D ==> next_comm=swapper/5 next_pid=0 next_prio=120
          <idle>-0     [005] d.h3   309.873611: sched_waking: comm=cyclictest pid=2102 prio=19 target_cpu=005
@@ -2304,13 +2304,13 @@ The following commonly-used handler.action pairs are available:
     enabled, which are the events that will show up in the snapshot
     when it is taken at some point:
 
-    # echo 1 > /sys/kernel/debug/tracing/events/sched/enable
-    # echo 1 > /sys/kernel/debug/tracing/events/tcp/enable
+    # echo 1 > /sys/kernel/tracing/events/sched/enable
+    # echo 1 > /sys/kernel/tracing/events/tcp/enable
 
     # echo 'hist:keys=dport:cwnd=snd_cwnd: \
             onchange($cwnd).save(snd_wnd,srtt,rcv_wnd): \
 	    onchange($cwnd).snapshot()' >> \
-	    /sys/kernel/debug/tracing/events/tcp/tcp_probe/trigger
+	    /sys/kernel/tracing/events/tcp/tcp_probe/trigger
 
     When the histogram is displayed, for each bucket the tracked value
     and the saved values corresponding to that value are displayed
@@ -2319,7 +2319,7 @@ The following commonly-used handler.action pairs are available:
     If a snapshot was taken, there is also a message indicating that,
     along with the value and event that triggered the snapshot::
 
-      # cat /sys/kernel/debug/tracing/events/tcp/tcp_probe/hist
+      # cat /sys/kernel/tracing/events/tcp/tcp_probe/hist
 
       { dport:       1521 } hitcount:          8
 	changed:         10  snd_wnd:      35456  srtt:     154262  rcv_wnd:      42112
@@ -2353,7 +2353,7 @@ The following commonly-used handler.action pairs are available:
     And finally, looking at the snapshot data should show at or near
     the end the event that triggered the snapshot::
 
-      # cat /sys/kernel/debug/tracing/snapshot
+      # cat /sys/kernel/tracing/snapshot
 
          gnome-shell-1261  [006] dN.3    49.823113: sched_stat_runtime: comm=gnome-shell pid=1261 runtime=49347 [ns] vruntime=1835730389 [ns]
        kworker/u16:4-773   [003] d..3    49.823114: sched_switch: prev_comm=kworker/u16:4 prev_pid=773 prev_prio=120 prev_state=R+ ==> next_comm=kworker/3:2 next_pid=135 next_prio=120
diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
index 4274cc6a2f94..2d1445fcefc4 100644
--- a/Documentation/trace/kprobetrace.rst
+++ b/Documentation/trace/kprobetrace.rst
@@ -17,10 +17,10 @@ To enable this feature, build your kernel with CONFIG_KPROBE_EVENTS=y.
 
 Similar to the events tracer, this doesn't need to be activated via
 current_tracer. Instead of that, add probe points via
-/sys/kernel/debug/tracing/kprobe_events, and enable it via
-/sys/kernel/debug/tracing/events/kprobes/<EVENT>/enable.
+/sys/kernel/tracing/kprobe_events, and enable it via
+/sys/kernel/tracing/events/kprobes/<EVENT>/enable.
 
-You can also use /sys/kernel/debug/tracing/dynamic_events instead of
+You can also use /sys/kernel/tracing/dynamic_events instead of
 kprobe_events. That interface will provide unified access to other
 dynamic events too.
 
@@ -146,7 +146,7 @@ trigger:
 Event Profiling
 ---------------
 You can check the total number of probe hits and probe miss-hits via
-/sys/kernel/debug/tracing/kprobe_profile.
+/sys/kernel/tracing/kprobe_profile.
 The first column is event name, the second is the number of probe hits,
 the third is the number of probe miss-hits.
 
@@ -170,7 +170,7 @@ Usage examples
 To add a probe as a new event, write a new definition to kprobe_events
 as below::
 
-  echo 'p:myprobe do_sys_open dfd=%ax filename=%dx flags=%cx mode=+4($stack)' > /sys/kernel/debug/tracing/kprobe_events
+  echo 'p:myprobe do_sys_open dfd=%ax filename=%dx flags=%cx mode=+4($stack)' > /sys/kernel/tracing/kprobe_events
 
 This sets a kprobe on the top of do_sys_open() function with recording
 1st to 4th arguments as "myprobe" event. Note, which register/stack entry is
@@ -180,15 +180,15 @@ under tools/perf/).
 As this example shows, users can choose more familiar names for each arguments.
 ::
 
-  echo 'r:myretprobe do_sys_open $retval' >> /sys/kernel/debug/tracing/kprobe_events
+  echo 'r:myretprobe do_sys_open $retval' >> /sys/kernel/tracing/kprobe_events
 
 This sets a kretprobe on the return point of do_sys_open() function with
 recording return value as "myretprobe" event.
 You can see the format of these events via
-/sys/kernel/debug/tracing/events/kprobes/<EVENT>/format.
+/sys/kernel/tracing/events/kprobes/<EVENT>/format.
 ::
 
-  cat /sys/kernel/debug/tracing/events/kprobes/myprobe/format
+  cat /sys/kernel/tracing/events/kprobes/myprobe/format
   name: myprobe
   ID: 780
   format:
@@ -211,7 +211,7 @@ You can see the format of these events via
 You can see that the event has 4 arguments as in the expressions you specified.
 ::
 
-  echo > /sys/kernel/debug/tracing/kprobe_events
+  echo > /sys/kernel/tracing/kprobe_events
 
 This clears all probe points.
 
@@ -226,8 +226,8 @@ Right after definition, each event is disabled by default. For tracing these
 events, you need to enable it.
 ::
 
-  echo 1 > /sys/kernel/debug/tracing/events/kprobes/myprobe/enable
-  echo 1 > /sys/kernel/debug/tracing/events/kprobes/myretprobe/enable
+  echo 1 > /sys/kernel/tracing/events/kprobes/myprobe/enable
+  echo 1 > /sys/kernel/tracing/events/kprobes/myretprobe/enable
 
 Use the following command to start tracing in an interval.
 ::
@@ -236,10 +236,10 @@ Use the following command to start tracing in an interval.
     Open something...
     # echo 0 > tracing_on
 
-And you can see the traced information via /sys/kernel/debug/tracing/trace.
+And you can see the traced information via /sys/kernel/tracing/trace.
 ::
 
-  cat /sys/kernel/debug/tracing/trace
+  cat /sys/kernel/tracing/trace
   # tracer: nop
   #
   #           TASK-PID    CPU#    TIMESTAMP  FUNCTION
diff --git a/Documentation/trace/mmiotrace.rst b/Documentation/trace/mmiotrace.rst
index fed13eaead89..95b750722a13 100644
--- a/Documentation/trace/mmiotrace.rst
+++ b/Documentation/trace/mmiotrace.rst
@@ -36,11 +36,11 @@ Usage Quick Reference
 ::
 
 	$ mount -t debugfs debugfs /sys/kernel/debug
-	$ echo mmiotrace > /sys/kernel/debug/tracing/current_tracer
-	$ cat /sys/kernel/debug/tracing/trace_pipe > mydump.txt &
+	$ echo mmiotrace > /sys/kernel/tracing/current_tracer
+	$ cat /sys/kernel/tracing/trace_pipe > mydump.txt &
 	Start X or whatever.
-	$ echo "X is up" > /sys/kernel/debug/tracing/trace_marker
-	$ echo nop > /sys/kernel/debug/tracing/current_tracer
+	$ echo "X is up" > /sys/kernel/tracing/trace_marker
+	$ echo nop > /sys/kernel/tracing/current_tracer
 	Check for lost events.
 
 
@@ -56,11 +56,11 @@ Check that the driver you are about to trace is not loaded.
 
 Activate mmiotrace (requires root privileges)::
 
-	$ echo mmiotrace > /sys/kernel/debug/tracing/current_tracer
+	$ echo mmiotrace > /sys/kernel/tracing/current_tracer
 
 Start storing the trace::
 
-	$ cat /sys/kernel/debug/tracing/trace_pipe > mydump.txt &
+	$ cat /sys/kernel/tracing/trace_pipe > mydump.txt &
 
 The 'cat' process should stay running (sleeping) in the background.
 
@@ -68,14 +68,14 @@ Load the driver you want to trace and use it. Mmiotrace will only catch MMIO
 accesses to areas that are ioremapped while mmiotrace is active.
 
 During tracing you can place comments (markers) into the trace by
-$ echo "X is up" > /sys/kernel/debug/tracing/trace_marker
+$ echo "X is up" > /sys/kernel/tracing/trace_marker
 This makes it easier to see which part of the (huge) trace corresponds to
 which action. It is recommended to place descriptive markers about what you
 do.
 
 Shut down mmiotrace (requires root privileges)::
 
-	$ echo nop > /sys/kernel/debug/tracing/current_tracer
+	$ echo nop > /sys/kernel/tracing/current_tracer
 
 The 'cat' process exits. If it does not, kill it by issuing 'fg' command and
 pressing ctrl+c.
@@ -93,12 +93,12 @@ events were lost, the trace is incomplete. You should enlarge the buffers and
 try again. Buffers are enlarged by first seeing how large the current buffers
 are::
 
-	$ cat /sys/kernel/debug/tracing/buffer_size_kb
+	$ cat /sys/kernel/tracing/buffer_size_kb
 
 gives you a number. Approximately double this number and write it back, for
 instance::
 
-	$ echo 128000 > /sys/kernel/debug/tracing/buffer_size_kb
+	$ echo 128000 > /sys/kernel/tracing/buffer_size_kb
 
 Then start again from the top.
 
diff --git a/Documentation/trace/postprocess/trace-pagealloc-postprocess.pl b/Documentation/trace/postprocess/trace-pagealloc-postprocess.pl
index b9b7d80c2f9d..d16494c5e200 100644
--- a/Documentation/trace/postprocess/trace-pagealloc-postprocess.pl
+++ b/Documentation/trace/postprocess/trace-pagealloc-postprocess.pl
@@ -4,7 +4,7 @@
 # to extract some high-level information on what is going on. The accuracy of the parser
 # may vary considerably
 #
-# Example usage: trace-pagealloc-postprocess.pl < /sys/kernel/debug/tracing/trace_pipe
+# Example usage: trace-pagealloc-postprocess.pl < /sys/kernel/tracing/trace_pipe
 # other options
 #   --prepend-parent	Report on the parent proc and PID
 #   --read-procstat	If the trace lacks process info, get it from /proc
@@ -94,7 +94,7 @@ sub generate_traceevent_regex {
 	my $regex;
 
 	# Read the event format or use the default
-	if (!open (FORMAT, "/sys/kernel/debug/tracing/events/$event/format")) {
+	if (!open (FORMAT, "/sys/kernel/tracing/events/$event/format")) {
 		$regex = $default;
 	} else {
 		my $line;
diff --git a/Documentation/trace/postprocess/trace-vmscan-postprocess.pl b/Documentation/trace/postprocess/trace-vmscan-postprocess.pl
index 2f4e39875fb3..e24c009789a0 100644
--- a/Documentation/trace/postprocess/trace-vmscan-postprocess.pl
+++ b/Documentation/trace/postprocess/trace-vmscan-postprocess.pl
@@ -3,7 +3,7 @@
 # page reclaim. It makes an attempt to extract some high-level information on
 # what is going on. The accuracy of the parser may vary
 #
-# Example usage: trace-vmscan-postprocess.pl < /sys/kernel/debug/tracing/trace_pipe
+# Example usage: trace-vmscan-postprocess.pl < /sys/kernel/tracing/trace_pipe
 # other options
 #   --read-procstat	If the trace lacks process info, get it from /proc
 #   --ignore-pid	Aggregate processes of the same name together
@@ -140,7 +140,7 @@ sub generate_traceevent_regex {
 	my $regex;
 
 	# Read the event format or use the default
-	if (!open (FORMAT, "/sys/kernel/debug/tracing/events/$event/format")) {
+	if (!open (FORMAT, "/sys/kernel/tracing/events/$event/format")) {
 		print("WARNING: Event $event format string not found\n");
 		return $default;
 	} else {
diff --git a/Documentation/trace/tracepoint-analysis.rst b/Documentation/trace/tracepoint-analysis.rst
index 716326b9f152..be01bf7b47e5 100644
--- a/Documentation/trace/tracepoint-analysis.rst
+++ b/Documentation/trace/tracepoint-analysis.rst
@@ -26,10 +26,10 @@ assumed that the PCL tool tools/perf has been installed and is in your path.
 2.1 Standard Utilities
 ----------------------
 
-All possible events are visible from /sys/kernel/debug/tracing/events. Simply
+All possible events are visible from /sys/kernel/tracing/events. Simply
 calling::
 
-  $ find /sys/kernel/debug/tracing/events -type d
+  $ find /sys/kernel/tracing/events -type d
 
 will give a fair indication of the number of events available.
 
@@ -59,7 +59,7 @@ See Documentation/trace/events.rst for a proper description on how events
 can be enabled system-wide. A short example of enabling all events related
 to page allocation would look something like::
 
-  $ for i in `find /sys/kernel/debug/tracing/events -name "enable" | grep mm_`; do echo 1 > $i; done
+  $ for i in `find /sys/kernel/tracing/events -name "enable" | grep mm_`; do echo 1 > $i; done
 
 3.2 System-Wide Event Enabling with SystemTap
 ---------------------------------------------
@@ -189,7 +189,7 @@ time on a system-wide basis using -a and sleep.
 ============================================
 
 When events are enabled the events that are triggering can be read from
-/sys/kernel/debug/tracing/trace_pipe in human-readable format although binary
+/sys/kernel/tracing/trace_pipe in human-readable format although binary
 options exist as well. By post-processing the output, further information can
 be gathered on-line as appropriate. Examples of post-processing might include
 
diff --git a/Documentation/trace/uprobetracer.rst b/Documentation/trace/uprobetracer.rst
index 3a1797d707f4..122d15572fd5 100644
--- a/Documentation/trace/uprobetracer.rst
+++ b/Documentation/trace/uprobetracer.rst
@@ -12,13 +12,13 @@ To enable this feature, build your kernel with CONFIG_UPROBE_EVENTS=y.
 
 Similar to the kprobe-event tracer, this doesn't need to be activated via
 current_tracer. Instead of that, add probe points via
-/sys/kernel/debug/tracing/uprobe_events, and enable it via
-/sys/kernel/debug/tracing/events/uprobes/<EVENT>/enable.
+/sys/kernel/tracing/uprobe_events, and enable it via
+/sys/kernel/tracing/events/uprobes/<EVENT>/enable.
 
 However unlike kprobe-event tracer, the uprobe event interface expects the
 user to calculate the offset of the probepoint in the object.
 
-You can also use /sys/kernel/debug/tracing/dynamic_events instead of
+You can also use /sys/kernel/tracing/dynamic_events instead of
 uprobe_events. That interface will provide unified access to other
 dynamic events too.
 
@@ -79,7 +79,7 @@ For $comm, the default type is "string"; any other type is invalid.
 Event Profiling
 ---------------
 You can check the total number of probe hits per event via
-/sys/kernel/debug/tracing/uprobe_profile. The first column is the filename,
+/sys/kernel/tracing/uprobe_profile. The first column is the filename,
 the second is the event name, the third is the number of probe hits.
 
 Usage examples
@@ -87,28 +87,28 @@ Usage examples
  * Add a probe as a new uprobe event, write a new definition to uprobe_events
    as below (sets a uprobe at an offset of 0x4245c0 in the executable /bin/bash)::
 
-    echo 'p /bin/bash:0x4245c0' > /sys/kernel/debug/tracing/uprobe_events
+    echo 'p /bin/bash:0x4245c0' > /sys/kernel/tracing/uprobe_events
 
  * Add a probe as a new uretprobe event::
 
-    echo 'r /bin/bash:0x4245c0' > /sys/kernel/debug/tracing/uprobe_events
+    echo 'r /bin/bash:0x4245c0' > /sys/kernel/tracing/uprobe_events
 
  * Unset registered event::
 
-    echo '-:p_bash_0x4245c0' >> /sys/kernel/debug/tracing/uprobe_events
+    echo '-:p_bash_0x4245c0' >> /sys/kernel/tracing/uprobe_events
 
  * Print out the events that are registered::
 
-    cat /sys/kernel/debug/tracing/uprobe_events
+    cat /sys/kernel/tracing/uprobe_events
 
  * Clear all events::
 
-    echo > /sys/kernel/debug/tracing/uprobe_events
+    echo > /sys/kernel/tracing/uprobe_events
 
 Following example shows how to dump the instruction pointer and %ax register
 at the probed text address. Probe zfree function in /bin/zsh::
 
-    # cd /sys/kernel/debug/tracing/
+    # cd /sys/kernel/tracing/
     # cat /proc/`pgrep zsh`/maps | grep /bin/zsh | grep r-xp
     00400000-0048a000 r-xp 00000000 08:03 130904 /bin/zsh
     # objdump -T /bin/zsh | grep -w zfree
@@ -168,7 +168,7 @@ Also, you can disable the event by::
 
     # echo 0 > events/uprobes/enable
 
-And you can see the traced information via /sys/kernel/debug/tracing/trace.
+And you can see the traced information via /sys/kernel/tracing/trace.
 ::
 
     # cat trace
diff --git a/Documentation/trace/user_events.rst b/Documentation/trace/user_events.rst
index 9f181f342a70..422802ef4025 100644
--- a/Documentation/trace/user_events.rst
+++ b/Documentation/trace/user_events.rst
@@ -11,10 +11,10 @@ that can be viewed via existing tools, such as ftrace and perf.
 To enable this feature, build your kernel with CONFIG_USER_EVENTS=y.
 
 Programs can view status of the events via
-/sys/kernel/debug/tracing/user_events_status and can both register and write
-data out via /sys/kernel/debug/tracing/user_events_data.
+/sys/kernel/tracing/user_events_status and can both register and write
+data out via /sys/kernel/tracing/user_events_data.
 
-Programs can also use /sys/kernel/debug/tracing/dynamic_events to register and
+Programs can also use /sys/kernel/tracing/dynamic_events to register and
 delete user based events via the u: prefix. The format of the command to
 dynamic_events is the same as the ioctl with the u: prefix applied.
 
@@ -22,9 +22,9 @@ Typically programs will register a set of events that they wish to expose to
 tools that can read trace_events (such as ftrace and perf). The registration
 process gives back two ints to the program for each event. The first int is
 the status bit. This describes which bit in little-endian format in the
-/sys/kernel/debug/tracing/user_events_status file represents this event. The
+/sys/kernel/tracing/user_events_status file represents this event. The
 second int is the write index which describes the data when a write() or
-writev() is called on the /sys/kernel/debug/tracing/user_events_data file.
+writev() is called on the /sys/kernel/tracing/user_events_data file.
 
 The structures referenced in this document are contained within the
 /include/uapi/linux/user_events.h file in the source tree.
@@ -35,7 +35,7 @@ filesystem and may be mounted at different paths than above.*
 Registering
 -----------
 Registering within a user process is done via ioctl() out to the
-/sys/kernel/debug/tracing/user_events_data file. The command to issue is
+/sys/kernel/tracing/user_events_data file. The command to issue is
 DIAG_IOCSREG.
 
 This command takes a packed struct user_reg as an argument::
@@ -54,7 +54,7 @@ and the write index.
 
 User based events show up under tracefs like any other event under the
 subsystem named "user_events". This means tools that wish to attach to the
-events need to use /sys/kernel/debug/tracing/events/user_events/[name]/enable
+events need to use /sys/kernel/tracing/events/user_events/[name]/enable
 or perf record -e user_events:[name] when attaching/recording.
 
 **NOTE:** *The write_index returned is only valid for the FD that was used*
@@ -96,7 +96,7 @@ Would be represented by the following field::
 Deleting
 -----------
 Deleting an event from within a user process is done via ioctl() out to the
-/sys/kernel/debug/tracing/user_events_data file. The command to issue is
+/sys/kernel/tracing/user_events_data file. The command to issue is
 DIAG_IOCSDEL.
 
 This command only requires a single string specifying the event to delete by
@@ -110,7 +110,7 @@ When tools attach/record user based events the status of the event is updated
 in realtime. This allows user programs to only incur the cost of the write() or
 writev() calls when something is actively attached to the event.
 
-User programs call mmap() on /sys/kernel/debug/tracing/user_events_status to
+User programs call mmap() on /sys/kernel/tracing/user_events_status to
 check the status for each event that is registered. The bit to check in the
 file is given back after the register ioctl() via user_reg.status_bit. The bit
 is always in little-endian format. Programs can check if the bit is set either
diff --git a/Documentation/translations/zh_CN/core-api/workqueue.rst b/Documentation/translations/zh_CN/core-api/workqueue.rst
index f6567cf9d3fb..6c1b5ec31d75 100644
--- a/Documentation/translations/zh_CN/core-api/workqueue.rst
+++ b/Documentation/translations/zh_CN/core-api/workqueue.rst
@@ -313,8 +313,8 @@ And with cmwq with ``@max_active`` >= 3, ::
 
 第一个可以用追踪的方式进行跟踪: ::
 
-	$ echo workqueue:workqueue_queue_work > /sys/kernel/debug/tracing/set_event
-	$ cat /sys/kernel/debug/tracing/trace_pipe > out.txt
+	$ echo workqueue:workqueue_queue_work > /sys/kernel/tracing/set_event
+	$ cat /sys/kernel/tracing/trace_pipe > out.txt
 	(wait a few secs)
 
 如果有什么东西在工作队列上忙着做循环，它就会主导输出，可以用工作项函数确定违规者。
diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
index 71a531061e4e..d218d70d8853 100644
--- a/Documentation/x86/resctrl.rst
+++ b/Documentation/x86/resctrl.rst
@@ -608,12 +608,12 @@ how we can measure the latency in cycles of reading from this region and
 visualize this data with a histogram that is available if CONFIG_HIST_TRIGGERS
 is set::
 
-  # :> /sys/kernel/debug/tracing/trace
-  # echo 'hist:keys=latency' > /sys/kernel/debug/tracing/events/resctrl/pseudo_lock_mem_latency/trigger
-  # echo 1 > /sys/kernel/debug/tracing/events/resctrl/pseudo_lock_mem_latency/enable
+  # :> /sys/kernel/tracing/trace
+  # echo 'hist:keys=latency' > /sys/kernel/tracing/events/resctrl/pseudo_lock_mem_latency/trigger
+  # echo 1 > /sys/kernel/tracing/events/resctrl/pseudo_lock_mem_latency/enable
   # echo 1 > /sys/kernel/debug/resctrl/newlock/pseudo_lock_measure
-  # echo 0 > /sys/kernel/debug/tracing/events/resctrl/pseudo_lock_mem_latency/enable
-  # cat /sys/kernel/debug/tracing/events/resctrl/pseudo_lock_mem_latency/hist
+  # echo 0 > /sys/kernel/tracing/events/resctrl/pseudo_lock_mem_latency/enable
+  # cat /sys/kernel/tracing/events/resctrl/pseudo_lock_mem_latency/hist
 
   # event histogram
   #
@@ -642,11 +642,11 @@ cache of a platform. Here is how we can obtain details of the cache hits
 and misses using the platform's precision counters.
 ::
 
-  # :> /sys/kernel/debug/tracing/trace
-  # echo 1 > /sys/kernel/debug/tracing/events/resctrl/pseudo_lock_l2/enable
+  # :> /sys/kernel/tracing/trace
+  # echo 1 > /sys/kernel/tracing/events/resctrl/pseudo_lock_l2/enable
   # echo 2 > /sys/kernel/debug/resctrl/newlock/pseudo_lock_measure
-  # echo 0 > /sys/kernel/debug/tracing/events/resctrl/pseudo_lock_l2/enable
-  # cat /sys/kernel/debug/tracing/trace
+  # echo 0 > /sys/kernel/tracing/events/resctrl/pseudo_lock_l2/enable
+  # cat /sys/kernel/tracing/trace
 
   # tracer: nop
   #
-- 
2.39.1.456.gfc5497dd1b-goog

