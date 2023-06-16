Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837B77331BE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345544AbjFPM6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345512AbjFPM5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:57:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016CE2713
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 05:57:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 942E022057;
        Fri, 16 Jun 2023 12:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686920271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SoXFQh+RzasTMouNeEc9Sv2mkn82qFE8WfTasNo7vBE=;
        b=sDNCqdYQ9KuxM/AapNsR3qQipjbFj4+Pt0gEHCUgW8lqoS7iiEQEKbIKAbGsgA3Hrr5kDs
        HpEE9CHDy5K1UwzUvknprcAGsJtjWXq7JQXZ6W1IkYExK8Sd1je0HqrygxBMIJDNPYTLIy
        BQfj3R/F9fXwQPnQ42TQGoWUfhZ+1hM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3EBBE1391E;
        Fri, 16 Jun 2023 12:57:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IL+0DE9cjGTjNwAAMHmgww
        (envelope-from <nik.borisov@suse.com>); Fri, 16 Jun 2023 12:57:51 +0000
From:   Nikolay Borisov <nik.borisov@suse.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com, jslaby@suse.cz,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH v3 3/5] x86/entry: Compile entry_SYSCALL32_ignore unconditionally
Date:   Fri, 16 Jun 2023 15:57:28 +0300
Message-Id: <20230616125730.1164989-4-nik.borisov@suse.com>
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

In upcomiing patches entry_SYSCALL32_ignore() could be used even if
CONFIG_IA32_EMULATION is selected but IA32 support is disabled either
via CONFIG_IA32_EMULATION_DEFAULT_DISABLED or the runtime override.i

Just compile it unconditionally.

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

