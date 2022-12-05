Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8AE642410
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 09:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbiLEIFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 03:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbiLEIE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 03:04:58 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FE115FD1
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 00:04:49 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B8E091FE3B;
        Mon,  5 Dec 2022 08:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1670227487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yMianIWALJeEq31IWXfqs8+ymd+X0ZqlQ5HivhuglU8=;
        b=O0TiN9vK31fNPKt8r4pZQ5mbZFzXECyGM25P8HGOrmC1GzxFUTz26b283hzdUJXe6TMtL1
        p9MEznH483Zd26pK9SovhTX/vXVV4jZsh/PYocav+3+FiW/5NUrsXvqO6vxXK0JE2UszWN
        BZMPgguXzGB16djGyLpqfVMSt1Qer5U=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 7A6751348F;
        Mon,  5 Dec 2022 08:04:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id px+rHB+mjWNTNAAAGKfGzw
        (envelope-from <jgross@suse.com>); Mon, 05 Dec 2022 08:04:47 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     kirill@shutemov.name, Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 2/2] x86/mtrr: make message for disabled MTRRs more descriptive
Date:   Mon,  5 Dec 2022 09:04:33 +0100
Message-Id: <20221205080433.16643-3-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221205080433.16643-1-jgross@suse.com>
References: <20221205080433.16643-1-jgross@suse.com>
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

Instead of just saying "Disabled" when MTRRs are disabled for any
reason, tell what is disabled and why.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/kernel/cpu/mtrr/mtrr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 6432abccbf56..94d5739758ba 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -630,6 +630,7 @@ int __initdata changed_by_mtrr_cleanup;
 void __init mtrr_bp_init(void)
 {
 	u32 phys_addr;
+	const char *why = "(not available)";
 
 	phys_addr = 32;
 
@@ -705,12 +706,13 @@ void __init mtrr_bp_init(void)
 				changed_by_mtrr_cleanup = mtrr_cleanup(phys_addr);
 			} else {
 				mtrr_if = NULL;
+				why = "by BIOS";
 			}
 		}
 	}
 
 	if (!mtrr_enabled())
-		pr_info("Disabled\n");
+		pr_info("MTRRs disabled %s\n", why);
 }
 
 /**
-- 
2.35.3

