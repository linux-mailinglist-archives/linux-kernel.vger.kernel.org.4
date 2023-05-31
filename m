Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6E4717C62
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235611AbjEaJs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235636AbjEaJsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 05:48:51 -0400
Received: from forward103c.mail.yandex.net (forward103c.mail.yandex.net [178.154.239.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B23186
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 02:48:47 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-46.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-46.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:4212:0:640:eaad:0])
        by forward103c.mail.yandex.net (Yandex) with ESMTP id 4A3776012A;
        Wed, 31 May 2023 12:48:45 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-46.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id PmJIwTgDTSw0-d00CHH58;
        Wed, 31 May 2023 12:48:44 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1685526524;
        bh=/+yrP7PJJrDTJFlfec0Z4gx8SGYdj6Pp6yB3C+HFcFA=;
        h=Message-Id:Date:Cc:Subject:To:From;
        b=osGjz3xkoP0YDkppDo8ILcDt0r6Uw3SsAsyXcheW034TzenmBUZsE9+wPQOrLsbH8
         S/u0uX1fwwwZoQv5UnHJ5zU8Ro/pckcycPT8j6/dIhLD+3FeXskKlsC2BBvHPGHXi3
         W0/GRN6PvftQqQqW4mNHb39hPDDz73uLbX+mHU6s=
Authentication-Results: mail-nwsmtp-smtp-production-main-46.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Ingo Molnar <mingo@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Dmitry Antipov <dmantipov@yandex.ru>,
        Dmitriy Antipov <Dmitriy.Antipov@softline.com>
Subject: [PATCH] x86: add prototypes to fix 'make LLVM=1 W=1' build
Date:   Wed, 31 May 2023 12:47:46 +0300
Message-Id: <20230531094746.114547-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add prototypes required to fix the following 'make LLVM=1 W=1'
build errors:

arch/x86/entry/common.c:238:24: error: no previous prototype for
function 'do_SYSENTER_32' [-Werror,-Wmissing-prototypes]
__visible noinstr long do_SYSENTER_32(struct pt_regs *regs)
                       ^

arch/x86/entry/common.c:302:24: error: no previous prototype for
function 'xen_pv_evtchn_do_upcall' [-Werror,-Wmissing-prototypes]
__visible noinstr void xen_pv_evtchn_do_upcall(struct pt_regs *regs)
                       ^

Signed-off-by: Dmitriy Antipov <Dmitriy.Antipov@softline.com>
---
 arch/x86/include/asm/syscall.h    | 4 ++++
 arch/x86/include/asm/xen/events.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
index 5b85987a5e97..b7929c27dc4f 100644
--- a/arch/x86/include/asm/syscall.h
+++ b/arch/x86/include/asm/syscall.h
@@ -132,4 +132,8 @@ long do_fast_syscall_32(struct pt_regs *regs);
 
 #endif	/* CONFIG_X86_32 */
 
+#if defined(CONFIG_X86_32) || defined(CONFIG_IA32_EMULATION)
+extern __visible noinstr long do_SYSENTER_32(struct pt_regs *regs);
+#endif
+
 #endif	/* _ASM_X86_SYSCALL_H */
diff --git a/arch/x86/include/asm/xen/events.h b/arch/x86/include/asm/xen/events.h
index 62bdceb594f1..8177aa839e7c 100644
--- a/arch/x86/include/asm/xen/events.h
+++ b/arch/x86/include/asm/xen/events.h
@@ -34,5 +34,7 @@ static inline bool xen_support_evtchn_rebind(void)
 	return (!xen_hvm_domain() || xen_have_vector_callback);
 }
 
+extern __visible noinstr void xen_pv_evtchn_do_upcall(struct pt_regs *regs);
+
 extern bool xen_percpu_upcall;
 #endif /* _ASM_X86_XEN_EVENTS_H */
-- 
2.40.1

