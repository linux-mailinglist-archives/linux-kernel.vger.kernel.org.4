Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E6769107B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 19:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjBISmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 13:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBISmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 13:42:31 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FA84DBD3
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 10:42:29 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id j17so4469253lfr.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 10:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i0aEDE75N2SdBDGGPL2lgt++w/A4f2z3JZVFa7fsP6w=;
        b=0sGaXDcbijcr7oYBBi4A/osUlPOLqpddmvr6yjcUghq8IMl4ZIdY6zKpopKJC9W6pV
         AGLHN3sBHEWqECUOQcSLQuJaRQsqGw6B+NcJwVdtbQ/mER/2nlVYQrJU2YuCTjaL2O/K
         ImF+MpptlhOrZxCBcvWTvrayzNUzK/SkWimx6fVKMhP8QIyMYlNAYyFUVWBg+XARH8bm
         65NFolmnqRyUx8euHY3CRVmmLp7vWK9ebEhQxRy4H0UTo1kRSKkyJQbTyw+GKXUap1jR
         xWoa0KMPh5Nw9oXdYTYbk6YGD0n3+b7jgsKk9MXrXTjwMPyq5xelyKlhVtgC2trJ0fSK
         Bg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i0aEDE75N2SdBDGGPL2lgt++w/A4f2z3JZVFa7fsP6w=;
        b=uTOdn657uNTavowNj0+T6Sk7g2Cfb2YmaEAFC5/UJpCREKcK+pMFSXxUmPmJ7KgtR5
         zG3OwVytdt4RC2xiEGROSs8vNssq1oudqCOWsgDAMeak7j0ToLNeAVSYzhEaUXp5ZemF
         qSTmSemVetjy4aYshzc4zRMIyQGMk+U5FsysAEVPt1I2o4qCW7QKGH2+kxy5+1DtpGz4
         F4V6Yi4ZeWWgfVkk7wTd36xXQjj/MzCi4jCJODv9miR+yRJRsA9ORnt97HtzIft4StOC
         utL/YTtS50KtPh7/FdpXJsBbKob1qw1oVLfgvO54ILllMWW/R3A3qD4f0EUzhAFX1T03
         JgsA==
X-Gm-Message-State: AO0yUKV7Nkx3kdifB78aH9D6bqpoooYxwLZWqUsadoszONyokJzfeKPR
        n/KioEoy0uMK0r4BMh0tx3YAnXNrLsO0UwSvhJilow==
X-Google-Smtp-Source: AK7set8Xnf2aypJtFoPs/ialPERepYClud8fqjfrGasZLQIuYamcdQuwo/59VT5Flm2ac6uKIY2iXRlx6BJ+wdu8Hyg=
X-Received: by 2002:a05:6512:218e:b0:4d7:2dc1:b7bc with SMTP id
 b14-20020a056512218e00b004d72dc1b7bcmr2133331lft.100.1675968147543; Thu, 09
 Feb 2023 10:42:27 -0800 (PST)
MIME-Version: 1.0
References: <20230206201455.1790329-1-evan@rivosinc.com> <20230206201455.1790329-3-evan@rivosinc.com>
 <Y+HsE397cY4HF+5K@kroah.com> <C3C21677-5250-4120-9A4F-24945C1EE51B@kernel.org>
 <CALs-HsvuX-Uj5g9c6vvUp=MaUpdcPdpwwQCsxzjoXpqS+3LEsA@mail.gmail.com> <Y+UpqHstcMahbadE@kroah.com>
In-Reply-To: <Y+UpqHstcMahbadE@kroah.com>
From:   Evan Green <evan@rivosinc.com>
Date:   Thu, 9 Feb 2023 10:41:51 -0800
Message-ID: <CALs-HssV0=fcDKtUN_3S8T+_Qtq+6qCiNbfQU9SXicsh2KFt4w@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] RISC-V: Add a syscall for HW probing
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>, vineetg@rivosinc.com,
        heiko@sntech.de, slewis@rivosinc.com,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Atish Patra <atishp@rivosinc.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Dao Lu <daolu@rivosinc.com>, Guo Ren <guoren@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ruizhe Pan <c141028@gmail.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 9, 2023 at 9:13 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Feb 09, 2023 at 09:09:16AM -0800, Evan Green wrote:
> > On Mon, Feb 6, 2023 at 10:32 PM Conor Dooley <conor@kernel.org> wrote:
> > >
> > > Hey Evan, Greg,
> > >
> > >
> > > On 7 February 2023 06:13:39 GMT, Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >On Mon, Feb 06, 2023 at 12:14:51PM -0800, Evan Green wrote:
> > > >> We don't have enough space for these all in ELF_HWCAP{,2} and there's no
> > > >> system call that quite does this, so let's just provide an arch-specific
> > > >> one to probe for hardware capabilities.  This currently just provides
> > > >> m{arch,imp,vendor}id, but with the key-value pairs we can pass more in
> > > >> the future.
> > > >
> > > >Ick, this is exactly what sysfs is designed to export in a sane way.
> > > >Why not just use that instead?  The "key" would be the filename, and the
> > > >value the value read from the filename.  If the key is not present, the
> > > >file is not present and it's obvious what is happening, no fancy parsing
> > > >and ABI issues at all.
> > >
> > > https://lore.kernel.org/linux-riscv/20221201160614.xpomlqq2fzpzfmcm@kamzik/
> > >
> > > This is the sysfs interface that I mentioned drew
> > > suggested on the v1.
> > > I think it fits ~perfectly with what Greg is suggesting too.
> >
> > Whoops, I'll admit I missed that comment when I reviewed the feedback
> > from v1. I spent some time thinking about sysfs. The problem is this
> > interface will be needed in places like very early program startup. If
> > we're trying to use this in places like the ifunc selector to decide
> > which memcpy to use, having to go open and read a fistful of files is
> > going to be complex that early, and rough on performance.
>
> How is it going to be any different on "performance" than a syscall?  Or
> complex?  It should be almost identical overall as this is all in-ram
> and not any real I/o is happening.  You are limited only by the speed of
> your cpu.

At best sysfs is 1 syscall per key, whereas this version of the
interface lets you query all the keys you're interested in with a
single syscall. With the
proposed vdso version, we'd be down to ~0 syscalls for most queries.
The complexity aspect is mostly a reference to having to do a bunch of
open/read/parse/close operations at a time when mem* operations are
still being set up. Since this is something that may get run on every
program invocation, it seems worth it to be able to get fast and
simple queries even if it's a slightly separated interface.


-Evan
