Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5756F4366
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 14:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbjEBMLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 08:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234038AbjEBMKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 08:10:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9953A6180
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 05:10:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 461191F8C4;
        Tue,  2 May 2023 12:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683029422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DgCRNXz0bs0WvceUdREg7f7DvaWPhgAqi3kLd7uuhq0=;
        b=lq/JU9s3oSNbApvUO2J/QNnpZ38LaA5+tBdvpKdJpFGH11oWD7aG9wcN8WnecgSSipclvz
        CHHgVq0j3W0tzZ+lTqI0QGexnUo7tg0okmG8LJoHk+lBn4wlxEzAITavTCl2CgXF9dQdkV
        5huto00ebmV9slfyWFAs3XanaYoWo8w=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 00114139C3;
        Tue,  2 May 2023 12:10:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7tRGOq39UGTjLwAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 02 May 2023 12:10:21 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     mikelley@microsoft.com, Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v6 07/16] x86/mtrr: have only one set_mtrr() variant
Date:   Tue,  2 May 2023 14:09:22 +0200
Message-Id: <20230502120931.20719-8-jgross@suse.com>
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

Today there are two variants of set_mtrr(): one calling stop_machine()
and one calling stop_machine_cpuslocked().

The first one (set_mtrr()) has only one caller, and this caller is
running only when resuming from suspend when the interrupts are still
off and only one CPU is active. Additionally this code is used only on
rather old 32-bit CPUs not supporting SMP.

For this reasons the first variant can be replaced by a simple call of
mtrr_if->set().

Rename the second variant set_mtrr_cpuslocked() to set_mtrr() now that
there is only one variant left, in order to have a shorter function
name.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V5:
- new patch
---
 arch/x86/kernel/cpu/mtrr/mtrr.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 3351730447e1..3a38f34bf289 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -177,20 +177,8 @@ static inline int types_compatible(mtrr_type type1, mtrr_type type2)
  * Note that the mechanism is the same for UP systems, too; all the SMP stuff
  * becomes nops.
  */
-static void
-set_mtrr(unsigned int reg, unsigned long base, unsigned long size, mtrr_type type)
-{
-	struct set_mtrr_data data = { .smp_reg = reg,
-				      .smp_base = base,
-				      .smp_size = size,
-				      .smp_type = type
-				    };
-
-	stop_machine(mtrr_rendezvous_handler, &data, cpu_online_mask);
-}
-
-static void set_mtrr_cpuslocked(unsigned int reg, unsigned long base,
-				unsigned long size, mtrr_type type)
+static void set_mtrr(unsigned int reg, unsigned long base, unsigned long size,
+		     mtrr_type type)
 {
 	struct set_mtrr_data data = { .smp_reg = reg,
 				      .smp_base = base,
@@ -320,7 +308,7 @@ int mtrr_add_page(unsigned long base, unsigned long size,
 	/* Search for an empty MTRR */
 	i = mtrr_if->get_free_region(base, size, replace);
 	if (i >= 0) {
-		set_mtrr_cpuslocked(i, base, size, type);
+		set_mtrr(i, base, size, type);
 		if (likely(replace < 0)) {
 			mtrr_usage_table[i] = 1;
 		} else {
@@ -328,7 +316,7 @@ int mtrr_add_page(unsigned long base, unsigned long size,
 			if (increment)
 				mtrr_usage_table[i]++;
 			if (unlikely(replace != i)) {
-				set_mtrr_cpuslocked(replace, 0, 0, 0);
+				set_mtrr(replace, 0, 0, 0);
 				mtrr_usage_table[replace] = 0;
 			}
 		}
@@ -456,7 +444,7 @@ int mtrr_del_page(int reg, unsigned long base, unsigned long size)
 		goto out;
 	}
 	if (--mtrr_usage_table[reg] < 1)
-		set_mtrr_cpuslocked(reg, 0, 0, 0);
+		set_mtrr(reg, 0, 0, 0);
 	error = reg;
  out:
 	mutex_unlock(&mtrr_mutex);
@@ -586,9 +574,9 @@ static void mtrr_restore(void)
 
 	for (i = 0; i < num_var_ranges; i++) {
 		if (mtrr_value[i].lsize) {
-			set_mtrr(i, mtrr_value[i].lbase,
-				    mtrr_value[i].lsize,
-				    mtrr_value[i].ltype);
+			mtrr_if->set(i, mtrr_value[i].lbase,
+				     mtrr_value[i].lsize,
+				     mtrr_value[i].ltype);
 		}
 	}
 }
-- 
2.35.3

