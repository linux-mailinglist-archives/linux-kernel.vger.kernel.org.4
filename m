Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65356685C95
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 02:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjBABVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 20:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjBABVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 20:21:08 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B5554239
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 17:21:06 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-50e79ffba49so131573497b3.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 17:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PQPTFMW4796/V59Q1M7MQSc/lfM2+0cZRexxlEjw8BE=;
        b=Rlxgv45bEMAa7iBOa2bNSfcd9vAqA2mYDbs1uj537poWq4Qx7+8PNrMe8lKi2hDj9A
         mgklECqq4B11oQwcT0fb0MA/FWNcWvgzPQLUbpMtB8kewuH4C14TFtmqwy+tPpRKkQyg
         omYOITCmP4SYOjNCFZw29MHPTAat0E/5rLNH5L/JR7om54abWiQ0XK228QbovmQdHMc9
         Q9VRSzkaGhea7Efv7cP3lSA0e+Fs4abVldnJiugWc0d0Y4XXyEoSYDreY0dWSBVck83I
         Z1zSL/GpR0AdE2M2jWkFcI7uMZKjBTiqS7En0DgUkEaPe9GSt12rketNUH+g/yjy1w78
         gtog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PQPTFMW4796/V59Q1M7MQSc/lfM2+0cZRexxlEjw8BE=;
        b=ABU9WY9oCCJCUJilYk+RGT4hyWk0kEu3dPzieZNPLroe7dmsw9QFg+UnfS1HuFbHZk
         NDqdJHOBzjR2uincsQq+QG1mVClPAoarItj2UHYSBn/XV9fvH0RF1W7eej080M4fbKuz
         dBk9w4Secm8ZywAggfjVYkrIn0iLXwFjDZeZqEtQQKjA9Sp62Ee6mxQhtAajzZFb3Ups
         96NB+6e9+NAyqYDX+Fkwpe7KenuuA9ZAWqZMFnpqiFqSzaoc/BHPIjmz17c5qdzfzSR2
         5ua8bPAQIjxEZGfmMEmJnGeoDs6c60LgOr2Y56jzGsFtpPN2GYcbo6P4rWcqtxwBc8hc
         +2oQ==
X-Gm-Message-State: AO0yUKWd30Tgklod8LmlqJPbWNFKcMtxYWTqggHg8r4OpUjQiXEjJy2O
        9Hgz3tX8NJBTuslCeQkgPrR/8/o=
X-Google-Smtp-Source: AK7set8Emavg/Q15QrAgi/Ft0H4UAeiRd/9XfHtT+24bmtZycjBa2Vb+zpXToXnb1KNA/ehTjOnGEsQ=
X-Received: from hvdc.svl.corp.google.com ([2620:15c:2d4:203:18c0:a70b:9cf:52a9])
 (user=xii job=sendgmr) by 2002:a81:4a43:0:b0:510:b7af:7e7c with SMTP id
 x64-20020a814a43000000b00510b7af7e7cmr51606ywa.70.1675214466009; Tue, 31 Jan
 2023 17:21:06 -0800 (PST)
Date:   Tue, 31 Jan 2023 17:20:32 -0800
Message-Id: <20230201012032.2874481-1-xii@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Subject: [PATCH] sched: Consider capacity for certain load balancing decisions
From:   Xi Wang <xii@google.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Ben Segall <bsegall@google.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Xi Wang <xii@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After load balancing was split into different scenarios, CPU capacity
is ignored for the "migrate_task" case, which means a thread can stay
on a softirq heavy cpu for an extended amount of time.

By comparing nr_running/capacity instead of just nr_running we can add
CPU capacity back into "migrate_task" decisions. This benefits
workloads running on machines with heavy network traffic. The change
is unlikely to cause serious problems for other workloads but maybe
some corner cases still need to be considered.

Signed-off-by: Xi Wang <xii@google.com>
---
 kernel/sched/fair.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0f8736991427..aad14bc04544 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10368,8 +10368,9 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 			break;
 
 		case migrate_task:
-			if (busiest_nr < nr_running) {
+			if (busiest_nr * capacity < nr_running * busiest_capacity) {
 				busiest_nr = nr_running;
+				busiest_capacity = capacity;
 				busiest = rq;
 			}
 			break;
-- 
2.39.1
