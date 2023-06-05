Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24AA722DC6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 19:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235453AbjFERl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 13:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjFERlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 13:41:25 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848CDA7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 10:41:24 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-33dea7d5424so13275ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 10:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685986884; x=1688578884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yUlwMMqaluEB3AWNinGyHM3bHJ/UF1t/FsSOYIiiPMM=;
        b=M6gD9hlJsy3+TJwcnLpILZwULtc7C1TqflT7Pfga0o4ESzlP4U391BoeSYsksDGN/F
         B341ZnREgnGmTxL4nLBS5y9cRF59PrUGmX6zAIN/8zAF+vM1ZfOegutHOv58msDYo3nv
         jAAAZGZC1h5A//CG5E5uSvOVc/wvZSdIyorxF861vF5y1zQUqgiN6LZF9MqKUuO7pHqv
         jXnPoSUCP+nWJDq2oWoRlieK23UQWzrbpBTJf6k1TFtNE8zG67gLxIasBlZBN1lFtu33
         wY7vQJeCi0o30FvN5KwY3cXG/WW+pWWgiIGGAEtH/a5NydsxnoL261n8TB6+wirghPZ6
         R4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685986884; x=1688578884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yUlwMMqaluEB3AWNinGyHM3bHJ/UF1t/FsSOYIiiPMM=;
        b=SffyamAYFJIHoQqXdke3nPgqEZiCVd6rGD9kXGSBKvolbmYdnc4w4Iy5dQnv3VDpEX
         5hlaHrTQYs8xDNSSqi2rff5pAct+fKesSvfmGosflfNKKX+Pljz4lzjCpom+AqTAgC6n
         VOv3Cl8XLpD4MuppFHbC47DvATSKOupDBbhKevBuBI8ppkaxuYKlN6rTNr10NIB8jGYK
         PPRas5DhtOtzMdj1BCcTjwYfw19EXjR/SbCcCjS380B2lJKN932EPijeMkCugAAEYcax
         wSo6qji5piL4p4THwsi6DgJdSMgH5LZbgTknXPm6GPD7H905QgeGLPWgwObCKtTGXmpe
         TIaQ==
X-Gm-Message-State: AC+VfDz0neuma/7zQBdnE+uCP+SbASculLv4gJq6MRRubVzGq4tqbIjd
        24CX9ltK1D61VsIXxaADhUp8HHQWQU8G9eZqlKN26w==
X-Google-Smtp-Source: ACHHUZ5jQ3NkEGZGgoRgSUZ30SK3gCea2rTDuwmDigyULPEYu5r1QJOzgSbCpHM+v84nEvBwcShhVLR4ODOmDNQcQHI=
X-Received: by 2002:a05:6e02:20e4:b0:33d:4e7a:3dac with SMTP id
 q4-20020a056e0220e400b0033d4e7a3dacmr19385ilv.3.1685986883754; Mon, 05 Jun
 2023 10:41:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230523004312.1807357-1-pcc@google.com> <20230523004312.1807357-2-pcc@google.com>
 <20230605140554.GC21212@willie-the-truck>
In-Reply-To: <20230605140554.GC21212@willie-the-truck>
From:   Peter Collingbourne <pcc@google.com>
Date:   Mon, 5 Jun 2023 10:41:12 -0700
Message-ID: <CAMn1gO4k=rg96GVsPW6Aaz12c7hS0TYcgVR7y38x7pUsbfwg5A@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] mm: Call arch_swap_restore() from do_swap_page()
To:     Will Deacon <will@kernel.org>
Cc:     akpm@linux-foundation.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        =?UTF-8?B?UXVuLXdlaSBMaW4gKOael+e+pOW0tCk=?= 
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
        Alexandru Elisei <alexandru.elisei@arm.com>,
        eugenis@google.com, Steven Price <steven.price@arm.com>,
        stable@vger.kernel.org
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

On Mon, Jun 5, 2023 at 7:06=E2=80=AFAM Will Deacon <will@kernel.org> wrote:
>
> Hi Peter,
>
> On Mon, May 22, 2023 at 05:43:08PM -0700, Peter Collingbourne wrote:
> > Commit c145e0b47c77 ("mm: streamline COW logic in do_swap_page()") move=
d
> > the call to swap_free() before the call to set_pte_at(), which meant th=
at
> > the MTE tags could end up being freed before set_pte_at() had a chance
> > to restore them. Fix it by adding a call to the arch_swap_restore() hoo=
k
> > before the call to swap_free().
> >
> > Signed-off-by: Peter Collingbourne <pcc@google.com>
> > Link: https://linux-review.googlesource.com/id/I6470efa669e8bd2f841049b=
8c61020c510678965
> > Cc: <stable@vger.kernel.org> # 6.1
> > Fixes: c145e0b47c77 ("mm: streamline COW logic in do_swap_page()")
> > Reported-by: Qun-wei Lin (=E6=9E=97=E7=BE=A4=E5=B4=B4) <Qun-wei.Lin@med=
iatek.com>
> > Closes: https://lore.kernel.org/all/5050805753ac469e8d727c797c2218a9d78=
0d434.camel@mediatek.com/
> > Acked-by: David Hildenbrand <david@redhat.com>
> > Acked-by: "Huang, Ying" <ying.huang@intel.com>
> > Reviewed-by: Steven Price <steven.price@arm.com>
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > ---
> > v2:
> > - Call arch_swap_restore() directly instead of via arch_do_swap_page()
> >
> >  mm/memory.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index f69fbc251198..fc25764016b3 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -3932,6 +3932,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >               }
> >       }
> >
> > +     /*
> > +      * Some architectures may have to restore extra metadata to the p=
age
> > +      * when reading from swap. This metadata may be indexed by swap e=
ntry
> > +      * so this must be called before swap_free().
> > +      */
> > +     arch_swap_restore(entry, folio);
> > +
> >       /*
> >        * Remove the swap entry and conditionally try to free up the swa=
pcache.
> >        * We're already holding a reference on the page but haven't mapp=
ed it
>
> It looks like the intention is for this patch to land in 6.4, whereas the
> other two in the series could go in later, right? If so, I was expecting
> Andrew to pick this one up but he's not actually on CC. I've added him no=
w,
> but you may want to send this as a separate fix so it's obvious what need=
s
> picking up for this cycle.

I was expecting that this whole series could be picked up in mm. There
was a previous attempt to apply v3 of this series to mm, but that
failed because a dependent patch (commit c4c597f1b367 ("arm64: mte: Do
not set PG_mte_tagged if tags were not initialized")) hadn't been
merged into Linus's master branch yet. The series should be good to go
in now that that patch has been merged.

Peter
