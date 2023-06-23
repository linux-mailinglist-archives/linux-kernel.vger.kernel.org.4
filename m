Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2EB073B5EB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 13:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbjFWLOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 07:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbjFWLOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 07:14:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65E62101
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 04:14:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 770E41F6E6;
        Fri, 23 Jun 2023 11:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1687518855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f0VodzPEDQcX9JjZJBEDkNzZARXLsoiBYtSqjF6vfi8=;
        b=TlbMDcQxYXlK/x5u7ubvCPwPsUHKpUfZI2GFCE+ITXT1GnMRj8C7W0StJCYva9t3+f64O/
        Fc6BaA9+wdK3ikB7F0nzb7Lxkn3Fn/eymNPmyTu4Z51VD2wn5JZ63vwZKARBD6R1AOiX+T
        TdRl3S2TG4GGIFFOhbEqDYmOQs8iEmY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 220221331F;
        Fri, 23 Jun 2023 11:14:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mNOEBYd+lWTcFAAAMHmgww
        (envelope-from <nik.borisov@suse.com>); Fri, 23 Jun 2023 11:14:15 +0000
From:   Nikolay Borisov <nik.borisov@suse.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mohocko@suse.com, jslaby@suse.cz,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH v4 4/6] x86/elf: Make loading of 32bit processes depend on ia32_enabled()
Date:   Fri, 23 Jun 2023 14:14:07 +0300
Message-Id: <20230623111409.3047467-5-nik.borisov@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623111409.3047467-1-nik.borisov@suse.com>
References: <20230623111409.3047467-1-nik.borisov@suse.com>
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

Major aspect of ia32 emulation is the ability to load 32bit processes.
That's currently decided (among others) by compat_elf_check_arch().

Make the macro use ia32_enabled() to decide if IA32 compat is
enabled before loading a 32bit process.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---
 arch/x86/include/asm/elf.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 18fd06f7936a..a0234dfd1031 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -7,6 +7,7 @@
  */
 #include <linux/thread_info.h>
 
+#include <asm/ia32.h>
 #include <asm/ptrace.h>
 #include <asm/user.h>
 #include <asm/auxvec.h>
@@ -149,7 +150,7 @@ do {						\
 	((x)->e_machine == EM_X86_64)
 
 #define compat_elf_check_arch(x)					\
-	(elf_check_arch_ia32(x) ||					\
+	((elf_check_arch_ia32(x) && ia32_enabled()) ||			\
 	 (IS_ENABLED(CONFIG_X86_X32_ABI) && (x)->e_machine == EM_X86_64))
 
 static inline void elf_common_init(struct thread_struct *t,
-- 
2.34.1

