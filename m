Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93AD6B5247
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 21:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjCJUzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 15:55:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjCJUyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 15:54:52 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AC812049D;
        Fri, 10 Mar 2023 12:54:49 -0800 (PST)
Date:   Fri, 10 Mar 2023 20:54:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678481688;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MCbb+kOqbMqyGray73WFbuU7v8aU1+sgCMEJ2CKIIxk=;
        b=PgGfqIrW0CRurY5CZqM8fMurJiQA6ZE3sh5WPgvuyWsKdH/xmyJnSDgMN470XleS2ArphE
        D+eF2U4DkPtrQWUUdCi32+oX1074eAX2q3lLgBZuDPOpiADl+v69wLTQKosDLZAsIePkcP
        q+4QnGXDz2oxNLRFBlE3daSCln5ls2guJ2J+lNozRCT6vYjqyhqMYFe7YJK8cnrlK6dr4v
        Q9lLsbZv0P4WU1s9+MZNvzHt4iGcJu6cwps6YkCbOf5+Vk3VgYEL/2IjD3q4g7vI75hgC5
        sp3W9tpvPVLzqFWoITOsoGl9I6DBzHKkgykm3u9+2A7cwMUxyFTIIGvUfjV9NA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678481688;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MCbb+kOqbMqyGray73WFbuU7v8aU1+sgCMEJ2CKIIxk=;
        b=S5b/5YxLElXc5WxATDwH/5Yeoi7H77OanU2ykRZKQY7HOjHCp0lCpbMuvBB3pdWRBofUkY
        2fGugehvYyCV4aBA==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] xtensa/cpu: Mark cpu_die() __noreturn
Cc:     Max Filippov <jcmvbkbc@gmail.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <ad801544cab7c26a0f3bbf7cfefb67303f4cd866.1676358308.git.jpoimboe@kernel.org>
References: <ad801544cab7c26a0f3bbf7cfefb67303f4cd866.1676358308.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <167848168816.5837.16921898081010171701.tip-bot2@tip-bot2>
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

Commit-ID:     69dee6f0338a20c76a7bc61c0a6b59f25e1b25c8
Gitweb:        https://git.kernel.org/tip/69dee6f0338a20c76a7bc61c0a6b59f25e1b25c8
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 13 Feb 2023 23:05:54 -08:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Wed, 08 Mar 2023 08:44:27 -08:00

xtensa/cpu: Mark cpu_die() __noreturn

cpu_die() doesn't return.  Annotate it as such.  By extension this also
makes arch_cpu_idle_dead() noreturn.

Acked-by: Max Filippov <jcmvbkbc@gmail.com>
Link: https://lore.kernel.org/r/ad801544cab7c26a0f3bbf7cfefb67303f4cd866.1676358308.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/xtensa/include/asm/smp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/xtensa/include/asm/smp.h b/arch/xtensa/include/asm/smp.h
index 4e43f56..5dc5bf8 100644
--- a/arch/xtensa/include/asm/smp.h
+++ b/arch/xtensa/include/asm/smp.h
@@ -33,7 +33,7 @@ void show_ipi_list(struct seq_file *p, int prec);
 
 void __cpu_die(unsigned int cpu);
 int __cpu_disable(void);
-void cpu_die(void);
+void __noreturn cpu_die(void);
 void cpu_restart(void);
 
 #endif /* CONFIG_HOTPLUG_CPU */
