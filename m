Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D464369BBCA
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 21:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjBRUTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 15:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjBRUTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 15:19:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471821498B
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 12:19:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1FE660BEA
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 20:19:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D30C43446;
        Sat, 18 Feb 2023 20:19:34 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pTTgD-000xw7-1z;
        Sat, 18 Feb 2023 15:19:33 -0500
Message-ID: <20230218201933.431917261@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 18 Feb 2023 15:18:29 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [for-next][PATCH 8/8] Documentation/rtla: Add hwnoise man page
References: <20230218201821.938318263@goodmis.org>
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

From: Daniel Bristot de Oliveira <bristot@kernel.org>

Add a man page for the new rtla hwnoise tool, mostly based in the
rtla osnoise top.

Link: https://lkml.kernel.org/r/27088e0f42a6129e9b75f789d78adff4171f2e79.1675805361.git.bristot@kernel.org

Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/tools/rtla/index.rst        |   1 +
 Documentation/tools/rtla/rtla-hwnoise.rst | 107 ++++++++++++++++++++++
 2 files changed, 108 insertions(+)
 create mode 100644 Documentation/tools/rtla/rtla-hwnoise.rst

diff --git a/Documentation/tools/rtla/index.rst b/Documentation/tools/rtla/index.rst
index 840f0bf3e803..05d2652e4072 100644
--- a/Documentation/tools/rtla/index.rst
+++ b/Documentation/tools/rtla/index.rst
@@ -17,6 +17,7 @@ behavior on specific hardware.
    rtla-timerlat
    rtla-timerlat-hist
    rtla-timerlat-top
+   rtla-hwnoise
 
 .. only::  subproject and html
 
diff --git a/Documentation/tools/rtla/rtla-hwnoise.rst b/Documentation/tools/rtla/rtla-hwnoise.rst
new file mode 100644
index 000000000000..fb1c52bbc00b
--- /dev/null
+++ b/Documentation/tools/rtla/rtla-hwnoise.rst
@@ -0,0 +1,107 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============
+rtla-hwnoise
+============
+------------------------------------------
+Detect and quantify hardware-related noise
+------------------------------------------
+
+:Manual section: 1
+
+SYNOPSIS
+========
+
+**rtla hwnoise** [*OPTIONS*]
+
+DESCRIPTION
+===========
+
+**rtla hwnoise** collects the periodic summary from the *osnoise* tracer
+running with *interrupts disabled*. By disabling interrupts, and the scheduling
+of threads as a consequence, only non-maskable interrupts and hardware-related
+noise is allowed.
+
+The tool also allows the configurations of the *osnoise* tracer and the
+collection of the tracer output.
+
+OPTIONS
+=======
+.. include:: common_osnoise_options.rst
+
+.. include:: common_top_options.rst
+
+.. include:: common_options.rst
+
+EXAMPLE
+=======
+In the example below, the **rtla hwnoise** tool is set to run on CPUs *1-7*
+on a system with 8 cores/16 threads with hyper-threading enabled.
+
+The tool is set to detect any noise higher than *one microsecond*,
+to run for *ten minutes*, displaying a summary of the report at the
+end of the session::
+
+  # rtla hwnoise -c 1-7 -T 1 -d 10m -q
+                                          Hardware-related Noise
+  duration:   0 00:10:00 | time is in us
+  CPU Period       Runtime        Noise  % CPU Aval   Max Noise   Max Single          HW          NMI
+    1 #599       599000000          138    99.99997           3            3           4           74
+    2 #599       599000000           85    99.99998           3            3           4           75
+    3 #599       599000000           86    99.99998           4            3           6           75
+    4 #599       599000000           81    99.99998           4            4           2           75
+    5 #599       599000000           85    99.99998           2            2           2           75
+    6 #599       599000000           76    99.99998           2            2           0           75
+    7 #599       599000000           77    99.99998           3            3           0           75
+
+
+The first column shows the *CPU*, and the second column shows how many
+*Periods* the tool ran during the session. The *Runtime* is the time
+the tool effectively runs on the CPU. The *Noise* column is the sum of
+all noise that the tool observed, and the *% CPU Aval* is the relation
+between the *Runtime* and *Noise*.
+
+The *Max Noise* column is the maximum hardware noise the tool detected in a
+single period, and the *Max Single* is the maximum single noise seen.
+
+The *HW* and *NMI* columns show the total number of *hardware* and *NMI* noise
+occurrence observed by the tool.
+
+For example, *CPU 3* ran *599* periods of *1 second Runtime*. The CPU received
+*86 us* of noise during the entire execution, leaving *99.99997 %* of CPU time
+for the application. In the worst single period, the CPU caused *4 us* of
+noise to the application, but it was certainly caused by more than one single
+noise, as the *Max Single* noise was of *3 us*. The CPU has *HW noise,* at a
+rate of *six occurrences*/*ten minutes*. The CPU also has *NMIs*, at a higher
+frequency: around *seven per second*.
+
+The tool should report *0* hardware-related noise in the ideal situation.
+For example, by disabling hyper-threading to remove the hardware noise,
+and disabling the TSC watchdog to remove the NMI (it is possible to identify
+this using tracing options of **rtla hwnoise**), it was possible to reach
+the ideal situation in the same hardware::
+
+  # rtla hwnoise -c 1-7 -T 1 -d 10m -q
+                                          Hardware-related Noise
+  duration:   0 00:10:00 | time is in us
+  CPU Period       Runtime        Noise  % CPU Aval   Max Noise   Max Single          HW          NMI
+    1 #599       599000000            0   100.00000           0            0           0            0
+    2 #599       599000000            0   100.00000           0            0           0            0
+    3 #599       599000000            0   100.00000           0            0           0            0
+    4 #599       599000000            0   100.00000           0            0           0            0
+    5 #599       599000000            0   100.00000           0            0           0            0
+    6 #599       599000000            0   100.00000           0            0           0            0
+    7 #599       599000000            0   100.00000           0            0           0            0
+
+SEE ALSO
+========
+
+**rtla-osnoise**\(1)
+
+Osnoise tracer documentation: <https://www.kernel.org/doc/html/latest/trace/osnoise-tracer.html>
+
+AUTHOR
+======
+Written by Daniel Bristot de Oliveira <bristot@kernel.org>
+
+.. include:: common_appendix.rst
-- 
2.39.1
