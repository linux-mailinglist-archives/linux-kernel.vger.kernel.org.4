Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279D56918B3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 07:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjBJGuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 01:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjBJGuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 01:50:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6529738EA0;
        Thu,  9 Feb 2023 22:50:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0526B823E4;
        Fri, 10 Feb 2023 06:50:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D39CC433EF;
        Fri, 10 Feb 2023 06:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676011807;
        bh=1txZm5lg17YUDHiL2gJL4ttB0KOec/UkSQZjiSaGozk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1fQVp2uwd4DZixE0rN7i1vvD8AH0xmbAzOTjZ+9As6NClYrQTG2IH8hTP9+pD0jFL
         MeCgmiFfkFQZRfc3F/CrXt5F9E87q3V2YjHVYAVTeVFcyfd6Rkj1vcDqFPnpup+sA9
         qMKNtWs5DXEZ9IPsLwjxvuTmqjnKzsz0RB0qisSI=
Date:   Fri, 10 Feb 2023 07:50:04 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Evan Green <evan@rivosinc.com>
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
Subject: Re: [PATCH v2 2/6] RISC-V: Add a syscall for HW probing
Message-ID: <Y+XpHNqnHyDEXbAj@kroah.com>
References: <20230206201455.1790329-1-evan@rivosinc.com>
 <20230206201455.1790329-3-evan@rivosinc.com>
 <Y+HsE397cY4HF+5K@kroah.com>
 <C3C21677-5250-4120-9A4F-24945C1EE51B@kernel.org>
 <CALs-HsvuX-Uj5g9c6vvUp=MaUpdcPdpwwQCsxzjoXpqS+3LEsA@mail.gmail.com>
 <Y+UpqHstcMahbadE@kroah.com>
 <CALs-HssV0=fcDKtUN_3S8T+_Qtq+6qCiNbfQU9SXicsh2KFt4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALs-HssV0=fcDKtUN_3S8T+_Qtq+6qCiNbfQU9SXicsh2KFt4w@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 10:41:51AM -0800, Evan Green wrote:
> On Thu, Feb 9, 2023 at 9:13 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Feb 09, 2023 at 09:09:16AM -0800, Evan Green wrote:
> > > On Mon, Feb 6, 2023 at 10:32 PM Conor Dooley <conor@kernel.org> wrote:
> > > >
> > > > Hey Evan, Greg,
> > > >
> > > >
> > > > On 7 February 2023 06:13:39 GMT, Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > >On Mon, Feb 06, 2023 at 12:14:51PM -0800, Evan Green wrote:
> > > > >> We don't have enough space for these all in ELF_HWCAP{,2} and there's no
> > > > >> system call that quite does this, so let's just provide an arch-specific
> > > > >> one to probe for hardware capabilities.  This currently just provides
> > > > >> m{arch,imp,vendor}id, but with the key-value pairs we can pass more in
> > > > >> the future.
> > > > >
> > > > >Ick, this is exactly what sysfs is designed to export in a sane way.
> > > > >Why not just use that instead?  The "key" would be the filename, and the
> > > > >value the value read from the filename.  If the key is not present, the
> > > > >file is not present and it's obvious what is happening, no fancy parsing
> > > > >and ABI issues at all.
> > > >
> > > > https://lore.kernel.org/linux-riscv/20221201160614.xpomlqq2fzpzfmcm@kamzik/
> > > >
> > > > This is the sysfs interface that I mentioned drew
> > > > suggested on the v1.
> > > > I think it fits ~perfectly with what Greg is suggesting too.
> > >
> > > Whoops, I'll admit I missed that comment when I reviewed the feedback
> > > from v1. I spent some time thinking about sysfs. The problem is this
> > > interface will be needed in places like very early program startup. If
> > > we're trying to use this in places like the ifunc selector to decide
> > > which memcpy to use, having to go open and read a fistful of files is
> > > going to be complex that early, and rough on performance.
> >
> > How is it going to be any different on "performance" than a syscall?  Or
> > complex?  It should be almost identical overall as this is all in-ram
> > and not any real I/o is happening.  You are limited only by the speed of
> > your cpu.
> 
> At best sysfs is 1 syscall per key, whereas this version of the
> interface lets you query all the keys you're interested in with a
> single syscall. With the
> proposed vdso version, we'd be down to ~0 syscalls for most queries.
> The complexity aspect is mostly a reference to having to do a bunch of
> open/read/parse/close operations at a time when mem* operations are
> still being set up. Since this is something that may get run on every
> program invocation, it seems worth it to be able to get fast and
> simple queries even if it's a slightly separated interface.

I'd be interested in the real benchmark numbers and seeing the userspace
and kernel code before arguing this too much.

Again, ignoring the lessons of the past is generally considered an
unwise decision, but hey, you do you, it's something that you are going
to have to maintain for 40+ years going forward, not me :)

good luck!

greg k-h
