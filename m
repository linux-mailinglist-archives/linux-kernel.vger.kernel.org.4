Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C104D61F66D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbiKGOns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbiKGOno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:43:44 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991FB63AD;
        Mon,  7 Nov 2022 06:43:40 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id e15so8208523qvo.4;
        Mon, 07 Nov 2022 06:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=gc232Q/sHxhB4Tw9GHxF3SEryN15BBvVfGsyv7GLejI=;
        b=FzdNDEU80Vfm+/Mn6taCLIfKXq0If84ZDF23eu2iKZG4DEt/BupujN2r0QeOFU9gzO
         Tb/9/nPia2P5z7dKXPBEA/Y5T9lqIzmZ1PpPN7Kzu6RWHyhfM594Iwh0EpXFmBI/lzZs
         jBEqWFdLHWA4UVjFnFYQln2xlvFYjyBoOr6WPxj/2bqNnVxGy2znTN77dlx5az9zJsFn
         4YfyjTBDufIDyXIx2jf8+F43Nz9NGDe2YGzBmN4T7OPtPWwo1flz2I4FR8b1/1Xkt9Fe
         ZTq/R0ArvJON8rbcxtFOa59dNhU+VTznDQJws5FiUrKzOYAPoLn3cbwTX4MievZxJeyJ
         NdiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gc232Q/sHxhB4Tw9GHxF3SEryN15BBvVfGsyv7GLejI=;
        b=Y2oOh/cZEyYAxSMryCG9LnHpSr3IFzx8GT2ZpS8K0PW4p4jNui1evWOZZoYbOzkqQG
         RXCCVxTTesx0nFvNre+wXO1Koj7LsHfbrec2OFGktmefz9gHyiX4KICPlgdYxXtNmmRB
         TUjZv67iWCNiIaUVJq283jL8GA4YOs9ILK5Dqh4jP4EB3SWYo+EbTgK/Gv53sN0htHCx
         dDfqomiOJZe6OSfSvJJ7EmT0kPT8qZgzlefxC7mJDHfsj2yqDfmGXOv7FsBY3Si9/yaF
         9Vg3FnUKKeMMWmnD7xVqawPSZg5v3c9IkQR+41oHCxYHt6dwE8/fgxsZoysHpUpd7kF0
         EpwQ==
X-Gm-Message-State: ACrzQf0PkFg1LwdIpsEegbcbWWdpQkKjlZrY5ldri1pRdHUHUuIkePUh
        S5CAnAqzQAroDQz/EGJWDbcivVRvlPc=
X-Google-Smtp-Source: AMsMyM7xjhGXCMyN1RJjs06evKtiQBruZIrFODbvih6QDdBMODbATw4MkOLNLFPZVsIG5qTdcATNWQ==
X-Received: by 2002:a05:6214:2346:b0:4c1:8906:8726 with SMTP id hu6-20020a056214234600b004c189068726mr16460233qvb.106.1667832219753;
        Mon, 07 Nov 2022 06:43:39 -0800 (PST)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-08-184-147-142-10.dsl.bell.ca. [184.147.142.10])
        by smtp.gmail.com with ESMTPSA id k3-20020a05620a414300b006f9f714cb6asm7055862qko.50.2022.11.07.06.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 06:43:38 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveria <bristot@redhat.com>
Cc:     linux-trace-devel@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        Chang Yin <cyin@redhat.com>, John Kacur <jkacur@redhat.com>
Subject: [PATCH V2] rtla: Fix exit status when returning from calls to usage()
Date:   Mon,  7 Nov 2022 09:43:13 -0500
Message-Id: <20221107144313.22470-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtla_usage(), osnoise_usage() and timerlat_usage() all exit with an
error status.

However when these are called from help, they should exit with a
non-error status.

Fix this by passing the exit status to the functions.

Note, although we remove the subsequent call to exit after calling
usage, we leave it in at the end of a function to suppress the compiler
warning "control reaches end of a non-void function".

Signed-off-by: John Kacur <jkacur@redhat.com>
---
- Regenerated Patch against 6.1.0-rc4
- Added periods at the end of my sentences in the description.
- Fixed the spelling of "suppress".
---
 tools/tracing/rtla/SAC/osnoise.c  |  9 ++++-----
 tools/tracing/rtla/src/rtla.c     | 12 +++++-------
 tools/tracing/rtla/src/timerlat.c |  9 ++++-----
 3 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise.c b/tools/tracing/rtla/src/osnoise.c
index b8ec6c15bccb..4dee343909b1 100644
--- a/tools/tracing/rtla/src/osnoise.c
+++ b/tools/tracing/rtla/src/osnoise.c
@@ -903,7 +903,7 @@ struct osnoise_tool *osnoise_init_trace_tool(char *tracer)
 	return NULL;
 }
 
-static void osnoise_usage(void)
+static void osnoise_usage(int err)
 {
 	int i;
 
@@ -923,7 +923,7 @@ static void osnoise_usage(void)
 
 	for (i = 0; msg[i]; i++)
 		fprintf(stderr, "%s\n", msg[i]);
-	exit(1);
+	exit(err);
 }
 
 int osnoise_main(int argc, char *argv[])
@@ -941,8 +941,7 @@ int osnoise_main(int argc, char *argv[])
 	}
 
 	if ((strcmp(argv[1], "-h") == 0) || (strcmp(argv[1], "--help") == 0)) {
-		osnoise_usage();
-		exit(0);
+		osnoise_usage(0);
 	} else if (strncmp(argv[1], "-", 1) == 0) {
 		/* the user skipped the tool, call the default one */
 		osnoise_top_main(argc, argv);
@@ -956,6 +955,6 @@ int osnoise_main(int argc, char *argv[])
 	}
 
 usage:
-	osnoise_usage();
+	osnoise_usage(1);
 	exit(1);
 }
diff --git a/tools/tracing/rtla/src/rtla.c b/tools/tracing/rtla/src/rtla.c
index 09bd21b8af81..52e8f1825281 100644
--- a/tools/tracing/rtla/src/rtla.c
+++ b/tools/tracing/rtla/src/rtla.c
@@ -14,7 +14,7 @@
 /*
  * rtla_usage - print rtla usage
  */
-static void rtla_usage(void)
+static void rtla_usage(int err)
 {
 	int i;
 
@@ -33,7 +33,7 @@ static void rtla_usage(void)
 
 	for (i = 0; msg[i]; i++)
 		fprintf(stderr, "%s\n", msg[i]);
-	exit(1);
+	exit(err);
 }
 
 /*
@@ -70,11 +70,9 @@ int main(int argc, char *argv[])
 		goto usage;
 
 	if (strcmp(argv[1], "-h") == 0) {
-		rtla_usage();
-		exit(0);
+		rtla_usage(0);
 	} else if (strcmp(argv[1], "--help") == 0) {
-		rtla_usage();
-		exit(0);
+		rtla_usage(0);
 	}
 
 	retval = run_command(argc, argv, 1);
@@ -82,6 +80,6 @@ int main(int argc, char *argv[])
 		exit(0);
 
 usage:
-	rtla_usage();
+	rtla_usage(1);
 	exit(1);
 }
diff --git a/tools/tracing/rtla/src/timerlat.c b/tools/tracing/rtla/src/timerlat.c
index 97abbf494fee..21cdcc5c4a29 100644
--- a/tools/tracing/rtla/src/timerlat.c
+++ b/tools/tracing/rtla/src/timerlat.c
@@ -14,7 +14,7 @@
 
 #include "timerlat.h"
 
-static void timerlat_usage(void)
+static void timerlat_usage(int err)
 {
 	int i;
 
@@ -34,7 +34,7 @@ static void timerlat_usage(void)
 
 	for (i = 0; msg[i]; i++)
 		fprintf(stderr, "%s\n", msg[i]);
-	exit(1);
+	exit(err);
 }
 
 int timerlat_main(int argc, char *argv[])
@@ -52,8 +52,7 @@ int timerlat_main(int argc, char *argv[])
 	}
 
 	if ((strcmp(argv[1], "-h") == 0) || (strcmp(argv[1], "--help") == 0)) {
-		timerlat_usage();
-		exit(0);
+		timerlat_usage(0);
 	} else if (strncmp(argv[1], "-", 1) == 0) {
 		/* the user skipped the tool, call the default one */
 		timerlat_top_main(argc, argv);
@@ -67,6 +66,6 @@ int timerlat_main(int argc, char *argv[])
 	}
 
 usage:
-	timerlat_usage();
+	timerlat_usage(1);
 	exit(1);
 }
-- 
2.38.1

