Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF5662DD1B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 14:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240257AbiKQNqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 08:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239997AbiKQNqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 08:46:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9C272993;
        Thu, 17 Nov 2022 05:46:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4322F61E3B;
        Thu, 17 Nov 2022 13:46:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D8AAC433D7;
        Thu, 17 Nov 2022 13:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668692793;
        bh=wIs6OQ9wUma9T3nTyddN8q7kE8iPbPMX9EIUDRvWD88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iDQFKQzvg0VfXgx9T73PhPe0D2nAyg+9d0aSuv/NaygYXlIGstQhEwBW1xVAbpttz
         jEy5KEcFZsgdsR22cdR5fGdP35chxR4ksV4erWaKHEqT0A7KH6FmxI5PFqTFEFWlTb
         Uft/SjIIdXBFKv4rWy6T8W7YWF73ki+XRNov+E56uhDnaye3XezVdXI0m0pD2G4TIW
         gnSAt/Gzqw7zmq9cYnDodrz60JTY2yOdwarz7hQzGAYzGiz1ljOSIN8du6WEqlimd5
         IRejCvZJwKdeDXtolBdQO+qV/oQJUAzAbkAUG/wZkRK974IgUYzSVb1hbOTQybhB9Q
         zsJKUmiL2DafA==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] Documentation/osnoise: Add osnoise/options documentation
Date:   Thu, 17 Nov 2022 14:46:20 +0100
Message-Id: <777af8f3d87beedd304805f98eff6c8291d64226.1668692096.git.bristot@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1668692096.git.bristot@kernel.org>
References: <cover.1668692096.git.bristot@kernel.org>
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

Add the documentation about the osnoise/options file, along
with an explanation about the OSNOISE_WORKLOAD option.

Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 Documentation/trace/osnoise-tracer.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/trace/osnoise-tracer.rst b/Documentation/trace/osnoise-tracer.rst
index 963def9f97c6..e1eed255a4ac 100644
--- a/Documentation/trace/osnoise-tracer.rst
+++ b/Documentation/trace/osnoise-tracer.rst
@@ -109,6 +109,11 @@ The tracer has a set of options inside the osnoise directory, they are:
  - tracing_threshold: the minimum delta between two time() reads to be
    considered as noise, in us. When set to 0, the default value will
    be used, which is currently 5 us.
+ - osnoise/options: a set of on/off options that can be enabled by
+   writing the option name to the file or disabled by writing the option
+   name preceded with the 'NO_' prefix. For example, writing
+   NO_OSNOISE_WORKLOAD disables the OSNOISE_WORKLOAD option. The
+   special DEAFAULTS option resets all options to the default value.
 
 Additional Tracing
 ------------------
@@ -150,3 +155,10 @@ tracepoints is smaller than eight us reported in the sample_threshold.
 The reason roots in the overhead of the entry and exit code that happens
 before and after any interference execution. This justifies the dual
 approach: measuring thread and tracing.
+
+Running osnoise tracer without workload
+---------------------------------------
+
+By enabling the osnoise tracer with the NO_OSNOISE_WORKLOAD option set,
+the osnoise: tracepoints serve to measure the execution time of
+any type of Linux task, free from the interference of other tasks.
-- 
2.32.0

