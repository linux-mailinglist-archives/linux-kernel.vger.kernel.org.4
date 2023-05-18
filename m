Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AABD1708827
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 21:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjERTBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 15:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjERTBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 15:01:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15476130
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 12:01:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5BE465149
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 19:01:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0977CC4339C
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 19:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684436500;
        bh=3L8pliCTcYUFN6WVwRXOTT1aMopsshjE7du+I5x8OKw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WHGVaGT8oxG3wdGdjq3yn6h/fsfp7MDD9K73/F0qNr9Mq+dI33dNnQkopLjyRY2Mz
         SPocIESAQofhxJRhJt3Cw9WIRZM6i+r1Qt2cgMM0h49RIpW3n1G2on4A72DQEY9qa/
         /pJsEkH5HaIPTQf5sU2y7JofD7s7K6ApwWyGxXehLq76i23OgJWBtqx/o0VYHhw3Hy
         MNEfwtKR827qCIlE2WhLodkk2XgzZhQsySquNW5SVf8PnnBdMPFpyw6JGmgAiew6LW
         3gkNDrrz8civpViRf++fnK5JCpy9M9bb9n3qvM1DuSxW7dfuLHDgRZyozoPdb31o01
         N2FQyOgj3BYwA==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-4ec8eca56cfso2739346e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 12:01:39 -0700 (PDT)
X-Gm-Message-State: AC+VfDxtU+MxUkZU1B/0GrT/YXeYW7610puUeBhPC5BBJrPTeAg8aUEI
        NmgfQGUikLFfi0xIPT7uvOSzAEF26p8JXS6pHCk=
X-Google-Smtp-Source: ACHHUZ5UXg1eeNGVLZjwNMxRFsYhtB74PojLRAdmrB5ozRnZzqbdO3B1Ji+4jthPGpZmNv80z+cnzCKVNY6FTQuBjDQ=
X-Received: by 2002:ac2:4198:0:b0:4ec:8245:3986 with SMTP id
 z24-20020ac24198000000b004ec82453986mr68503lfh.14.1684436498062; Thu, 18 May
 2023 12:01:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230308094106.227365-1-rppt@kernel.org> <20230308094106.227365-2-rppt@kernel.org>
 <ZGWdHC3Jo7tFUC59@moria.home.lan> <20230518152354.GD4967@kernel.org>
 <CAPhsuW541pcsMKYah=2U8mUs8is3jAiNKC8Erte=RkAUGFO9EA@mail.gmail.com> <ZGZZIM0qftr0T59b@moria.home.lan>
In-Reply-To: <ZGZZIM0qftr0T59b@moria.home.lan>
From:   Song Liu <song@kernel.org>
Date:   Thu, 18 May 2023 12:01:26 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7yz4iOuDaA_eH2aWsY7B_NQayW1WGZ_1qYepur_4KOsQ@mail.gmail.com>
Message-ID: <CAPhsuW7yz4iOuDaA_eH2aWsY7B_NQayW1WGZ_1qYepur_4KOsQ@mail.gmail.com>
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
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 9:58=E2=80=AFAM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Thu, May 18, 2023 at 09:33:20AM -0700, Song Liu wrote:
> > I am working on patches based on the discussion in [1]. I am planning t=
o
> > send v1 for review in a week or so.
>
> For reference, here's my own (early, but functioning :) slab allocator:
>
> Look forward to comparing!
> -->--
> From 6eeb6b8ef4271ea1a8d9cac7fbaeeb7704951976 Mon Sep 17 00:00:00 2001
> From: Kent Overstreet <kent.overstreet@linux.dev>
> Date: Wed, 17 May 2023 01:22:06 -0400
> Subject: [PATCH] mm: jit/text allocator
>
> This provides a new, very simple slab allocator for jit/text, i.e. bpf,
> ftrace trampolines, or bcachefs unpack functions.
>
> With this API we can avoid ever mapping pages both writeable and
> executable (not implemented in this patch: need to tweak
> module_alloc()), and it also supports sub-page sized allocations.
>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>

[...]

> +static void *jit_cache_alloc(void *buf, size_t len, struct jit_cache *ca=
che)
> +{
> +       struct jit_slab *s =3D
> +               list_first_entry_or_null(&cache->partial, struct jit_slab=
, list) ?:
> +               jit_slab_alloc(cache);
> +       unsigned obj_idx, nr_allocated;
> +
> +       if (!s)
> +               return NULL;
> +
> +       obj_idx =3D find_first_zero_bit(s->objs_allocated, cache->objs_pe=
r_slab);
> +
> +       BUG_ON(obj_idx >=3D cache->objs_per_slab);
> +       __set_bit(obj_idx, s->objs_allocated);
> +
> +       nr_allocated =3D bitmap_weight(s->objs_allocated, s->cache->objs_=
per_slab);
> +
> +       if (nr_allocated =3D=3D s->cache->objs_per_slab) {
> +               list_del_init(&s->list);
> +       } else if (nr_allocated =3D=3D 1) {
> +               list_del(&s->list);
> +               list_add(&s->list, &s->cache->partial);
> +       }
> +
> +       return s->executably_mapped + (obj_idx << cache->obj_size_bits);
> +}

IIUC, "len" is ignored in jit_cache_alloc(), so it can only handle
<=3D16 byte allocations?

Thanks,
Song
