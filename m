Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65856E2D96
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 01:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjDNXsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 19:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjDNXsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 19:48:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61211A249;
        Fri, 14 Apr 2023 16:46:55 -0700 (PDT)
Message-ID: <20230414232311.316352541@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681515909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=2PTnDdSuwes/9NjD8Pm7hXlACOxFTN9vJCNjWOfgGXM=;
        b=Jh6ZM0Us9GGh285BMnb5fEm77rslh++J6j/QuRkHBnu0IJ3u2WPmnGe/3gdgkhs+Itn6YC
        EYm2JHM+HCoiKXud+mnLR3pzE3sn62xS6OTtxoSRYTybybUo7HLhqrcnKqV1RwxPAi5wc5
        OBp150tG8AHyoMw6+86zMyjFChURpnILiUkhTuUlpHCRtOIbCa3VMT62a8kcqkB8R+gKQ4
        U9tfXpB5IVu1MhpvFCVN68arP6yea+vniJ2RVD3n3fNQwQKszlDZIcpnpbeZf4M7nBLa8W
        ZFeGomntJTFI5LAn96fL2tniH8jRiNy2rM7ZxO27HO46gpoe/qq365pH/j/4pA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681515909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=2PTnDdSuwes/9NjD8Pm7hXlACOxFTN9vJCNjWOfgGXM=;
        b=JDEmTRQRnlWI2RxVIaPHzb6Y3x+BSeHE+/1j/fasD5aAeXT8ZfKeZ96xHuB6wXG5qxyGWZ
        eqmeypWBVFC7DyAA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, David Woodhouse <dwmw@infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        "Arjan van de Veen" <arjan@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
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
        Sabin Rapan <sabrapan@amazon.com>
Subject: [patch 34/37] x86/cpu/amd; Invoke detect_extended_topology_early() on
 boot CPU
References: <20230414225551.858160935@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 15 Apr 2023 01:45:08 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The early detection stores the extended topology leaf number which is
required for parallel hotplug.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/amd.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -692,6 +692,8 @@ static void early_init_amd(struct cpuinf
 		}
 	}
 
+	detect_extended_topology_early(c);
+
 	if (cpu_has(c, X86_FEATURE_TOPOEXT))
 		smp_num_siblings = ((cpuid_ebx(0x8000001e) >> 8) & 0xff) + 1;
 }

