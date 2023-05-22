Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A18E70CF2A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 02:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235187AbjEWAZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 20:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234894AbjEWAGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 20:06:30 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2CF1BCA
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 16:45:16 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-3f6b679b357so38341cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 16:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684799115; x=1687391115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krhUajFGwK9L4o6aKxZVhfmKxVJjexnutJuCxQxG8Gg=;
        b=1RihYSk6Zvns0JROPxQYk0Fcpayju51Z23Rlq8vH615/5q/51u3Z9nDKo4XsyRsvLC
         57zj7WOOobI4CjKqY9mfJJU2hUrqCC7k1V7Nm/p8f06nWwps7cEdhSYj2Ai8BLC+oBlh
         TBINzV5AAn6g3j5T4NvLJfWkp6OapPffbMoDmGyaSSos/gP3RPmd1OJTgNxrJrhevCAY
         sMUKJoFw+PNZqTV9hMNlsJAN2ZpF1nxeBlGjqwJUg8qwFxl1rYmliIEFbAuxPIBTQEuZ
         2Ai+XsSE1Q9DB+wyIi3zbWaw0i9YTfbJV8V6hBlze8sROH/ZR+LAfmGkxN06hca93jBd
         tR9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684799115; x=1687391115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=krhUajFGwK9L4o6aKxZVhfmKxVJjexnutJuCxQxG8Gg=;
        b=K/o7AH3BJKvc2piqkkD2CFttysdBbO3Ebw2zgWMmvQbycF9kJRFPGu0vWQYanO1qFi
         f6xlr+5qkHWU+jtr5Qb57DKIhnFGpl7Z8zdRAJo6MA0Vv8Z/CmB0mZLH+s4/jxkNqNZn
         FtFxxRmTlmBR3L5zUjiasX+datzZQ2Sg409Fg+3ObmN3EVjfxVPrb+vkfHl7MO1adTzy
         vFN+uBEHHCdLiEHyiD/rIgHqFkGkPpxN5q5wow1Nm3F4/0/ClYU1cO9mnomg1sCROly+
         LmAUdTO2/4Om7dEsSCNiTUpxNRHezg+KhN5462IrQDs+8p7LVv0g7yoF65nuuJqe6Nu2
         mHDg==
X-Gm-Message-State: AC+VfDxOoaK9swXrYjo+GYlWJGEYzq+QCNHZsGkA705DVOGQ4GlBsjPR
        UHgVWsuuWNa0TvFX+tbZaY8xY4aBSP5SbDkfHqat1w==
X-Google-Smtp-Source: ACHHUZ7wBfGgsdy00R8ePI1bWfcVg1wI7q3Fky9eoCR908S8bzONaFI1Zv2vSD88c686ebxubQflLWpRUlZrF7OUwPk=
X-Received: by 2002:ac8:598e:0:b0:3ed:86f6:6eab with SMTP id
 e14-20020ac8598e000000b003ed86f66eabmr104822qte.14.1684799115109; Mon, 22 May
 2023 16:45:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230517022115.3033604-1-pcc@google.com> <20230517022115.3033604-4-pcc@google.com>
 <ZGepsWDEfG+gk/t3@arm.com>
In-Reply-To: <ZGepsWDEfG+gk/t3@arm.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Mon, 22 May 2023 16:45:03 -0700
Message-ID: <CAMn1gO4pWpcu_F_vbfeURQX85hp9aRLWTwDyDRB=eZEKM_hb9A@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] arm64: mte: Simplify swap tag restoration logic
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     =?UTF-8?B?UXVuLXdlaSBMaW4gKOael+e+pOW0tCk=?= 
        <Qun-wei.Lin@mediatek.com>, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "surenb@google.com" <surenb@google.com>,
        "david@redhat.com" <david@redhat.com>,
        =?UTF-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?= 
        <chinwen.chang@mediatek.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        =?UTF-8?B?S3Vhbi1ZaW5nIExlZSAo5p2O5Yag56mOKQ==?= 
        <Kuan-Ying.Lee@mediatek.com>,
        =?UTF-8?B?Q2FzcGVyIExpICjmnY7kuK3mpq4p?= <casper.li@mediatek.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        vincenzo.frascino@arm.com,
        Alexandru Elisei <alexandru.elisei@arm.com>, will@kernel.org,
        eugenis@google.com, Steven Price <steven.price@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

On Fri, May 19, 2023 at 9:54=E2=80=AFAM Catalin Marinas <catalin.marinas@ar=
m.com> wrote:
>
> On Tue, May 16, 2023 at 07:21:13PM -0700, Peter Collingbourne wrote:
> > As a result of the previous two patches, there are no circumstances
> > in which a swapped-in page is installed in a page table without first
> > having arch_swap_restore() called on it. Therefore, we no longer need
> > the logic in set_pte_at() that restores the tags, so remove it.
> >
> > Because we can now rely on the page being locked, we no longer need to
> > handle the case where a page is having its tags restored by multiple ta=
sks
> > concurrently, so we can slightly simplify the logic in mte_restore_tags=
().
> [...]
> > diff --git a/arch/arm64/mm/mteswap.c b/arch/arm64/mm/mteswap.c
> > index cd508ba80ab1..3a78bf1b1364 100644
> > --- a/arch/arm64/mm/mteswap.c
> > +++ b/arch/arm64/mm/mteswap.c
> > @@ -53,10 +53,9 @@ void mte_restore_tags(swp_entry_t entry, struct page=
 *page)
> >       if (!tags)
> >               return;
> >
> > -     if (try_page_mte_tagging(page)) {
> > -             mte_restore_page_tags(page_address(page), tags);
> > -             set_page_mte_tagged(page);
> > -     }
> > +     WARN_ON_ONCE(!try_page_mte_tagging(page));
> > +     mte_restore_page_tags(page_address(page), tags);
> > +     set_page_mte_tagged(page);
> >  }
>
> Can we have a situation where two processes share the same swap pte
> (CoW) and they both enter the do_swap_page() or the unuse_pte() paths
> triggering this warning?

Having examined the code more closely, I realized that this is
possible with two do_swap_page() calls on CoW shared pages (or
do_swap_page() followed by unuse_pte()), because the swapcache page
will be shared between the tasks and so they will both call
arch_swap_restore() on the same page. I was able to provoke the
warning with the following program:

#include <sys/mman.h>
#include <unistd.h>

int main() {
  char *p =3D mmap(0, 4096, PROT_READ|PROT_WRITE|PROT_MTE,
MAP_ANON|MAP_PRIVATE, -1, 0);
  p[0] =3D 1;
  madvise(p, 4096, MADV_PAGEOUT);
  fork();
  return p[0];
}

I will send a v4 with this hunk removed.

> Other than that, the looks nice, it simplifies the logic and probably
> saves a few cycles as well on the set_pte_at() path.
>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks for the review!

Peter
