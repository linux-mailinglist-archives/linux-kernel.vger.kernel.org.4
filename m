Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C2C70880A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 20:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjERSyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 14:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjERSyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 14:54:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F538E52
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 11:54:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BB0A61B56
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 18:54:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8CDC4339B
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 18:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684436077;
        bh=tSeHM2j6YYE6eQ0ZjDsz94w5GR3l8DavaTLlPbhc2J8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OD5NrdHwvEf3BnD5mg99CS/15uplK/QF3paQ9C+SLkCMRtmw0TcqQqyWN/sgsntT+
         Wf9gA6IhsBCoqvaqSTP+oxD51l+ATZ+rp0zdNk0O/LJeMDB6SZS7Z4chIihHq/R5zr
         XqlT2s8Y67+wQhbNPC+GLRPPTc7V7qcp8NuYB+d4nczWXY4k2y+8TOTUtTczbuJz00
         d14rRtP+sqZa1dOW4IV5WpVY45+04HWhVv5QQBPD9ErtrZ7zNGwCO4aVQ7LdjyvRH6
         oEGWp8eJOiYQuE1QEMp3f0bXe4ar88F2Q8ZGkaDLnPCW+t2rtxERYwF7qyl40A6HIi
         eniMRMbgArPPg==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-4eed764a10cso2868982e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 11:54:37 -0700 (PDT)
X-Gm-Message-State: AC+VfDxIxCfpa6T+TGmfEe8UP1AyH10gZXdmP1xVM3SpE6TLLOCASpEq
        z6BDtkY7mnyZkjrEAVlyGG0oyQw9o7QRkqg77yc=
X-Google-Smtp-Source: ACHHUZ5hNGUAql7F4iLvA6AejMOez0kLIougPttOSmgZJuTKMCgCBvbcFvUx4IUPbIfwuKe5NGHsnVlzd8gSMRY0R40=
X-Received: by 2002:ac2:5315:0:b0:4f2:6817:2379 with SMTP id
 c21-20020ac25315000000b004f268172379mr62228lfh.23.1684436075613; Thu, 18 May
 2023 11:54:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230308094106.227365-1-rppt@kernel.org> <20230308094106.227365-2-rppt@kernel.org>
 <ZGWdHC3Jo7tFUC59@moria.home.lan> <20230518152354.GD4967@kernel.org>
 <CAPhsuW541pcsMKYah=2U8mUs8is3jAiNKC8Erte=RkAUGFO9EA@mail.gmail.com>
 <ZGZZIM0qftr0T59b@moria.home.lan> <CAPhsuW4Ccu1oYw1WjqqX0a685VWxiieHZiPui_=BMAn8dV7ivQ@mail.gmail.com>
 <ZGZffIc9VHlnDsPf@moria.home.lan>
In-Reply-To: <ZGZffIc9VHlnDsPf@moria.home.lan>
From:   Song Liu <song@kernel.org>
Date:   Thu, 18 May 2023 11:54:23 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5a7jB1wsyNiUMM-QuuvLx4omTRgDiywEMDn3NLhnqMzg@mail.gmail.com>
Message-ID: <CAPhsuW5a7jB1wsyNiUMM-QuuvLx4omTRgDiywEMDn3NLhnqMzg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] mm: intorduce __GFP_UNMAPPED and unmapped_alloc()
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 10:25=E2=80=AFAM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Thu, May 18, 2023 at 10:15:59AM -0700, Song Liu wrote:
> > On Thu, May 18, 2023 at 9:58=E2=80=AFAM Kent Overstreet
> > <kent.overstreet@linux.dev> wrote:
> > >
> > > On Thu, May 18, 2023 at 09:33:20AM -0700, Song Liu wrote:
> > > > I am working on patches based on the discussion in [1]. I am planni=
ng to
> > > > send v1 for review in a week or so.
> > >
> > > For reference, here's my own (early, but functioning :) slab allocato=
r:
> > >
> > > Look forward to comparing!
> >
> > This looks similar to the bpf_prog_pack allocator we use for BPF at the
> > moment. (search for bpf_prog_pack in kernel/bpf/core.c). I guess we
> > can also use bpf_prog_pack for bcachefs for now.
>
> The code in bpf/core.c does a _lot_, my preference would be to split
> that up and refactor the bpf code to use something generic :)

The code is actually splitted into two parts:

   bpf_prog_pack_[alloc|free] vs. bpf_jit_binary_pack_[alloc|free].

The latter has logic just for BPF. But the former can be reused by
other users (maybe with a little refactoring).

Once the vmap_area based solution is committed, we will replace the
former with the new allocator.

Thanks,
Song
