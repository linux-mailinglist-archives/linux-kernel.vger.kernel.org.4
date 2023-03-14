Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715F06B8E3D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 10:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjCNJMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 05:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjCNJL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 05:11:57 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695BB97FCF
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 02:11:56 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id nn12so14721407pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 02:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1678785116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vKgzht+gmBOBVC9nKYNuGxb9cEGGStYD0EpYNTNxlyk=;
        b=MMrv6ZFHPI284Taspim+FZeJ6qozn0gloLqh+CxK4nBduqnhhyIbXrePSgt5OCIHrE
         EvqrolF79gdgWPT8feQqTD/5LwfRwaKzK22Skvz80I4XiRYCYJplQ+niOpiXf6P/IEjz
         h0Ztc5KvjaGqg473FVDid4DZBxtst34g/Z+x/ROnyG+orVI/zI0/Znxy38Nwx771RuvN
         PYta3zARpAZxDa2rLgHEhG3jx6JoZXGifgFpezRU2rREdpRkvprpJU3FXLufhHbGSqvb
         +ozCg/0srVvYP2w/w2YDxZcGPx4uTbf7j3UrsOAar48T+xvMjJQ3ZZJ++mQ2x8sirVwC
         DADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678785116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vKgzht+gmBOBVC9nKYNuGxb9cEGGStYD0EpYNTNxlyk=;
        b=3Iy1Rdb1yCkBSS6p0myxJYGuz6SPidlhFAF8GcO+9smfgLUlVqm3yu/JdExCqcNwCq
         ZQAmYzROWBwmaksLsH7ogXck/ggUQz7jAU9lZ+wvbiHnBkEqNNlAWzqAuaSf/5noi5JG
         b87OkeDJy/R2Sw9E62Nuvg+dcYp8PDNh0pTsDDRaoewnmwch1qVCwo7jjuHx6IjieRbl
         tTR/kd2BgdivmJFrH3Ssc1TsFyX/CZy2cKOl2XEoBw1RoPZsTe//+BmV2a+4NFXW1yfI
         LZl4SkV1Z/rUI5RCzT199E2WgntK2o7KS1WJUBZk7nkvGdmG4eRvFECHvOXSAfzq02dT
         +FeA==
X-Gm-Message-State: AO0yUKW0t/tmxX2zhx42PpAYrUaG8+HmRAYtRZNI5GtEixA9edF5DsF/
        NPjvN8pdTy9pirPagp7W8OppJUKkU6odfZAsD19ljMmW
X-Google-Smtp-Source: AK7set/QO8WXl+vPCHk6UYrPBWOwE9kYIAE8uv3WBqv12RwllKBFelhfpgPqk+c+mjFUzxhDpyZtZA==
X-Received: by 2002:a17:902:e54e:b0:1a0:42c0:b2af with SMTP id n14-20020a170902e54e00b001a042c0b2afmr8081816plf.33.1678785115897;
        Tue, 14 Mar 2023 02:11:55 -0700 (PDT)
Received: from ubuntu-haifeng.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id kj8-20020a17090306c800b001991942dde7sm1258594plb.125.2023.03.14.02.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 02:11:55 -0700 (PDT)
From:   Haifeng Xu <haifeng.xu@shopee.com>
To:     mhocko@suse.com
Cc:     shakeelb@google.com, hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH RESEND] mm/oom_kill: don't kill exiting tasks in oom_kill_memcg_member
Date:   Tue, 14 Mar 2023 09:11:36 +0000
Message-Id: <20230314091136.264878-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If oom_group is set, oom_kill_process() invokes oom_kill_memcg_member()
to kill all processes in the memcg. When scanning tasks in memcg, maybe
the provided task is marked as oom victim. Also, some tasks are likely
to release their address space. There is no need to kill the exiting tasks.

In order to handle these tasks which may free memory in the future, add
a function helper reap_task_will_free_mem() to mark it as oom victim and
queue it in oom reaper.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 mm/oom_kill.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 044e1eed720e..f16bca506dc2 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -996,15 +996,43 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
 }
 #undef K
 
+static bool reap_task_will_free_mem(struct task_struct *victim)
+{
+	bool ret = false;
+
+	task_lock(victim);
+	if (task_will_free_mem(victim)) {
+		mark_oom_victim(victim);
+		queue_oom_reaper(victim);
+		ret = true;
+	}
+	task_unlock(victim);
+
+	return ret;
+}
+
 /*
  * Kill provided task unless it's secured by setting
  * oom_score_adj to OOM_SCORE_ADJ_MIN.
+ * If the task is marked as oom victim or will free
+ * memory, there is no need to kill it again.
  */
 static int oom_kill_memcg_member(struct task_struct *task, void *message)
 {
 	if (task->signal->oom_score_adj != OOM_SCORE_ADJ_MIN &&
 	    !is_global_init(task)) {
 		get_task_struct(task);
+
+		/*
+		 * If the task is already exiting, don't alarm the sysadmin or kill
+		 * its children or threads, just give it access to memory reserves
+		 * so it can die quickly
+		 */
+		if (tsk_is_oom_victim(task) || reap_task_will_free_mem(task)) {
+			put_task_struct(task);
+			return 0;
+		}
+
 		__oom_kill_process(task, message);
 	}
 	return 0;
@@ -1022,15 +1050,10 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
 	 * its children or threads, just give it access to memory reserves
 	 * so it can die quickly
 	 */
-	task_lock(victim);
-	if (task_will_free_mem(victim)) {
-		mark_oom_victim(victim);
-		queue_oom_reaper(victim);
-		task_unlock(victim);
+	if (reap_task_will_free_mem(victim)) {
 		put_task_struct(victim);
 		return;
 	}
-	task_unlock(victim);
 
 	if (__ratelimit(&oom_rs))
 		dump_header(oc, victim);
-- 
2.25.1

