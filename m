Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4642A68C97B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 23:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjBFWeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 17:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjBFWeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 17:34:13 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B85823C47
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 14:34:10 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id ml19so38730847ejb.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 14:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diag.uniroma1.it; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oPNP2/Jy05oYx7Ua/KHbVlH+c1xyVbqGnx/noop7sjo=;
        b=gu0nF7ItiqVouL+YD1YwEyk8qIJ6jlY35wBXYtEqdIT0pE5jC939+c8/4uANgcrYm1
         iC6NshSMYlrxlR2/ucmgOM8mF8xIyzGoUP12jTYlicbu7JWvlSsnx9RK4slOUfbIYjRr
         2uRWoJ7EjmBl6CUrMsrhIvVfLvcWPYgV8AfEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oPNP2/Jy05oYx7Ua/KHbVlH+c1xyVbqGnx/noop7sjo=;
        b=XExolMI1YJ2Ezu2+n1kD+ebomEsoaIepQ1+FU20vOOc6eafHcVAoRY2laRZRU0FzyO
         VelMCjpqVoXFq5JjxJ5HQs2Lu5to8rjqgxN9AeB/7z2oG1K3jXJQk6nHDMqVOrf7G9JR
         0w/Tw7j1bFTwe0LBCjy8fVVkcHn3XZ45FQeuNOFjk9b7OuBEseOuWv7uw5uBllE6V61o
         0GcwFWehcPsOgq/INZd86hmiTSb82jWc9fpWWWQ032K4nDFkvGuEF3NpGmFjmFE+lLHw
         3qo0IcCADj5vSHQfOX2Arm0fV5/7QY/cXo4vc2fyOsKzb0T9/OsM2n0C3StRgqxnZYnU
         yyNg==
X-Gm-Message-State: AO0yUKUVCIJM12g3RbMIUemiB9cWrd0eViBe9PllNSy4n6FN2s4W3HxP
        KDaNqZhQe0QVg+s3uY5Agz9SwA==
X-Google-Smtp-Source: AK7set+yY68oBu2tHm2T564Jwa47RoeBc7Ca68SNH7ZzN8Ddb5UdZvby7KO44vUS6CiGYyVlrIRHxQ==
X-Received: by 2002:a17:906:228b:b0:888:a06f:104b with SMTP id p11-20020a170906228b00b00888a06f104bmr1042001eja.36.1675722848580;
        Mon, 06 Feb 2023 14:34:08 -0800 (PST)
Received: from [192.168.17.2] (wolkje-127.labs.vu.nl. [130.37.198.127])
        by smtp.gmail.com with ESMTPSA id y18-20020a1709063a9200b00878b89075adsm6002799ejd.51.2023.02.06.14.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 14:34:08 -0800 (PST)
From:   Pietro Borrello <borrello@diag.uniroma1.it>
Date:   Mon, 06 Feb 2023 22:33:54 +0000
Subject: [PATCH v3] sched: pick_next_rt_entity(): check list_entry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230128-list-entry-null-check-sched-v3-1-b1a71bd1ac6b@diag.uniroma1.it>
X-B4-Tracking: v=1; b=H4sIAFGA4WMC/5XOTQ6CMBAF4KuQrh3SHyHgynsYF6UdYCIW0xYiI
 dzdwtqFriZvJvnerCygJwzskq3M40yBRpeCOmXM9Np1CGRTZpJLxYWsYKAQAV30C7hpGMD0aB4
 Q0rCgVatsa0t7LiuWhEYHhMZrZ/rdeOoQ0e+Hl8eW3kft7Z5yn9DRL8cXs9i3vxXOAgSYWvGqQ
 OS8KK6WdJdPjvz41CKnyHZ+ln+QMpG2Qi64MViL5gu5bdsHr5FpCzkBAAA=
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Phil Auld <pauld@redhat.com>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Dmitry Adamushko <dmitry.adamushko@gmail.com>
Cc:     Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jkl820.git@gmail.com>,
        Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
        Pietro Borrello <borrello@diag.uniroma1.it>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675722848; l=1950;
 i=borrello@diag.uniroma1.it; s=20221223; h=from:subject:message-id;
 bh=vTdCdz8mzVgH9HkpgBXyq+LcnD4OnRfIU38f71CBPBI=;
 b=09d4TBy2OlH9UJqpZpGZsfVSQSid141a0s7KRtEwZzBLi5Yj9TNj5+2UHl+reZjU0iD9gVqRDNV2
 6804kGknAdHjTpm7jdUyxFQ6TsGyZ7iKgZhp9cntNv3koW3gwyYV
X-Developer-Key: i=borrello@diag.uniroma1.it; a=ed25519;
 pk=4xRQbiJKehl7dFvrG33o2HpveMrwQiUPKtIlObzKmdY=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 326587b84078 ("sched: fix goto retry in pick_next_task_rt()")
removed any path which could make pick_next_rt_entity() return NULL.
However, BUG_ON(!rt_se) in _pick_next_task_rt() (the only caller of
pick_next_rt_entity()) still checks the error condition, which can
never happen, since list_entry() never returns NULL.
Remove the BUG_ON check, and instead emit a warning in the only
possible error condition here: the queue being empty which should
never happen.

Fixes: 326587b84078 ("sched: fix goto retry in pick_next_task_rt()")
Signed-off-by: Pietro Borrello <borrello@diag.uniroma1.it>
---
Changes in v3:
- return NULL if the list is empty
- Link to v2: https://lore.kernel.org/r/20230128-list-entry-null-check-sched-v2-1-d8e010cce91b@diag.uniroma1.it

Changes in v2:
- pick_next_rt_entity(): emit warning instead of crashing
- Link to v1: https://lore.kernel.org/r/20230128-list-entry-null-check-sched-v1-1-c93085ee0055@diag.uniroma1.it
---
 kernel/sched/rt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index ed2a47e4ddae..0a11f44adee5 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1777,6 +1777,8 @@ static struct sched_rt_entity *pick_next_rt_entity(struct rt_rq *rt_rq)
 	BUG_ON(idx >= MAX_RT_PRIO);
 
 	queue = array->queue + idx;
+	if (SCHED_WARN_ON(list_empty(queue)))
+		return NULL;
 	next = list_entry(queue->next, struct sched_rt_entity, run_list);
 
 	return next;
@@ -1789,7 +1791,8 @@ static struct task_struct *_pick_next_task_rt(struct rq *rq)
 
 	do {
 		rt_se = pick_next_rt_entity(rt_rq);
-		BUG_ON(!rt_se);
+		if (unlikely(!rt_se))
+			return NULL;
 		rt_rq = group_rt_rq(rt_se);
 	} while (rt_rq);
 

---
base-commit: 2241ab53cbb5cdb08a6b2d4688feb13971058f65
change-id: 20230128-list-entry-null-check-sched-a3f3dfd6d468

Best regards,
-- 
Pietro Borrello <borrello@diag.uniroma1.it>

