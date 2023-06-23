Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484E473B5E9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 13:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjFWLOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 07:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjFWLOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 07:14:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D101FF9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 04:14:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 104EC21B15;
        Fri, 23 Jun 2023 11:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1687518855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Yy85zR9fuPHZsIKybiFZXTFB/OLmUVvR9b3i0pMJzE=;
        b=qDURYg8SdKUS2CeWjKzKeaUE2JWhPqjAqw74ROnCesy7Xrt1T6opu1bv0KCx5b0kJdxR5R
        n2Nlp6Ku8HJK4DaAXcQeUF5NtHKmx2/kRkAMKtv6RPo3bDgj6TnSfP2oowpVrsImFXoUlB
        ++4SWHnumHiq1/eR7cbNFbkPSH/LDLY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AE9111331F;
        Fri, 23 Jun 2023 11:14:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EO3pJ4Z+lWTcFAAAMHmgww
        (envelope-from <nik.borisov@suse.com>); Fri, 23 Jun 2023 11:14:14 +0000
From:   Nikolay Borisov <nik.borisov@suse.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mohocko@suse.com, jslaby@suse.cz,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH v4 3/6] x86/entry: Compile entry_SYSCALL32_ignore() unconditionally
Date:   Fri, 23 Jun 2023 14:14:06 +0300
Message-Id: <20230623111409.3047467-4-nik.borisov@suse.com>
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

To limit the IA32 exposure on 64bit kernels while keeping the
flexibility for the user to enable it when required, the compile time
enable/disable via CONFIG_IA32_EMULATION is not good enough and will
be complemented with a kernel command line option.

Right now entry_SYSCALL32_ignore() is only compiled when
CONFIG_IA32_EMULATION=n, but boot-time enable- / disablement obviously
requires it to be unconditionally available.

Remove the #ifndef CONFIG_IA32_EMULATION guard.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---
 arch/x86/entry/entry_64.S | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index ccce0ccd8589..7068af44008a 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1514,7 +1514,6 @@ SYM_CODE_START(asm_exc_nmi)
 	iretq
 SYM_CODE_END(asm_exc_nmi)
 
-#ifndef CONFIG_IA32_EMULATION
 /*
  * This handles SYSCALL from 32-bit code.  There is no way to program
  * MSRs to fully disable 32-bit SYSCALL.
@@ -1525,7 +1524,6 @@ SYM_CODE_START(entry_SYSCALL32_ignore)
 	mov	$-ENOSYS, %eax
 	sysretl
 SYM_CODE_END(entry_SYSCALL32_ignore)
-#endif
 
 .pushsection .text, "ax"
 	__FUNC_ALIGN
-- 
2.34.1

