Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F09472CA8A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239615AbjFLPo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239689AbjFLPor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:44:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B0F19C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:44:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D6852201CA;
        Mon, 12 Jun 2023 15:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686584682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=17atOqn7TUYDCnzDYeFz31heYTXfkLqafdxQqG9pN2E=;
        b=G882Nc/ChI7nAOWeLzrbZFop4mWc7QzBHavOgV1/KK25GEc4l4rGKMCxxNTxNMgv/pUCuG
        i7xhsrRPrQLgikKtNpxpRSutExJroaTiJVRGRCHa9TFNYH5PQZ/vEzFSbCSgG29aIJKYF8
        fxxrseq+UqE2zN0jqrRMFLZEBVNfd58=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 99B2C138EC;
        Mon, 12 Jun 2023 15:44:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NVBuImo9h2ROQgAAMHmgww
        (envelope-from <nik.borisov@suse.com>); Mon, 12 Jun 2023 15:44:42 +0000
From:   Nikolay Borisov <nik.borisov@suse.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH] x86: Remove dead declarations in ia32.h
Date:   Mon, 12 Jun 2023 18:44:38 +0300
Message-Id: <20230612154438.638491-1-nik.borisov@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ia32_pick_mmap_layout got removed in 675a0813609f ("x86: unify mmap_{32|64}.c")
and ia32_setup_arg_pages was removed as part of
32974ad4907c ("[IA64] Remove COMPAT_IA32 support").

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---
 arch/x86/include/asm/ia32.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/x86/include/asm/ia32.h b/arch/x86/include/asm/ia32.h
index fada857f0a1e..068f6227dfdb 100644
--- a/arch/x86/include/asm/ia32.h
+++ b/arch/x86/include/asm/ia32.h
@@ -59,15 +59,6 @@ struct stat64 {
 
 #define IA32_STACK_TOP IA32_PAGE_OFFSET
 
-#ifdef __KERNEL__
-struct linux_binprm;
-extern int ia32_setup_arg_pages(struct linux_binprm *bprm,
-				unsigned long stack_top, int exec_stack);
-struct mm_struct;
-extern void ia32_pick_mmap_layout(struct mm_struct *mm);
-
-#endif
-
 #endif /* CONFIG_IA32_EMULATION */
 
 #endif /* _ASM_X86_IA32_H */
-- 
2.34.1

