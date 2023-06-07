Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84C37255CB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 09:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238981AbjFGHfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 03:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239174AbjFGHeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 03:34:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144911BEF
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 00:29:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B296B219EC;
        Wed,  7 Jun 2023 07:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686122982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y8Pjt8EA8tFinVOCzCHnLFdQUw7jcSWs6svSbR9DVSQ=;
        b=tNQhbwuzxd5SYqDHVX1o1k0QPg1PyklcAk0KnWACq32tGICNwRNqxEcpfISX3DoiwspJma
        InYIIsN2JAZuvWOhF/lywInWaSzYm6Vlgg6fNqZxDHqt1tBGevmgEIzlefQ8vnHNXqlMvk
        RmV2oovEiZq5IZC61VRKr1+GcSKlyus=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 610D413776;
        Wed,  7 Jun 2023 07:29:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OMwTFeYxgGSUIQAAMHmgww
        (envelope-from <nik.borisov@suse.com>); Wed, 07 Jun 2023 07:29:42 +0000
From:   Nikolay Borisov <nik.borisov@suse.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com, jslaby@suse.cz,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH 3/3] x86: Disable running 32bit processes if ia32_disabled is passed
Date:   Wed,  7 Jun 2023 10:29:36 +0300
Message-Id: <20230607072936.3766231-4-nik.borisov@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607072936.3766231-1-nik.borisov@suse.com>
References: <20230607072936.3766231-1-nik.borisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In addition to disabling 32bit syscall interface let's also disable the
ability to run 32bit processes altogether. This is achieved by setting
the GDT_ENTRY_DEFAULT_USER32_CS descriptor to not present which would
cause 32 bit processes to trap with a #NP exception. Furthermore,
forbid loading compat processes as well.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---
 arch/x86/include/asm/elf.h   | 5 +++--
 arch/x86/kernel/cpu/common.c | 8 ++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 18fd06f7936a..406245bc0fb0 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -148,9 +148,10 @@ do {						\
 #define elf_check_arch(x)			\
 	((x)->e_machine == EM_X86_64)
 
+extern bool ia32_disabled;
 #define compat_elf_check_arch(x)					\
-	(elf_check_arch_ia32(x) ||					\
-	 (IS_ENABLED(CONFIG_X86_X32_ABI) && (x)->e_machine == EM_X86_64))
+	(!ia32_disabled && (elf_check_arch_ia32(x) ||			\
+	 (IS_ENABLED(CONFIG_X86_X32_ABI) && (x)->e_machine == EM_X86_64)))
 
 static inline void elf_common_init(struct thread_struct *t,
 				   struct pt_regs *regs, const u16 ds)
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 71f8b55f70c9..ddc301c09419 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2359,6 +2359,11 @@ void microcode_check(struct cpuinfo_x86 *prev_info)
 }
 #endif
 
+static void remove_user32cs_from_gdt(void * __unused)
+{
+	get_current_gdt_rw()[GDT_ENTRY_DEFAULT_USER32_CS].p = 0;
+}
+
 /*
  * Invoked from core CPU hotplug code after hotplug operations
  */
@@ -2368,4 +2373,7 @@ void arch_smt_update(void)
 	cpu_bugs_smt_update();
 	/* Check whether IPI broadcasting can be enabled */
 	apic_smt_update();
+	if (ia32_disabled)
+		on_each_cpu(remove_user32cs_from_gdt, NULL, 1);
+
 }
-- 
2.34.1

