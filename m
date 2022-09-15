Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945275B9CFF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 16:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiIOOYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 10:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiIOOYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 10:24:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF5D9C8E2;
        Thu, 15 Sep 2022 07:24:12 -0700 (PDT)
Date:   Thu, 15 Sep 2022 14:24:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663251851;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EvLHKuejWzRszAiwt0EF9ZYaqKXPmd8jt6upfMrSOUM=;
        b=UUvjwo9RJ4SuNZev/VOGuKpXIpZ5QZy5kBDyaIzjwt3CfNU4v82dzNThp770/zBexY/6jh
        7zjhw/kPXz5R3szv+CYKVRhZp2N7oNKA00O5lr9XupPw29H3tePAvwrTSsMBAHt4qWiocq
        IhVNVcRkDaRP4TzaSB0hr93zPvdXm5Ky7fegcb+IXpw8GXmqj+HnxcXRwQBQY6AxUrn7gV
        ZpA8OYraJ3YJ84ExZ2bfsQ7czx8XqmJh8Z8OTyHhVz/aKxeDPbEb5ZmM+Yk7C/MQluCMid
        YYrq3fbB0LZDNZ4JSgwY7rzGSoy5mhC5LBj3KeUNKYzN961Oec9XWSs8S+sSSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663251851;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EvLHKuejWzRszAiwt0EF9ZYaqKXPmd8jt6upfMrSOUM=;
        b=MUCAWpYl7VPsTxv/cZMUxrZy7giC9eHYA1jUyIQzMtdYu59ImubukgGUn61LH3mn1vO7f3
        2XP+C47ytHHzWqAQ==
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Move call to list_last_entry() in detach_tasks
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220825122726.20819-4-vincent.guittot@linaro.org>
References: <20220825122726.20819-4-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <166325184995.401.17589955355834278252.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     7e9518baed4cef76dbfa07cbffbae1e6dbc87be6
Gitweb:        https://git.kernel.org/tip/7e9518baed4cef76dbfa07cbffbae1e6dbc87be6
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Thu, 25 Aug 2022 14:27:25 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 15 Sep 2022 16:13:52 +02:00

sched/fair: Move call to list_last_entry() in detach_tasks

Move the call to list_last_entry() in detach_tasks() after testing
loop_max and loop_break.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220825122726.20819-4-vincent.guittot@linaro.org
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7b3a58f..5ffec43 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8044,8 +8044,6 @@ static int detach_tasks(struct lb_env *env)
 		if (env->idle != CPU_NOT_IDLE && env->src_rq->nr_running <= 1)
 			break;
 
-		p = list_last_entry(tasks, struct task_struct, se.group_node);
-
 		env->loop++;
 		/*
 		 * We've more or less seen every task there is, call it quits
@@ -8062,6 +8060,8 @@ static int detach_tasks(struct lb_env *env)
 			break;
 		}
 
+		p = list_last_entry(tasks, struct task_struct, se.group_node);
+
 		if (!can_migrate_task(p, env))
 			goto next;
 
