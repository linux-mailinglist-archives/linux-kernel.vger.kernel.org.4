Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA7C7331BD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345550AbjFPM6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345513AbjFPM5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:57:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898F5358C
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 05:57:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 071211F8AC;
        Fri, 16 Jun 2023 12:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686920272; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uebKOiOaouuF4hP+m2W8QMLwwo8lvdplmN5LTEefmQs=;
        b=ApQssAVDFiBkb791JaTp+XIxktjd23BYoBaEWhjnIkcR4UR6Ziljlnuq8PkAWp36ZWfp7h
        jRcdbUm7Ja7zjBEJRkdn4nGYBEExEXV4DKGne1uxAa6iUzNJXHCIvyNcaMiWdhX2FpuraS
        puIfvomTJiZ+hOjOPGeaATq5oWT8POs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A41371330B;
        Fri, 16 Jun 2023 12:57:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aHRnJU9cjGTjNwAAMHmgww
        (envelope-from <nik.borisov@suse.com>); Fri, 16 Jun 2023 12:57:51 +0000
From:   Nikolay Borisov <nik.borisov@suse.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com, jslaby@suse.cz,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH v3 4/5] x86/elf: Make loading of 32bit processes depend on ia32_enabled()
Date:   Fri, 16 Jun 2023 15:57:29 +0300
Message-Id: <20230616125730.1164989-5-nik.borisov@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230616125730.1164989-1-nik.borisov@suse.com>
References: <20230616125730.1164989-1-nik.borisov@suse.com>
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

Make this macro also consider the runtime state of ia32 emulation before
allowing to load a 32bit process.

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

