Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F447347A1
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 20:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjFRSc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 14:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjFRScy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 14:32:54 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56A0128
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 11:32:52 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-988b204ce5fso21160266b.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 11:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687113171; x=1689705171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=grb4k9rcKHfeGi29uyBKq1vskbqp8uHxrZwULjij13A=;
        b=5J+ByrPzzTeRM4palylTnHVbjrHE0spmjZPRD5L9SpVLaw8kfIRdoAGT7GF0HPE8ZH
         EL3j6NRD9AoMhmR6jLQGLeq1M6LmPHRG8qBJEHdbQeRAwI7lLvmfL06zMUFUncL33jhF
         tc5DrVR0arPD07AwL7LPRkhWoxRw3dcfKqz85Mzw3868vsi43gRSZ7obVrbiUkc66XYT
         +aDPfLsFNUjyKm7XTIfbHXuWphpiSzdL08Id9MWN9kImf7+DV/5SLQmls1R8iCNXgPUz
         YQn5/dAfD/reULvvHPQ1L0hs6CdMFVc6fKtQdFt/GYDRRmOscIBpOr1DYSfAssDUX1SF
         qWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687113171; x=1689705171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=grb4k9rcKHfeGi29uyBKq1vskbqp8uHxrZwULjij13A=;
        b=T2dQuJJOMyfpYjdCZGVaHSwsjVEkn7b4IMEnAQGxB2dgPsrc94fARGAXC/4ePu+yFL
         Y2TAbPHo9k9K4W9+zxM06MnH5sAZKOc7aR5tCWssZlHDpsvSy3s3lKgVRjowrMZuPX51
         HiTxsuMjh6RcfWlA5oJ+7htXC7v++wwblgYivc0M+ak6ICaKVM4r5WBwu816MZVRXhkc
         dr2DoBSU0z3pgTwDj7ZsDxlNt3/y12C2x8BJkArNTxanK1J772eHI1J55rk1Py8YJ15W
         +4+UkdkEt5qGe+WuRcymC/Cc8pdizLAPBiV7m4NGBf7lr+QQB/CfjNt8sg+/s/nMtVqi
         JUig==
X-Gm-Message-State: AC+VfDxdlRC8DnDbQ0huA5A4JDuuH4RcVfuryr8JQ+SIIzoIDvPM3oNv
        XAX9lUNMaVxLS5BARiwnARvcfU+qJItIdhNpnRl4Iw==
X-Google-Smtp-Source: ACHHUZ5lHTyUiE/kl2PsEqYfURKY54833RcnHytNpujvFfEXGhX0B5Iq4FG3i+Dhdx1dzL6ZONw1syDMnVoGChG0jHM=
X-Received: by 2002:a17:907:3f18:b0:978:6e73:e837 with SMTP id
 hq24-20020a1709073f1800b009786e73e837mr8777288ejc.4.1687113171090; Sun, 18
 Jun 2023 11:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230618065744.1363948-1-yosryahmed@google.com> <ZI7ocP/Jstx7TNDy@casper.infradead.org>
In-Reply-To: <ZI7ocP/Jstx7TNDy@casper.infradead.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Sun, 18 Jun 2023 11:32:14 -0700
Message-ID: <CAJD7tkYV-ffQChd3dAtf+4BFg+oywYTO-n826+f8rHXofYx33w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] mm/mlock: rework mlock_count to use _mapcount for
 order-0 folios
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>,
        "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>,
        Steven Barrett <steven@liquorix.net>,
        Brian Geffon <bgeffon@google.com>,
        "T.J. Alumbaugh" <talumbau@google.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        David Howells <dhowells@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Greg Thelen <gthelen@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Sun, Jun 18, 2023 at 4:20=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Sun, Jun 18, 2023 at 06:57:44AM +0000, Yosry Ahmed wrote:
> > @@ -337,6 +318,7 @@ struct folio {
> >                       atomic_t _entire_mapcount;
> >                       atomic_t _nr_pages_mapped;
> >                       atomic_t _pincount;
> > +                     atomic_t _mlock_count;
> >  #ifdef CONFIG_64BIT
> >                       unsigned int _folio_nr_pages;
> >  #endif
>
> You can't quite do this.  On 32-bt systems (I know, I know ...),
> we have:
>
> offset  page 0          page 1
> 0       flags           flags
> 4       lru             head
> 8       lru             dtor+order
> 12      mapping         entire_mapcount
> 16      index           nr_pages_napped
> 20      private         pincount
> 24      mapcount
> 28      refcount
>
> so it actually ends up overlapping page->mapcount on the second page,
> which is of course used for counting the number of PTEs which map
> that specific page.

Ah yeah, of course. In retrospect, it was very silly of me not to
notice given that I was modifying the mapcount handling code.

Thanks for pointing this out.

>
> I don't have a scenario where this would matter, but we are quite
> careful to only allocate order-2+ large folios, so I'd suggest putting
> it in page 2 instead of page 1.

Can you point me to the code that does so?

>
> I should probably add a comment to struct folio warning of this dragon.
> I thought the #ifdef CONFIG_64BIT would be enough to warn unwary
> passers-by of its presence, but a more explicit sign must be in order.
>

I saw the CONFIG_64BIT and spent some time trying to figure out why we
need it. I added the size of all explicit fields on 32-bit and they
were less than 32 bytes, so I was confused. I looked at the commit log
with no luck. I should have realized we should not overlay mapcount or
refcount. The presence of _mapcount_1/_refcount_1 fields could have
helped.

Anyway, we can also put it in page 1 inside #ifdef CONFIG_64BIT. We
will need a few extra #ifdef's in mm/mlock.c, and I think that's
pretty much it. For 32-bit, we can just keep piggybacking on mapcount
for all folios, I doubt a huge number of mappings is a concern for
32-bit anyway. I don't have a strong preference.
