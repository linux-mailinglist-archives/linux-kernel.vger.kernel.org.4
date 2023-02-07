Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5D368D096
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 08:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjBGH3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 02:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjBGH3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 02:29:13 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FA732E7F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 23:29:11 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9E32F21EBA;
        Tue,  7 Feb 2023 07:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675754950; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rbY40ezGliGVnHSth5hMXNDNMzMU7QLwqm1NaZ+5dkM=;
        b=jO5CLX0xWZHkj2UeNFp7sHfonkrtsyyATSHmwc/Kj7LOQ6K7zCAPf53+TN60RGd5qHyeEr
        QDMFsUrfE5zkMS5871Z37xsigU2CNsjkAmu1NlqLmB3WZ/h+Ab/lSeX1EUiYkCIzl+W5wt
        V2LD3eJTvJVvptr8534mzNyQfilK9OU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5163613A8C;
        Tue,  7 Feb 2023 07:29:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1Wd/Esb94WOfUQAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 07 Feb 2023 07:29:10 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     lists@nerdbynature.de, mikelley@microsoft.com,
        torvalds@linux-foundation.org, Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 1/6] x86/mtrr: make mtrr_enabled() non-static
Date:   Tue,  7 Feb 2023 08:28:57 +0100
Message-Id: <20230207072902.5528-2-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230207072902.5528-1-jgross@suse.com>
References: <20230207072902.5528-1-jgross@suse.com>
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

In order to be able to use mtrr_enabled() outside of MTRR code, make
it non-static and add a sub for the !CONFIG_MTRR case.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/mtrr.h     | 6 ++++++
 arch/x86/kernel/cpu/mtrr/mtrr.c | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/mtrr.h b/arch/x86/include/asm/mtrr.h
index f0eeaf6e5f5f..29ec2d6f0537 100644
--- a/arch/x86/include/asm/mtrr.h
+++ b/arch/x86/include/asm/mtrr.h
@@ -31,6 +31,7 @@
  */
 # ifdef CONFIG_MTRR
 void mtrr_bp_init(void);
+bool mtrr_enabled(void);
 extern u8 mtrr_type_lookup(u64 addr, u64 end, u8 *uniform);
 extern void mtrr_save_fixed_ranges(void *);
 extern void mtrr_save_state(void);
@@ -48,6 +49,11 @@ void mtrr_disable(void);
 void mtrr_enable(void);
 void mtrr_generic_set_state(void);
 #  else
+static inline bool mtrr_enabled(void)
+{
+	return false;
+}
+
 static inline u8 mtrr_type_lookup(u64 addr, u64 end, u8 *uniform)
 {
 	/*
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 783f3210d582..814cc13fd6eb 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -59,7 +59,7 @@
 #define MTRR_TO_PHYS_WC_OFFSET 1000
 
 u32 num_var_ranges;
-static bool mtrr_enabled(void)
+bool mtrr_enabled(void)
 {
 	return !!mtrr_if;
 }
-- 
2.35.3

