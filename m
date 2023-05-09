Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B663A6FC520
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 13:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235402AbjEILhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 07:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235398AbjEILh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 07:37:26 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B839749D6
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 04:37:03 -0700 (PDT)
Received: from zn.tnic (p5de8e8ea.dip0.t-ipconnect.de [93.232.232.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6392B1EC026E;
        Tue,  9 May 2023 13:36:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1683632205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=iRy9wit3VIAYkvswE/qzqrLiqHriAFmaIQ1jPlmHXYw=;
        b=hbt5/+RIbh1pguP2LJ6Bl5Czpp0PnNgQGpUe9q4lIUT3AHO3EmnJACpVJN6l/E7AaXiacm
        uCEQJJkx4Fk/uEsSKuPzditPVpu8r9KVaxV6KEO3nm2Hbc7vq9sPYmneUE49t3tyAgm8ut
        xnEk4yifILc3IQ/BvznHDRZKP5rUGo4=
Date:   Tue, 9 May 2023 13:36:40 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        mikelley@microsoft.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v6 11/16] x86/mtrr: construct a memory map with cache
 modes
Message-ID: <20230509113640.GDZFowSMVK66B30cAA@fat_crate.local>
References: <20230502120931.20719-1-jgross@suse.com>
 <20230502120931.20719-12-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230502120931.20719-12-jgross@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2023 at 02:09:26PM +0200, Juergen Gross wrote:
> @@ -841,6 +1137,10 @@ static void generic_set_mtrr(unsigned int reg, unsigned long base,
>  
>  	cache_enable();
>  	local_irq_restore(flags);
> +
> +	/* On the first CPU rebuild the cache mode memory map. */
> +	if (smp_processor_id() == cpumask_first(cpu_online_mask))
> +		rebuild_map();

I still don't like this. Anything against doing this instead?

---
diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index 163dca53796c..e69c8c56897f 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -458,8 +458,11 @@ static void map_add_var(void)
  * removals of registers, which are complicated to handle without rebuild of
  * the map.
  */
-static void rebuild_map(void)
+void rebuild_map(void)
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
diff --git a/arch/x86/kernel/cpu/mtrr/legacy.c b/arch/x86/kernel/cpu/mtrr/legacy.c
index d25882fcf181..30a3d51d06e0 100644
--- a/arch/x86/kernel/cpu/mtrr/legacy.c
+++ b/arch/x86/kernel/cpu/mtrr/legacy.c
@@ -67,6 +67,7 @@ static void mtrr_restore(void)
 				     mtrr_value[i].ltype);
 		}
 	}
+	rebuild_map();
 }
 
 static struct syscore_ops mtrr_syscore_ops = {
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 5fb61bb97ab1..10608c7f9606 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -187,6 +187,8 @@ static void set_mtrr(unsigned int reg, unsigned long base, unsigned long size,
 				    };
 
 	stop_machine_cpuslocked(mtrr_rendezvous_handler, &data, cpu_online_mask);
+
+	rebuild_map();
 }
 
 /**
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.h b/arch/x86/kernel/cpu/mtrr/mtrr.h
index 48ffd89cf3a6..286ce89ce7f1 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.h
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.h
@@ -79,3 +79,4 @@ extern const struct mtrr_ops centaur_mtrr_ops;
 
 extern int changed_by_mtrr_cleanup;
 extern int mtrr_cleanup(void);
+void rebuild_map(void);

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
