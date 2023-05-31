Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293F1718A97
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 21:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjEaTzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 15:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjEaTzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 15:55:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA92185
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 12:55:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32DBE617E7
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 19:55:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A45A3C433EF;
        Wed, 31 May 2023 19:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685562926;
        bh=K6BiB4d4pwh5l5fEvqg5HdsW+2/SZ5ha4oA58FNbVQ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JuSCt7/41WoHCLlFavs2RXRxmldBL7Ykn9PLKEI5mTlSq8J8r3pTx9GA6RlHeXPHs
         Bs7j3d47LzA6lzpLmKw49dzEsf0GHytMnrsv6BBfUSM0ou+i6s3zAz7/bUEIKf+edU
         9ETJeJF8nBvARAe8pp4O9agqKhDGNPCh3pBNUzDIkPWSWgKa8CdBsMHBH3BNV/fMWG
         v8iuohJNe6KusvYI9dmcvVVyTq7z+fjUFHwk+26RGP41wNFB2J7hcZRPiokWcBTYS2
         JHgziIzlZDrcsqgATpaEjbzvteIxpIDZ7bWbH8O+yYHtPFGuqU1Td4rWl8EfQHGRHy
         vxeSinydRSACg==
Date:   Wed, 31 May 2023 22:54:54 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        mcgrof@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        x86@kernel.org
Subject: Re: [PATCH 0/3] Type aware module allocator
Message-ID: <20230531195454.GB395338@kernel.org>
References: <20230526051529.3387103-1-song@kernel.org>
 <ZHGrjJ8PqAGN9OZK@moria.home.lan>
 <CAPhsuW4DAwx=7Nta5HGiPTJ1LQJCGJGY3FrsdKi62f_zJbsRFQ@mail.gmail.com>
 <20230529104530.GL4967@kernel.org>
 <CAPhsuW6g98Wz9Oj1NiwwZ1OkSVNXX10USByY0b9tEfzOt8SVQg@mail.gmail.com>
 <20230531135120.GA395338@kernel.org>
 <CAPhsuW6r=0r0dKfKxwPp9KXqLSKWw4x6RrbNBnS=1M1Y1sh5Ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW6r=0r0dKfKxwPp9KXqLSKWw4x6RrbNBnS=1M1Y1sh5Ag@mail.gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 10:03:58AM -0700, Song Liu wrote:
> On Wed, May 31, 2023 at 6:51 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Tue, May 30, 2023 at 03:37:24PM -0700, Song Liu wrote:
> > > On Mon, May 29, 2023 at 3:45 AM Mike Rapoport <rppt@kernel.org> wrote:
> > > >
> > > > On Sat, May 27, 2023 at 10:58:37PM -0700, Song Liu wrote:
> > > > > On Sat, May 27, 2023 at 12:04 AM Kent Overstreet
> > > > > <kent.overstreet@linux.dev> wrote:
> > > > > >
> > > > > > I think this needs to back to the drawing board and we need something
> > > > > > simpler just targeted at executable memory; architecture specific
> > > > > > options should definitely _not_ be part of the exposed interface.
> > > > >
> > > > > I don't think we are exposing architecture specific options to users.
> > > > > Some layer need to handle arch specifics. If the new allocator is
> > > > > built on top of module_alloc, module_alloc is handling that. If the new
> > > > > allocator is to replace module_alloc, it needs to handle arch specifics.
> > > >
> > > > I'm for creating a new allocator that will replace module_alloc(). This
> > > > will give us a clean abstraction that modules and all the rest will use and
> > > > it will make easier to plug binpack or another allocator instead of
> > > > vmalloc.
> > > >
> > > > Another point is with a new allocator we won't have weird dependencies on
> > > > CONFIG_MODULE in e.g. bpf and kprobes.
> > > >
> > > > I'll have something ready to post as an RFC in a few days.
> > >
> > > I guess this RFC is similar to unmapped_alloc()? If it replaces
> > > vmalloc, we can probably trim this set down a bit (remove
> > > mod_alloc_params and vmalloc_params, etc.).
> >
> > No, it's not a new allocator. I'm trying to create an API for code
> > allocations that can accommodate all the architectures and it won't be a
> > part of modules code. The modules will use the new API just like every
> > other subsystem that needs to allocate code.
> >
> > I've got a core part of it here:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=jitalloc/v1
> 
> This branch looks like the same scope as this set (but with different
> implementation). So it will still use vmalloc, right?

Yes, it still uses vmalloc. The idea is to decouple code allocations from
modules from one side and make it handle all the variants expected by the
architectures based on a set of parameters each architecture provides.

The first few commits essentially shuffle the code around and replace
arch::module_alloc() with arch::jit_alloc_params.

The commits on top enable some bits that are not available today, like ROX
executable memory and DYNAMIC_FTRACE without modules for x86.
 
> Thanks,
> Song

-- 
Sincerely yours,
Mike.
