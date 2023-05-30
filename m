Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54F8715BEB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbjE3KfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbjE3Kew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:34:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5062C115;
        Tue, 30 May 2023 03:34:48 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685442886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N5ajidpHHWOd1M+zXooDoN2CL1Doa07SpiUyV9RulE8=;
        b=uwnjy/mtKr2+9HiMkSppEBJvhSBQeJYZy8y9yBLg+rfzmVqY1K2fbkQ0BK6atYsbdlb/kZ
        OX0X95CEbPOmVVjWUm+w4pOuAY3qcbvl7jw9Z0BenrltybggdqR4c9qAM8x64i9YH37qey
        O9JBKI7y/oKr72QRWkDpq+hYUst4bIaCugFeqfZmWg1LhT6voGsk3R6H6krFIw1PwzllcV
        ucldO4NpvXDnORVDB9AFUwXdgJ89s7Ov7ICB6gREcPwIDmnuEeCUVFSvurBgxsiF9roVck
        ep3RsDjejQbfVOSuPv04nD7vklCwo/Y4EbsS5SCA7EfqWM3aQeTimx2OFQGCyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685442886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N5ajidpHHWOd1M+zXooDoN2CL1Doa07SpiUyV9RulE8=;
        b=AxdWUb0SeD9XPAfvorylY2NPRS35OXUO70xmZChpaLP+3HhDz+9CZ0RcptudTwiisrOZW2
        YPXQzLGGwMCVv4AQ==
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
Subject: Re: [patch v3 31/36] x86/apic: Provide cpu_primary_thread mask
In-Reply-To: <87mt1mjhk3.ffs@tglx>
References: <20230508181633.089804905@linutronix.de>
 <20230508185218.962208640@linutronix.de>
 <20230524204818.3tjlwah2euncxzmh@box.shutemov.name> <87y1lbl7r6.ffs@tglx>
 <87sfbhlwp9.ffs@tglx> <20230529023939.mc2akptpxcg3eh2f@box.shutemov.name>
 <87bki3kkfi.ffs@tglx> <20230529203129.sthnhzgds7ynddxd@box.shutemov.name>
 <20230530005428.jyrc2ezx5raohlrt@box.shutemov.name> <87mt1mjhk3.ffs@tglx>
Date:   Tue, 30 May 2023 12:34:45 +0200
Message-ID: <87jzwqjeey.ffs@tglx>
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

On Tue, May 30 2023 at 11:26, Thomas Gleixner wrote:
> On Tue, May 30 2023 at 03:54, Kirill A. Shutemov wrote:
>> On Mon, May 29, 2023 at 11:31:29PM +0300, Kirill A. Shutemov wrote:
>>> Disabling parallel bringup helps. I didn't look closer yet. If you have
>>> an idea let me know.
>>
>> Okay, it crashes around .Lread_apicid due to touching MSRs that trigger #VE.
>>
>> Looks like the patch had no intention to enable parallel bringup on TDX.
>>
>> +        * Intel-TDX has a secure RDMSR hypercall, but that needs to be
>> +        * implemented seperately in the low level startup ASM code.
>>
>> But CC_ATTR_GUEST_STATE_ENCRYPT that used to filter it out is
>> SEV-ES-specific thingy and doesn't cover TDX. I don't think we have an
>> attribute that fits nicely here.
>
> Bah. That sucks.

Can we have something consistent in this CC space or needs everything to
be extra magic per CC variant?
