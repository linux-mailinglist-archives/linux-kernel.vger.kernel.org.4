Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04C465B3BA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 16:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236146AbjABPES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 10:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235976AbjABPEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 10:04:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8737065F7
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 07:04:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39787B80D35
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 15:04:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E30F6C43396
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 15:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672671842;
        bh=IG1cdiy1CkS1pPFordbJMkK1hhJGEd8r4QDsZMxFoG8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=g5JhoYBCKO0AQ39xgQU5vDJzDvfaoBJj2MtmB8jks02J8FJM19Z+mpO8OjzpNwdFj
         Bavo56S9AYVExdjFjkpPOZXzuNGsfEPlHQLpK7+5ZO1HbT5YQ3uQJrIpmRKgRTG096
         k9dYw+5Lg0+YSB/KYRO4Vs4NUkvpu3WZKcqRpn0oo6gMX9ut62288Nz8BM9p50vKpR
         4KR5ADLzRcueX5dU1YV/cwo4lUQO3Fvuto1VZHfn38ZHAolJcCE1gga3K/bBlmDh+N
         h9Ap+cgELDJYoe2obgZDoOxUyUsQwpRYLF9xmBRL+PZH9Xb9iXAqWrAqfiHNG8+EMj
         cHH9xrCFB3ebA==
Received: by mail-lj1-f173.google.com with SMTP id bn6so19356321ljb.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 07:04:02 -0800 (PST)
X-Gm-Message-State: AFqh2kpV1/UarIvzzuYHPXVqRTYnycdhDSBIut1tDFK2n10P0BE+swJ2
        MdG8fgD7YGPVMMG4RJUMs1VIR0uW6upYebG6rOU=
X-Google-Smtp-Source: AMrXdXu3X9iDdXOxHCK7qO6O1hOORBeIqnyBxt7XCC0oVIzyoA1v8mtAqqmRjSm8ZfowbDlKHSITW8JZL2Y1CTVCVTU=
X-Received: by 2002:a2e:bd0c:0:b0:27f:bc58:3924 with SMTP id
 n12-20020a2ebd0c000000b0027fbc583924mr2090552ljq.352.1672671840869; Mon, 02
 Jan 2023 07:04:00 -0800 (PST)
MIME-Version: 1.0
References: <Y7A9nBud6UeH+wYd@zn.tnic> <Y7A+YELM7m5E2PUQ@zx2c4.com>
 <Y7BGIAL4z6o6FEI5@zn.tnic> <Y7B993P1+jYB/etX@zx2c4.com> <Y7CGzde+qPB7YJP4@zn.tnic>
 <60566f8b-c90f-12e7-c13e-94e9829eee2d@zytor.com> <8f072588-7d66-0932-7486-ed9159ae93ae@zytor.com>
 <Y7JzTh8JnMXM6ZPS@zn.tnic> <Y7J3B50kn1kWrxlk@zn.tnic> <CAMj1kXHDw5p5yX25TnKiQ7sgqVbhEjB+=fu=7Oz67shQD-fL6Q@mail.gmail.com>
 <Y7Ld9MVZC3/fsj9Y@zn.tnic>
In-Reply-To: <Y7Ld9MVZC3/fsj9Y@zn.tnic>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 2 Jan 2023 16:03:49 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG3fsBwRL8+_4jsb=040o6NzR_0RrmtGFnJ3u1YETY60w@mail.gmail.com>
Message-ID: <CAMj1kXG3fsBwRL8+_4jsb=040o6NzR_0RrmtGFnJ3u1YETY60w@mail.gmail.com>
Subject: Re: [PATCH qemu] x86: don't let decompressed kernel image clobber setup_data
To:     Borislav Petkov <bp@alien8.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, pbonzini@redhat.com,
        ebiggers@kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        qemu-devel@nongnu.org, kraxel@redhat.com, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jan 2023 at 14:37, Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Jan 02, 2023 at 10:32:03AM +0100, Ard Biesheuvel wrote:
> > So instead of appending data to the compressed image and assuming that
> > it will stay in place, create or extend a memory reservation
> > elsewhere, and refer to its absolute address in setup_data.
>
> From my limited experience with all those boot protocols, I'd say hardcoding
> stuff is always a bad idea. But, we already more or less hardcode, or rather
> codify through the setup header contract how stuff needs to get accessed.
>
> And yeah, maybe specifying an absolute address and size for a blob of data and
> putting that address and size in the setup header so that all the parties
> involved are where what is, is probably better.
>

Exactly. In the EFI case, this was problematic because we would need
to introduce a new way to pass memory reservations between QEMU and
the firmware. But I don't think that issue should affect legacy BIOS
boot, and we could just reserve the memory in the E820 table AFAIK.
