Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13516E9255
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 13:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbjDTLV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 07:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235070AbjDTLUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 07:20:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C604B46C;
        Thu, 20 Apr 2023 04:18:52 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681989462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t5XqcHn966UpzdXXi00/lSAzdYJUEVQOjSwT6u3WS8Y=;
        b=pAb6n5DzMyj9cPuaDVh1nEa4eMPTGWjlabRanF0gKYgC9Dt16bSxIF65k8A6Phxdd7b+m1
        8rtjGcomkGZGHPfqi5gCMDsNgIxkIz7fE3iWI1yVPEr7CzAxuLO52VMUjueL9yA1cignQ0
        2aZBXvrGK95/A3SZLIzR4CO2Gt6BjAJeGZFwZ0r5DeQJZY9f+42NHleeHSDTjxF+sNMncp
        Pj8zsu3xSjO1U4uiCaq79l7sMSO/XzBLws+gTsKxCyOwMVcTz52DRxt/Fl9qBPDScBZpAE
        EzRwxWNG9FQP9wQGTFVsN5ZBm94BxGBjsCTcRwuXnpgNipezItO8FzlRvwCjfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681989462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t5XqcHn966UpzdXXi00/lSAzdYJUEVQOjSwT6u3WS8Y=;
        b=K7n7gkxobQSbdvGZErkz25VRgfZFGdff1cfdZxrOPRjWpL/QdasoOCujc47S1yFH9hOfDu
        jdhNH58O+gxzlPDw==
To:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Gerst <brgerst@gmail.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Usama Arif <usama.arif@bytedance.com>,
        =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
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
        "James E. J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Sabin Rapan <sabrapan@amazon.com>
Subject: Re: [patch 00/37] cpu/hotplug, x86: Reworked parallel CPU bringup
In-Reply-To: <26d385da-2ede-5d73-2959-84c8f7d89e03@citrix.com>
References: <20230414225551.858160935@linutronix.de>
 <8247ce4d-15b7-03b2-0c9b-74f8cd6cad50@molgen.mpg.de> <87wn2a4la5.ffs@tglx>
 <bd5a6a93-def1-9248-2258-c3d3b40071ef@molgen.mpg.de> <87ttxd4qxz.ffs@tglx>
 <87r0sh4m7a.ffs@tglx> <8592a301-9933-1cad-bd61-8d97e7c7493b@molgen.mpg.de>
 <87a5z443g2.ffs@tglx> <877cu83v45.ffs@tglx> <874jpc3s3r.ffs@tglx>
 <0f5463fd-9c4a-6361-adbb-dd89dbb9138d@citrix.com>
 <c2aaa4fb-a5ba-d5bf-634a-dcf4fd8ad246@citrix.com> <871qkf3qek.ffs@tglx>
 <26d385da-2ede-5d73-2959-84c8f7d89e03@citrix.com>
Date:   Thu, 20 Apr 2023 13:17:40 +0200
Message-ID: <87y1mm3iqz.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20 2023 at 10:23, Andrew Cooper wrote:
> On 20/04/2023 9:32 am, Thomas Gleixner wrote:
>> I'm pondering to simply deny parallel mode if x2APIC is not there.
>
> I'm not sure if that will help much.

Spoilsport.

> Just because x2APIC is there doesn't mean it's in use.=C2=A0 There are
> several generations of Intel system which have x2APIC but also use the
> opt-out bit in ACPI tables.=C2=A0 There are some machines which have
> mismatched APIC-ness settings in the BIOS->OS handover.
>
> There's very little you can do on the BSP alone to know for certain that
> the APs come out of wait-for-SIPI already in x2APIC mode.

Yeah. Reading the APIC that early is going to be entertaining too :)

> One way is the =C3=86PIC Leak "locked into x2APIC mode" giant security
> bodge.=C2=A0

Bah.

> If the system really does have a CPU with an APIC ID above 0xfe, then
> chances are good that the APs come out consistently...

Anything else would be really magic :)
