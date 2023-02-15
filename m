Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494B2697A99
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 12:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbjBOLW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 06:22:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbjBOLW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 06:22:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF38367E5;
        Wed, 15 Feb 2023 03:22:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62B1F61B5D;
        Wed, 15 Feb 2023 11:22:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C363DC4339E;
        Wed, 15 Feb 2023 11:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676460145;
        bh=QwVZFx27VjT5yCCEbgsy3jL3pVFwM58NqLhQ0viUv54=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Z1ntUSNKq4QIcM7Y/LYIYnGx621K2FIiQFFSiAA/4w2nUYoXaQU2PvsH5SNO7rY2L
         /FgPXP8iT7KwtVzjmTDPEjqLJh0n0zClydwSoZQmwxKvQrTrx7g1UBs8xaOwKUSwLQ
         ziB9NBme9VyKArZk9NtgPQBdz82VjpR/f5mci1z2iWN0AbeYdXOnlqsn/oIHJE4gc+
         ZWIcQxxdL6i5MH/19To7YTJk1MbxTvmwBy3ZqjgwR5w0RiEVw69uKFX8JEv+wR8y/i
         zVHt8ZrUmGzmMhyZP/32ELCJFMU+ymBTdreowLORNNU4HRTD1xHm0+dAmAHCV1rZla
         tNORfkvnX9XLQ==
Received: by mail-lj1-f180.google.com with SMTP id a9so21743022ljr.13;
        Wed, 15 Feb 2023 03:22:25 -0800 (PST)
X-Gm-Message-State: AO0yUKUCVa39fIBoy91TOecgdFgE70LJLAGicij3CmLj5NiGNjxMxIEr
        AAvvLK44doN0MEWSJXwExA5ZO48Zi3jD8L5zvLQ=
X-Google-Smtp-Source: AK7set/eTBJGx4Y9pI3QYM9cfkjOhKgD3507K955RYIkG8GtEfcAMZZ0ILMSIY1ASegCA4qvd/WVg+1F0o5+68LU3LM=
X-Received: by 2002:a05:651c:386:b0:293:515f:4105 with SMTP id
 e6-20020a05651c038600b00293515f4105mr447446ljp.2.1676460143824; Wed, 15 Feb
 2023 03:22:23 -0800 (PST)
MIME-Version: 1.0
References: <20230215100008.2565237-1-ardb@kernel.org> <20230215100008.2565237-3-ardb@kernel.org>
 <ea12dd12-db17-44a8-8c29-6b0a129f355d@app.fastmail.com> <62e7ab37-1148-4cf1-8d6a-3da440fa623f@app.fastmail.com>
In-Reply-To: <62e7ab37-1148-4cf1-8d6a-3da440fa623f@app.fastmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 15 Feb 2023 12:22:12 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGYcLLaJQfYjcjvAnFbb+MAWQF-2BzeUGJTqBu4V=ejNw@mail.gmail.com>
Message-ID: <CAMj1kXGYcLLaJQfYjcjvAnFbb+MAWQF-2BzeUGJTqBu4V=ejNw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/5] kernel: Drop IA64 support from sig_fault handlers
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Tony Luck <tony.luck@intel.com>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Matthew Wilcox <willy@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ia64@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Feb 2023 at 12:15, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Feb 15, 2023, at 11:19, Arnd Bergmann wrote:
> >
> > I can probably do the same recursive check for removed Kconfig
> > options that I used for finding dead code after the boardfile
> > removal.
>
> FWIW, here is the list from a bit of scripting.

Thanks

> Symbols that
> are only defined in arch/ia64 but are referenced elsewhere are:
>
> CONFIG_IA64
> CONFIG_IA64_PAGE_SIZE_64KB
> CONFIG_IA64_SGI_UV
> CONFIG_IA64_DEBUG_CMPXCHG
> CONFIG_MSPEC

These are all gone from the code after applying this series.

> Kconfig symbols that are only selected in arch/ia64 but
> defined elsewhere are
>
> CONFIG_ARCH_HAS_DMA_MARK_CLEAN
> CONFIG_ARCH_TASK_STRUCT_ALLOCATOR
> CONFIG_ARCH_TASK_STRUCT_ON_STACK
> CONFIG_ARCH_THREAD_STACK_ALLOCATOR
> CONFIG_GENERIC_IRQ_LEGACY
>

I can follow up with patches that remove all of those as well once we
progress on this series.

> plus a few that have only one or two other places selecting them:
>
> CONFIG_ARCH_CLOCKSOURCE_DATA (sparc64)
> CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC (x86)
> CONFIG_ATA_NONSTANDARD (powerpc-maple)
> CONFIG_FUNCTION_ALIGNMENT_32B (i386)
> CONFIG_HUGETLB_PAGE_SIZE_VARIABLE (powerpc64)
> CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT (x86, loongarch)
> CONFIG_ARCH_BINFMT_ELF_EXTRA_PHDRS (arm64, arch/um 32-bit)
> CONFIG_HAVE_FUNCTION_DESCRIPTORS (ppc64be, parisc64)
> CONFIG_HAVE_UNSTABLE_SCHED_CLOCK (parisc, x86)
> CONFIG_HAVE_VIRT_CPU_ACCOUNTING (powerpc, s390)
> CONFIG_SYSCTL_ARCH_UNALIGN_NO_WARN (arc, loongarch)
>
>       Arnd
