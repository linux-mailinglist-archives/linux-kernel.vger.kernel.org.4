Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF49702208
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 05:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbjEODOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 23:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238101AbjEODNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 23:13:53 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405E719AE;
        Sun, 14 May 2023 20:13:52 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-24df6bbf765so10416294a91.0;
        Sun, 14 May 2023 20:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684120431; x=1686712431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JzkH4lQfb5ZOUjwqO+AdNbxgdgLDuSyyuCXzioTUQhE=;
        b=enBaw82MMhF8WgmXnqu36qFSVY3hKbpo+op2O5MAGLA+GpkIJEl3vC1lBt3rERLk8L
         gRdcppCEuq/5D+3OQ0RfxKTGM6PKQGMJw3kTzsQvcBmKRjF/5dCFVVY86/f8EwCVFMFh
         gfFgegsBJXoMf5eyTbJWd7LqflGxj2HgBaapTA0wMctFtIPZ9gwkztpfL71uZ5QezH2t
         yllnfUII7mWYm0JTwyV8wKKJ2C6HQuf/+vk3uizyMMJPyIZ1t8I2aht/uDigW0kAQp42
         1vdzBOYtzxIjhyWUSIjfXUopS486Ag1SwrAzvHCXAmDBigR9h3snNa4b3n+aaqAMps2u
         RWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684120431; x=1686712431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JzkH4lQfb5ZOUjwqO+AdNbxgdgLDuSyyuCXzioTUQhE=;
        b=It18kmxqVFfNTfoCapw1cBcHpuCB8TAdDRZ0dpn40lXD7OrcesZgFFfeNDZr9O7ZtQ
         cb7N78rgCWv02pnyrFNJ2sDceOWKCoGOU5GKJZBqHv3DDodVE23XgckQq88KOGBHPWlC
         kXZ12S9ms09Q61YxM/uIZxWv49n5qigS47Iz5MAeNwjcsb593UCgA5ga0CNqgiqNRE5U
         d//F93GbYCpRiCfnU0IxB0Inqf1MyF0SFh6bO4an1lFouCHxsmj/fyzZwc7o+SQWPp5d
         l9ZnYEteyBV5m2dwUie2hTj0OJPtQ1eWE/7NWuLmaSngjUbzssacQJKsoycG/XW5PuXO
         /Iqw==
X-Gm-Message-State: AC+VfDxWzA7M6pQf1sJIKbejixWcxrIjThDdSzmwtCvPpWZwlalYfYiX
        U7m9ard1MkKj0sGEdmIK55s=
X-Google-Smtp-Source: ACHHUZ5GrgRj7NCgathp/fju+a7KK2X6O9ZJDALx5XT87j51s2z2mlXSftJsbGFjtlwsDbJ1t4xo4Q==
X-Received: by 2002:a17:90b:a58:b0:23f:81c0:eadd with SMTP id gw24-20020a17090b0a5800b0023f81c0eaddmr31427720pjb.47.1684120431582;
        Sun, 14 May 2023 20:13:51 -0700 (PDT)
Received: from localhost.localdomain ([43.132.98.42])
        by smtp.googlemail.com with ESMTPSA id o4-20020a17090a744400b00252b3328ad8sm4943577pjk.0.2023.05.14.20.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 20:13:51 -0700 (PDT)
From:   Ze Gao <zegao2021@gmail.com>
X-Google-Original-From: Ze Gao <zegao@tencent.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ze Gao <zegao@tencent.com>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH 3/4] fprobe: add recursion detection in fprobe_exit_handler
Date:   Mon, 15 May 2023 11:13:12 +0800
Message-Id: <20230515031314.7836-4-zegao@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515031314.7836-1-zegao@tencent.com>
References: <20230515031314.7836-1-zegao@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fprobe_hander and fprobe_kprobe_handler has guarded ftrace recusion
detection but fprobe_exit_handler has not, which possibly introduce
recurive calls if the fprobe exit callback calls any traceable
functions. Checking in fprobe_hander or fprobe_kprobe_handler
is not enough and misses this case.

So add recusion free guard the same way as fprobe_hander and also
mark fprobe_exit_handler notrace. Since ftrace recursion check does
not employ ips, so here use entry_ip and entry_parent_ip the same as
fprobe_handler.

Signed-off-by: Ze Gao <zegao@tencent.com>
---
 kernel/trace/fprobe.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index ad9a36c87ad9..cf982d4ab142 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -17,6 +17,7 @@
 struct fprobe_rethook_node {
 	struct rethook_node node;
 	unsigned long entry_ip;
+	unsigned long entry_parent_ip;
 	char data[];
 };
 
@@ -39,6 +40,7 @@ static inline notrace void __fprobe_handler(unsigned long ip, unsigned long
 		}
 		fpr = container_of(rh, struct fprobe_rethook_node, node);
 		fpr->entry_ip = ip;
+		fpr->entry_parent_ip = parent_ip;
 		if (fp->entry_data_size)
 			entry_data = fpr->data;
 	}
@@ -109,19 +111,30 @@ static void notrace fprobe_kprobe_handler(unsigned long ip, unsigned long parent
 	ftrace_test_recursion_unlock(bit);
 }
 
-static void fprobe_exit_handler(struct rethook_node *rh, void *data,
+static void notrace fprobe_exit_handler(struct rethook_node *rh, void *data,
 				struct pt_regs *regs)
 {
 	struct fprobe *fp = (struct fprobe *)data;
 	struct fprobe_rethook_node *fpr;
+	int bit;
 
 	if (!fp || fprobe_disabled(fp))
 		return;
 
 	fpr = container_of(rh, struct fprobe_rethook_node, node);
 
+	/* we need to assure no calls to traceable functions in-between the
+	 * end of fprobe_handler and the beginning of fprobe_exit_handler.
+	 */
+	bit = ftrace_test_recursion_trylock(fpr->entry_ip, fpr->entry_parent_ip);
+	if (bit < 0) {
+		fp->nmissed++;
+		return;
+	}
+
 	fp->exit_handler(fp, fpr->entry_ip, regs,
 			 fp->entry_data_size ? (void *)fpr->data : NULL);
+	ftrace_test_recursion_unlock(bit);
 }
 NOKPROBE_SYMBOL(fprobe_exit_handler);
 
-- 
2.40.1

