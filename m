Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821A36631DE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjAIUwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjAIUwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:52:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E47D66981;
        Mon,  9 Jan 2023 12:52:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 417BDB80FA1;
        Mon,  9 Jan 2023 20:52:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3194C433EF;
        Mon,  9 Jan 2023 20:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673297533;
        bh=w6giNhEzja4pgAeC8sK8XKIURy8g4tLqWCNa5venu/w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Omao7qEfDeJvFmmYIBbAs7gty+78r4rkqQuBOI1M/vX6uh4Z8mCJbn4Ila+GY0kMP
         ma8eLjQPVx5Evm6iP9ifexy3P4XBS/86xQkCVHawaRjUxq926TiCrwFH/Mxan98XfX
         fGVmeU05g19tNCa0NgnEm1NS1pzMNDZ06kZstdHQZVJXLXGJ4iqilYXykHtSFHhWZD
         4w1GlUBxM7bqH0O1arYtbqnMDD9jZnCWPt+iWy3d9I4FTucZJZbASB19UhIV+UnTMP
         WVbc5kOTMiM3szMrTHCW/5yHR8/d0sIVLCfvyNPgERKFMPHctCL67sLmHCY+7q0Y67
         wMcfF1pfM+gIA==
Received: by mail-lj1-f171.google.com with SMTP id y18so6704734ljk.11;
        Mon, 09 Jan 2023 12:52:13 -0800 (PST)
X-Gm-Message-State: AFqh2kpnQAiu+ZfSApdm0ibkciXXz1bI9DDAuw5z/FpGeeRbdX61BaN7
        c4o2HU/beu1Gmr/KfP46+O/sRsXkssH4u3uf3rw=
X-Google-Smtp-Source: AMrXdXvsR1omeXlLq2wIZglNeAKgZiCHQZTQhRui2PIQNFZR4JgUuEEhi0ECmFj9ymAFJCXS4P7t/FKSJImSFwj/KwE=
X-Received: by 2002:a2e:9382:0:b0:284:b05a:9e82 with SMTP id
 g2-20020a2e9382000000b00284b05a9e82mr376245ljh.479.1673297531894; Mon, 09 Jan
 2023 12:52:11 -0800 (PST)
MIME-Version: 1.0
References: <20230106220959.3398792-1-song@kernel.org> <83941b74-7585-235b-ee54-3b127ca70d9e@csgroup.eu>
 <CAPhsuW6S8qJWFzSLpVf_4ZpyM0Cxty=-pS2_K=tgF52s95Zhag@mail.gmail.com>
In-Reply-To: <CAPhsuW6S8qJWFzSLpVf_4ZpyM0Cxty=-pS2_K=tgF52s95Zhag@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 9 Jan 2023 12:51:59 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7+BG9wYaoD6EYH-jnWqX30JdgNr5_733sO-++SzR5v3w@mail.gmail.com>
Message-ID: <CAPhsuW7+BG9wYaoD6EYH-jnWqX30JdgNr5_733sO-++SzR5v3w@mail.gmail.com>
Subject: Re: [PATCH/RFC] module: replace module_layout with module_memory
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 9, 2023 at 10:24 AM Song Liu <song@kernel.org> wrote:
>
> On Mon, Jan 9, 2023 at 10:03 AM Christophe Leroy
> <christophe.leroy@csgroup.eu> wrote:
> >
> >
> >
> > Le 06/01/2023 =C3=A0 23:09, Song Liu a =C3=A9crit :
> > > module_layout manages different types of memory (text, data, rodata, =
etc.)
> > > in one allocation, which is problematic for some reasons:
> > >
> > > 1. It is hard to enable CONFIG_STRICT_MODULE_RWX.
> > > 2. It is hard to use huge pages in modules (and not break strict rwx)=
.
> > > 3. Many archs uses module_layout for arch-specific data, but it is no=
t
> > >     obvious how these data are used (are they RO, RX, or RW?)
> > >
> > > Improve the scenario by replacing 2 (or 3) module_layout per module w=
ith
> > > up to 7 module_memory per module:
> > >
> > >          MOD_MEM_TYPE_TEXT,
> > >          MOD_MEM_TYPE_DATA,
> > >          MOD_MEM_TYPE_RODATA,
> > >          MOD_MEM_TYPE_RO_AFTER_INIT,
> > >          MOD_MEM_TYPE_INIT_TEXT,
> > >          MOD_MEM_TYPE_INIT_DATA,
> > >          MOD_MEM_TYPE_INIT_RODATA,
> > >
> > > and allocating them separately.
> > >
> > > Various archs use module_layout for different data. These data are pu=
t
> > > into different module_memory based on their location in module_layout=
.
> > > IOW, data that used to go with text is allocated with MOD_MEM_TYPE_TE=
XT;
> > > data that used to go with data is allocated with MOD_MEM_TYPE_DATA, e=
tc.
> >
> > I dislike how it looks with enums, things like
> > mod->mod_mem[MOD_MEM_TYPE_INIT_TEXT] are odd and don't read nicely.
> > Could we have something nicer like mod->mod_mem_init_text ?
> > I know it will complicate your for_each_mod_mem_type() but it would loo=
k
> > nicer.
>
> Hmm.. I am not sure whether we want 7 module_memory here. But if we
> agree that it looks better like that, I am ok with it.
>
> >
> > Also, can you explain how you switch from two trees to only one ?
> > As far as I remember, the same question arised when I implemented
> > CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC, and the conclusion was that
> > we had to keep two independant trees, so I'm a bit puzzled that you hav=
e
> > now merged everything into a single tree.
>
> AFAICT, we only need __module_address() to work? So one tree is enough.
> Did I miss something?

Do you mean one tree will cause addr_[min|max] to be inaccurate?

Thanks,
Song
