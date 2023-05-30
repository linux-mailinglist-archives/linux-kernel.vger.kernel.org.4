Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95EDE716EFB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 22:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbjE3UkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 16:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjE3Ujr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 16:39:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBC399;
        Tue, 30 May 2023 13:39:46 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685479184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ulmrcImbtRvzqGgwE3a2VNEOCnRPGxt2UYSBYI3GTxQ=;
        b=4qWCcJKQCkNkGPqM/Rfcb/VSCOwDyDojxTr5YkT3yoCg+h+F4OXwKDoF2GjtKdG3kd2wY8
        L6bWsrD3kwGyYxrBlWcx8MzjAlMZB6uXNTfvj3b9vg3gdFNgUQPGfyCbjSp51zbj1DtDUf
        ZjhuZVqHtZUcqLZbFThMCPsY5zK/aJ3WXndEd7hP4OxuJTEM55rjMY4KMg2bFxvvHz6wsE
        N9v3mPnUudrr0MrxZTNc1yl0Htt+qivGdQJImDDVV7QN/OKhjJMU+C93JgoYjKHuK5xZ6E
        cCzobMUk50hG/fjlycbXB22hdFz/Ih2wozkyllmdvsLBgk3kP7tJ+RO+prCUDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685479184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ulmrcImbtRvzqGgwE3a2VNEOCnRPGxt2UYSBYI3GTxQ=;
        b=OCsvGQbDF6UOTjQKlqYKNmvbthDBtxG8seNlKDn/Ru8sYGzf7Qdj9re6e3JcMKWoHbPnwS
        H9C/y8wZ1kg41FCA==
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
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
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [patch] x86/smpboot: Disable parallel bootup if cc_vendor != NONE
In-Reply-To: <8751e955-e975-c6d4-630c-02912b9ef9da@amd.com>
References: <87sfbhlwp9.ffs@tglx>
 <20230529023939.mc2akptpxcg3eh2f@box.shutemov.name> <87bki3kkfi.ffs@tglx>
 <20230529203129.sthnhzgds7ynddxd@box.shutemov.name>
 <20230530005428.jyrc2ezx5raohlrt@box.shutemov.name> <87mt1mjhk3.ffs@tglx>
 <87jzwqjeey.ffs@tglx> <87cz2ija1e.ffs@tglx>
 <20230530122951.2wu5rwcu26ofov6f@box.shutemov.name> <87wn0pizbl.ffs@tglx>
 <ZHYqwsCURnrFdsVm@google.com> <87leh5iom8.ffs@tglx>
 <8751e955-e975-c6d4-630c-02912b9ef9da@amd.com>
Date:   Tue, 30 May 2023 22:39:44 +0200
Message-ID: <871qiximen.ffs@tglx>
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

On Tue, May 30 2023 at 15:03, Tom Lendacky wrote:
> On 5/30/23 14:51, Thomas Gleixner wrote:
>> That aside. From a semantical POV making this decision about parallel
>> bootup based on some magic CC encryption attribute is questionable.
>> 
>> I'm tending to just do the below and make this CC agnostic (except that
>> I couldn't find the right spot for SEV-ES to clear that flag.)
>
> Maybe in sme_sev_setup_real_mode() in arch/x86/realmode/init.c? You could 
> clear the flag within the CC_ATTR_GUEST_STATE_ENCRYPT check.

Eeew.

Can we please have a AMD SEV-ES init specific place and not hijack some
random code which has to check CC_ATTR_GUEST_STATE_ENCRYPT?

Thanks,

        tglx
