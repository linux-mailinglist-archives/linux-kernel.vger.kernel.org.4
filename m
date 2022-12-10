Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA09D648F17
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 15:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiLJN77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 08:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiLJN6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 08:58:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6201518E0F
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 05:58:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 435E360C3B
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 13:58:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DAD1C43396;
        Sat, 10 Dec 2022 13:58:28 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1p40N1-000kwr-0j;
        Sat, 10 Dec 2022 08:58:27 -0500
Message-ID: <20221210135827.094878105@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 10 Dec 2022 08:58:15 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [for-next][PATCH 25/25] Documentation/osnoise: Add osnoise/options documentation
References: <20221210135750.425719934@goodmis.org>
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

Add the documentation about the osnoise/options file, the options,
and some additional explanation about the OSNOISE_WORKLOAD option.

Link: https://lkml.kernel.org/r/fde5567a4bae364f67fd1e9a644d1d62862618a6.1670623111.git.bristot@kernel.org

Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/trace/osnoise-tracer.rst | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/trace/osnoise-tracer.rst b/Documentation/trace/osnoise-tracer.rst
index fdd562d7c22d..140ef2533d26 100644
--- a/Documentation/trace/osnoise-tracer.rst
+++ b/Documentation/trace/osnoise-tracer.rst
@@ -92,8 +92,8 @@ Note that the example above shows a high number of HW noise samples.
 The reason being is that this sample was taken on a virtual machine,
 and the host interference is detected as a hardware interference.
 
-Tracer options
----------------------
+Tracer Configuration
+--------------------
 
 The tracer has a set of options inside the osnoise directory, they are:
 
@@ -115,6 +115,22 @@ The tracer has a set of options inside the osnoise directory, they are:
    NO_OSNOISE_WORKLOAD disables the OSNOISE_WORKLOAD option. The
    special DEAFAULTS option resets all options to the default value.
 
+Tracer Options
+--------------
+
+The osnoise/options file exposes a set of on/off configuration options for
+the osnoise tracer. These options are:
+
+ - DEFAULTS: reset the options to the default value.
+ - OSNOISE_WORKLOAD: do not dispatch osnoise workload (see dedicated
+   section below).
+ - PANIC_ON_STOP: call panic() if the tracer stops. This option serves to
+   capture a vmcore.
+ - OSNOISE_PREEMPT_DISABLE: disable preemption while running the osnoise
+   workload, allowing only IRQ and hardware-related noise.
+ - OSNOISE_IRQ_DISABLE: disable IRQs while running the osnoise workload,
+   allowing only NMIs and hardware-related noise, like hwlat tracer.
+
 Additional Tracing
 ------------------
 
-- 
2.35.1


