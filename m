Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B806F436C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 14:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbjEBMLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 08:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbjEBMLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 08:11:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3849659F6
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 05:10:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A467A21E57;
        Tue,  2 May 2023 12:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683029433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bZxyQRt/yrkvsCuSBp3GRmGhot3fCxU/5bmk8IYlVXE=;
        b=h4ig5p68zyj7w+Prtp0LSrsGUHVIqvAYzHTQ1SsVfPHchwaGf+iO2/BY9mYvogjv4Zv0mE
        FcemY3Ruri+norMMTKMXBjQyK7cAIZnQ8JXAyt6yiklzKJI11o+lB1V9hbcoJ4uW7Uqgsi
        VdXEFoSKzGJMKoJIg36vcnE0SubV/Vk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 65CAC139C3;
        Tue,  2 May 2023 12:10:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TYqNF7n9UGQAMAAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 02 May 2023 12:10:33 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     mikelley@microsoft.com, Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v6 09/16] x86/mtrr: allocate mtrr_value array dynamically
Date:   Tue,  2 May 2023 14:09:24 +0200
Message-Id: <20230502120931.20719-10-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230502120931.20719-1-jgross@suse.com>
References: <20230502120931.20719-1-jgross@suse.com>
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

The mtrr_value[] array is a static variable, which is used only in a
few configurations. Consuming 6kB is ridiculous for this case,
especially as the array doesn't need to be that large and it can easily
be allocated dynamically.

Signed-off-by: Juergen Gross <jgross@suse.com>
Tested-by: Michael Kelley <mikelley@microsoft.com>
---
V5:
- check for allocation failure (Kai Huang, Boris Petkov)
- add #ifdef
V6:
- rebase
---
 arch/x86/kernel/cpu/mtrr/legacy.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mtrr/legacy.c b/arch/x86/kernel/cpu/mtrr/legacy.c
index 7d379fb26cce..d25882fcf181 100644
--- a/arch/x86/kernel/cpu/mtrr/legacy.c
+++ b/arch/x86/kernel/cpu/mtrr/legacy.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include <linux/types.h>
+#include <linux/slab.h>
 #include <linux/syscore_ops.h>
 #include <asm/cpufeature.h>
 #include <asm/mtrr.h>
@@ -38,12 +39,15 @@ struct mtrr_value {
 	unsigned long	lsize;
 };
 
-static struct mtrr_value mtrr_value[MTRR_MAX_VAR_RANGES];
+static struct mtrr_value *mtrr_value;
 
 static int mtrr_save(void)
 {
 	int i;
 
+	if (!mtrr_value)
+		return -ENOMEM;
+
 	for (i = 0; i < num_var_ranges; i++) {
 		mtrr_if->get(i, &mtrr_value[i].lbase,
 				&mtrr_value[i].lsize,
@@ -72,6 +76,8 @@ static struct syscore_ops mtrr_syscore_ops = {
 
 void mtrr_register_syscore(void)
 {
+	mtrr_value = kcalloc(num_var_ranges, sizeof(*mtrr_value), GFP_KERNEL);
+
 	/*
 	 * The CPU has no MTRR and seems to not support SMP. They have
 	 * specific drivers, we use a tricky method to support
-- 
2.35.3

