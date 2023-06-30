Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A080743401
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 07:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjF3FUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 01:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjF3FUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 01:20:00 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E672D78
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 22:19:59 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b80f2e6c17so12098135ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 22:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688102399; x=1690694399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZXNjXyUXRB3e3R4COIZ6LKTKDhQp6FWYpoDH70i59sQ=;
        b=S4VO+ZyRe1+UIGkN8iQT2QCJs8/H6Xekfswk+8UWSaAtM27VaDw3fv/6JVLGq4DMK5
         J3ZzXzPK82IztcwwyEkMHBaUFLKZ/KSVivQ8vHYDx965HaaUHvDwvuYT0elk6ei/wokK
         HjXyv0GgW5ZKy+zeDx0OkrTGkMvbZilQ19EwlCTQ+zXhzeymIeryPCjg7jSPD8QHNIg3
         p73VkhXgbRMUojuTudIVQ8hk1X8Ls7ULSMFzHa9wuLWPmQE2+lEmSgluqax5JT2QQmBQ
         HhWdK6o5cWueeco4PgZ1yi7fbCg6k1O2jRA8mFsPvlpgKfCjdBhEDCIDIiIhWxncDu0H
         EV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688102399; x=1690694399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZXNjXyUXRB3e3R4COIZ6LKTKDhQp6FWYpoDH70i59sQ=;
        b=Pok5qMaCK6rRuG8RF2+gikoiqO4lEuLRJqEIwrACSFbtqwuONp8F6j1ec65IBkUry8
         rbXP/hU/hSWC8iRsusarGyoPa6UIIEDD/TWdjWBNjLHysD5W5gS3VRZfK/3M4XALKRfO
         ThoRIGSJ1ld5DWoRhNuVW5n11d2qrFP/yEP5iXp6hRnpTu4aEo/MOFinNDsBec9bSHSZ
         kh6donwRLVaptZc4eBJF9OK0HC2nRsIsUVwzEkJoPhvhmwQ+TE2FR5Xc4yEY3I6bGK4p
         sjv9qvY7HJA9OQzs9yqTF0Blc3iM5yIqGDNyJUbqha9yrDRZ6i65tpxlZZjFpvddQyGo
         BnMQ==
X-Gm-Message-State: ABy/qLZHTuy9lrR+Ide5CoJCzhhdMnLNI7Qel+A7mSFDKkSKb3H7ubAw
        Jbq2G4ys7nicJ2pM/E+cvXK8m12PCu0=
X-Google-Smtp-Source: APBJJlGL/07aze3izJN38pC+qJB65V7uPwoyh7HLd3fAOBDM7mKlDC9oR5xSwuu+3lWwdRAMausdSA==
X-Received: by 2002:a17:902:ec88:b0:1b6:b805:5ae3 with SMTP id x8-20020a170902ec8800b001b6b8055ae3mr1608020plg.3.1688102398561;
        Thu, 29 Jun 2023 22:19:58 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id p20-20020a170902a41400b001b85a4821f8sm1727390plq.276.2023.06.29.22.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 22:19:57 -0700 (PDT)
From:   Andrei Vagin <avagin@gmail.com>
To:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Cc:     Andrei Vagin <avagin@gmail.com>
Subject: [PATCH] perf/bench/seccomp-notify: don't use assert to check syscall errors
Date:   Thu, 29 Jun 2023 22:19:53 -0700
Message-Id: <20230630051953.454638-1-avagin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 616b14b47a86, perf is built with NDEBUG=1 so the macro
assert() is nop.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 tools/perf/bench/sched-seccomp-notify.c | 35 +++++++++++++++----------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/tools/perf/bench/sched-seccomp-notify.c b/tools/perf/bench/sched-seccomp-notify.c
index eac4ef60090f..73ab86269427 100644
--- a/tools/perf/bench/sched-seccomp-notify.c
+++ b/tools/perf/bench/sched-seccomp-notify.c
@@ -22,9 +22,7 @@
 #include <sys/wait.h>
 #include <string.h>
 #include <errno.h>
-/* keep all assert() calls. */
-#undef NDEBUG
-#include <assert.h>
+#include <err.h>
 
 #define LOOPS_DEFAULT 1000000UL
 static uint64_t loops = LOOPS_DEFAULT;
@@ -74,15 +72,18 @@ static void user_notification_sync_loop(int listener)
 
 	for (nr = 0; nr < loops; nr++) {
 		memset(&req, 0, sizeof(req));
-		assert(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req) == 0);
+		if (ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req))
+			err(EXIT_FAILURE, "SECCOMP_IOCTL_NOTIF_RECV failed");
 
-		assert(req.data.nr == __NR_gettid);
+		if (req.data.nr != __NR_gettid)
+			errx(EXIT_FAILURE, "unexpected syscall: %d", req.data.nr);
 
 		resp.id = req.id;
 		resp.error = 0;
 		resp.val = USER_NOTIF_MAGIC;
 		resp.flags = 0;
-		assert(ioctl(listener, SECCOMP_IOCTL_NOTIF_SEND, &resp) == 0);
+		if (ioctl(listener, SECCOMP_IOCTL_NOTIF_SEND, &resp))
+			err(EXIT_FAILURE, "SECCOMP_IOCTL_NOTIF_SEND failed");
 	}
 }
 
@@ -105,12 +106,15 @@ int bench_sched_seccomp_notify(int argc, const char **argv)
 	prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
 	listener = user_notif_syscall(__NR_gettid,
 				      SECCOMP_FILTER_FLAG_NEW_LISTENER);
-	assert(listener >= 0);
+	if (listener < 0)
+		err(EXIT_FAILURE, "can't create a notification descriptor");
 
 	pid = fork();
-	assert(pid >= 0);
+	if (pid < 0)
+		err(EXIT_FAILURE, "fork");
 	if (pid == 0) {
-		assert(prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0) == 0);
+		if (prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0))
+			err(EXIT_FAILURE, "can't set the parent death signal");
 		while (1) {
 			ret = syscall(__NR_gettid);
 			if (ret == USER_NOTIF_MAGIC)
@@ -121,15 +125,18 @@ int bench_sched_seccomp_notify(int argc, const char **argv)
 	}
 
 	if (sync_mode) {
-		assert(ioctl(listener, SECCOMP_IOCTL_NOTIF_SET_FLAGS,
-			     SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP, 0) == 0);
+		if (ioctl(listener, SECCOMP_IOCTL_NOTIF_SET_FLAGS,
+			     SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP, 0))
+			err(EXIT_FAILURE,
+			    "can't set SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP");
 	}
 	user_notification_sync_loop(listener);
 
 	kill(pid, SIGKILL);
-	assert(waitpid(pid, &status, 0) == pid);
-	assert(WIFSIGNALED(status));
-	assert(WTERMSIG(status) == SIGKILL);
+	if (waitpid(pid, &status, 0) != pid)
+		err(EXIT_FAILURE, "waitpid(%d) failed", pid);
+	if (!WIFSIGNALED(status) || WTERMSIG(status) != SIGKILL)
+		errx(EXIT_FAILURE, "unexpected exit code: %d", status);
 
 	gettimeofday(&stop, NULL);
 	timersub(&stop, &start, &diff);
-- 
2.40.1

