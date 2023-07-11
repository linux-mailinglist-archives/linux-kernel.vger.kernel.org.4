Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1681D74F93C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 22:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjGKUoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 16:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjGKUoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 16:44:04 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173F810E3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 13:44:03 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-682ae5d4184so1334067b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 13:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689108242; x=1691700242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYDIyeoAajuf9ZWE7uQTqbgmYwdh8IUMjMetvGRNy4k=;
        b=Kw7OJtlIsWYqkTdCePYJ6j0sZ/wo/9SVbH1Crr+PV4T3hXRLT6ogGGfyIuciZw49Gj
         cI5oawLufTg1VdoXxqFJTj96IZ9LHiViG8qs9gqHj9oPq4Y+91EB96UEMZsm7r77wu8P
         Yn5JRCM0rusYPLf30cag4PsOv2r3sDrVrBlFj8C8ONp/aX3iV8zqm3noaS84jfGYo3ha
         sfPT2yzhH/vVULPlCdqjag8UkzdvJZMrmv6e93tXoG7wSen83LRi+nKcGRZYT5lteNac
         JU7032+kC7Es/v+DINgPt+3jH99AVZJHNmV2oujw+iOFWZ8fWulhdp34w6aNdBogxLb2
         x++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689108242; x=1691700242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WYDIyeoAajuf9ZWE7uQTqbgmYwdh8IUMjMetvGRNy4k=;
        b=KEj+NlNZSKDbESphy3bXJ8sum1Xq1l8vQz8iZ5yxHjICxUC2sFn/WZY4UNKPa0nrOe
         1E3ZiPVlihJ38zPUiEo9udcRlXttyw7aXcisDFHHnpjyzxLgjP7bZM4cML7RwMnqitT4
         ssahtHjScQEkcVw4TlTfvM7Ozc9MD1p+Nt0frrauIXZ29c7W/YYqL4Re1IhpaVP1Xlrs
         8DvqVUHLhwBlt2EIsQALkjoFsFUNhA01qYELLk9Gqov+M31g9lIyRQmRq9CcRFJ477JP
         /nNjyWtAizVHo3zeQiBEflwXYa+YitcrVZIBlXBoTa+SfHtvWiql2u/RggXf/I9dcD0j
         KEnQ==
X-Gm-Message-State: ABy/qLbi32jY6jV9rx2dcZuJhqkFboJzr2BITTM2aXhLPVVWDO8SLvD6
        IrXrECxPE5tv5ZjYgS5m4zkBew==
X-Google-Smtp-Source: APBJJlGrBzyDodI3jjldRm2AfTKQR8y4sjoRYFlulavDgrAkLjnAdFzCa2anegPvzfZpkAxtJcCLjQ==
X-Received: by 2002:a05:6a20:a128:b0:132:8daa:23eb with SMTP id q40-20020a056a20a12800b001328daa23ebmr2053712pzk.4.1689108242624;
        Tue, 11 Jul 2023 13:44:02 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id f7-20020aa78b07000000b00640ddad2e0dsm2124461pfd.47.2023.07.11.13.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 13:44:02 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     brauner@kernel.org, arnd@arndb.de, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/5] exit: add kernel_waitid_prepare() helper
Date:   Tue, 11 Jul 2023 14:43:50 -0600
Message-Id: <20230711204352.214086-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230711204352.214086-1-axboe@kernel.dk>
References: <20230711204352.214086-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the setup logic out of kernel_waitid(), and into a separate helper.

No functional changes intended in this patch.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 kernel/exit.c | 41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index d8fb124cc038..8934c91a9fe1 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1662,14 +1662,12 @@ static long do_wait(struct wait_opts *wo)
 	return retval;
 }
 
-static long kernel_waitid(int which, pid_t upid, struct waitid_info *infop,
-			  int options, struct rusage *ru)
+static int kernel_waitid_prepare(struct wait_opts *wo, int which, pid_t upid,
+				 struct waitid_info *infop, int options,
+				 struct rusage *ru, unsigned int *f_flags)
 {
-	struct wait_opts wo;
 	struct pid *pid = NULL;
 	enum pid_type type;
-	long ret;
-	unsigned int f_flags = 0;
 
 	if (options & ~(WNOHANG|WNOWAIT|WEXITED|WSTOPPED|WCONTINUED|
 			__WNOTHREAD|__WCLONE|__WALL))
@@ -1703,7 +1701,7 @@ static long kernel_waitid(int which, pid_t upid, struct waitid_info *infop,
 		if (upid < 0)
 			return -EINVAL;
 
-		pid = pidfd_get_pid(upid, &f_flags);
+		pid = pidfd_get_pid(upid, f_flags);
 		if (IS_ERR(pid))
 			return PTR_ERR(pid);
 
@@ -1712,19 +1710,34 @@ static long kernel_waitid(int which, pid_t upid, struct waitid_info *infop,
 		return -EINVAL;
 	}
 
-	wo.wo_type	= type;
-	wo.wo_pid	= pid;
-	wo.wo_flags	= options;
-	wo.wo_info	= infop;
-	wo.wo_rusage	= ru;
-	if (f_flags & O_NONBLOCK)
-		wo.wo_flags |= WNOHANG;
+	wo->wo_type	= type;
+	wo->wo_pid	= pid;
+	wo->wo_flags	= options;
+	wo->wo_info	= infop;
+	wo->wo_rusage	= ru;
+	if (*f_flags & O_NONBLOCK)
+		wo->wo_flags |= WNOHANG;
+
+	return 0;
+}
+
+static long kernel_waitid(int which, pid_t upid, struct waitid_info *infop,
+			  int options, struct rusage *ru)
+{
+	struct wait_opts wo;
+	long ret;
+	unsigned int f_flags = 0;
+
+	ret = kernel_waitid_prepare(&wo, which, upid, infop, options, ru,
+					&f_flags);
+	if (ret)
+		return ret;
 
 	ret = do_wait(&wo);
 	if (!ret && !(options & WNOHANG) && (f_flags & O_NONBLOCK))
 		ret = -EAGAIN;
 
-	put_pid(pid);
+	put_pid(wo.wo_pid);
 	return ret;
 }
 
-- 
2.40.1

