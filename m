Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7452715E8D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjE3MJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjE3MJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:09:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950AD90;
        Tue, 30 May 2023 05:09:19 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685448557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iZKRAQ6PZ8GK4gaM6K1HebRWTpJfBGLswDCJGgLN5o0=;
        b=m4WMewK162ZNFwFaX5aCd5h4XR9fVfFKlcOKr0XvrKt28u52sp90XWujVFM8gK3h4ofwRI
        SOK74XcgObHGkHLKgrJtnZmuimwWXh/wXN5q9j6Dv8gCxwb+AXijmXtlT1aYPYK1KlmCia
        BRY4IEuplIYlboTaZlXuZ97GEPZdzEDaxJWuCfBZTFHFXe1n4ZZe6munDRdPajOfnef4JY
        B2aRHT8SvnCVu5Z0nVzDGLL0t8nspaFR5wLfetwgGrG6VTVTYbuigWgnfZFxZNY8e+e9jz
        fk5DZ/0bhEUcm9JiTR/8v3EDg6m0oY8ot+sN837vZzmjbxzjbsdTnvzWX7grnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685448557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iZKRAQ6PZ8GK4gaM6K1HebRWTpJfBGLswDCJGgLN5o0=;
        b=ePubrlCxuRaMVoLtUqukHirTYLds6qKP6f4ORS+5dYI6s8wS4PLvyw0YznjLBK3j2Pn/GB
        8pWP8hu7tKt0KJDA==
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
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
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Sabin Rapan <sabrapan@amazon.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [patch] x86/smpboot: Disable parallel bootup if cc_vendor != NONE
In-Reply-To: <87jzwqjeey.ffs@tglx>
References: <20230508181633.089804905@linutronix.de>
 <20230508185218.962208640@linutronix.de>
 <20230524204818.3tjlwah2euncxzmh@box.shutemov.name> <87y1lbl7r6.ffs@tglx>
 <87sfbhlwp9.ffs@tglx> <20230529023939.mc2akptpxcg3eh2f@box.shutemov.name>
 <87bki3kkfi.ffs@tglx> <20230529203129.sthnhzgds7ynddxd@box.shutemov.name>
 <20230530005428.jyrc2ezx5raohlrt@box.shutemov.name> <87mt1mjhk3.ffs@tglx>
 <87jzwqjeey.ffs@tglx>
Date:   Tue, 30 May 2023 14:09:17 +0200
Message-ID: <87cz2ija1e.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The decision to allow parallel bringup of secondary CPUs checks
CC_ATTR_GUEST_STATE_ENCRYPT to detect encrypted guests. Those cannot use
parallel bootup because accessing the local APIC is intercepted and raises
a #VC or #VE, which cannot be handled at that point.

The check works correctly, but only for AMD encrypted guests. TDX does not
set that flag.

Check for cc_vendor != CC_VENDOR_NONE instead. That might be overbroad, but
definitely works for both AMD and Intel.

Fixes: 0c7ffa32dbd6 ("x86/smpboot/64: Implement arch_cpuhp_init_parallel_bringup() and enable it")
Reported-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/smpboot.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1282,7 +1282,7 @@ bool __init arch_cpuhp_init_parallel_bri
 	 * Intel-TDX has a secure RDMSR hypercall, but that needs to be
 	 * implemented seperately in the low level startup ASM code.
 	 */
-	if (cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT)) {
+	if (cc_get_vendor() != CC_VENDOR_NONE) {
 		pr_info("Parallel CPU startup disabled due to guest state encryption\n");
 		return false;
 	}
