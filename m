Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53F0632955
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 17:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiKUQYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 11:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiKUQYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 11:24:38 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99ED6C8462
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 08:24:36 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3D348220D0;
        Mon, 21 Nov 2022 16:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669047875; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=vM7lsk8RXRK5rWKi3euFrZN65JTSYYzeLkaycP3+980=;
        b=lQb73XmuRm9cAtopvVxw3SQmWht21QY4S171ZrLyfYCA9szFaF5WMaLQoFaaJ7cHRQwR3n
        nsupt0qTscoP313sDisopDmfcapC9h30V/Qz5P7dBh9GK3Kz6Px3C35142ZP3aWnXcYh2X
        VVD2FPS4NvnIK8XoAlO0pYandrnMQXg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EB2E51377F;
        Mon, 21 Nov 2022 16:24:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5E3SN0Kme2NIYAAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 21 Nov 2022 16:24:34 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/boot: skip realmode init code when running as Xen PV guest
Date:   Mon, 21 Nov 2022 17:24:33 +0100
Message-Id: <20221121162433.28070-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running as a Xen PV guest there is no need for setting up the
realmode trampoline, as realmode isn't supported in this environment.

Trying to setup the trampoline has been proven to be problematic in
some cases, especially when trying to debug early boot problems with
Xen requiring to keep the EFI boot-services memory mapped (some
firmware variants seem to claim basically all memory below 1M for boot
services).

Skip the trampoline setup code for Xen PV guests.

Fixes: 084ee1c641a0 ("x86, realmode: Relocator for realmode code")
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/realmode.h | 4 ++--
 arch/x86/realmode/init.c        | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
index fd6f6e5b755a..5bfce58f1bab 100644
--- a/arch/x86/include/asm/realmode.h
+++ b/arch/x86/include/asm/realmode.h
@@ -78,8 +78,8 @@ extern unsigned char secondary_startup_64_no_verify[];
 
 static inline size_t real_mode_size_needed(void)
 {
-	if (real_mode_header)
-		return 0;	/* already allocated. */
+	if (real_mode_header || cpu_feature_enabled(X86_FEATURE_XENPV))
+		return 0;	/* already allocated or not needed. */
 
 	return ALIGN(real_mode_blob_end - real_mode_blob, PAGE_SIZE);
 }
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index 41d7669a97ad..1826700b156e 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -202,6 +202,9 @@ static void __init set_real_mode_permissions(void)
 
 static int __init init_real_mode(void)
 {
+	if (cpu_feature_enabled(X86_FEATURE_XENPV))
+		return 0;
+
 	if (!real_mode_header)
 		panic("Real mode trampoline was not allocated");
 
-- 
2.35.3

