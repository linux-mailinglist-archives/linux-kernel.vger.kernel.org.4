Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10D0617E8D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbiKCN6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbiKCN55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:57:57 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DAD15719;
        Thu,  3 Nov 2022 06:57:56 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id f8so1143051qkg.3;
        Thu, 03 Nov 2022 06:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=6zKL0p3k+0bFPIxIyqcrWd3FoCp9vRs2pREmUvTJ8Mc=;
        b=babiasjMmhUjUIckFVWjAZtfE17QYWSm+6fjmgKMKmggCs6wXlXlJVICsnMg1GEozV
         3/xUu0VB83OyZjeiJiTsQbEuxjiHs9Re7Mc27IjSaL+Uwelsgq+NQ0E25p6rAeF8svBt
         Y5TldH4xoWYk07OTl2gaj3xstddjsS3ZlLeJket0UWkSCgbW0hNfYNPUX66v/F3/oTx7
         Pqz5VqOjPPYPM5lVeUuECyHI74r68sbbwmu6mpb660rEPs0oADd4iT+HYjOEzCj5CgVy
         24Tx6QO/y9EvxwnF0QD23l0XDevvN7Xue7SO3sDI4uiRoZuzuO727WJCaazaKY8MumXG
         rqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zKL0p3k+0bFPIxIyqcrWd3FoCp9vRs2pREmUvTJ8Mc=;
        b=cUE3M8rVTsugIGiHUnmvedW5isnOVWHCRjN5gkObnj9zQz9MzZ5blirZbC2GAJhnO0
         V3F+HX2sB2Mur+OG548Rh2k/P4LGboDE39uYOShv6EEgxpzaULw/Bi6dX2p3GkMD1w3G
         eWeE5235VCTLZa4d6Ds6qsjC+oOYuySQ2EaeLqdTVp1mNJj6Q3Mm+YztfW94ekbNf7d+
         nVYQ27yCpFmGfagXvAyFltckl+MyBMbh9eiRckMqaFyVN9YVPZ0QgRmxAz7L8mOYVG1+
         yCAASlDy5nInDJ0Ga4/qOr7gwLMAyzG1AIqJPwwpsPcrm+jCvqAD75M6wNZ+dc+Dylgv
         pIEw==
X-Gm-Message-State: ACrzQf00NAzrin5WADeq+L3eCcYV0tXCshUg23kGOEMhnZSgeQY3BxLW
        /I2imONsK2tEmdGHcN/Ho3EW8AgR5tA=
X-Google-Smtp-Source: AMsMyM5OjJFpnvG0CrG681z650uDRYhzp0315WTUy7x1FFYputrefBMPa/HEuOkVvGzEoNSOv1ohpQ==
X-Received: by 2002:a05:620a:84a:b0:6fa:2f1d:2ec with SMTP id u10-20020a05620a084a00b006fa2f1d02ecmr16069592qku.669.1667483875447;
        Thu, 03 Nov 2022 06:57:55 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-08-184-147-142-10.dsl.bell.ca. [184.147.142.10])
        by smtp.gmail.com with ESMTPSA id u12-20020a05620a430c00b006b640efe6dasm763495qko.132.2022.11.03.06.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 06:57:53 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveria <bristot@redhat.com>
Cc:     linux-trace-devel@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        Chang Yin <cyin@redhat.com>, John Kacur <jkacur@redhat.com>
Subject: [PATCH] rtla: Fix exit status when returning from calls to usage()
Date:   Thu,  3 Nov 2022 09:57:42 -0400
Message-Id: <20221103135742.9523-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtla_usage(), osnoise_usage() and timerlat_usage() all exit with an
error status

However when these are called from help, they should exit with a
non-error status.

Fix this by passing the exit status to the functions

Note, although we remove the subsequent call to exit after calling
usage, we leave it in at the end of a function to supress the compiler
warning "control reaches end of a non-void function"

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tools/tracing/rtla/src/osnoise.c  |  9 ++++-----
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

