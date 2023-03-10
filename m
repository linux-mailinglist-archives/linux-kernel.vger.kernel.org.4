Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2BB6B524D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 21:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjCJUzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 15:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbjCJUyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 15:54:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7971A96C;
        Fri, 10 Mar 2023 12:54:49 -0800 (PST)
Date:   Fri, 10 Mar 2023 20:54:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678481688;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HF9W/KUr4Gp2MNsxFmHjSGH0UnmP2/01xQcvQXQtHjY=;
        b=Q/Z0Q5sKXtE9VFFDtZG4Bv2AQybXDZoiNJO1Ls9ETtKqYA5b5KyIDb9zeNH8u69VxoA7BX
        1XlE4XlkBc0w+enqYD6oYI7XUhMuNU2TS3WePmif5smI3E9fKqd2Zy0bK1Oa1Kma5qs0+/
        j03TSUwl/vcRd/QsYkTzDxS6fotx4M5rsV230SrNZ0aaL7/3sWH0MAxUiPHuY4xclcFFeq
        g0g8e17u9zuHjfB1RQn5N1t7ADI4H5UCO9E5I7l0nF12hAzRXUzF96cVEgT+jsMjt3Ke8H
        UyyxnGMV6lbKuFAVHBe9y0zkDZysvPFaX/0XpaodE8ZXEC4Cbp95N0jdlJK7vw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678481688;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HF9W/KUr4Gp2MNsxFmHjSGH0UnmP2/01xQcvQXQtHjY=;
        b=I77aEj9Naj66vNT93ZRJaXzSPtUHKEuGziMakLvNoAsBEiTEQrGLsOKtkZioXoLSCQ1R8x
        KToX9cZxkpTgHHDA==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] sched/idle: Make sure weak version of
 arch_cpu_idle_dead() doesn't return
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <cf5ad95eef50f7704bb30e7770c59bfe23372af7.1676358308.git.jpoimboe@kernel.org>
References: <cf5ad95eef50f7704bb30e7770c59bfe23372af7.1676358308.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <167848168775.5837.8625028915626505990.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     dfb0f170cadb03da4f408ae53cc2908120e1f90e
Gitweb:        https://git.kernel.org/tip/dfb0f170cadb03da4f408ae53cc2908120e1f90e
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 13 Feb 2023 23:05:55 -08:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Wed, 08 Mar 2023 08:44:27 -08:00

sched/idle: Make sure weak version of arch_cpu_idle_dead() doesn't return

arch_cpu_idle_dead() should never return.  Make it so.

Link: https://lore.kernel.org/r/cf5ad95eef50f7704bb30e7770c59bfe23372af7.1676358308.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 kernel/sched/idle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index e9ef66b..56e152f 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -75,7 +75,7 @@ static noinline int __cpuidle cpu_idle_poll(void)
 void __weak arch_cpu_idle_prepare(void) { }
 void __weak arch_cpu_idle_enter(void) { }
 void __weak arch_cpu_idle_exit(void) { }
-void __weak arch_cpu_idle_dead(void) { }
+void __weak arch_cpu_idle_dead(void) { while (1); }
 void __weak arch_cpu_idle(void)
 {
 	cpu_idle_force_poll = 1;
