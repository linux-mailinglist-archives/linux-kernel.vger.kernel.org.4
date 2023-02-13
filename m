Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D99C694E3E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 18:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjBMRk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 12:40:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjBMRkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 12:40:55 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F884B769
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 09:40:54 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id v13so3924157iln.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 09:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1676310054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h+PWTa2pO4esPa5UD4RNk+GztWSuSz5/1ZS7yaWFz34=;
        b=OuOhFSbIAn2tlb7Slyv6UN18a8sJqMQWcuvW8nT3HY/aZksKLVs0X8RG3C1ltfXbaw
         rgXwAMA9rTUs/Q7DpU5s2HDCBBco5cHAhizz0X7EM5oMYjw6NVpXjFhtJ3M2I07s1M47
         rTfsya7qJhWXnaMj4sUfypdUnLQryZSEgM8o0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676310054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h+PWTa2pO4esPa5UD4RNk+GztWSuSz5/1ZS7yaWFz34=;
        b=o2OWh6r10qnYYaWh9+/jsItu+s4baS2phUltvpzKgZJwLkp5mQ7Eu9nkFm0gNSnqcS
         l/sJIt23HrR92RUd+1Gybh9LfdvN3+L9EZHoOnOK8hK/+UQN7DFFTp6aPoxv7hGPICaB
         t95XkwCHeJjxnuCIGHDN01NzvOuEcaoOciuW60biwiWJVLNL9USDY3nxBwBFUegUPRxc
         SQa8A9p4PLQkqJusU1isyaNluMacsGjGf2ngb4rm+r/7AK4W1QieJVdWCbtbDQkGo+5l
         jTuqCnEdFOf4IC8hChycqJHp9wCdFkYa1ZW2GZ78AbuhJ2wHc7VWYI0qrnZb9CraNXTG
         RJsw==
X-Gm-Message-State: AO0yUKUy2Uv2fXkNMxx1uLOup4eddked8qodZ3Ru9MWSwJ+sj3rSi4uX
        hJpb/oI3+nKtUsW/VYVa8ytvZA==
X-Google-Smtp-Source: AK7set8DwLUUaMDcEM6NeFqYj6+evvtN1x27KLGM0BWds0Zq/GF3mwyErWkbqFJwo3flLk+QrDFXlA==
X-Received: by 2002:a92:cd8d:0:b0:314:6968:ed8d with SMTP id r13-20020a92cd8d000000b003146968ed8dmr11072079ilb.3.1676310053964;
        Mon, 13 Feb 2023 09:40:53 -0800 (PST)
Received: from shuah-tx13.internal ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id h16-20020a02cd30000000b003adb75f4aa6sm4169412jaq.108.2023.02.13.09.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 09:40:53 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/sched: fix warn_unused_result build warns
Date:   Mon, 13 Feb 2023 10:40:52 -0700
Message-Id: <20230213174052.229104-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
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

Fix the following warns by adding return check and error handling.

gcc -O2 -Wall -g -I./ -isystem .../tools/testing/selftests/../../../usr/include -Wl,-rpath=./      cs_prctl_test.c -lpthread -o .../tools/testing/selftests/sched/cs_prctl_test
cs_prctl_test.c: In function ‘create_processes’:
cs_prctl_test.c:187:17: warning: ignoring return value of ‘read’ declared with attribute ‘warn_unused_result’ [-Wunused-result]
  187 |                 read(proc[i].pfd[0], &proc[i].thr_tids, sizeof(int) * proc[i].num_threads);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cs_prctl_test.c: In function ‘child_func_process’:
cs_prctl_test.c:159:9: warning: ignoring return value of ‘write’ declared with attribute ‘warn_unused_result’ [-Wunused-result]
  159 |         write(ca->pfd[1], &ca->thr_tids, sizeof(int) * ca->num_threads);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/sched/cs_prctl_test.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/sched/cs_prctl_test.c b/tools/testing/selftests/sched/cs_prctl_test.c
index 8109b17dc764..25e0d95d3713 100644
--- a/tools/testing/selftests/sched/cs_prctl_test.c
+++ b/tools/testing/selftests/sched/cs_prctl_test.c
@@ -27,6 +27,7 @@
 #include <sys/prctl.h>
 #include <unistd.h>
 #include <time.h>
+#include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -151,12 +152,17 @@ static void create_threads(int num_threads, int thr_tids[])
 static int child_func_process(void *arg)
 {
 	struct child_args *ca = (struct child_args *)arg;
+	int ret;
 
 	close(ca->pfd[0]);
 
 	create_threads(ca->num_threads, ca->thr_tids);
 
-	write(ca->pfd[1], &ca->thr_tids, sizeof(int) * ca->num_threads);
+	ret = write(ca->pfd[1], &ca->thr_tids, sizeof(int) * ca->num_threads);
+	if (ret == -1)
+		printf("write failed on pfd[%d] - error (%s)\n",
+			ca->pfd[1], strerror(errno));
+
 	close(ca->pfd[1]);
 
 	while (1)
@@ -169,7 +175,7 @@ static unsigned char child_func_process_stack[STACK_SIZE];
 void create_processes(int num_processes, int num_threads, struct child_args proc[])
 {
 	pid_t cpid;
-	int i;
+	int i, ret;
 
 	for (i = 0; i < num_processes; ++i) {
 		proc[i].num_threads = num_threads;
@@ -184,7 +190,10 @@ void create_processes(int num_processes, int num_threads, struct child_args proc
 	}
 
 	for (i = 0; i < num_processes; ++i) {
-		read(proc[i].pfd[0], &proc[i].thr_tids, sizeof(int) * proc[i].num_threads);
+		ret = read(proc[i].pfd[0], &proc[i].thr_tids, sizeof(int) * proc[i].num_threads);
+		if (ret == -1)
+			printf("read failed on proc[%d].pfd[0] error (%s)\n",
+				i, strerror(errno));
 		close(proc[i].pfd[0]);
 	}
 }
-- 
2.37.2

