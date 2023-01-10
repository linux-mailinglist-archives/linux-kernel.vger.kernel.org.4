Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C02663985
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 07:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjAJGv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 01:51:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjAJGvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 01:51:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1E6C02;
        Mon,  9 Jan 2023 22:51:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E00AFB81112;
        Tue, 10 Jan 2023 06:51:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92558C43396;
        Tue, 10 Jan 2023 06:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673333488;
        bh=UM6JFDUfiN86MtEOn9iLMKaVuAuSP2hILh1bak8qWto=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CoyFAWt6tZBTDdWEgTu9Nco8C4VHCxfO7j2YhBir+0+uVM6tsdtnCOeBNNdJLyibV
         GWz8buOdQzBtlmLHMv73PStyjnMLPp4eqB1mAyijoVOisad+Nw2eTpyBRMONox0Ls0
         eRDV/q9sAqr3WtxScSzKiTv4L0a6KhpmYMespOrGxvgU9WaA3TOkzBlHK9BR7PHhrm
         BWYF0RyKmduL5jMOtatw059jsaDMnItyi7aFkYXlrwdNPUzlofG/kpcODnUf2816D0
         Ut20gixS52sBKK/ykvjMJvpaqfH26atw9rjap7MGlaZw9e6t/dmQgVIn9OQrPM+E2J
         OeamWiyQel2tg==
Received: by mail-lf1-f45.google.com with SMTP id bq39so16881065lfb.0;
        Mon, 09 Jan 2023 22:51:28 -0800 (PST)
X-Gm-Message-State: AFqh2krrobVaKEnDGBXRzsUL56RHJTQZPDGDJTpDUyZj8o9LggSZh+NI
        tBr5Fc+Uex2XzAHe8zZLacO5cKGQE5AmR9Z7gS0=
X-Google-Smtp-Source: AMrXdXvU1XkJruoPQt17VhQJzStIsNWVLxHQu9Lb3RioSoxSucgOjW8aYRiDNnKObY4DhbK3PUuAk+t+vfWQsv3ymQk=
X-Received: by 2002:ac2:4a8d:0:b0:4a2:4282:89c7 with SMTP id
 l13-20020ac24a8d000000b004a2428289c7mr5035928lfp.437.1673333486519; Mon, 09
 Jan 2023 22:51:26 -0800 (PST)
MIME-Version: 1.0
References: <20230106220959.3398792-1-song@kernel.org> <83941b74-7585-235b-ee54-3b127ca70d9e@csgroup.eu>
 <CAPhsuW6S8qJWFzSLpVf_4ZpyM0Cxty=-pS2_K=tgF52s95Zhag@mail.gmail.com>
 <CAPhsuW7+BG9wYaoD6EYH-jnWqX30JdgNr5_733sO-++SzR5v3w@mail.gmail.com> <154ed99c-5877-35f6-5e7d-9d7abada7d33@csgroup.eu>
In-Reply-To: <154ed99c-5877-35f6-5e7d-9d7abada7d33@csgroup.eu>
From:   Song Liu <song@kernel.org>
Date:   Mon, 9 Jan 2023 22:51:14 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7tio5-mENPBCfMsULRhoVnGMJKsEoi95ANpyCw9YxjZQ@mail.gmail.com>
Message-ID: <CAPhsuW7tio5-mENPBCfMsULRhoVnGMJKsEoi95ANpyCw9YxjZQ@mail.gmail.com>
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

On Mon, Jan 9, 2023 at 10:31 PM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 09/01/2023 =C3=A0 21:51, Song Liu a =C3=A9crit :
> > On Mon, Jan 9, 2023 at 10:24 AM Song Liu <song@kernel.org> wrote:
> >>
> >> On Mon, Jan 9, 2023 at 10:03 AM Christophe Leroy
> >> <christophe.leroy@csgroup.eu> wrote:
> >>>
> >>>
> >>>
> >>> Le 06/01/2023 =C3=A0 23:09, Song Liu a =C3=A9crit :
> >>>> module_layout manages different types of memory (text, data, rodata,=
 etc.)
> >>>> in one allocation, which is problematic for some reasons:
> >>>>
> >>>> 1. It is hard to enable CONFIG_STRICT_MODULE_RWX.
> >>>> 2. It is hard to use huge pages in modules (and not break strict rwx=
).
> >>>> 3. Many archs uses module_layout for arch-specific data, but it is n=
ot
> >>>>      obvious how these data are used (are they RO, RX, or RW?)
> >>>>
> >>>> Improve the scenario by replacing 2 (or 3) module_layout per module =
with
> >>>> up to 7 module_memory per module:
> >>>>
> >>>>           MOD_MEM_TYPE_TEXT,
> >>>>           MOD_MEM_TYPE_DATA,
> >>>>           MOD_MEM_TYPE_RODATA,
> >>>>           MOD_MEM_TYPE_RO_AFTER_INIT,
> >>>>           MOD_MEM_TYPE_INIT_TEXT,
> >>>>           MOD_MEM_TYPE_INIT_DATA,
> >>>>           MOD_MEM_TYPE_INIT_RODATA,
> >>>>
> >>>> and allocating them separately.
> >>>>
> >>>> Various archs use module_layout for different data. These data are p=
ut
> >>>> into different module_memory based on their location in module_layou=
t.
> >>>> IOW, data that used to go with text is allocated with MOD_MEM_TYPE_T=
EXT;
> >>>> data that used to go with data is allocated with MOD_MEM_TYPE_DATA, =
etc.
> >>>
> >>> I dislike how it looks with enums, things like
> >>> mod->mod_mem[MOD_MEM_TYPE_INIT_TEXT] are odd and don't read nicely.
> >>> Could we have something nicer like mod->mod_mem_init_text ?
> >>> I know it will complicate your for_each_mod_mem_type() but it would l=
ook
> >>> nicer.
> >>
> >> Hmm.. I am not sure whether we want 7 module_memory here. But if we
> >> agree that it looks better like that, I am ok with it.
> >>
> >>>
> >>> Also, can you explain how you switch from two trees to only one ?
> >>> As far as I remember, the same question arised when I implemented
> >>> CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC, and the conclusion was tha=
t
> >>> we had to keep two independant trees, so I'm a bit puzzled that you h=
ave
> >>> now merged everything into a single tree.
> >>
> >> AFAICT, we only need __module_address() to work? So one tree is enough=
.
> >> Did I miss something?
> >
> > Do you mean one tree will cause addr_[min|max] to be inaccurate?
> >
>
> Yes at least. On powerpc you will have module text below kernel,
> somewhere between 0xb0000000 and 0xcfffffff, and you will have module
> data in vmalloc area, somewhere between 0xf0000000 and 0xffffffff.
>
> If you have only one tree, any address between 0xc0000000 and 0xefffffff
> will trigger a tree search.

Do we use this part of the address space and call __module_address()?
If so, we can problem solve it with secondary addr_[min|max]. If we don't
really use these addresses, we can probably just ignore it?

Thanks,
Song
