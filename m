Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6637297ED
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 13:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239352AbjFILN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 07:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239066AbjFILNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 07:13:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44D11FDC
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 04:13:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7F7FA1FDF8;
        Fri,  9 Jun 2023 11:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686309196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HtizpSkxYlWAXraFNdbEL4Y1/gcbY1LlaDxMnphho2M=;
        b=UfksIQJpywX61OplTPxdtEDNEBSpbS3sTOKsu5I1T09Sg+g+iZOZnic15IyTQ7jF02wqJk
        cAAUC0lHEDfDIMbPAsSptmzLjsj6Dep7T7jvofqOl+VMNFnCp2oHgBAm79TsGGQojOkRph
        pzQb8epcwfI04NZZLFJoct3BG1dBTzQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2BBDA139C8;
        Fri,  9 Jun 2023 11:13:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cAXTB0wJg2ReIwAAMHmgww
        (envelope-from <nik.borisov@suse.com>); Fri, 09 Jun 2023 11:13:16 +0000
From:   Nikolay Borisov <nik.borisov@suse.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com, jslaby@suse.cz,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH v2 4/4] x86: Disable laoding 32bit processes if ia32_disabled is true
Date:   Fri,  9 Jun 2023 14:13:11 +0300
Message-Id: <20230609111311.4110901-5-nik.borisov@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230609111311.4110901-1-nik.borisov@suse.com>
References: <20230609111311.4110901-1-nik.borisov@suse.com>
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
ability to load 32bit compat processes.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---
 arch/x86/include/asm/elf.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 18fd06f7936a..0fa49388ff16 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -148,9 +148,16 @@ do {						\
 #define elf_check_arch(x)			\
 	((x)->e_machine == EM_X86_64)
 
+#ifdef CONFIG_IA32_EMULATION
+extern bool ia32_disabled;
 #define compat_elf_check_arch(x)					\
-	(elf_check_arch_ia32(x) ||					\
+	((elf_check_arch_ia32(x) && !ia32_disabled) ||			\
 	 (IS_ENABLED(CONFIG_X86_X32_ABI) && (x)->e_machine == EM_X86_64))
+#else
+#define compat_elf_check_arch(x)					\
+	(elf_check_arch_ia32(x) ||			\
+	 (IS_ENABLED(CONFIG_X86_X32_ABI) && (x)->e_machine == EM_X86_64))
+#endif
 
 static inline void elf_common_init(struct thread_struct *t,
 				   struct pt_regs *regs, const u16 ds)
-- 
2.34.1

