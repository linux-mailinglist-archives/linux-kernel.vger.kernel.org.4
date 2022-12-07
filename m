Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD71D646556
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 00:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiLGXpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 18:45:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiLGXpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 18:45:36 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195298AAFE
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 15:45:36 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-3c090251d59so203925567b3.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 15:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mXsz6/Icjh465llNxu4s0rXYIhAO+R+B34XNkGIo6eQ=;
        b=Be1pHwvM4e7ouSG+ZY6N9k/NiEQ4tzzDVuXyq4CEbwd9ADrS9FJ3QaPyXtXz2d1OdS
         qYzdxL6v4h/5A9aQJcky67nIla75qGdrJ85MwA1KqQc3qgPS4YtS4Vut3e6qnGU82G3o
         lQHWwLuJtztifl8vYx5gAgBC8BNMgctCbp72zj3JslJx5k3nQosHW4HKSGteEit76fR3
         Yc0mGCeHk7bo4xicAjtUfwALdzwuGnKwQvDu1x0nLwq6Qb3WzoqCxfZ4zEUbgJXsd/oH
         bmeiO9/QSI7+8qvg60KDx7Ti9ptHefiR2pn2ij2Gs6XWpl2Ld/c0+UgyzbpAfe7ooJHE
         Ca0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mXsz6/Icjh465llNxu4s0rXYIhAO+R+B34XNkGIo6eQ=;
        b=IeuHeVqE1GozpFrIG14dqq9xkZLIczJmxTjDsCnFWKYCEG9MKRoTG1nVMBHkh2cd3z
         H2/UJGIl6qvAVhja2lgu9rNC3qeB7UfZBCzYtOU8xSG12UxWoUEvpPdAEFnNc7sjC9fZ
         jKwCXHMf3e27mKQ1AK+t71mfRrvkSymHBQyL1Kn5vlCZD3gbE7UdA8A6l6/zlRgt45xK
         PawtNqCzsC1ShwZeIlYmOlSBuu8dnG+iAafaz+KEJTd6u3QBV3dhXaSYjqvfgiPg6nEs
         a8zgS1dku09Xky9n43n8MiUn3jP3Ca1hzmSWVsMhOAiY27mkIz1Ks3ReRq6cWU6xa1MZ
         7yOQ==
X-Gm-Message-State: ANoB5pmPRkj6nN/Ffu2DJXqOca6bx9qGBX9ZKpL1C4hrdPCLSED3To50
        BpZM3ogRQycUIYG5MiqyfxYpkdmziaj3Jf0oU7/YW1IU17M=
X-Google-Smtp-Source: AA0mqf52bzfVlI6LIM25NDvI3hhBqrvEmEgMvsJj/HL3v965u91m6cU3HIkbbbsGBTFyKyJOp/lVfoCS00snfAfx8RU=
X-Received: by 2002:a0d:cb43:0:b0:368:e8a:3b1d with SMTP id
 n64-20020a0dcb43000000b003680e8a3b1dmr21578440ywd.469.1670456735268; Wed, 07
 Dec 2022 15:45:35 -0800 (PST)
MIME-Version: 1.0
References: <20221207230152.22938-1-vishal.moola@gmail.com>
 <20221207230152.22938-2-vishal.moola@gmail.com> <Y5EdR1l1Ho3FyrY3@casper.infradead.org>
In-Reply-To: <Y5EdR1l1Ho3FyrY3@casper.infradead.org>
From:   Vishal Moola <vishal.moola@gmail.com>
Date:   Wed, 7 Dec 2022 15:45:24 -0800
Message-ID: <CAOzc2pynRnO9ME5L2VohYUU_qSWcL14cwBsGPNGWW7XJPVo3HA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] madvise: Convert madvise_cold_or_pageout_pte_range()
 to use folios
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, damon@lists.linux.dev,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        sj@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 7, 2022 at 3:09 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Dec 07, 2022 at 03:01:50PM -0800, Vishal Moola (Oracle) wrote:
> > @@ -424,28 +425,29 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
> >               page = vm_normal_page(vma, addr, ptent);
> >               if (!page || is_zone_device_page(page))
> >                       continue;
> > +             folio = page_folio(page);
>
> Maybe we should add a vm_normal_folio() first?  That way we could get
> rid of the 'struct page' in this function entirely.

Yeah, I'll do that. Many other callers will benefit from it later as well.

> > @@ -453,13 +455,13 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
> >               }
> >
> >               /*
> > -              * Do not interfere with other mappings of this page and
> > -              * non-LRU page.
> > +              * Do not interfere with other mappings of this folio and
> > +              * non-LRU folio.
> >                */
> > -             if (!PageLRU(page) || page_mapcount(page) != 1)
> > +             if (!folio_test_lru(folio))
>
> Why has the test for folio_mapcount() disappeared?

Oops, that page_mapcount() should have been replaced
with a folio_mapcount(). It appears I accidentally removed it.
