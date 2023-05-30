Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66A5716867
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbjE3QAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233089AbjE3QAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:00:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B074B2;
        Tue, 30 May 2023 09:00:49 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685462447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m93yS995VjAenJm1Tq30bXHcCehNtX8a6hAD3sks2W4=;
        b=AfBAWRGV89Mc653n/xLqy7vteib+6M5/l2mZj+wR8AGKO3PMoCQnprQPz2JjGFxvFh3npR
        75LwJDM0EE4g+P7BnJV6fDBo0D5A2wsMq2qcoO+Epgc1++GT/hm/IsyZQlfl88sd3wNdLj
        HacEZyX2iikiKMUlVpHMaBRfI2+ABpbUurQzM9ir/bGUnTaJbVHwLys+6ejBpuK/Ql2gfK
        8t5edlP2m1H7BWSDdUEp+QUPxhedXZYO6JcbMtV5DS0rwT2VI36zKlSE9ot+0iGtjPkQ+7
        L4moXOZFPonmdPVRaj68CTj/NyhRRfgqXsWZ04Esn64uoqL2rtpo8bp2DKqCyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685462447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m93yS995VjAenJm1Tq30bXHcCehNtX8a6hAD3sks2W4=;
        b=kHOcw6J0QHtLvp0yEL0d0xC3npNrA5vZH/XdZXuEI3If84/jq/yLIElk56Kjr2Nz9yF9mV
        nI3pJZIHdR0bsSDw==
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
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
Subject: Re: [patch] x86/smpboot: Disable parallel bootup if cc_vendor != NONE
In-Reply-To: <20230530122951.2wu5rwcu26ofov6f@box.shutemov.name>
References: <20230524204818.3tjlwah2euncxzmh@box.shutemov.name>
 <87y1lbl7r6.ffs@tglx> <87sfbhlwp9.ffs@tglx>
 <20230529023939.mc2akptpxcg3eh2f@box.shutemov.name> <87bki3kkfi.ffs@tglx>
 <20230529203129.sthnhzgds7ynddxd@box.shutemov.name>
 <20230530005428.jyrc2ezx5raohlrt@box.shutemov.name> <87mt1mjhk3.ffs@tglx>
 <87jzwqjeey.ffs@tglx> <87cz2ija1e.ffs@tglx>
 <20230530122951.2wu5rwcu26ofov6f@box.shutemov.name>
Date:   Tue, 30 May 2023 18:00:46 +0200
Message-ID: <87wn0pizbl.ffs@tglx>
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

On Tue, May 30 2023 at 15:29, Kirill A. Shutemov wrote:
> On Tue, May 30, 2023 at 02:09:17PM +0200, Thomas Gleixner wrote:
>> The decision to allow parallel bringup of secondary CPUs checks
>> CC_ATTR_GUEST_STATE_ENCRYPT to detect encrypted guests. Those cannot use
>> parallel bootup because accessing the local APIC is intercepted and raises
>> a #VC or #VE, which cannot be handled at that point.
>> 
>> The check works correctly, but only for AMD encrypted guests. TDX does not
>> set that flag.
>> 
>> Check for cc_vendor != CC_VENDOR_NONE instead. That might be overbroad, but
>> definitely works for both AMD and Intel.
>
> It boots fine with TDX, but I think it is wrong. cc_get_vendor() will
> report CC_VENDOR_AMD even on bare metal if SME is enabled. I don't think
> we want it.

Right. Did not think about that.

But the same way is CC_ATTR_GUEST_MEM_ENCRYPT overbroad for AMD. Only
SEV-ES traps RDMSR if I'm understandig that maze correctly.

Thanks,

        tglx
