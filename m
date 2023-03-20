Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1910A6C0D44
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 10:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjCTJ2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 05:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjCTJ1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 05:27:52 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CF424480
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 02:27:18 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id o11so11777568ple.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 02:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679304438;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mlRkPjgE6TNTCRfOd4LJQHCW3cMFbfvmsoyX6CTOd28=;
        b=nck84eVIWYKc6j5O2HotAFWxm9ge477KpfBKUiLzgG61Kg4Lzx4EspGOyF4YyJgvcO
         /SMx7ZcNtb/bEGJmUHO5nl5MMISdbajbdDrLWvhyWX5p7IF6k5zJoVsqM3rB8E8/h+fX
         cmQEQXjkfug+dJX4bwF7dPbtblsZST3EB2gyW2zhq21GcezdsAqdnIePIjmb0/4ddN6b
         BWNwASyPbkAAU2PjjDBeIqvRan8tE6r/YCm0TlvuR+F/EMZm9nrQ0x/vqVQVDn5xZV4h
         BXFR9NxTrXj6NADW5VbrF/N7TdgJXPxlUUeXEnaEfynAvkRpFkAENXKqN5fgV1l+YAfW
         JOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679304438;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mlRkPjgE6TNTCRfOd4LJQHCW3cMFbfvmsoyX6CTOd28=;
        b=Bcobo56EhaufYzSEf4LMXJsqhXi7ToDvOaulDLr19tNM0zEZR8XuyZdC7ZbY60vlTQ
         mEFykp40F6vOD86HYIvyuwjDuPhOkguFC5wWRi/bnAVZdqMK32OzWRyV0ActVCBotCQU
         h1kNvqbRORoOJxhmY+JJLQTL0aFg0fSA9n2/asVkgPTm95XX8dh8UDdYrjYZKT58F8nE
         P9zXmgenCa9zdK94edHWyxM7GV1SfJnGhyVtlXwrGT9lqdpakWa6lHmFrXvZPken67Pf
         Mp1FOFSFnUaDxNUrX48A46ORUxt59ipMtvnxtcuae98b1be9mlmz8e+aN1eP0jQrte3g
         cQqw==
X-Gm-Message-State: AO0yUKVyYz4rozBVWK8kMwOOdtGCoNOttLJo+Rr8Wl/va3Zu5FXsS0hW
        16OBAy/K18Ll3KjwVqoL0z4=
X-Google-Smtp-Source: AK7set8AnDscPH5z7QpLyNdQO2zpLXdm5jdVcdLcyZfW2ppPhar1l16w+s7LOu+DaRWRuMptSeanoQ==
X-Received: by 2002:a17:902:f687:b0:1a1:c551:bd00 with SMTP id l7-20020a170902f68700b001a1c551bd00mr5674478plg.35.1679304438180;
        Mon, 20 Mar 2023 02:27:18 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id t8-20020a63dd08000000b00502ecb91940sm5880011pgg.55.2023.03.20.02.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 02:27:17 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     tj@kernel.org, jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org, huyue2@coolpad.com,
        zhangwen@coolpad.com
Subject: [PATCH] workqueue: Drop the NOT_RUNNING check to flags in worker_{set,clr}_flags
Date:   Mon, 20 Mar 2023 17:26:52 +0800
Message-Id: <20230320092652.16649-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Hu <huyue2@coolpad.com>

We know whether the worker flags are belong to WORKER_NOT_RUNNING or not
when we are setting and clearing them.  So check the flags not running
related is unnecessary for both the cases.

Currently, worker_{set,clr}_flags() are all used for WORKER_NOT_RUNNING
except for clearing WORKER_IDLE.  Let's change to directly clear it
instead.  Also, update the comment a little in worker_clr_flags().

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 kernel/workqueue.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index de4282736999..c56112cb17c3 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -978,10 +978,8 @@ static inline void worker_set_flags(struct worker *worker, unsigned int flags)
 	WARN_ON_ONCE(worker->task != current);
 
 	/* If transitioning into NOT_RUNNING, adjust nr_running. */
-	if ((flags & WORKER_NOT_RUNNING) &&
-	    !(worker->flags & WORKER_NOT_RUNNING)) {
+	if (!(worker->flags & WORKER_NOT_RUNNING))
 		pool->nr_running--;
-	}
 
 	worker->flags |= flags;
 }
@@ -1007,12 +1005,11 @@ static inline void worker_clr_flags(struct worker *worker, unsigned int flags)
 
 	/*
 	 * If transitioning out of NOT_RUNNING, increment nr_running.  Note
-	 * that the nested NOT_RUNNING is not a noop.  NOT_RUNNING is mask
-	 * of multiple flags, not a single flag.
+	 * that NOT_RUNNING is mask of multiple flags, not a single flag.
 	 */
-	if ((flags & WORKER_NOT_RUNNING) && (oflags & WORKER_NOT_RUNNING))
-		if (!(worker->flags & WORKER_NOT_RUNNING))
-			pool->nr_running++;
+	if ((oflags & WORKER_NOT_RUNNING) &&
+	    (!(worker->flags & WORKER_NOT_RUNNING)))
+		pool->nr_running++;
 }
 
 /**
@@ -1835,7 +1832,9 @@ static void worker_leave_idle(struct worker *worker)
 
 	if (WARN_ON_ONCE(!(worker->flags & WORKER_IDLE)))
 		return;
-	worker_clr_flags(worker, WORKER_IDLE);
+	WARN_ON_ONCE(worker->task != current);
+
+	worker->flags &= ~WORKER_IDLE;
 	pool->nr_idle--;
 	list_del_init(&worker->entry);
 }
-- 
2.17.1

