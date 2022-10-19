Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940E9604E01
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 19:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbiJSRAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 13:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbiJSRAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 13:00:10 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10958147D04
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 09:59:59 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7c5329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7c5:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D06B41EC06F6;
        Wed, 19 Oct 2022 18:59:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666198789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=wfzcVssgEajdu3Qp/ntlN+Oqmn9PoGR/l9r0yknqTb8=;
        b=TEqEzpVxA7DXX33Wbq7ud/RduEzU+tJ2UgxwtF6X0o5cy6M04a65q/PD9Rou4opREQp73F
        grdXlwbkGxw+K0xnU9hvK1ObPovjBgTE5QgguZg3iD1pFvUO6qO7ZpKwbSNFeEoGvpzvaQ
        CXfFkU5VEJZsmg1ujeRN/SijAmg6FgQ=
Date:   Wed, 19 Oct 2022 18:59:45 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     virtualization@lists.linux-foundation.org, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH x86/core] x86/paravirt: Fix a !PARAVIRT build warning
Message-ID: <Y1AtAXM8YjtBm2cj@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this goes ontop of x86/core as the issue is caused by one of the
includes in callthunks.c there.

Thx.

---
From: Borislav Petkov <bp@suse.de>

Fix

  ./include/trace/events/xen.h:28:31: warning: ‘enum paravirt_lazy_mode’ \
    declared inside parameter list will not be visible outside of this definition or declaration

which turns into a build error:

  ./include/trace/events/xen.h:28:50: error: parameter 1 (‘mode’) has incomplete type
     28 |                 TP_PROTO(enum paravirt_lazy_mode mode), \

due to enum paravirt_lazy_mode being visible only under CONFIG_PARAVIRT.
Just pull it up where it is unconditionally visible.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/paravirt_types.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index e137d9412123..27c692791b7e 100644
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
 
 #ifdef CONFIG_PARAVIRT
@@ -582,13 +589,6 @@ int paravirt_disable_iospace(void);
 	__PVOP_VCALL(op, PVOP_CALL_ARG1(arg1), PVOP_CALL_ARG2(arg2),	\
 		     PVOP_CALL_ARG3(arg3), PVOP_CALL_ARG4(arg4))
 
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
-- 
2.35.1


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
