Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF626A23E3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 22:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjBXViz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 16:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBXViy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 16:38:54 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4642C570B5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 13:38:53 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id f20so169141qka.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 13:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L+7PrPVDt+NF4Msq9rTPMCoAb1ssGO79mLXGBCn8ZiY=;
        b=IEBBV92DNh9RWgK38vkunJygXvUAOXmkRL24a7o6wzi3PjM6TLHOIruCgrmuamO3iA
         8GTtmZGtWM7AbZ/rzXMPvD47I4XlfgWY1H8FKEmGmGdszJBjqYA6LJaq+T2aCI+Acc3Y
         5LhYKbHf6fFKISh+gHvDSevjL0F8rrPR9qoxDAeaEc+zgHFtAmNaxlUmZRqGQPIOSSYA
         rlTpVtFzLwp4/0E70b8nWELsOz+/b0iz2f9V8uGsUvSsVbFkNGpSulHOvjL95/DOgwsR
         sxciOs2yicChnBzLWilFlnzBtnsTUt2OURf04Wh1OhP4jUeuRwXLR7JQdJYuOSSuQdm3
         cRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L+7PrPVDt+NF4Msq9rTPMCoAb1ssGO79mLXGBCn8ZiY=;
        b=jDes8Yt+qU5Xer4qDMB3+L0dfPyAKEUhUQ0aMAYWsdxChl5m4jT3A05KMvti9FjKDm
         /rDl3xEclccUHRkTs01Lvg5y/nmH+AICKvlRv42Hn0wXz64qjrr86tNJ4SFBY72LIskn
         wjy3whSeqZ5C9afSckcGCjethBrFqly8WigWPXVpHesh5zM5Efs7NBcQVRoYvVHmwpFX
         NLppa3GM4JQyRdXJnX0pxbOXqTKeEwYE8K5eIwsrdUjuzYV8cfqF3FI02nbn8hNP9EVH
         /wp3KbWIvKC/1IZbpPFOWbSMG8bf0ZrnNTQr85xZWUiBlNkmwcrPmY4VxU2n8VkuoXLP
         phsQ==
X-Gm-Message-State: AO0yUKXoHbI5YHPx8fbApNuGdKmK413+tig2IXuPESpzeeIZkwHnrgdq
        W3hz3Ep8ys6vpp3EjLlbn9EgNq18C/C2JiDg9A==
X-Google-Smtp-Source: AK7set+CA/4y3OFI0N4AfnibLo20AwwTiggtAskujFFxilg1v5+U9ljRkWF6efIdvpTNRhdyD4MxSJJFq8X1QIZJIrA=
X-Received: by 2002:a05:620a:152a:b0:73b:6ec3:4732 with SMTP id
 n10-20020a05620a152a00b0073b6ec34732mr3264527qkk.2.1677274732438; Fri, 24 Feb
 2023 13:38:52 -0800 (PST)
MIME-Version: 1.0
References: <20230224154235.277350-1-brgerst@gmail.com> <cfdb9c5a-4723-d920-511e-b57ae6c492f7@bytedance.com>
In-Reply-To: <cfdb9c5a-4723-d920-511e-b57ae6c492f7@bytedance.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Fri, 24 Feb 2023 16:38:41 -0500
Message-ID: <CAMzpN2hvPHWYOeyzfpRmk39XYwCrSJx0UyqxE48F1TjTNyoKAg@mail.gmail.com>
Subject: Re: [External] [PATCH v2 0/5] x86-64: Remove global variables from boot
To:     Usama Arif <usama.arif@bytedance.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 3:40 PM Usama Arif <usama.arif@bytedance.com> wrote:
>
>
>
> On 24/02/2023 15:42, Brian Gerst wrote:
> > This is based on the parallel boot v11 series.
> >
> > Remove the global variables initial_gs, initial_stack, and
> > early_gdt_descr from the 64-bit boot code.  The stack, GDT, and GSBASE
> > can be determined from the CPU number.
> >
> > v2: - Dropped first two patches which were merged into another patch in
> >        the parallel boot series.
> >      - Fixed a compile error in patch 1 found by the kernel test robot.
> >      - Split out the removal of STARTUP_SECONDARY into a separate patch
> >        and renumber the remaining flags.
> >
> > Brian Gerst (5):
> >    x86/smpboot: Remove initial_stack on 64-bit
> >    x86/smpboot: Remove early_gdt_descr on 64-bit
> >    x86/smpboot: Remove initial_gs
> >    x86/smpboot: Simplify boot CPU setup
> >    x86/smpboot: Remove STARTUP_SECONDARY
> >
> >   arch/x86/include/asm/processor.h |  6 +-
> >   arch/x86/include/asm/realmode.h  |  1 -
> >   arch/x86/include/asm/smp.h       |  5 +-
> >   arch/x86/kernel/acpi/sleep.c     |  5 +-
> >   arch/x86/kernel/head_64.S        | 99 ++++++++++++--------------------
> >   arch/x86/kernel/smpboot.c        |  6 +-
> >   arch/x86/xen/xen-head.S          |  2 +-
> >   7 files changed, 49 insertions(+), 75 deletions(-)
> >
>
> Its weird putting something in earlier patches like
> STARTUP_APICID_CPUID_*,STARTUP_SECONDARY.. and removing/changing it
> later on in *the same series*. Maybe better to keep this as a separate
> series from parallel smp? i.e. not include this in v12 and review it
> separately? Happy with whatever you and David decide..
>
> Thanks,
> Usama

Removing the globals before the parallel boot series, would be the
best option IMO.  That would make the transition simpler.

--
Brian Gerst.
