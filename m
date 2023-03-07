Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A486AD873
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 08:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjCGHtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 02:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjCGHtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 02:49:03 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6645FCE
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 23:49:02 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id p20so13145471plw.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 23:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1678175342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5/0dHmlbYMl8JGzVTPk6nV0NKYl8wDENDKsl5texprU=;
        b=PBmMz327qjFJYp6lc4XsmGReKAbWj/vd1lIcVGm+UXdnrxxZyF08S1xIcNHDHhtRI0
         MgPakAbOPqLAJz0IA/OTTy9rnWA4fW3kDPlwYIWpISay8mwkhor+pZ1XSbvJ3PuqXY5S
         8zseNOdxhid5xc879kz01okxB0bzz4BOQTPx46uJpTwXyFRIty4ecB0Nf+aJQPLKCqRc
         W3PCbYEb7hlBVfNCyWu7KLl40nmFXF0WV3C2akZzTVTSbBnTHjaFP6kMhC5HVKpJKZyY
         6JvCtuCLV3y0Puqda8KIEH9ovF4zrrJBKd7kQAyC/eJIAfwxmjxed1TR+mtT9/GJ8Hl7
         QO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678175342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5/0dHmlbYMl8JGzVTPk6nV0NKYl8wDENDKsl5texprU=;
        b=WiFEXd43aUnAoKp4yYQmJdnCwyBxRKKP1i1e/uWhRVhQpkEQBj51yoSbGTXFQwsxi0
         lpGsmpqgmE8hy4DxFRCHRUDmbytOpucJiRka92McqA8AdhAoRg1ktvN+i/i/0xO/RW/U
         wGH59kJb9ZJoA0yiyH35O4zG5/CLk3UDgj/Kao5lvbr4NZPSApp8W9UHx15oB+S3sd+e
         RAleqltBVh7EtIPq3Ic0vmvElEtfxIGFx2UJTlYdbOROsrR8GEZMnIQMwTCE3ET5FiRB
         kVR0++DpNLgUiyD+1D+1Ktpxw+QXZqEvx/5A6vvHFKF5cF5Xo0a3CV/NVKPAmLmWIssC
         skUQ==
X-Gm-Message-State: AO0yUKU2xcbiCrPE2JZ0dGRIqgTCzE0HEHq0+ufQ16VnYJnrTzir9O8S
        IgE+PzcZOJ5n09yXPN/t+o/mtQ==
X-Google-Smtp-Source: AK7set9AX+z+O3GC1BUn+/Ixdi4fNKXrB1mNKK9sgi3krus2z7HASC4eVClH+fDyaMMFaB+CCaWsiQ==
X-Received: by 2002:a17:902:c94b:b0:19a:c65d:f93 with SMTP id i11-20020a170902c94b00b0019ac65d0f93mr17706680pla.53.1678175341930;
        Mon, 06 Mar 2023 23:49:01 -0800 (PST)
Received: from ubuntu-haifeng.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id ju5-20020a170903428500b0019cad2de863sm7841459plb.176.2023.03.06.23.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 23:49:01 -0800 (PST)
From:   Haifeng Xu <haifeng.xu@shopee.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH] mm/oom_kill: don't kill exiting tasks in oom_kill_memcg_member
Date:   Tue,  7 Mar 2023 07:48:08 +0000
Message-Id: <20230307074808.235649-1-haifeng.xu@shopee.com>
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
a function helper reap_task_will_free_mem() to mark it oom victim and
queue it in oom reaper.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 mm/oom_kill.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 044e1eed720e..36f5848fbc99 100644
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
+ * If the task is marked as oom_victim or will free
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

