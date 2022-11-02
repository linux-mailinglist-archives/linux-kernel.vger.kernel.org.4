Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84D1615D23
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 08:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbiKBHs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 03:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiKBHsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 03:48:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C38625EA8
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 00:48:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 07B191F8F6;
        Wed,  2 Nov 2022 07:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667375281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jEdYANPBbo11yEPhclA11hPNGtJyAv+5gydUG+2wLoA=;
        b=HNhwEaizrMBram9B1DMCvJi1mShlOtPjN9L3JRMrTMezKPmg9gEri+ki/ZVoBZ+2c1B7Cg
        fEFmNmizwcFlmkkfoTYL0rYYi3ZA4ZC1U6Diyvr8jyHZmhvwV3FiqS+fWX8XojEihjGhjy
        rIOuhc+lCXpgsb1jyFU3vsl3BxuG9/Y=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BC24E1376E;
        Wed,  2 Nov 2022 07:48:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PdaVLLAgYmPmcgAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 02 Nov 2022 07:48:00 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v5 08/16] x86/mtrr: remove set_all callback from struct mtrr_ops
Date:   Wed,  2 Nov 2022 08:47:05 +0100
Message-Id: <20221102074713.21493-9-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221102074713.21493-1-jgross@suse.com>
References: <20221102074713.21493-1-jgross@suse.com>
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

Instead of using an indirect call to mtrr_if->set_all just call the
only possible target cache_cpu_init() directly. This enables to remove
the set_all callback from struct mtrr_ops.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/kernel/cpu/mtrr/generic.c |  1 -
 arch/x86/kernel/cpu/mtrr/mtrr.c    | 10 +++++-----
 arch/x86/kernel/cpu/mtrr/mtrr.h    |  2 --
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index 32aebed25e3f..af8422c96b92 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -843,7 +843,6 @@ int positive_have_wrcomb(void)
  * Generic structure...
  */
 const struct mtrr_ops generic_mtrr_ops = {
-	.set_all		= cache_cpu_init,
 	.get			= generic_get_mtrr,
 	.get_free_region	= generic_get_free_region,
 	.set			= generic_set_mtrr,
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 4209945c4e68..a44b510ced0e 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -170,15 +170,15 @@ static int mtrr_rendezvous_handler(void *info)
 	 * saved, and we want to replicate that across all the cpus that come
 	 * online (either at the end of boot or resume or during a runtime cpu
 	 * online). If we're doing that, @reg is set to something special and on
-	 * all the cpu's we do mtrr_if->set_all() (On the logical cpu that
+	 * all the CPUs we do cache_cpu_init() (On the logical CPU that
 	 * started the boot/resume sequence, this might be a duplicate
-	 * set_all()).
+	 * cache_cpu_init()).
 	 */
 	if (data->smp_reg != ~0U) {
 		mtrr_if->set(data->smp_reg, data->smp_base,
 			     data->smp_size, data->smp_type);
 	} else if (mtrr_aps_delayed_init || !cpu_online(smp_processor_id())) {
-		mtrr_if->set_all();
+		cache_cpu_init();
 	}
 	return 0;
 }
@@ -770,7 +770,7 @@ void __init mtrr_bp_init(void)
 
 			if (mtrr_cleanup(phys_addr)) {
 				changed_by_mtrr_cleanup = 1;
-				mtrr_if->set_all();
+				cache_cpu_init();
 			}
 		}
 	}
@@ -856,7 +856,7 @@ void mtrr_bp_restore(void)
 	if (!memory_caching_control)
 		return;
 
-	mtrr_if->set_all();
+	cache_cpu_init();
 }
 
 static int __init mtrr_init_finialize(void)
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.h b/arch/x86/kernel/cpu/mtrr/mtrr.h
index 88b1c4b6174a..3b1883185185 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.h
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.h
@@ -16,8 +16,6 @@ struct mtrr_ops {
 	u32	vendor;
 	void	(*set)(unsigned int reg, unsigned long base,
 		       unsigned long size, mtrr_type type);
-	void	(*set_all)(void);
-
 	void	(*get)(unsigned int reg, unsigned long *base,
 		       unsigned long *size, mtrr_type *type);
 	int	(*get_free_region)(unsigned long base, unsigned long size,
-- 
2.35.3

