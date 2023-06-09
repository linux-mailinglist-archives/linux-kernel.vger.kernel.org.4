Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6921D72749A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 03:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbjFHBts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 21:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjFHBto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 21:49:44 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 7E669269F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 18:49:42 -0700 (PDT)
Received: from localhost.localdomain (unknown [219.141.250.2])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 31A1C1801128CB;
        Thu,  8 Jun 2023 09:49:40 +0800 (CST)
X-MD-Sfrom: zeming@nfschina.com
X-MD-SrcIP: 219.141.250.2
From:   Li zeming <zeming@nfschina.com>
To:     tglx@linutronix.de, jstultz@google.com, sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, Li zeming <zeming@nfschina.com>
Subject: [PATCH] time: alarmtimer: remove unnecessary (void*) conversions
Date:   Sat, 10 Jun 2023 02:20:59 +0800
Message-Id: <20230609182059.4509-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_24_48,
        RCVD_IN_SBL_CSS,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointer variables of void * type do not require type cast.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 kernel/time/alarmtimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index e918d556dd51..65c20c4f0b7f 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -751,7 +751,7 @@ static int alarm_timer_create(struct k_itimer *new_timer)
 static enum alarmtimer_restart alarmtimer_nsleep_wakeup(struct alarm *alarm,
 								ktime_t now)
 {
-	struct task_struct *task = (struct task_struct *)alarm->data;
+	struct task_struct *task = alarm->data;
 
 	alarm->data = NULL;
 	if (task)
-- 
2.18.2

