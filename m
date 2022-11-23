Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82DFB636696
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 18:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239131AbiKWRHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 12:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238904AbiKWRGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 12:06:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D69C5B51;
        Wed, 23 Nov 2022 09:06:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FE3661DEC;
        Wed, 23 Nov 2022 17:06:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26521C43470;
        Wed, 23 Nov 2022 17:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669223204;
        bh=wx38S8oDI/3l7QO5/iOpwcyoWSlY3bOo8MNcfNr6WO8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b/fagKtWUhKJtbRJor0oTXVyLiMPuyF+ekrSh4ajY32KOJCqwkQZC/WYTFXOcdI3Q
         kN4IbX198yi8Tej6qJYMnQoiY5WOc4l961AtInYV0qsPonyLjEqb2FVTdEHk3U1n7O
         AXNQU+8tJU6SLtUalujKnx85OgapVKsO8T4Mf85sH0UA8hXv6F/zn/d1qP09i1a0fA
         VhlaDw0PhdPgJStJWwGhtZ58OZqHGCPgMkYp0a3+hUeeBJYW1NPDqq2f7MebxwdEI3
         vdf7OGZB4WR3vLchauCrRU91A4J88OLtx4+p54t8+XAhdmyx0rWm6HZkKB5YBa88/7
         WxwqidzJ38sbw==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 6/6] Documentation/osnoise: Add osnoise/options documentation
Date:   Wed, 23 Nov 2022 18:06:24 +0100
Message-Id: <f1a1569c22aef2744e0b787cdd414465750dc7c2.1669115208.git.bristot@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1669115208.git.bristot@kernel.org>
References: <cover.1669115208.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the documentation about the osnoise/options file, the options,
and some additional explanation about the OSNOISE_WORKLOAD option.

Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 Documentation/trace/osnoise-tracer.rst | 32 ++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/Documentation/trace/osnoise-tracer.rst b/Documentation/trace/osnoise-tracer.rst
index 963def9f97c6..618bcdc90bb6 100644
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
 
@@ -109,6 +109,27 @@ The tracer has a set of options inside the osnoise directory, they are:
  - tracing_threshold: the minimum delta between two time() reads to be
    considered as noise, in us. When set to 0, the default value will
    be used, which is currently 5 us.
+ - osnoise/options: a set of on/off options that can be enabled by
+   writing the option name to the file or disabled by writing the option
+   name preceded with the 'NO_' prefix. For example, writing
+   NO_OSNOISE_WORKLOAD disables the OSNOISE_WORKLOAD option. The
+   special DEAFAULTS option resets all options to the default value.
+
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
+    capture a vmcore.
+ - OSNOISE_PREEMPT_DISABLE: disable preemption while running the osnoise
+   workload, allowing only IRQ-related and hardware-related noise.
+ - OSNOISE_IRQ_DISABLE: disable IRQs while running the osnoise workload,
+   allowing only NMIs and hardware-related noise, like hwlat tracer.
 
 Additional Tracing
 ------------------
@@ -150,3 +171,10 @@ tracepoints is smaller than eight us reported in the sample_threshold.
 The reason roots in the overhead of the entry and exit code that happens
 before and after any interference execution. This justifies the dual
 approach: measuring thread and tracing.
+
+Running osnoise tracer without workload
+---------------------------------------
+
+By enabling the osnoise tracer with the NO_OSNOISE_WORKLOAD option set,
+the osnoise: tracepoints serves to measure the execution time of
+any type of Linux task, free from the interference of other tasks.
-- 
2.32.0

