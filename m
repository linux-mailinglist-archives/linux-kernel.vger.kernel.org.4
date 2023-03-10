Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94056B5267
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 21:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbjCJU40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 15:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbjCJUy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 15:54:58 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3A11A96C;
        Fri, 10 Mar 2023 12:54:57 -0800 (PST)
Date:   Fri, 10 Mar 2023 20:54:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678481695;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u6Vobpw+4vgUYr0JhP/C3/4m0sqFlHx1JqSixKRFPIQ=;
        b=QmmJ9tXtwGv8NFgrkV6lNJlqsfiGyoHjgXT48Unihibk5mf5cAQWAKuLryj10D6y90tuqt
        FiMQGkH7DegBcHcyKj7wD1OYlnIda91UMHnKUvalN5zku8UWWFhjJwVhJ6FAE48SlcLe9R
        AREeCs3QoyybymcMMmAFPPANeA/zeYBHn4k0DaFwFs8ibR5ie9SuGxi1KuIBPCMoYxuJOL
        PnfD943Wqsd+pGOdnWqMxoHScJe+bk3BJKSBtT6ZDcI4iGBNUAu6InOH+Hy4rIIyeF86yB
        Gbte1PqbaWsCBDqb8lzkNtvlO+2qhZuywgP9/aAF5U5gWP8H0y+2mPX1a7qb4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678481695;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u6Vobpw+4vgUYr0JhP/C3/4m0sqFlHx1JqSixKRFPIQ=;
        b=4HCUsrWHwy9up3WiH7e3o1fZDK4hYtZb/6lgn/ACagv44CVgo09hkeLDnT6U/wamAoWkYE
        myf+Bg6Fkw3bMvCA==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] arm/cpu: Add unreachable() to arch_cpu_idle_dead()
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230216183851.s5bnvniomq44rytu@treble>
References: <20230216183851.s5bnvniomq44rytu@treble>
MIME-Version: 1.0
Message-ID: <167848169549.5837.9296234527293777617.tip-bot2@tip-bot2>
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

Commit-ID:     b40c7d6d31ac2f6b78371cdc08bc1b6b62f01375
Gitweb:        https://git.kernel.org/tip/b40c7d6d31ac2f6b78371cdc08bc1b6b62f01375
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Thu, 16 Feb 2023 10:38:55 -08:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Mon, 06 Mar 2023 15:34:04 -08:00

arm/cpu: Add unreachable() to arch_cpu_idle_dead()

arch_cpu_idle_dead() doesn't return.  Make that visible to the compiler
with an unreachable() code annotation.

Link: https://lkml.kernel.org/r/20230216183851.s5bnvniomq44rytu@treble
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/arm/kernel/smp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 0b8c257..441ea5c 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -382,6 +382,8 @@ void arch_cpu_idle_dead(void)
 		: "r" (task_stack_page(current) + THREAD_SIZE - 8),
 		  "r" (current)
 		: "r0");
+
+	unreachable();
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
