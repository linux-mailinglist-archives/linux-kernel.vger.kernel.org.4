Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5744870CE8D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 01:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbjEVXMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 19:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbjEVXMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 19:12:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48408CD;
        Mon, 22 May 2023 16:12:29 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684797146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C7TsK7GgGmkvmWTTcWM2ucSNGAZooIPJARpsVm1elw0=;
        b=yrUtqJV10ki6ehHolL2hnu9DMcCIuWlud8kBCfHX2rWfH90kquusd5JROH50fXuSFSmQwU
        PKNQy6H0pPg6Mk5OQdYPhKYbeQI1YUR9KMUd/a7Qt8XePk2e/SyRiHPAMSjuFqp7Gvl67j
        jsYzQTS2roesS5yiUarkF8GfeI3DeGPf6Ebcoc4Ljc1KYqKx7NP63xqe3/V5tuO0wj3vfK
        JFIGfRt4eOzIcmOGPkAafZCHGsIxOB41QQ0hviBcfX4KV8V6SP+E8PZS1myMMBnon3NhCD
        iok8IPIaOi8QqOj9b+eAxWl9vgJ4JWbE94zRxWOk3/fV7mjhSGxDcyoSZunF8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684797146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C7TsK7GgGmkvmWTTcWM2ucSNGAZooIPJARpsVm1elw0=;
        b=LsHOhlHhAmIjOmv4OFf6rm8oVhRsGLXF3Ede/E4PfuqZRooT2DLrTIb9VMr4oD66YERTjE
        beGkkZmQ8Ci6bkBQ==
To:     Mark Brown <broonie@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
        Usama Arif <usama.arif@bytedance.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Sabin Rapan <sabrapan@amazon.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Ross Philipson <ross.philipson@oracle.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [patch V4 33/37] cpu/hotplug: Allow "parallel" bringup up to
 CPUHP_BP_KICK_AP_STATE
In-Reply-To: <2ed3ff77-c973-4e23-9e2f-f10776e432b7@sirena.org.uk>
References: <20230512203426.452963764@linutronix.de>
 <20230512205257.240231377@linutronix.de>
 <4ca39e58-055f-432c-8124-7c747fa4e85b@sirena.org.uk> <87bkicw01a.ffs@tglx>
 <2ed3ff77-c973-4e23-9e2f-f10776e432b7@sirena.org.uk>
Date:   Tue, 23 May 2023 01:12:26 +0200
Message-ID: <87wn10ufj9.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22 2023 at 23:27, Mark Brown wrote:
> On Mon, May 22, 2023 at 11:04:17PM +0200, Thomas Gleixner wrote:
>
>> That does not make any sense at all and my tired brain does not help
>> either.
>
>> Can you please apply the below debug patch and provide the output?
>
> Here's the log, a quick glance says the 
>
> 	if (!--ncpus)
> 		break;
>
> check is doing the wrong thing

Obviously.

Let me find a brown paperbag and go to sleep before I even try to
compile the obvious fix.

---
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 005f863a3d2b..88a7ede322bd 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1770,9 +1770,6 @@ static void __init cpuhp_bringup_mask(const struct cpumask *mask, unsigned int n
 	for_each_cpu(cpu, mask) {
 		struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
 
-		if (!--ncpus)
-			break;
-
 		if (cpu_up(cpu, target) && can_rollback_cpu(st)) {
 			/*
 			 * If this failed then cpu_up() might have only
@@ -1781,6 +1778,9 @@ static void __init cpuhp_bringup_mask(const struct cpumask *mask, unsigned int n
 			 */
 			WARN_ON(cpuhp_invoke_callback_range(false, cpu, st, CPUHP_OFFLINE));
 		}
+
+		if (!--ncpus)
+			break;
 	}
 }
 
