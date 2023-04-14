Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BBC6E2627
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjDNOsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjDNOsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:48:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219639039;
        Fri, 14 Apr 2023 07:48:00 -0700 (PDT)
Date:   Fri, 14 Apr 2023 14:47:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681483676;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I6eWeHhDXQ8Dk1a3rU13BnGG9fZTkXy6cJScMSWpIeA=;
        b=JTSauNRt4iuEP1B4h5wgsv4FOh5m2/ry3WiAReJL/aL+IOmfaKz8XhC2PVt6/taO7t4ugW
        iilMTMETwLm6rqYPVDDhMfF4JS4eHavZj7VUJ81/XwtQJG0UOo5WwUiRGBTTkk1fNoZ2JJ
        zDubjf0SDAgbm0dBM84RMMQpN1BIjEF3Gwwu8HJOfozJ1116P4/SAqJZ05ANmqmX/iojCa
        Oizb6IQ+ZeVk6rQpIBBrtcIMYL+I4sow2AY69tyMmERkF4QFz+fXBBxg+yMR/aaleXQK/U
        gSHDydcl1/wscuML71nQFGs/vZnjufPa3Xb36/Ap2cH+CohjHqL3vLXsMaehbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681483676;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I6eWeHhDXQ8Dk1a3rU13BnGG9fZTkXy6cJScMSWpIeA=;
        b=SwChvhsG1TkF2yK9BUAY42IEpjDy10h1C+L+c3zgt4PX+M6MITJlpq7fruPsUOvrXc+gAm
        xtuFBGNqROXeHICg==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] context_tracking: Fix KCSAN noinstr violation
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <dc93f45abdec90c171108b4b590b7fff5790963c.1681320026.git.jpoimboe@kernel.org>
References: <dc93f45abdec90c171108b4b590b7fff5790963c.1681320026.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <168148367618.404.8910517787032335784.tip-bot2@tip-bot2>
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

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     e8deb00c0c4808654d1bf96a8f79cf1deb59b631
Gitweb:        https://git.kernel.org/tip/e8deb00c0c4808654d1bf96a8f79cf1deb59b631
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 12 Apr 2023 10:24:06 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 14 Apr 2023 16:08:27 +02:00

context_tracking: Fix KCSAN noinstr violation

With KCSAN enabled, even empty inline stubs can be out-of-lined.

Force the context_tracking_guest_exit() stub inline.

Fixes the following warnings:

  vmlinux.o: warning: objtool: vmx_vcpu_enter_exit+0x1be: call to context_tracking_guest_exit() leaves .noinstr.text section
  vmlinux.o: warning: objtool: svm_vcpu_enter_exit+0x85: call to context_tracking_guest_exit() leaves .noinstr.text section

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/dc93f45abdec90c171108b4b590b7fff5790963c.1681320026.git.jpoimboe@kernel.org
---
 include/linux/context_tracking.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index d4afa85..5ae3abd 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -97,7 +97,7 @@ static inline int exception_enter(void) { return 0; }
 static inline void exception_exit(enum ctx_state prev_ctx) { }
 static inline int ct_state(void) { return -1; }
 static __always_inline bool context_tracking_guest_enter(void) { return false; }
-static inline void context_tracking_guest_exit(void) { }
+static __always_inline void context_tracking_guest_exit(void) { }
 #define CT_WARN_ON(cond) do { } while (0)
 #endif /* !CONFIG_CONTEXT_TRACKING_USER */
 
