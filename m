Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064286D6D6A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 21:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236112AbjDDTuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 15:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjDDTuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 15:50:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8832A8
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 12:50:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41A9E63326
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 19:50:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5BDBC433D2
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 19:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680637805;
        bh=fvTkCVZEyMJNw7WD541y3Rt3+kzQgqyVt41Bt1E6wfw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WnEeE9ZPAsq7jlYNVdkEWbr5HueDKsvvrARnKe+UxPVKhcauFjHbPI0tUPVcZIncl
         f/Y/xtUzoA4UJDIqMM859KWrYWQj8p/8R+Rgg2WSPK+WBBY9ydqqLb1GnesVRDfjDF
         0QrXMf936gIg5/8RXRlmsLJnCoU2jbucRaYmJtMOI/pCg26LeO8VZO9n/41fxF8Wlf
         jntvEmEa/axdYBFv1yy1/Lgiw+OhNJWNc5D9DP1RIKg1MRcWIUHuox1TeLw+iOhA1r
         rzd93r9VRIwg1FK0EExS1cO6nGzMmoWHT9Pez3fO0jokuObHr+uuClymfLINyfIZBH
         WNaRNyJe49cGQ==
Received: by mail-lf1-f43.google.com with SMTP id j11so43735357lfg.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 12:50:05 -0700 (PDT)
X-Gm-Message-State: AAQBX9eWBtjWpyyLjH48pez/+/thpRi0ZYGZ+21hQ610rQzkoGTuR+rv
        vXt8+bf5SbA6xDTl0a0d4Vx+mPQOaF3a5hr3yvA=
X-Google-Smtp-Source: AKy350Z+lFUs5Ei9bQ//iga4uJ9NUiyJ63Mb1chTf34A6H/OnK4gu24Ir8W8CZvkdpIQgbZoQT7ldEygyGi3I5nKXHA=
X-Received: by 2002:a05:6512:4de:b0:4eb:f3d:94bf with SMTP id
 w30-20020a05651204de00b004eb0f3d94bfmr1055992lfq.9.1680637803742; Tue, 04 Apr
 2023 12:50:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230330114956.20342-1-kirill.shutemov@linux.intel.com>
 <cover.1680628986.git.thomas.lendacky@amd.com> <1d38d28c2731075d66ac65b56b813a138900f638.1680628986.git.thomas.lendacky@amd.com>
 <20230404174506.pjdikxvk2fsyy4au@box.shutemov.name> <bc9e6d82-c7c1-47dc-e91f-57d9b4e2bb0a@intel.com>
 <20230404180917.4fsgkzcdhqvph6io@box.shutemov.name>
In-Reply-To: <20230404180917.4fsgkzcdhqvph6io@box.shutemov.name>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 4 Apr 2023 21:49:52 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF0XyEOuSUDqgsLSYK8GSkGN1xK3RQ525+BxhG+7+vnCA@mail.gmail.com>
Message-ID: <CAMj1kXF0XyEOuSUDqgsLSYK8GSkGN1xK3RQ525+BxhG+7+vnCA@mail.gmail.com>
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

On Tue, 4 Apr 2023 at 20:09, Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Tue, Apr 04, 2023 at 10:57:52AM -0700, Dave Hansen wrote:
> > On 4/4/23 10:45, Kirill A. Shutemov wrote:
> > > I still think it is a bad idea.
> > >
> > > As I asked before, please include my
> > >
> > > Nacked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > >
> > > into the patch.
> >
> > I was pretty opposed to this when I first saw it too.  But, Tom and
> > company have worn down my opposition a bit.
> >
> > The fact is that we have upstream kernels out there with SEV-SNP support
> > that don't know anything about unaccepted memory.  They're either
> > relegated to using the pre-accepted memory (4GB??) or _some_ entity
> > needs to accept the memory.  That entity obviously can't be the kernel
> > unless we backport unaccepted memory support.
> >
> > This both lets the BIOS be the page-accepting entity _and_ allows the
> > entity to delegate that to the kernel when it needs to.
> >
> > As much as I want to nak this and pretend that that those existing
> > kernel's don't exist, my powers of self-delusion do have their limits.
> >
> > If our AMD friends don't do this, what is their alternative?
>
> The alternative is coordination on the host side: VMM can load a BIOS that
> pre-accepts all memory if the kernel is older.
>

And how does one identify such a kernel? How does the VMM know which
kernel the guest is going to load after it boots?

> I know that it is not convenient for VMM, but it is technically possible.
>
> Introduce an ABI with an expiration date is much more ugly. And nobody
> will care about the expiration date, until you will try to remove it.
>

None of us are thrilled about this, but the simple reality is that
there are kernels that do not understand unaccepted memory. EFI being
an extensible, generic, protocol based programmatic interface, the
best way of informing the loader that a kernel does understand it is
/not/ by adding some flag to some highly arch and OS specific header,
but to discover a protocol and call it.

We're past arguing that a legitimate need exists for a solution to
this problem. So what solution are you proposing?
