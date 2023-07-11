Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766C974F939
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 22:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjGKUoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 16:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjGKUoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 16:44:03 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24847195
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 13:44:02 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-682ae5d4184so1334063b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 13:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689108241; x=1691700241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZsZ8f6snXSrxb5rxjwdGIt7zdNvfSU6bnPqicjdHws=;
        b=3N0SJijDU79cAiD9z1CvyfDS/0x4aovQkXowXuC+Qe1dNPjhu6fJB7n6LWQMnowsAe
         gKjPDzKnsWBD/lwJgTSNQfJjXo2iY3sW1mTttU10WMNXtDzZA5helUetsfpokXL0VIeR
         qTBoIj6i6NslICeWocfhD5cpKS6rzMp1yweglA3MTbo83yNW33FIAEGIjHXn/SoQ10R4
         0c/62G9XNASoHReTCnZT5a8jQggpIPw0IrSNebcBBMmqmZz7Kd4c97bpfncwLb3pvQHf
         XqIU1WdKzQ6bf48mwEaIVRV4aVQharmr6OAiPZ2Cbz6Rzaluuo4ZPzmSvUnzWVUfmKsQ
         GYhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689108241; x=1691700241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZsZ8f6snXSrxb5rxjwdGIt7zdNvfSU6bnPqicjdHws=;
        b=kJfk7nyzezqncYn3LZtvd2FeIzNB95KSpJmNWRVuucGhWFfQJpvq8WlKOEsVW14x3a
         IrEfLwUVgzOlk91ucnYDRNNYxafWz400yhuaLBnZ4W6NcOfMFYGxW6WrOiadN2Qs/BjY
         1wVNFEmbmlExu+apJnNpMh/0IYQo1lfrCLX0Sb5YCYJl9Hx/AuSTIFGGpZ0h42ZOd31c
         dT110eOpC3jbF1kxEuxGMgLwPHMnk8gfomfHxsWGBvgIoetargLX83osBLAQkES+AnHL
         eDrHNFims2ioAsQlJUd5sMdgoHt9EobaEBkoK1Zvr2uBpBnLXDXAL/F4WRAhdsMWIKET
         kU7Q==
X-Gm-Message-State: ABy/qLa5iJM/4Pax5OnPTEjzfWsjFahYgLoY55aRXSTgbxZF2EkjQT9H
        1JaaZBPg9eNZNY3re27191/H0g==
X-Google-Smtp-Source: APBJJlFUmKm5liBmfPCLe8ejx6eVIvyRfxMcXMOo2baI8F8tmJRbdIQrgiMCuzIJcf+oMF+SPGqA2A==
X-Received: by 2002:a05:6a20:3d0d:b0:123:149b:a34f with SMTP id y13-20020a056a203d0d00b00123149ba34fmr22664283pzi.1.1689108241461;
        Tue, 11 Jul 2023 13:44:01 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id f7-20020aa78b07000000b00640ddad2e0dsm2124461pfd.47.2023.07.11.13.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 13:44:00 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     brauner@kernel.org, arnd@arndb.de, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/5] exit: move core of do_wait() into helper
Date:   Tue, 11 Jul 2023 14:43:49 -0600
Message-Id: <20230711204352.214086-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230711204352.214086-1-axboe@kernel.dk>
References: <20230711204352.214086-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than have a maze of gotos, put the actual logic in __do_wait()
and have do_wait() loop deal with waitqueue setup/teardown and whether
to call __do_wait() again.

No functional changes intended in this patch.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 kernel/exit.c | 49 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 2809dad69492..d8fb124cc038 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1590,16 +1590,10 @@ static int do_wait_pid(struct wait_opts *wo)
 	return 0;
 }
 
-static long do_wait(struct wait_opts *wo)
+static long __do_wait(struct wait_opts *wo)
 {
-	int retval;
-
-	trace_sched_process_wait(wo->wo_pid);
+	long retval;
 
-	init_waitqueue_func_entry(&wo->child_wait, child_wait_callback);
-	wo->child_wait.private = current;
-	add_wait_queue(&current->signal->wait_chldexit, &wo->child_wait);
-repeat:
 	/*
 	 * If there is nothing that can match our criteria, just get out.
 	 * We will clear ->notask_error to zero if we see any child that
@@ -1617,18 +1611,18 @@ static long do_wait(struct wait_opts *wo)
 	if (wo->wo_type == PIDTYPE_PID) {
 		retval = do_wait_pid(wo);
 		if (retval)
-			goto end;
+			return retval;
 	} else {
 		struct task_struct *tsk = current;
 
 		do {
 			retval = do_wait_thread(wo, tsk);
 			if (retval)
-				goto end;
+				return retval;
 
 			retval = ptrace_do_wait(wo, tsk);
 			if (retval)
-				goto end;
+				return retval;
 
 			if (wo->wo_flags & __WNOTHREAD)
 				break;
@@ -1638,14 +1632,31 @@ static long do_wait(struct wait_opts *wo)
 
 notask:
 	retval = wo->notask_error;
-	if (!retval && !(wo->wo_flags & WNOHANG)) {
-		retval = -ERESTARTSYS;
-		if (!signal_pending(current)) {
-			schedule();
-			goto repeat;
-		}
-	}
-end:
+	if (!retval && !(wo->wo_flags & WNOHANG))
+		return -ERESTARTSYS;
+
+	return retval;
+}
+
+static long do_wait(struct wait_opts *wo)
+{
+	int retval;
+
+	trace_sched_process_wait(wo->wo_pid);
+
+	init_waitqueue_func_entry(&wo->child_wait, child_wait_callback);
+	wo->child_wait.private = current;
+	add_wait_queue(&current->signal->wait_chldexit, &wo->child_wait);
+
+	do {
+		retval = __do_wait(wo);
+		if (retval != -ERESTARTSYS)
+			break;
+		if (signal_pending(current))
+			break;
+		schedule();
+	} while (1);
+
 	__set_current_state(TASK_RUNNING);
 	remove_wait_queue(&current->signal->wait_chldexit, &wo->child_wait);
 	return retval;
-- 
2.40.1

