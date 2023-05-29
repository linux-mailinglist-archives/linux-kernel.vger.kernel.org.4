Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E30971421A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 04:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjE2Cj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 22:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjE2Cj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 22:39:56 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97421A7;
        Sun, 28 May 2023 19:39:50 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 68EBC320083A;
        Sun, 28 May 2023 22:39:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sun, 28 May 2023 22:39:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1685327985; x=
        1685414385; bh=CkLoqHnVGlymW7d8k4EFDgQjQ/Ry/XUh7kKzLI6+vlE=; b=W
        7EccITdMZC0pSl/b1cfDKDyxZJGjSM57ZL2lxSNLgeqB4IerV8LFdI9zEG9Uv3G5
        XelSpBSDuEiMFswqvgC+uqMSU41P+0pHnc0CfVm+/om40YXV8TBgy4FQ3uAnJ0sd
        0leGMjl2uPikmG/RgzzVFUtdTyGqRV9PoTLcM/5fX1Q+VN3mISeO/SGfktGELjZZ
        NdxDajeL23HVze7H5M+ZON2UH8rVcjxVZPc4eeORlBj44HD0strS02gomytli9s7
        PBU0KbXi2fQ1wTum70GIBqTrZdwfVGFyVfYmU4ShoSq7JbcP7lXhTS7MnuWZ/MSP
        q530uy7ak3gazTiZQa03w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685327985; x=1685414385; bh=CkLoqHnVGlymW
        7d8k4EFDgQjQ/Ry/XUh7kKzLI6+vlE=; b=Ym18twRp4YDc99fHB93LquZJ0Z4zp
        embehcemE/kKIw1lZWuqx1KLQozamaAeoJM8goXmgoaZW3VB8Dgu+XxcQIKA7hdr
        ii4iswSCwWVizYzEQhscnjWq5UJr55hgxRG1klgsxQfGEpvQcFkllQ/IlrtZeuNd
        IkgtrkaFdbgTtMVHe/1BaJAZgG5u4VOq3VGMrtOS9mrpBphl1Sv9YkU1wdeQ//ZD
        7Iq1V0iH3LUN1FJ4cnVRQ7ifNB0s2ek3SVY9vbksOnEwoqh4M6UrCmTyI4hRZ4zX
        H05f0ian4GSUghIm00k8vxuIOxyQfYMTfS1T0c/t3HVr9UH3nfIjwNYjw==
X-ME-Sender: <xms:bhB0ZISkSebDoY7ePFrAHMDJbiQqzCSLtGQEC7GihGdfbUW05RzW4w>
    <xme:bhB0ZFzAz6AVefd2szJo-ws8Uh2hNyL_zT_y1XDQB_wTeqEm_eppvzBm55tfHAdwY
    NArb6jCfmWTz_8OPNI>
X-ME-Received: <xmr:bhB0ZF3ndzPOosUupfAXA2uJY_qxBkSmJjfdBatmCRw5_Peevlwyk7NCarF_NFDe7DIgoQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekgedgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:bhB0ZMB8itjXVeTPWF_K8Nmn0VUSqgIS-owqp_lG18bg5bU4EsSh7g>
    <xmx:bhB0ZBhiT1zEB1GcRZ1uvkLgyLjitMFL8pFJUil6ufu20rCWUASJ9g>
    <xmx:bhB0ZIrw9F7S8Wzi-Fm-LbfqbFWndpEyT87JM97uPNmv25HvJJw6bQ>
    <xmx:cRB0ZEAbi-FwJdt75RNpPlGa_l7-Cjrsterd_z2tGu_lje6NiEeMZQ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 May 2023 22:39:42 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id DC398109530; Mon, 29 May 2023 05:39:39 +0300 (+03)
Date:   Mon, 29 May 2023 05:39:39 +0300
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
Message-ID: <20230529023939.mc2akptpxcg3eh2f@box.shutemov.name>
References: <20230508181633.089804905@linutronix.de>
 <20230508185218.962208640@linutronix.de>
 <20230524204818.3tjlwah2euncxzmh@box.shutemov.name>
 <87y1lbl7r6.ffs@tglx>
 <87sfbhlwp9.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sfbhlwp9.ffs@tglx>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 27, 2023 at 03:40:02PM +0200, Thomas Gleixner wrote:
> On Fri, May 26 2023 at 12:14, Thomas Gleixner wrote:
> > On Wed, May 24 2023 at 23:48, Kirill A. Shutemov wrote:
> >> This patch causes boot regression on TDX guest. The guest crashes on SMP
> >> bring up.
> 
> The below should fix that. Sigh...

Okay, this gets me fixes the boot for TDX guest:

Tested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

But it gets broken again on "x86/smpboot: Implement a bit spinlock to
protect the realmode stack" with

[    0.554079] .... node  #0, CPUs:        #1  #2
[    0.738071] Callback from call_rcu_tasks() invoked.
[   10.562065] CPU2 failed to report alive state
[   10.566337]   #3
[   20.570066] CPU3 failed to report alive state
[   20.574268]   #4
...

Notably CPU1 is missing from "failed to report" list. So CPU1 takes the
lock fine, but seems never unlocks it.

Maybe trampoline_lock(%rip) in head_64.S somehow is not the same as
&tr_lock in trampoline_64.S. I donno.

I haven't find the root cause yet. But bypassing locking in
LOAD_REALMODE_ESP makes the issue go away.

I will look more into it.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
