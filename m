Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04BEB606298
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 16:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiJTONv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 10:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiJTONs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 10:13:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A3C1DB8AE;
        Thu, 20 Oct 2022 07:13:47 -0700 (PDT)
Date:   Thu, 20 Oct 2022 14:13:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666275224;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ObeAeeAOvdgHTvRViRSMWDjpDb0JcMd6Lt070o+on5I=;
        b=dFMi/P8OBE4iP/PueTQ5lOORh7/r/4yiWzpqaKXfxmqIxhlx3uUc9i/djBzr7DxXN49nXW
        TNZyaab3zE4d/8jagN4qYsgBSKq/GCXtFsIlHeDLmPXz7N5AteEPQpswOa8K8748M9LNxC
        0jnOyX7WjrNiVjJr26g/Ar7LfN5BQ7T+I5D2gsx52Xq9FzTFm74tjsxHd+G7KyrxjC8pMl
        Gk3PR4WFuWRKd9V941ESztI6FYsgLRO/yxqZXN75dadjN4ePniPGWHAJcUvPcMN+85zrBs
        so6dlZnkAAr5ZmzaT2g/SpTMzkhT/nWkg7ZpwmA9p//qinF8SihjHnv6a1DJtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666275224;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ObeAeeAOvdgHTvRViRSMWDjpDb0JcMd6Lt070o+on5I=;
        b=YvJ25f8Tg8lYzSI+PpJVIj6l6FhfMzF+/cpDoGHvZqRjifIBDxjskmSRB5t/zJmu8BbiJf
        mzwpTSD7VPAizYCg==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/paravirt: Fix a !PARAVIRT build warning
Cc:     Borislav Petkov <bp@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <Y1AtAXM8YjtBm2cj@zn.tnic>
References: <Y1AtAXM8YjtBm2cj@zn.tnic>
MIME-Version: 1.0
Message-ID: <166627522295.401.15571888009057472602.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     dbf53a29b28b277fa952a000245b558536c6bdd7
Gitweb:        https://git.kernel.org/tip/dbf53a29b28b277fa952a000245b558536c=
6bdd7
Author:        Borislav Petkov <bp@alien8.de>
AuthorDate:    Wed, 19 Oct 2022 18:59:45 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 20 Oct 2022 16:00:59 +02:00

x86/paravirt: Fix a !PARAVIRT build warning

Fix

  ./include/trace/events/xen.h:28:31: warning: =E2=80=98enum paravirt_lazy_mo=
de=E2=80=99 \
    declared inside parameter list will not be visible outside of this defini=
tion or declaration

which turns into a build error:

  ./include/trace/events/xen.h:28:50: error: parameter 1 (=E2=80=98mode=E2=80=
=99) has incomplete type
     28 |                 TP_PROTO(enum paravirt_lazy_mode mode), \

due to enum paravirt_lazy_mode being visible only under CONFIG_PARAVIRT.
Just pull it up where it is unconditionally visible.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/Y1AtAXM8YjtBm2cj@zn.tnic
---
 arch/x86/include/asm/paravirt_types.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/par=
avirt_types.h
index e137d94..27c6927 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -9,6 +9,13 @@ struct paravirt_patch_site {
 	u8 type;		/* type of this instruction */
 	u8 len;			/* length of original instruction */
 };
+
+/* Lazy mode for batching updates / context switch */
+enum paravirt_lazy_mode {
+	PARAVIRT_LAZY_NONE,
+	PARAVIRT_LAZY_MMU,
+	PARAVIRT_LAZY_CPU,
+};
 #endif
=20
 #ifdef CONFIG_PARAVIRT
@@ -582,13 +589,6 @@ int paravirt_disable_iospace(void);
 	__PVOP_VCALL(op, PVOP_CALL_ARG1(arg1), PVOP_CALL_ARG2(arg2),	\
 		     PVOP_CALL_ARG3(arg3), PVOP_CALL_ARG4(arg4))
=20
-/* Lazy mode for batching updates / context switch */
-enum paravirt_lazy_mode {
-	PARAVIRT_LAZY_NONE,
-	PARAVIRT_LAZY_MMU,
-	PARAVIRT_LAZY_CPU,
-};
-
 enum paravirt_lazy_mode paravirt_get_lazy_mode(void);
 void paravirt_start_context_switch(struct task_struct *prev);
 void paravirt_end_context_switch(struct task_struct *next);
