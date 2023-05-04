Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428696F72E9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 21:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjEDTGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 15:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjEDTF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 15:05:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627167AB4;
        Thu,  4 May 2023 12:03:46 -0700 (PDT)
Message-ID: <20230504185938.232336513@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683226975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=PaGuo8GAZ65ZbtTn7wzwCB2xmjp/8CcdVtBqqK3zJyY=;
        b=WBrmRYfVh8Hf7VAtaZM+773NG/l2NaZEQY2PbsMWpwgijTHlkaPZNZwTTqZqSePaJs28Tp
        huH2qX95r4oDUOSFSd9zA+6+RZv5lgr0xa0QdgDkEncw9LVXBvKPVIlHpBCwardNQlPmIT
        cajVqbzngFG+dnpn2I0UeA+RYWcEBwo1QkYYSYABAtHiWYiay4DXWTSDKMd3/FerfS7z8b
        xwX6otdMILDZ1YbCULvPsUARGQzswNTUUkZzB3iKqcysyV9JxG2dUxCWqjPi7FUYFLn/3T
        jkRxQ4LmxpZMkrdtxeZw1NAb25wiC+Tx1duuJ885D0xawxhq7zhP9DRXxAmkFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683226975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=PaGuo8GAZ65ZbtTn7wzwCB2xmjp/8CcdVtBqqK3zJyY=;
        b=G0tsDBn5b6jENP+Wz6pMSYtlj20+hRg4V3sQlU3KTcd+8sMa78JVCQNTfSLn2dU5TfjS5i
        VD5uznhB/0z5zkAQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, David Woodhouse <dwmw2@infradead.org>,
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
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Subject: [patch V2 35/38] x86/apic: Save the APIC virtual base address
References: <20230504185733.126511787@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Thu,  4 May 2023 21:02:55 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

For parallel CPU brinugp it's required to read the APIC ID in the low level
startup code. The virtual APIC base address is a constant because its a
fix-mapped address. Exposing that constant which is composed via macros to
assembly code is non-trivial dues to header inclusion hell.

Aside of that it's constant only because of the vsyscall ABI
requirement. Once vsyscall is out of the picture the fixmap can be placed
at runtime.

Avoid header hell, stay flexible and store the address in a variable which
can be exposed to the low level startup code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/include/asm/smp.h  |    1 +
 arch/x86/kernel/apic/apic.c |    4 ++++
 2 files changed, 5 insertions(+)
---
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -196,6 +196,7 @@ extern void nmi_selftest(void);
 #endif
 
 extern unsigned int smpboot_control;
+extern unsigned long apic_mmio_base;
 
 #endif /* !__ASSEMBLY__ */
 
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -101,6 +101,9 @@ static int apic_extnmi __ro_after_init =
  */
 static bool virt_ext_dest_id __ro_after_init;
 
+/* For parallel bootup. */
+unsigned long apic_mmio_base __ro_after_init;
+
 /*
  * Map cpu index to physical APIC ID
  */
@@ -2163,6 +2166,7 @@ void __init register_lapic_address(unsig
 
 	if (!x2apic_mode) {
 		set_fixmap_nocache(FIX_APIC_BASE, address);
+		apic_mmio_base = APIC_BASE;
 		apic_printk(APIC_VERBOSE, "mapped APIC to %16lx (%16lx)\n",
 			    APIC_BASE, address);
 	}

