Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA586D7E16
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 15:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237860AbjDENve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 09:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238012AbjDENva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 09:51:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFB3A7
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 06:51:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F89F63D84
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 13:51:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1EBAC433B4
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 13:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680702687;
        bh=fjhPgey+stuoKKktlVCjMgDxMo4Cy6SgPUpbjtk7rkw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j9SiVPAU9Iu6Jrk702zlKTEqJr6w5zbO0s42/RIZvq3Met5yHPdDZR+u//Ke0z4Au
         lmDIJtzmiiNNFYAyrVKMk1xc+zGcCoVGqkeaUq8xa2a+kPMIP3sVM91kc45Bpj5WdD
         Af+008lzJz6ytI6CbJJd5WZCOGB/ykYSicauWFAItCmLfLp9K2P2g8KyfnuE2xLkEw
         T8CkGLWwPKB4czGgFAb64CWV26cbEZcL18DOmiRX55aFjN7I+9bpW1RW/w4IpCkm36
         3p4jIGkumeZHYSL6fsDMgWUk+KtTkewr5IYjksDXJX77MgRRslQOuc5EXtw2+U3bP0
         pl32Ud42gRipg==
Received: by mail-lf1-f47.google.com with SMTP id h25so46734445lfv.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 06:51:27 -0700 (PDT)
X-Gm-Message-State: AAQBX9ea4IStVV9JCr+F3eugmH35ujARx5UrRxZzpIHWqx+chU0a9/E5
        z657N9hz6tThMggLtMNXKBzr5h6jzmwsqUKNlzA=
X-Google-Smtp-Source: AKy350aniz5YU1EPJWPDvAKF+CMNwiFxRZpqVyOI6peE5ALeVXQUUtk3X48UtNPtv+kRqkPHiYlscYCV8q4GlVKcnnA=
X-Received: by 2002:a05:6512:3c3:b0:4e9:d81f:9a8a with SMTP id
 w3-20020a05651203c300b004e9d81f9a8amr1897060lfp.9.1680702685805; Wed, 05 Apr
 2023 06:51:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1680628986.git.thomas.lendacky@amd.com> <1d38d28c2731075d66ac65b56b813a138900f638.1680628986.git.thomas.lendacky@amd.com>
 <20230404174506.pjdikxvk2fsyy4au@box.shutemov.name> <bc9e6d82-c7c1-47dc-e91f-57d9b4e2bb0a@intel.com>
 <20230404180917.4fsgkzcdhqvph6io@box.shutemov.name> <CAMj1kXF0XyEOuSUDqgsLSYK8GSkGN1xK3RQ525+BxhG+7+vnCA@mail.gmail.com>
 <20230404202445.6qkl7hz67qgievqz@box.shutemov.name> <CAMj1kXFrm74+zNcSpHJ1kw38PTMOFk1cTx_EAoGFHaG1fYzRTQ@mail.gmail.com>
 <20230404210153.tll2mojlglx4rfsa@box.shutemov.name> <CAMj1kXGvcg-E84h1T_vPi7qxPWxEXBpyuB79KOL+ON7v5YAgJg@mail.gmail.com>
 <20230405134226.2ptk3rd7mfin3wlm@box.shutemov.name>
In-Reply-To: <20230405134226.2ptk3rd7mfin3wlm@box.shutemov.name>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 5 Apr 2023 15:51:14 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGgvk1=QQOJ_u-VqTyoOe68zv2cJYxuJfsvJR4-r5QshA@mail.gmail.com>
Message-ID: <CAMj1kXGgvk1=QQOJ_u-VqTyoOe68zv2cJYxuJfsvJR4-r5QshA@mail.gmail.com>
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

On Wed, 5 Apr 2023 at 15:42, Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Wed, Apr 05, 2023 at 09:46:59AM +0200, Ard Biesheuvel wrote:
> > On Tue, 4 Apr 2023 at 23:02, Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > >
> > > On Tue, Apr 04, 2023 at 10:41:02PM +0200, Ard Biesheuvel wrote:
> > > > On Tue, 4 Apr 2023 at 22:24, Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > > > >
> > > > > On Tue, Apr 04, 2023 at 09:49:52PM +0200, Ard Biesheuvel wrote:
> > > > > > On Tue, 4 Apr 2023 at 20:09, Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > > > > > >
> > > > > > > On Tue, Apr 04, 2023 at 10:57:52AM -0700, Dave Hansen wrote:
> > > > > > > > On 4/4/23 10:45, Kirill A. Shutemov wrote:
> > > > > > > > > I still think it is a bad idea.
> > > > > > > > >
> > > > > > > > > As I asked before, please include my
> > > > > > > > >
> > > > > > > > > Nacked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > > > > > > >
> > > > > > > > > into the patch.
> > > > > > > >
> > > > > > > > I was pretty opposed to this when I first saw it too.  But, Tom and
> > > > > > > > company have worn down my opposition a bit.
> > > > > > > >
> > > > > > > > The fact is that we have upstream kernels out there with SEV-SNP support
> > > > > > > > that don't know anything about unaccepted memory.  They're either
> > > > > > > > relegated to using the pre-accepted memory (4GB??) or _some_ entity
> > > > > > > > needs to accept the memory.  That entity obviously can't be the kernel
> > > > > > > > unless we backport unaccepted memory support.
> > > > > > > >
> > > > > > > > This both lets the BIOS be the page-accepting entity _and_ allows the
> > > > > > > > entity to delegate that to the kernel when it needs to.
> > > > > > > >
> > > > > > > > As much as I want to nak this and pretend that that those existing
> > > > > > > > kernel's don't exist, my powers of self-delusion do have their limits.
> > > > > > > >
> > > > > > > > If our AMD friends don't do this, what is their alternative?
> > > > > > >
> > > > > > > The alternative is coordination on the host side: VMM can load a BIOS that
> > > > > > > pre-accepts all memory if the kernel is older.
> > > > > > >
> > > > > >
> > > > > > And how does one identify such a kernel? How does the VMM know which
> > > > > > kernel the guest is going to load after it boots?
> > > > >
> > > > > VMM has to know what it is running. Yes, it is cumbersome. But enabling
> > > > > phase for a feature is often rough. It will get smoother overtime.
> > > > >
> > > >
> > > > So how does the VMM get informed about what it is running? How does it
> > > > distinguish between kernels that support unaccepted memory and ones
> > > > that don't? And how does it predict which kernel a guest is going to
> > > > load?
> > >
> > > User will specify if it wants unaccepted memory or not for the VM. And if
> > > it does it is his responsibility to have kernel that supports it.
> > >
> > > And you have not addressed my question:
> > >
> > >         How is it different from any other feature the kernel is not [yet] aware
> > >         of?
> > >
> >
> > It is the same problem, but this is just a better solution.
>
> Okay, we at least agree that there are more then one solution to the
> problem.
>
> > Having a BIOS menu option (or similar) to choose between unaccepted
> > memory or not (or to expose CXL memory via the EFI memory map, which is
> > another hack I have seen) is just unnecessary complication, if the
> > kernel can simply inform the loader about what it supports. We do this
> > all the time with things like OsIndications.
>
> It assumes that kernel calls ExitBootServices() which is not always true.
> A bootloader in between will make impossible for kernel to use any of
> futures exposed this way.
>
> But we talked about this before.
>

Yes, we have. But this is a theoretical concern, as nobody who is
deploying this stuff is interested in booting the kernel without the
stub: even the trenchboot folks are bending over backwards to
incorporate execution of the kernel's EFI stub into the D-RTM
bootflow, and all of the confidential compute attestation logic is
based on EFI protocols as well. So using a bootloader that calls
ExitBootServices() and subsequently boots the Linux kernel using the
legacy boot protocol is simply not something anyone is interested in
doing. But don't take my word for it.

> BTW, can we at least acknowledge the limitation in the commit message?
>

Sure.

> > We can phase out the protocol implementation from the firmware once we
> > no longer need it, at which point the LocateProtocol() call just
> > becomes a NOP (we do the same thing for UGA support, which has
> > disappeared a long time ago, but we still look for the protocol in the
> > EFI stub).
> >
> > Once the firmware stops exposing this protocol (and ceases to accept
> > memory on the OS's behalf), we can phase it out from the kernel as
> > well.
>
> It is unlikely to ever happen. In few year everybody will forget about
> this conversation. Regardless of what is written in commit message.
>
> Everything works, why bother?
>

That is a good question. If it doesn't get in the way and does not
prevent us from doing any of the things we want to do, why would we
even care?

But as I argued in my reply to Dave, we can actually drop it from
mainline later if we provide an upgrade path for legacy workloads that
want to upgrade their kernels.

> > The only other potential solution I see is exposing the unaccepted
> > memory as coldplugged ACPI memory objects, and implementing the accept
> > calls via PRM methods. But PRM has had very little test coverage, so
> > it is anybody's guess whether it works for the stable kernels that we
> > need to support with this. It would also mean that the new unaccepted
> > memory logic would need to be updated and cross reference these memory
> > regions with EFI unaccepted memory regions and avoid claiming them
> > both.
>
> Nah. That is a lot of complexity for no particular reason.
>

Good, at least we agree on that :-)
