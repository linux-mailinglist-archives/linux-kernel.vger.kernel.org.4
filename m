Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34825F3DF2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiJDIMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiJDILv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:11:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4AD64E0
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 01:11:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3E95A219BD;
        Tue,  4 Oct 2022 08:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664871072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sTywZDx5uRgwnEEo9krOm0MUfpgr1DThTwZJSMEuMvI=;
        b=XbrNHjsqorneAM5hvphiO008+u7tQbZAMy9OICerPrz1WyenkVVDzYl+5BlrdIM2PXG5nO
        xAzBNXobk9Ss6eyCMHqRNMgNWKGZsDNcpNX4z5WOJl8XEXML4ww7B60QDPghIH3iAJHQK0
        3UAiLjyzWJbQ97zQws3Ndv1gHoKlorU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F3EC4139EF;
        Tue,  4 Oct 2022 08:11:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Mv5POp/qO2NoSAAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 04 Oct 2022 08:11:11 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v4 08/16] x86/mtrr: remove set_all callback from struct mtrr_ops
Date:   Tue,  4 Oct 2022 10:10:15 +0200
Message-Id: <20221004081023.32402-9-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221004081023.32402-1-jgross@suse.com>
References: <20221004081023.32402-1-jgross@suse.com>
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
index dacb537da126..501ca1747d55 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -165,15 +165,15 @@ static int mtrr_rendezvous_handler(void *info)
 	 * saved, and we want to replicate that across all the cpus that come
 	 * online (either at the end of boot or resume or during a runtime cpu
 	 * online). If we're doing that, @reg is set to something special and on
-	 * all the cpu's we do mtrr_if->set_all() (On the logical cpu that
+	 * all the cpu's we do cache_cpu_init() (On the logical cpu that
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
@@ -765,7 +765,7 @@ void __init mtrr_bp_init(void)
 
 			if (mtrr_cleanup(phys_addr)) {
 				changed_by_mtrr_cleanup = 1;
-				mtrr_if->set_all();
+				cache_cpu_init();
 			}
 		}
 	}
@@ -851,7 +851,7 @@ void mtrr_bp_restore(void)
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

