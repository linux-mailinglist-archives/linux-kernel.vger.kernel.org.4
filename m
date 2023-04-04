Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9FD6D6E31
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 22:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236164AbjDDUlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 16:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjDDUlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 16:41:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3AB4220
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 13:41:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29FBB6399F
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 20:41:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F91BC4339E
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 20:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680640875;
        bh=2L7K7JZ9AGmWjR6Gal62R9AiYNqUSYJgex9m0wAx9S0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PClS8jkRSpcvKV7sLWhskZgYJkw5W1WgqHnpGhGhk9EiHLdpk/UAJnbUywHwtnBrc
         27UYdzDPU55rzQUJBnv/2RpJq2/+L8LRpfIQcFdtnjP7fEhLeKn/mpjHRhUIwLqqwp
         MCT+CN0qE3/l/sNJZn6XK9bEdybugR3XncGNJeFX9CHJz1pnst4jMHDCgoHUrVVE7/
         eyx8rkTCbc/hqu+73cYX9ItLGVmevlsSkokmFBxyhRaFQ0Ghzp7P/qWSog8+0vbQXk
         ziaq1icJlYT499U5sdSat9Rhyt2tZJ+CsMA85oJYpxTvFlV6FuxN+lIs2qKtnlis+r
         3nyYHAF2PNpww==
Received: by mail-lf1-f54.google.com with SMTP id h11so36972300lfu.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 13:41:15 -0700 (PDT)
X-Gm-Message-State: AAQBX9dC3sOU0BmLT1QEFlGc2sN1BLYXleAewzMy/u3w9IZkEtLVW3TV
        90U31EPUf0v+iaiok7J65gseonk2H8lg+PCBLhE=
X-Google-Smtp-Source: AKy350bzfOXJoKaOVmVsaEmS2fKeO5rQ+REjpKtpc1GAYh6FsMYi6nsTQIR74ZXHXc5USiHHEpTphoaDjbXu4uvuPcc=
X-Received: by 2002:ac2:4c89:0:b0:4db:1c2a:a96e with SMTP id
 d9-20020ac24c89000000b004db1c2aa96emr1157988lfl.9.1680640873498; Tue, 04 Apr
 2023 13:41:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230330114956.20342-1-kirill.shutemov@linux.intel.com>
 <cover.1680628986.git.thomas.lendacky@amd.com> <1d38d28c2731075d66ac65b56b813a138900f638.1680628986.git.thomas.lendacky@amd.com>
 <20230404174506.pjdikxvk2fsyy4au@box.shutemov.name> <bc9e6d82-c7c1-47dc-e91f-57d9b4e2bb0a@intel.com>
 <20230404180917.4fsgkzcdhqvph6io@box.shutemov.name> <CAMj1kXF0XyEOuSUDqgsLSYK8GSkGN1xK3RQ525+BxhG+7+vnCA@mail.gmail.com>
 <20230404202445.6qkl7hz67qgievqz@box.shutemov.name>
In-Reply-To: <20230404202445.6qkl7hz67qgievqz@box.shutemov.name>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 4 Apr 2023 22:41:02 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFrm74+zNcSpHJ1kw38PTMOFk1cTx_EAoGFHaG1fYzRTQ@mail.gmail.com>
Message-ID: <CAMj1kXFrm74+zNcSpHJ1kw38PTMOFk1cTx_EAoGFHaG1fYzRTQ@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] x86/efi: Safely enable unaccepted memory in UEFI
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Apr 2023 at 22:24, Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Tue, Apr 04, 2023 at 09:49:52PM +0200, Ard Biesheuvel wrote:
> > On Tue, 4 Apr 2023 at 20:09, Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > >
> > > On Tue, Apr 04, 2023 at 10:57:52AM -0700, Dave Hansen wrote:
> > > > On 4/4/23 10:45, Kirill A. Shutemov wrote:
> > > > > I still think it is a bad idea.
> > > > >
> > > > > As I asked before, please include my
> > > > >
> > > > > Nacked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > > >
> > > > > into the patch.
> > > >
> > > > I was pretty opposed to this when I first saw it too.  But, Tom and
> > > > company have worn down my opposition a bit.
> > > >
> > > > The fact is that we have upstream kernels out there with SEV-SNP support
> > > > that don't know anything about unaccepted memory.  They're either
> > > > relegated to using the pre-accepted memory (4GB??) or _some_ entity
> > > > needs to accept the memory.  That entity obviously can't be the kernel
> > > > unless we backport unaccepted memory support.
> > > >
> > > > This both lets the BIOS be the page-accepting entity _and_ allows the
> > > > entity to delegate that to the kernel when it needs to.
> > > >
> > > > As much as I want to nak this and pretend that that those existing
> > > > kernel's don't exist, my powers of self-delusion do have their limits.
> > > >
> > > > If our AMD friends don't do this, what is their alternative?
> > >
> > > The alternative is coordination on the host side: VMM can load a BIOS that
> > > pre-accepts all memory if the kernel is older.
> > >
> >
> > And how does one identify such a kernel? How does the VMM know which
> > kernel the guest is going to load after it boots?
>
> VMM has to know what it is running. Yes, it is cumbersome. But enabling
> phase for a feature is often rough. It will get smoother overtime.
>

So how does the VMM get informed about what it is running? How does it
distinguish between kernels that support unaccepted memory and ones
that don't? And how does it predict which kernel a guest is going to
load?

If the solution you described many times addresses these questions,
could you please share a link?
