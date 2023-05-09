Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87916FC5F7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 14:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235678AbjEIMKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 08:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235671AbjEIMKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 08:10:09 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0257930DF
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 05:10:05 -0700 (PDT)
Received: from zn.tnic (p5de8e8ea.dip0.t-ipconnect.de [93.232.232.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7AF891EC051E;
        Tue,  9 May 2023 14:10:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1683634204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wKU+5dLzi/cyyvoZTda4liRyQwOA+JP82DzVCavTcYc=;
        b=MBUrxK5kSRYcYCoCd7fWpSgPCFQgu7IKO1o1ecpTGtL9Tujw1DqdDebpNFtSOw/6tR/uOt
        u9CYkGSEF4hBdpKPWh4xO9BvBYZQODFwZ9MXVVezrvr1eK5fHqZNVn7289ckuGCQYoYP/D
        ixWbEw5/pwcB9yPISKOZNjkA729ptuM=
Date:   Tue, 9 May 2023 14:10:00 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        mikelley@microsoft.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v6 11/16] x86/mtrr: construct a memory map with cache
 modes
Message-ID: <20230509121000.GAZFo4GOV9RnygziXH@fat_crate.local>
References: <20230502120931.20719-1-jgross@suse.com>
 <20230502120931.20719-12-jgross@suse.com>
 <20230509113640.GDZFowSMVK66B30cAA@fat_crate.local>
 <1048ca31-bc34-fd29-c0da-6df141ff8b68@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1048ca31-bc34-fd29-c0da-6df141ff8b68@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 01:47:47PM +0200, Juergen Gross wrote:
> ... this call not being needed at all. We can reach this point only for
> mtrr_if != &generic_mtrr_ops.

Can't be too cautious with that MTRR maze but yeah, this is the MTRRs
disabled path. Ok, so even simpler then. I've renamed it to
generic_rebuild_map() to go along with the rest of the generic.c APIs.

Thx.

---
diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index 163dca53796c..3a3b985006e2 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -458,8 +458,11 @@ static void map_add_var(void)
  * removals of registers, which are complicated to handle without rebuild of
  * the map.
  */
-static void rebuild_map(void)
+void generic_rebuild_map(void)
 {
+	if (mtrr_if != &generic_mtrr_ops)
+		return;
+
 	cache_map_n = cache_map_fixed;
 
 	map_add_var();
@@ -1127,10 +1130,6 @@ static void generic_set_mtrr(unsigned int reg, unsigned long base,
 
 	cache_enable();
 	local_irq_restore(flags);
-
-	/* On the first CPU rebuild the cache mode memory map. */
-	if (smp_processor_id() == cpumask_first(cpu_online_mask))
-		rebuild_map();
 }
 
 int generic_validate_add_page(unsigned long base, unsigned long size,
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 5fb61bb97ab1..bcde9a754f62 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -187,6 +187,8 @@ static void set_mtrr(unsigned int reg, unsigned long base, unsigned long size,
 				    };
 
 	stop_machine_cpuslocked(mtrr_rendezvous_handler, &data, cpu_online_mask);
+
+	generic_rebuild_map();
 }
 
 /**
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.h b/arch/x86/kernel/cpu/mtrr/mtrr.h
index 48ffd89cf3a6..81babff29c59 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.h
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.h
@@ -79,3 +79,4 @@ extern const struct mtrr_ops centaur_mtrr_ops;
 
 extern int changed_by_mtrr_cleanup;
 extern int mtrr_cleanup(void);
+void generic_rebuild_map(void);


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
