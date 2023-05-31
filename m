Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDCAD718406
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237490AbjEaN61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjEaN6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:58:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3819C524F
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 06:51:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1797263C2C
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 13:51:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE6FC433D2;
        Wed, 31 May 2023 13:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685541105;
        bh=B3N6YHdsFd5bPXI4OFTcPK/kl2cL7GTlWbHn5XcxccU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sSrNQlbXLkP7OPfaP4f9CJjlzTtVupzjE3UkcNVidX1ShjoM37KTUOY0L1MO8u1tw
         zUL9t+OvlyBZj8/SysBwAeub43D2MhJgPH6vgY4XXIWeg44cAlK6GmCsbTWcteJkv8
         blRcIhsH4eDJCDKmLaGtEPZbfyNJp/qqZO5aXfBtDXB19eSQD5MukWCj3cVSNlKTR0
         ClebjkweU55d+7QdLvPKg1/jWuk7P1a+Zsr/axepmsJgqDUTJZBvDTz4mYTZFadZks
         reYootRezpaeWoHGqklnmo7eVJYPkhkWgbUStnfM0QeVcucNAI/iif0kZGFCkezXSw
         tfilJlbRFXrLg==
Date:   Wed, 31 May 2023 16:51:20 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        mcgrof@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        x86@kernel.org
Subject: Re: [PATCH 0/3] Type aware module allocator
Message-ID: <20230531135120.GA395338@kernel.org>
References: <20230526051529.3387103-1-song@kernel.org>
 <ZHGrjJ8PqAGN9OZK@moria.home.lan>
 <CAPhsuW4DAwx=7Nta5HGiPTJ1LQJCGJGY3FrsdKi62f_zJbsRFQ@mail.gmail.com>
 <20230529104530.GL4967@kernel.org>
 <CAPhsuW6g98Wz9Oj1NiwwZ1OkSVNXX10USByY0b9tEfzOt8SVQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW6g98Wz9Oj1NiwwZ1OkSVNXX10USByY0b9tEfzOt8SVQg@mail.gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 03:37:24PM -0700, Song Liu wrote:
> On Mon, May 29, 2023 at 3:45 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Sat, May 27, 2023 at 10:58:37PM -0700, Song Liu wrote:
> > > On Sat, May 27, 2023 at 12:04 AM Kent Overstreet
> > > <kent.overstreet@linux.dev> wrote:
> > > >
> > > > I think this needs to back to the drawing board and we need something
> > > > simpler just targeted at executable memory; architecture specific
> > > > options should definitely _not_ be part of the exposed interface.
> > >
> > > I don't think we are exposing architecture specific options to users.
> > > Some layer need to handle arch specifics. If the new allocator is
> > > built on top of module_alloc, module_alloc is handling that. If the new
> > > allocator is to replace module_alloc, it needs to handle arch specifics.
> >
> > I'm for creating a new allocator that will replace module_alloc(). This
> > will give us a clean abstraction that modules and all the rest will use and
> > it will make easier to plug binpack or another allocator instead of
> > vmalloc.
> >
> > Another point is with a new allocator we won't have weird dependencies on
> > CONFIG_MODULE in e.g. bpf and kprobes.
> >
> > I'll have something ready to post as an RFC in a few days.
> 
> I guess this RFC is similar to unmapped_alloc()? If it replaces
> vmalloc, we can probably trim this set down a bit (remove
> mod_alloc_params and vmalloc_params, etc.).

No, it's not a new allocator. I'm trying to create an API for code
allocations that can accommodate all the architectures and it won't be a
part of modules code. The modules will use the new API just like every
other subsystem that needs to allocate code.

I've got a core part of it here:

https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=jitalloc/v1

and I hope I'll get it ready to post this week.

> Thanks,
> Song

-- 
Sincerely yours,
Mike.
