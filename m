Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755E169DC66
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 09:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233809AbjBUItS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 03:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233762AbjBUItO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 03:49:14 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D0D234E6;
        Tue, 21 Feb 2023 00:49:12 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id h17so514442qka.11;
        Tue, 21 Feb 2023 00:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wJTfMbj3kGNnK1JU4uoKAn7SrV5lBQ6hVKEJS0vCxoI=;
        b=Bqg/aM/IFmI0qVOd2/CGhR0Xytmmr3xKb+/LYy0LImlJx3XcLV4PelQxa25cVs9adf
         bmpYOjsHSBTOgeH0rUE5anZIz5oAg9CVy90hMXGZ/YxMaLQwU9t1xZSc//EUUYIcWHna
         YvIszHxP2dhQwZMU0oxUxJfjqu1kkzUA/OEgJ81iRgfn4FP2TbKcUs2/w00zIXX7CIor
         5GyV64R8qnW14Mhdf7tq0EFcnWLZR+jK1+7QuvX7N4WFHBQrffkP70xjXHJzzd561v1X
         J2GchTaK+NmreWGaKfELFboXg0yu5K+NPetd1n+eY46qFMxoinkAgMU5wkhyEolEvV2A
         8ysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wJTfMbj3kGNnK1JU4uoKAn7SrV5lBQ6hVKEJS0vCxoI=;
        b=niVz+15yNNZkcYZq2zQW6dkNEFBpj4tkEsajbWSrx0pTT44TQdLGmiq8aM680v2H+Y
         siAoI2GNuCBE8PKAOUnYsXWGfbkJ4ssuP+csdi28DLdGAnpHAhIKpaFxiUZqcFgDI67G
         I7Cwg+UDQ6nLIXmcZVl+UkuiGCVlC6vrVHAqC4FvqXJV+WCVONSBOoI/4bRoajGaeTQJ
         uhDcMo3PQrcwX00QvEb4p5IXD/oqwqMqL/W2YddnzMfHaC4wkZzEDAd+4/EG87+RAMGZ
         oN7ruO9n0mkLgD/BK5FKfYsR9eV4yJfhd/HQSQ0TovXpS7oyq7Cbvlw4DwQ+WEaC4OuM
         zKYg==
X-Gm-Message-State: AO0yUKXL1vVTc8gbCD3uoQiuCwVan7M0sN3RCZ1j0b2T7GTpQRMSoyFw
        KXb0PSLXQhmUFmhLhqYzxmSuKMBn2f0SzLBPTdg=
X-Google-Smtp-Source: AK7set/rSUhxo3ewnvZBvtzLapNPE97O8LKPSnmQmOIGb1kxtIGRKkTUZD2aipJroPFBNTw9cfd9OyZ/HsTXfTOHUqA=
X-Received: by 2002:a05:620a:2092:b0:733:4e2d:7834 with SMTP id
 e18-20020a05620a209200b007334e2d7834mr305494qka.4.1676969351705; Tue, 21 Feb
 2023 00:49:11 -0800 (PST)
MIME-Version: 1.0
References: <20230219073318.366189-1-nphamcs@gmail.com> <20230219073318.366189-2-nphamcs@gmail.com>
 <Y/IQlWdD1NvcUROv@casper.infradead.org>
In-Reply-To: <Y/IQlWdD1NvcUROv@casper.infradead.org>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Tue, 21 Feb 2023 00:49:00 -0800
Message-ID: <CAKEwX=NfD-57zAgXBoCVFVHu_TDbbnng3piZTu7iGjALpj=Tug@mail.gmail.com>
Subject: Re: [PATCH v10 1/3] workingset: refactor LRU refault to expose
 refault recency check
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com, arnd@arndb.de,
        linux-api@vger.kernel.org, kernel-team@meta.com
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

On Sun, Feb 19, 2023 at 4:05 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sat, Feb 18, 2023 at 11:33:16PM -0800, Nhat Pham wrote:
> > +++ b/mm/workingset.c
> > @@ -244,6 +244,30 @@ static void *lru_gen_eviction(struct folio *folio)
> >       return pack_shadow(mem_cgroup_id(memcg), pgdat, token, refs);
> >  }
> >
> > +/*
> > + * Test if the folio is recently evicted.
> > + *
> > + * As a side effect, also populates the references with
> > + * values unpacked from the shadow of the evicted folio.
> > + */
>
> I find this comment hard to understand.  First it talks about "the
> folio", but it doesn't pass a folio.  Then it talks about "the
> references", but I don't have any idea what those are either.
>
> I think what you mean is,
>
>  * Test if the shadow entry is for a folio which was recently evicted.
>  * Fills in @memcgid, @pgdat, @token and @workingset with values
>  * extracted from the shadow entry.

I'll fix this comment in the next version. Thanks for the suggestion!

>
> > +static bool lru_gen_test_recent(void *shadow, bool file, int *memcgid,
> > +             struct pglist_data **pgdat, unsigned long *token, bool *workingset)
> > +{
> > +     struct mem_cgroup *eviction_memcg;
> > +     struct lruvec *lruvec;
> > +     struct lru_gen_struct *lrugen;
> > +     unsigned long min_seq;
> > +
> > +     unpack_shadow(shadow, memcgid, pgdat, token, workingset);
> > +     eviction_memcg = mem_cgroup_from_id(*memcgid);
> > +
> > +     lruvec = mem_cgroup_lruvec(eviction_memcg, *pgdat);
> > +     lrugen = &lruvec->lrugen;
> > +
> > +     min_seq = READ_ONCE(lrugen->min_seq[file]);
> > +     return (*token >> LRU_REFS_WIDTH) == (min_seq & (EVICTION_MASK >> LRU_REFS_WIDTH));
> > +}
>
> [...]
>
> > +/*
> > + * Test if the folio is recently evicted by checking if
> > + * refault distance of shadow exceeds workingset size.
> >   *
> > - * Calculates and evaluates the refault distance of the previously
> > - * evicted folio in the context of the node and the memcg whose memory
> > - * pressure caused the eviction.
> > + * As a side effect, populate workingset with the value
> > + * unpacked from shadow.
> >   */
>
> 1. Shouldn't this be kernel-doc?

Hmm good point...

> 2. Again, don't use the term "side effect" here.  It's just one of
> the things that the function _does_.
>

I'll fix this! Thanks for pointing it out.
