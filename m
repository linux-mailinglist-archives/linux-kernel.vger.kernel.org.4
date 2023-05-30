Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498137152B9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 02:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjE3Ayz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 20:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjE3Ayw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 20:54:52 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CCCE9;
        Mon, 29 May 2023 17:54:33 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 2516C5C0115;
        Mon, 29 May 2023 20:54:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 29 May 2023 20:54:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1685408073; x=
        1685494473; bh=X0c3nPbso4/0oqcOAoLD0+cBIPIras9+w1Pgn+nO65Q=; b=T
        CpJAvctGQu5S8VNM66C4FtRjgGq+q2MMUeaaYMu/HRHh4mEh7tcuyRuKGV4Mu1TM
        bPKX+5J4fl5PcZjZe+BDqQjvRSOpFrIlZq/fUwOeVF0Vkn6L+7z7bbDkp7/3HLSy
        8Q7A7P3l3sK33G79IiUGI6gyrN6Ssgfy4fLfvvdjLaVkwb9jwoY1Da7YDny6eGQC
        d5fy28JHVhf2h28hjqoG/eQCTsoJBmLwqyIlfi8Lh+zezV/dOvyXi3qbvN6ojnnR
        AUajs9bVEMhhU+D7YYhU7KMj/a6bfChoCakItQcYs2XGwVOAV85jszU0b44fYZ6F
        XgI7XkLmbTxGpFuiSO0gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685408073; x=1685494473; bh=X0c3nPbso4/0o
        qcOAoLD0+cBIPIras9+w1Pgn+nO65Q=; b=IdTnfWW5E7gVhvTEsHohP2Bwmn0WD
        YLKITfgHaYIgSlaFBWykuQ8uaRJvMhCZjh72YNyUSnLpF34Q6eS5tYsDlXlgI4Tm
        Fl41MrtIZNPFaKU1w7vcs+XW2Jwb0qk+JlrCyo2Hx8xp06hAbbxdoZ/iIp73cMh6
        jPpRlwmBDQq7eel++fmaTcxDtMTZ4MNWyWDLm7CyV2Sq6sDfwgiCdmTojDQN8bV8
        Ao3L2aIodNehScXAsUA4Nu0WBS/5hNXLD5mcBurMlbGDqvKYjlL6UQ+NVdauwRUG
        K75NcrCzRC06cuvgrhoJu4tTrDFE1tA7dMZ4ujnKquiYWErzK8nW0e83g==
X-ME-Sender: <xms:R0l1ZPnuRgrRKbHAQnFn6Dk1UOlq8SI_pxyLVuaTKE2xNVAoJeF1tg>
    <xme:R0l1ZC2SaZ60xaaLY0cIcVdRN9oYuSd84RMlMDFIFmMkiMxQj4eU0yEE5qZexcsp8
    6TVt5dhxqNigjSw30Y>
X-ME-Received: <xmr:R0l1ZFoDJAvHxTvcP5H3fy5tpsgojfUK2OFM7oQXBZY6PT83cLKCZ5UqZI-OEFCAqO6oNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekiedgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:R0l1ZHm1M4GFUYoy1T_HKVif9sWKE7Vx-Gdei9gW_GugdY6yIE5Y2A>
    <xmx:R0l1ZN2-3u2974MjnGYlBlFfYuQD_eWmtDcZBpWF4dboPyqwekjw0Q>
    <xmx:R0l1ZGtu9IFogJNQH3LK2d2jfxh4Wy4Q41z9_vyhI4V_YDaJJ4sitQ>
    <xmx:SUl1ZC1BVfuKc-tubEg0R0ZWBkvATsLR5IPsd-2lVdd02_aMwMmTZQ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 May 2023 20:54:30 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 50794102633; Tue, 30 May 2023 03:54:28 +0300 (+03)
Date:   Tue, 30 May 2023 03:54:28 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Thomas Gleixner <tglx@linutronix.de>
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
Message-ID: <20230530005428.jyrc2ezx5raohlrt@box.shutemov.name>
References: <20230508181633.089804905@linutronix.de>
 <20230508185218.962208640@linutronix.de>
 <20230524204818.3tjlwah2euncxzmh@box.shutemov.name>
 <87y1lbl7r6.ffs@tglx>
 <87sfbhlwp9.ffs@tglx>
 <20230529023939.mc2akptpxcg3eh2f@box.shutemov.name>
 <87bki3kkfi.ffs@tglx>
 <20230529203129.sthnhzgds7ynddxd@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529203129.sthnhzgds7ynddxd@box.shutemov.name>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 11:31:29PM +0300, Kirill A. Shutemov wrote:
> On Mon, May 29, 2023 at 09:27:13PM +0200, Thomas Gleixner wrote:
> > On Mon, May 29 2023 at 05:39, Kirill A. Shutemov wrote:
> > > On Sat, May 27, 2023 at 03:40:02PM +0200, Thomas Gleixner wrote:
> > > But it gets broken again on "x86/smpboot: Implement a bit spinlock to
> > > protect the realmode stack" with
> > >
> > > [    0.554079] .... node  #0, CPUs:        #1  #2
> > > [    0.738071] Callback from call_rcu_tasks() invoked.
> > > [   10.562065] CPU2 failed to report alive state
> > > [   10.566337]   #3
> > > [   20.570066] CPU3 failed to report alive state
> > > [   20.574268]   #4
> > > ...
> > >
> > > Notably CPU1 is missing from "failed to report" list. So CPU1 takes the
> > > lock fine, but seems never unlocks it.
> > >
> > > Maybe trampoline_lock(%rip) in head_64.S somehow is not the same as
> > > &tr_lock in trampoline_64.S. I donno.
> > 
> > It's definitely the same in the regular startup (16bit mode), but TDX
> > starts up via:
> > 
> > trampoline_start64
> >   trampoline_compat
> >     LOAD_REALMODE_ESP <- lock
> > 
> > That place cannot work with that LOAD_REALMODE_ESP macro. The untested
> > below should cure it.
> 
> Yep, works for me.
> 
> Aaand the next patch that breaks TDX boot is... <drum roll>
> 
> 	x86/smpboot/64: Implement arch_cpuhp_init_parallel_bringup() and enable it
> 
> Disabling parallel bringup helps. I didn't look closer yet. If you have
> an idea let me know.

Okay, it crashes around .Lread_apicid due to touching MSRs that trigger #VE.

Looks like the patch had no intention to enable parallel bringup on TDX.

+        * Intel-TDX has a secure RDMSR hypercall, but that needs to be
+        * implemented seperately in the low level startup ASM code.

But CC_ATTR_GUEST_STATE_ENCRYPT that used to filter it out is
SEV-ES-specific thingy and doesn't cover TDX. I don't think we have an
attribute that fits nicely here.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
