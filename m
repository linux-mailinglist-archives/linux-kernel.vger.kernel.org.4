Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8B16D6E9B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 23:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235428AbjDDVE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 17:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDDVEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 17:04:25 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292854ED6
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 14:03:59 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id C764232003AC;
        Tue,  4 Apr 2023 17:01:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 04 Apr 2023 17:02:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1680642117; x=
        1680728517; bh=lijSnSmLcaAFcUlvqXgtuVKUdAarFaz8tX2jIVimq1A=; b=j
        TzAXm0TTIfjdt+dSpPGZY0wPf09zRFNkLWIhbXB3T0hFu49kcWBqhnBIhDrgtTy5
        RWbld6m2djhnAWFCFO0rFQK6V7K2MQplm+CL3JkVw5Yo/bUJgsFvfNG7hf/5wTg+
        nrr7e7Eo3S84X/QMIzTWsXL6jxjACrCsqkj6pcgjhVKxDo4s4SwOZ+kwEPr9Tqph
        l7cDEyiQsBz4l9dFh7KeV7VHfPoSrSWJ2v0NPbepZlmXIVF2jIJBidO4NUNrEFzF
        unSVIpgNm5Uc/kcWMRFTtvG1QhKxec2sKWo318hvAIL04Nt4IpXG0HFM8KK449Yu
        IzcllL4PvAThbfdmdHWJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680642117; x=1680728517; bh=lijSnSmLcaAFc
        UlvqXgtuVKUdAarFaz8tX2jIVimq1A=; b=Kb1ibZlySuDNFOodGM+HC3laU0aqX
        bA8rOcPXohR8aecc7mglIc9ExY5Od0A1ELq37YHUNEng6rxvWWEdkW9oOhXTS2RY
        /RAOXpBh8R1jNjgyyEB/cQ9gUQWhWa9rTWUjl4eaCNZTVJEa+PMSWnRxU0XFmIFf
        G0QN4FpGplGQ04xgrPWTOtzvv4Jy5lX5iVgn/y1wHinOMG9QWmoWHJS3EQjOlrC/
        +8KbtLeU3nfUdoiuTqa95LsmK25lEQAXpWDLJJKv34l6jkBfV2CvsBp/olLb7FP0
        LXN5kq5ZWg8fUvRR/5X9ObCw6TJBfkXoEVKQc0LO1/vEU0XayB+SI2dSg==
X-ME-Sender: <xms:Q5AsZBP3tmYYQnnJRSvIpW2_9B6gq7tKmo9N8alCtKljjH0Mc0EHnA>
    <xme:Q5AsZD9hXKW4hvr19Rmbfv3RMNsAdLuMNgbCpaIuOPJunkWGBxx9QzualnI0mqKKT
    MfQm3fp2wXvoBULUfs>
X-ME-Received: <xmr:Q5AsZARaKKdw5c0GSdeF8GdgI7ObzuIDL7CQbcXg5tMM_7zTj-ChLWsCH-veLgAw9s0KuQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeiledgudehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhi
    rhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhephfeigefhtdefhedtfedthefghedutddvueeh
    tedttdehjeeukeejgeeuiedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:Q5AsZNtXoSW8qETZJUv7qpNi96xcbB3n4JCXBdwC6tWVNKpAW03dWQ>
    <xmx:Q5AsZJfuyB7SX5PloT4itUfATJr4y5-bKOYNzn3LrczFK9jg1siE5A>
    <xmx:Q5AsZJ3cAwhyugKe5HuJDPLetjQexJADsJm_-8UEEXbAGNfgBiHzMg>
    <xmx:RZAsZKC4U7EHiinnKG_nB5vtRoaj9xL0ZmURezA4JvQ9qzCCM8behA>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Apr 2023 17:01:55 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 755CE10C32D; Wed,  5 Apr 2023 00:01:53 +0300 (+03)
Date:   Wed, 5 Apr 2023 00:01:53 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Dionna Glaze <dionnaglaze@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Min M. Xu" <min.m.xu@intel.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Jiewen Yao <jiewen.yao@intel.com>,
        Erdem Aktas <erdemaktas@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v7 6/6] x86/efi: Safely enable unaccepted memory in UEFI
Message-ID: <20230404210153.tll2mojlglx4rfsa@box.shutemov.name>
References: <20230330114956.20342-1-kirill.shutemov@linux.intel.com>
 <cover.1680628986.git.thomas.lendacky@amd.com>
 <1d38d28c2731075d66ac65b56b813a138900f638.1680628986.git.thomas.lendacky@amd.com>
 <20230404174506.pjdikxvk2fsyy4au@box.shutemov.name>
 <bc9e6d82-c7c1-47dc-e91f-57d9b4e2bb0a@intel.com>
 <20230404180917.4fsgkzcdhqvph6io@box.shutemov.name>
 <CAMj1kXF0XyEOuSUDqgsLSYK8GSkGN1xK3RQ525+BxhG+7+vnCA@mail.gmail.com>
 <20230404202445.6qkl7hz67qgievqz@box.shutemov.name>
 <CAMj1kXFrm74+zNcSpHJ1kw38PTMOFk1cTx_EAoGFHaG1fYzRTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFrm74+zNcSpHJ1kw38PTMOFk1cTx_EAoGFHaG1fYzRTQ@mail.gmail.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 10:41:02PM +0200, Ard Biesheuvel wrote:
> On Tue, 4 Apr 2023 at 22:24, Kirill A. Shutemov <kirill@shutemov.name> wrote:
> >
> > On Tue, Apr 04, 2023 at 09:49:52PM +0200, Ard Biesheuvel wrote:
> > > On Tue, 4 Apr 2023 at 20:09, Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > > >
> > > > On Tue, Apr 04, 2023 at 10:57:52AM -0700, Dave Hansen wrote:
> > > > > On 4/4/23 10:45, Kirill A. Shutemov wrote:
> > > > > > I still think it is a bad idea.
> > > > > >
> > > > > > As I asked before, please include my
> > > > > >
> > > > > > Nacked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > > > >
> > > > > > into the patch.
> > > > >
> > > > > I was pretty opposed to this when I first saw it too.  But, Tom and
> > > > > company have worn down my opposition a bit.
> > > > >
> > > > > The fact is that we have upstream kernels out there with SEV-SNP support
> > > > > that don't know anything about unaccepted memory.  They're either
> > > > > relegated to using the pre-accepted memory (4GB??) or _some_ entity
> > > > > needs to accept the memory.  That entity obviously can't be the kernel
> > > > > unless we backport unaccepted memory support.
> > > > >
> > > > > This both lets the BIOS be the page-accepting entity _and_ allows the
> > > > > entity to delegate that to the kernel when it needs to.
> > > > >
> > > > > As much as I want to nak this and pretend that that those existing
> > > > > kernel's don't exist, my powers of self-delusion do have their limits.
> > > > >
> > > > > If our AMD friends don't do this, what is their alternative?
> > > >
> > > > The alternative is coordination on the host side: VMM can load a BIOS that
> > > > pre-accepts all memory if the kernel is older.
> > > >
> > >
> > > And how does one identify such a kernel? How does the VMM know which
> > > kernel the guest is going to load after it boots?
> >
> > VMM has to know what it is running. Yes, it is cumbersome. But enabling
> > phase for a feature is often rough. It will get smoother overtime.
> >
> 
> So how does the VMM get informed about what it is running? How does it
> distinguish between kernels that support unaccepted memory and ones
> that don't? And how does it predict which kernel a guest is going to
> load?

User will specify if it wants unaccepted memory or not for the VM. And if
it does it is his responsibility to have kernel that supports it.

And you have not addressed my question:

	How is it different from any other feature the kernel is not [yet] aware
	of?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
