Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3E1734841
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 22:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjFRUuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 16:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjFRUt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 16:49:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BEEE4D;
        Sun, 18 Jun 2023 13:49:55 -0700 (PDT)
Date:   Sun, 18 Jun 2023 20:49:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687121394;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bkMtBEsz/9x+JYJV7sYVmdSjjMNpn9H56vxMP6g8o7M=;
        b=kVxfw3gtIxOAAo/D1IjSjiSMr+BnWsqLtAm5xGUbvi9wOqwX8aEYspK/KQqcyjPMy3VL8E
        0Y+pFU2sVIvLi2RjfaeSoRuAjYETFNLy5+dc7GmoJZV02QqQrBY/Syh5ve8mQv3g7iRZ7c
        2DbFSAWzoHDU3YgTuYtWAsWsdLEgYvpvlXtnsmquQ1vq6ClPgG6WoMcgsdjpaLRzzf63x7
        ftO1UPVhjcSsTi0bZXCoCdXY8KLKsMKPGMmgk61ulAF1F6oObzAfJn+SFmWWU/y9NOz5F8
        J5HiAg5MRq5e/JxilX2oywg62z8KQWdOL2lSU+vqU75mpzRW8CkDinzbiQ/e3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687121394;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bkMtBEsz/9x+JYJV7sYVmdSjjMNpn9H56vxMP6g8o7M=;
        b=g3i7VR8J65CsBvq5v3bBOcuLsueQMLdblFrpLuwoYQgn/KAHG2O3xUzql+3sWiRMUX6IR0
        7UpBDWvetGqAImCw==
From:   "tip-bot2 for Li zeming" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] alarmtimer: Remove unnecessary (void *) cast
Cc:     Li zeming <zeming@nfschina.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230609182059.4509-1-zeming@nfschina.com>
References: <20230609182059.4509-1-zeming@nfschina.com>
MIME-Version: 1.0
Message-ID: <168712139395.404.6449837644292312630.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     fc4b4d96f793c827a5abf23df3e793592dbd38ce
Gitweb:        https://git.kernel.org/tip/fc4b4d96f793c827a5abf23df3e793592dbd38ce
Author:        Li zeming <zeming@nfschina.com>
AuthorDate:    Sat, 10 Jun 2023 02:20:59 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 18 Jun 2023 22:41:53 +02:00

alarmtimer: Remove unnecessary (void *) cast

Pointers of type void * do not require a type cast when they are assigned
to a real pointer.

Signed-off-by: Li zeming <zeming@nfschina.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230609182059.4509-1-zeming@nfschina.com

---
 kernel/time/alarmtimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 09c9cde..8d9f13d 100644
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
