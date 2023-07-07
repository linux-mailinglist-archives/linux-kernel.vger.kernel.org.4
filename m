Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15CA74B2EC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjGGOQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbjGGOQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:16:45 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146C9199F
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 07:16:44 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-4409abccbefso490512137.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 07:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688739403; x=1691331403;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NmhRPpdN6RIYT+v2UBFcFUNwgVlDjZy43O4KVZygLbw=;
        b=dSuOVZO5uuYWymoT9aMNlqPp0oxM93k6GP6GzSNRhGmMWbEoeqQq+3bUoKw6O3QXbn
         soCtS2hQAPpDvo4Qp75Sii9thV8JaLqH77Ynxeufw5+5NYZJyH6RB93NvzvkIy1JwaPV
         dtdNOLdV2iHjWkyyUR1CtE5HvwMv2ILUcTXjKocZyfM+mGUTllgQHGi4rli8mKYSy5kv
         dLYq+MBlCv+3DbVs6U1ZbuP5OTZrVOLWlUK7uMTuDUJxCrFMqLLi1CkNQUjwMbL+uVLZ
         0yViwuZ62JOe0q/WpMLttQDFSbOPAOwN9iQAWpTf++Kk4sWocKuEPniLOcUWzijhjHVQ
         s5uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688739403; x=1691331403;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NmhRPpdN6RIYT+v2UBFcFUNwgVlDjZy43O4KVZygLbw=;
        b=FvpeCJ2jSNd8sRMe5kv/Pyneoo+RlJyArKOtKwfT9Na3ndl4PN7mkgw/uY2g5OSlbc
         7odAMKHyVmncyqr+qRhf5m3oluo1l/dM7ywJZeaWB1ec5tYx35venAxwRK21v+ybTi/p
         25/1ulaYKmVTHLzx4pJDMkaXubqmZ9JutwLitoT/XVapG9kKAuCsQmnlJK5dhuqNreRi
         dlbo901G7k29HafrU1S65MwhERI+HQ4EQFejiu58nxbVrhvE+qphpRISEz4W3475RsPv
         i4D50Zi/1NCJyBqPcDtPAxkdc0j6cqGhJu8fIQSTnCf6xxoVZgSran0QAbiiTlLXldxi
         NQlg==
X-Gm-Message-State: ABy/qLYlGrOOYDeykivZUE47F42hxv8N4T7DZhHZZAed17CP3yreMNAl
        xnJFgx6dfKGZlkC4QbglbigvbTvYiK8Ixe2xhnettfSIctaYyQ==
X-Google-Smtp-Source: APBJJlG2kFCAk8KqK1POIGReF+E3FJsIJqOmxJ/+aNyI5mGmBDQYqWzLcaY76ijRIf6azEjeI6y5UIvxjNQp+uF1V0U=
X-Received: by 2002:a67:eb54:0:b0:444:481b:8ca8 with SMTP id
 x20-20020a67eb54000000b00444481b8ca8mr2232021vso.11.1688739402990; Fri, 07
 Jul 2023 07:16:42 -0700 (PDT)
MIME-Version: 1.0
References: <1688668070-8408-1-git-send-email-quic_pintu@quicinc.com>
 <1688668414-12350-1-git-send-email-quic_pintu@quicinc.com>
 <26816f0a-7f55-f5ce-b71d-769011f9230f@arm.com> <ZKgJIlqZk8cw4MBa@casper.infradead.org>
 <CAOuPNLiOO_Pa=J_-0RhDBQ0auL0rgCjmpCZHtH3ngv6D1OhW6Q@mail.gmail.com> <ZKgctnmuVbLvYb9d@casper.infradead.org>
In-Reply-To: <ZKgctnmuVbLvYb9d@casper.infradead.org>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Fri, 7 Jul 2023 19:46:31 +0530
Message-ID: <CAOuPNLjcBe7iEdJUhLS-kJuCc-uxXarh6o=JiTirGixq+tj+jg@mail.gmail.com>
Subject: Re: [PATCH v2] mm: cma: print cma name as well in cma_alloc debug
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Pintu Kumar <quic_pintu@quicinc.com>,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jul 2023 at 19:40, Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Jul 07, 2023 at 07:36:20PM +0530, Pintu Agarwal wrote:
> > On Fri, 7 Jul 2023 at 18:16, Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Fri, Jul 07, 2023 at 03:57:42PM +0530, Anshuman Khandual wrote:
> > > > LGTM, cma->name is an identifying attribute for the region for which the allocation
> > > > request was made. But how about using cma_get_name() helper instead ? Very few call
> > > > sites have been using the helper.
> > >
> > > It's not really a "helper", is it?  The function name is longer than
> > > its implementation.
> > >
> > > cma_get_name(cma)
> > > vs
> > > cma->name
> > >
> > > Plus there's the usual question about whether a "got" name needs to be
> > > "put" (does it grab a refcount?)
> > >
> > > I think it's useful that this function exists since it lets us not expose
> > > struct cma outside of mm/, but it really should be called cma_name()
> > > and I don't think we should be encouraging its use within cma.c.
> >
> > Also, cma_get_name() is a trivial assignment.
> > And in one of the previous patches we avoided function calls with
> > trivial assignments.
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/kernel/dma/contiguous.c?h=next-20230705&id=5af638931eb374aa0894d8343cee72f50307ef20
> > dma-contiguous: remove dev_set_cma_area
> >
> > One more question from here:
> > pr_debug("%s(cma %p, name: %s, count %lu, align %d)\n", __func__,
> >                 (void *)cma, cma->name, count, align);
> >
> > Do we really need this "cma %p" printing ?
> > I hardly check it and simply rely on name and count.
>
> Printing pointers is almost always a bad idea.  Printing the base_pfn
> might be a good idea to distinguish CMAs which happen to have the
> same name?
>
No there is no name there, it's just a ptrval
cma: cma_alloc(cma (ptrval), name: reserved, count 64, align 6)
