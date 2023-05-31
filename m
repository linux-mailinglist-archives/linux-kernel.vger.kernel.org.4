Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E458718A7D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 21:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjEaTuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 15:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjEaTuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 15:50:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF38C180;
        Wed, 31 May 2023 12:49:54 -0700 (PDT)
Date:   Wed, 31 May 2023 19:49:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685562593;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pElWneLjM7SUDkkkhZokKjsYLWcqMuio7YltlDNyBxk=;
        b=N73tbZIsp8H/1SE/hjMdSxeEzWFN+vBZUwIb20zrbVx77ywwbAziV5PlDTAMwZGN/QTJiW
        PT0dsT3a+p9+Vr/MCrEDxo1Y990M4x27g4TVi+cY+FsDzbjPcX5dO2p3tBnN/xdShPxBrG
        Pj5UPXK6RRcxS+cOIhJ8r3tCOV687ntXMJIMs3V8IjQdtIv1n8QylEaMkUuqbMzOUXsJCq
        LOM6Q1me5vDlz1IYbvPEtWkKmOUYms7IgMniqNlRcHpsKevXQr09fq7GGcMKBswMSp2msX
        Vl5X3IVVbipRhNDYBZaUIEaBUzedN+IsPoacvS4YEhSxuI0Mrvk1dS6j8z5I6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685562593;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pElWneLjM7SUDkkkhZokKjsYLWcqMuio7YltlDNyBxk=;
        b=DrKQyGjgfPkZqvr/S39XBrV1i3hQm0WUxi7bpzJbXm1aatPkSIOj/fpKFyJEFFlhoi/GRA
        Vxphd0nKfaP7DSCg==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] vdso/timens: Always provide arch_get_vdso_data()
 prototype for vdso
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230517131102.934196-15-arnd@kernel.org>
References: <20230517131102.934196-15-arnd@kernel.org>
MIME-Version: 1.0
Message-ID: <168556259256.404.5823615515338296247.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     b7a7ce1bb77b19ff2859d365da96285340fbc145
Gitweb:        https://git.kernel.org/tip/b7a7ce1bb77b19ff2859d365da96285340fbc145
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Wed, 17 May 2023 15:11:02 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 31 May 2023 21:45:49 +02:00

vdso/timens: Always provide arch_get_vdso_data() prototype for vdso

The arch_get_vdso_data() function is defined separately on each architecture,
but only called when CONFIG_TIME_NS is set. If the definition is a global
function, this causes a W=1 warning without TIME_NS:

arch/x86/entry/vdso/vma.c:35:19: error: no previous prototype for 'arch_get_vdso_data' [-Werror=missing-prototypes]

Move the prototype out of the #ifdef block to reliably turn off that
warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230517131102.934196-15-arnd@kernel.org
---
 include/linux/time_namespace.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index bb9d3f5..03d9c5a 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -44,7 +44,6 @@ struct time_namespace *copy_time_ns(unsigned long flags,
 				    struct time_namespace *old_ns);
 void free_time_ns(struct time_namespace *ns);
 void timens_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk);
-struct vdso_data *arch_get_vdso_data(void *vvar_page);
 struct page *find_timens_vvar_page(struct vm_area_struct *vma);
 
 static inline void put_time_ns(struct time_namespace *ns)
@@ -163,4 +162,6 @@ static inline ktime_t timens_ktime_to_host(clockid_t clockid, ktime_t tim)
 }
 #endif
 
+struct vdso_data *arch_get_vdso_data(void *vvar_page);
+
 #endif /* _LINUX_TIMENS_H */
