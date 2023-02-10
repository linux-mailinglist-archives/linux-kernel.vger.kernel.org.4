Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8FC96918AF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 07:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjBJGs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 01:48:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjBJGs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 01:48:27 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9A138EA0;
        Thu,  9 Feb 2023 22:48:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2D5F1CE2755;
        Fri, 10 Feb 2023 06:48:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E180C433D2;
        Fri, 10 Feb 2023 06:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676011702;
        bh=b6Oc5ZzVG7nkvmdk4QiD1WgVKwZk2maRbTIji6Y1fRs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E/mNkwkhzmWnBepo6lLnMq2Hy8LeFdqTjsvG9JKYOHiE3I/OTk2GACwE/E1kBhDwQ
         SsexiB9LjVzuhFVNyP232bjlM6QwapGkfcBJ6shtGvQWoQIQb/oyi1re+7V5Rinbrx
         4PZpgtZNXiGKHAaG4ZW91ELrOP7LaTvQkDp4gW0w=
Date:   Fri, 10 Feb 2023 07:48:18 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jessica Clarke <jrtc27@jrtc27.com>
Cc:     Evan Green <evan@rivosinc.com>, Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Vineet Gupta <vineetg@rivosinc.com>,
        Heiko Stuebner <heiko@sntech.de>, slewis@rivosinc.com,
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
Message-ID: <Y+Xosn6Zbbcqn3ge@kroah.com>
References: <20230206201455.1790329-1-evan@rivosinc.com>
 <20230206201455.1790329-3-evan@rivosinc.com>
 <Y+HsE397cY4HF+5K@kroah.com>
 <C3C21677-5250-4120-9A4F-24945C1EE51B@kernel.org>
 <CALs-HsvuX-Uj5g9c6vvUp=MaUpdcPdpwwQCsxzjoXpqS+3LEsA@mail.gmail.com>
 <Y+UpqHstcMahbadE@kroah.com>
 <F4C20D57-912B-489F-A262-51EAEE79F41D@jrtc27.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F4C20D57-912B-489F-A262-51EAEE79F41D@jrtc27.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 05:22:09PM +0000, Jessica Clarke wrote:
> On 9 Feb 2023, at 17:13, Greg KH <gregkh@linuxfoundation.org> wrote:
> > On Thu, Feb 09, 2023 at 09:09:16AM -0800, Evan Green wrote:
> >> On Mon, Feb 6, 2023 at 10:32 PM Conor Dooley <conor@kernel.org> wrote:
> >>> 
> >>> Hey Evan, Greg,
> >>> 
> >>> 
> >>> On 7 February 2023 06:13:39 GMT, Greg KH <gregkh@linuxfoundation.org> wrote:
> >>>> On Mon, Feb 06, 2023 at 12:14:51PM -0800, Evan Green wrote:
> >>>>> We don't have enough space for these all in ELF_HWCAP{,2} and there's no
> >>>>> system call that quite does this, so let's just provide an arch-specific
> >>>>> one to probe for hardware capabilities.  This currently just provides
> >>>>> m{arch,imp,vendor}id, but with the key-value pairs we can pass more in
> >>>>> the future.
> >>>> 
> >>>> Ick, this is exactly what sysfs is designed to export in a sane way.
> >>>> Why not just use that instead?  The "key" would be the filename, and the
> >>>> value the value read from the filename.  If the key is not present, the
> >>>> file is not present and it's obvious what is happening, no fancy parsing
> >>>> and ABI issues at all.
> >>> 
> >>> https://lore.kernel.org/linux-riscv/20221201160614.xpomlqq2fzpzfmcm@kamzik/
> >>> 
> >>> This is the sysfs interface that I mentioned drew
> >>> suggested on the v1.
> >>> I think it fits ~perfectly with what Greg is suggesting too.
> >> 
> >> Whoops, I'll admit I missed that comment when I reviewed the feedback
> >> from v1. I spent some time thinking about sysfs. The problem is this
> >> interface will be needed in places like very early program startup. If
> >> we're trying to use this in places like the ifunc selector to decide
> >> which memcpy to use, having to go open and read a fistful of files is
> >> going to be complex that early, and rough on performance.
> > 
> > How is it going to be any different on "performance" than a syscall?  Or
> > complex?  It should be almost identical overall as this is all in-ram
> > and not any real I/o is happening.  You are limited only by the speed of
> > your cpu.
> > 
> >> Really this is data that would go great in the aux vector, except
> >> there's probably too much of it to justify preparing and copying into
> >> every new process. You could point the aux vector into a vDSO data
> >> area. This has the advantage of great performance and no syscall, but
> >> has the disadvantages of making that data ABI, and requiring it all to
> >> be known up front (eg the kernel can't compute any answers on the
> >> fly).
> >> 
> >> After discussions with Palmer, my plan for the next version is to move
> >> this into a vDSO function plus a syscall. Private vDSO data will be
> >> prepped with common answers for the "all CPUs" case, avoiding the need
> >> for a syscall in most cases and making this fast. Since the data is
> >> hidden behind the vdso function, it's not ABI, which is a plus. Then
> >> the vdso function can fall back to the syscall for cases with exotic
> >> CPU masks or keys that are unknown/expensive to compute at runtime.
> > 
> > I still think that's wrong, as you are wanting a set of key/values here,
> > which is exactly what sysfs is designed for.
> 
> But this needs to be a RISC-V standard interface that can be programmed
> against, not something tied to highly Linux-specific things like sysfs.
> You’re free to implement that interface with sysfs, but exposing that
> as *the* interface to use would be terrible for portability.

A vdso and a new kernel syscall is also a highly Linux-specific thing,
so I do not understand the objection here at all.  You're going to have
to wrap all of this up in some sort of common userspace library code
anyway, and that will have to handle all of the different operating
system implementations.

Also, frankly, I don't care about non-Linux implementations, so that
isn't a valid argument here :)

thanks,

greg k-h
