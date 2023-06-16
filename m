Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A45733562
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjFPQHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFPQG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:06:58 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72692119
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:06:56 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-25ec0b27e4fso336428a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686931616; x=1689523616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0G7Semk72J4t3p4kyn3yyN8DMzzZ6FPSFQ8xY4ugkA=;
        b=QJxa1vOcE8rQhWgizO0XuACCRpq0Uppp+jXsxnRuMncxkb5yrQAJI7qMt9LkqwDd7R
         PV4tqzr1iPuNsJDpvBqlHB3nUCCP+5vPD4k/JFpxC6D2gIqRxggYDkFesv3ZaS0K5JWR
         /wStYTXp5//TcktuJR64Fxd4pr2R0sEWY0m47BO9hDIuN63Ec8bwdE+rThvAM1ZuwIYB
         T4D7AS/ndymzYcYgPRbSXFzXppRmJq+lUstVt85ocmqnAIrsGY2pYWGxCV5+ba5qqfVe
         7asrMrMMPg+hNewml/KmL5O24wKjWcrKsI4SumLxsurmw4hkhn74w6QWTdZc48isQ1H9
         oVbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686931616; x=1689523616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i0G7Semk72J4t3p4kyn3yyN8DMzzZ6FPSFQ8xY4ugkA=;
        b=XnJZzc9zOk0+DDzjbMbQFVrUq9AKlMl5w30SCYpzA+9eMfLOfaJsF6OD+AdldalzvM
         R1I/5X2RFfhVcAo+PQMYl7r5rCkSzFltVFEI1upQa48gjWuLnBdPPrsrJ2QWub+SyGNk
         GgZ7ffBUtLMc0N96GUh/bzPahYOxpsL6LB8rgA43CEL67rODNKH3jqRhqFioYxwufpwm
         w1QDNgQXVprD5vQ/s7hh//yVM3ybG15RXLsmErnNXOojJ0UDAR0etYt83O8f6CXfqcPj
         61twcSt086j3f8jPKwUq2ehluT4bKieKAimv6cCGjb7Kma3WUMAk46Jd7zg8V8Kq2+Km
         wG4A==
X-Gm-Message-State: AC+VfDyQiXlSW/d2khioWUqgWHLpY6hYRUqmaGxES0O+cJE8D0BV/BPz
        c5+phDoKTDujvCD1xuqkIfLmNIxMR3GAZBP54H8=
X-Google-Smtp-Source: ACHHUZ4zyg1zxLBKfeGMzytzy/B6r1BRDnE5XaflvwrOKH/X5QyBu86XsC2LkWsG5g54K9PtAga9SKJKTFxIvXCStmo=
X-Received: by 2002:a17:90a:6c63:b0:25b:fbdc:dd8 with SMTP id
 x90-20020a17090a6c6300b0025bfbdc0dd8mr1991263pjj.24.1686931616191; Fri, 16
 Jun 2023 09:06:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230524153311.3625329-1-dhowells@redhat.com> <20230524153311.3625329-4-dhowells@redhat.com>
 <51161740e832334594960ed43430b868a6f892c3.camel@gmail.com> <617059.1686929309@warthog.procyon.org.uk>
In-Reply-To: <617059.1686929309@warthog.procyon.org.uk>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Fri, 16 Jun 2023 09:06:19 -0700
Message-ID: <CAKgT0Udfud_wVKLiZbi4Okuzor7OKzRi_PwvvCwnsiOdw7ir7A@mail.gmail.com>
Subject: Re: [PATCH net-next 03/12] mm: Make the page_frag_cache allocator
 alignment param a pow-of-2
To:     David Howells <dhowells@redhat.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Jeroen de Borst <jeroendb@google.com>,
        Catherine Sullivan <csully@google.com>,
        Shailend Chand <shailend@google.com>,
        Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 8:28=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
> Alexander H Duyck <alexander.duyck@gmail.com> wrote:
>
> > The requirement should only be cache alignment, not power of 2
> > alignment.
>
> Sure, but, upstream, page_frag_alloc_align() allows the specification of =
an
> alignment and applies that alignment by:
>
>         offset &=3D align_mask;
>
> which doesn't really make sense unless the alignment boils down to being =
a
> power of two.  Now, it might make sense to kill off the align_mask parame=
ter
> and just go with SMP_CACHE_BYTES (which will be a power of two).
>
> Note, though, that most users seem to use an align_mask of ~0u which feel=
s a
> bit dodgy (it's not an unsigned long), but is probably fine.

Yeah, now that I think about it this should be fine. I must have been
responding to this without enough sleep. When I originally read it I
saw it as limiting it to a power of 2 allocation, not limiting the
alignment mask to a power of 2.
