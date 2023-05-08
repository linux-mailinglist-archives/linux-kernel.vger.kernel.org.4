Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306B36FBB71
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 01:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbjEHXbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 19:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjEHXba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 19:31:30 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9A58A7C
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 16:31:28 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-966400ee79aso422924066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 16:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683588687; x=1686180687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GzMdbVoG745mJfyVZSyS1nRnxpcs6VHM3XhP7lUUdDQ=;
        b=EVdymPSG23QfghUkIUf8ZhcmeXUCgHuCw1IiMb8Vj4PhRgui9cH5rE5ffvbqgnPTcz
         xUIZCaZn+407Ynq8/A/b0PnAeNJ5iBhy6TMJQIY6CtkVDHXdjZXY1O3l0QdwOj3H39Dv
         1+LjQeDxMoasrDgf2fNGyMxSiQFCLF033ClzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683588687; x=1686180687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GzMdbVoG745mJfyVZSyS1nRnxpcs6VHM3XhP7lUUdDQ=;
        b=OL3NZGaacHLc4BFQ9e430PbsdUUuFybdXvuTPSTd0I0Ad+ZFSRdJZVmFadKOkd0q7o
         YfYRI4va4MDLPgv4WYEaJNKnBEqlBjuxNlgHadd/dBbul30qx8bu3c8zIU+mt2FBnUqH
         g31eMKJMtF37GOjqrqr5r3UnkipRpwKsOpxwnVgRGcDzrhvJvs+HGN/FfLPqzjb85e96
         mJhhi4aPORo5qB4oeSke7h47GKtwlJnbrlr0pbVXWQt6gTfqQjcr300ZhGU6Wi4vcZDK
         qw3l6pYdbVbLVV9k2lJdcbafgy7TmVuWQLl/l4IX+XnjGWwUdYGnxUzIfpsN4x6emHib
         5nww==
X-Gm-Message-State: AC+VfDwie75hVKge8yu7R6b/WK35SB+PgVP96BhV6jv/PD5ZkVNamwFu
        vnHq/Qj0bgbiTh4PDhkKbhwdQg4Dj+kbu0p5ZN3yXg==
X-Google-Smtp-Source: ACHHUZ6q8ZEDx7ORW7FLuAGaRnXuNxss/rSPh1Fp8rAYsvgx812gGxkoTcjDR/XVbJCNp3FN5yoKpg==
X-Received: by 2002:a17:906:478f:b0:94e:b3a1:3ed9 with SMTP id cw15-20020a170906478f00b0094eb3a13ed9mr11286265ejc.49.1683588687176;
        Mon, 08 May 2023 16:31:27 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id y10-20020a170906914a00b009663cf5dc3bsm559683ejw.53.2023.05.08.16.31.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 16:31:26 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-96622bca286so516568566b.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 16:31:26 -0700 (PDT)
X-Received: by 2002:a17:907:84a:b0:94e:bc04:c6f6 with SMTP id
 ww10-20020a170907084a00b0094ebc04c6f6mr9181954ejb.9.1683588686119; Mon, 08
 May 2023 16:31:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230424212130.590684-1-dave.hansen@linux.intel.com>
 <CAHk-=whn3F1k263SZNUVQK195tcCMAo5E_WbmjUE0qFC5rWg=w@mail.gmail.com>
 <4433c3595db23f7c779b69b222958151b69ddd70.camel@intel.com>
 <148b3edb-b056-11a0-1684-6273a4a2d39a@intel.com> <CAHk-=wiuVXTfgapmjYQvrEDzn3naF2oYnHuky+feEJSj_G_yFQ@mail.gmail.com>
 <CAHk-=wiB0wy6oXOsPtYU4DSbqJAY8z5iNBKdjdOp2LP23khUoA@mail.gmail.com> <4171c4b0-e24b-a7e2-9928-030cc14f1d8d@intel.com>
In-Reply-To: <4171c4b0-e24b-a7e2-9928-030cc14f1d8d@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 8 May 2023 16:31:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiVLvz3RdZiSjLNGKKgR3s-=2goRPnNWg6cbrcwMVvndQ@mail.gmail.com>
Message-ID: <CAHk-=wiVLvz3RdZiSjLNGKKgR3s-=2goRPnNWg6cbrcwMVvndQ@mail.gmail.com>
Subject: Re: [GIT PULL] x86/shstk for 6.4
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 8, 2023 at 3:57=E2=80=AFPM Dave Hansen <dave.hansen@intel.com> =
wrote:
>
> There's a wrinkle to enforcing that universally.  From the SDM's
> "ACCESSED AND DIRTY FLAGS" section:
>
>         If software on one logical processor writes to a page while
>         software on another logical processor concurrently clears the
>         R/W flag in the paging-structure entry that maps the page,
>         execution on some processors may result in the entry=E2=80=99s di=
rty
>         flag being set.

I was actually wondering about that.

I had this memory that we've done special things in the past to make
sure that the dirty bit is guaranteed stable (ie the whole
"ptep_clear()" dance). But I wasn't sure.

> This behavior is gone on shadow stack CPUs

Ok, so Intel has actually tightened up the rules on setting dirty, and
now guarantees that it will set dirty only if the pte is actually
writable?

> We could probably tolerate the cost for some of the users like ksm.  But
> I can't think of a way to do it without making fork() suffer.  fork() of
> course modifies the PTE (RW->RO) and flushes the TLB now.  But there
> would need to be a Present=3D0 PTE in there somewhere before the TLB flus=
h.

Yeah, we don't want to make fork() any worse than it already is.  No
question about that.

But if we make the rule be that having the exact dirty bit vs rw bit
semantics only matters for CPUs that do the shadow stack thing, and on
*those* CPU's it's ok to not go through the dance, can we then come up
with a sequence that works for everybody?

> So, the rule would be something like:
>
>         The *kernel* will never itself create Write=3D0,Dirty=3D1 PTEs
>
> That won't prevent the hardware from still being able to do it behind
> our backs on older CPUs.  But it does avoid a few of the special cases.

Right. So looking at the fork() case as a nasty example, right now we have

        ptep_set_wrprotect()

on the source pte of a fork(), which atomically just clears the WRITE
bit (and thus guarantees that dirty bits cannot get lost, simply
because it doesn't matter if some other CPU atomically sets another
bit concurrently).

On the destination we don't have any races with concurrent accesses,
and just do entirely non-atomic

                pte =3D pte_wrprotect(pte);

and then eventually (after other bit games) do

        set_pte_at(dst_vma->vm_mm, addr, dst_pte, pte);

and basically you're saying that there is no possible common sequence
for that ptep_set_wrprotect() that doesn't penalize some case.

Hmm.

Yeah, right now the non-shadow-stack ptep_set_wrprotect() can just be
an atomic clear_bit(), which turns into just

        lock andb $-3, (%reg)

and I guess that would inevitably become a horror of a cmpxchg loop
when you need to move the dirty bit to the SW dirty on CPU's where the
dirty bit can come in late.

How very very horrid.

                     Linus
