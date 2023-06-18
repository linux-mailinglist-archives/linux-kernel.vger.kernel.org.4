Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61FE87344F9
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 07:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjFRF33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 01:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjFRF31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 01:29:27 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BCF18D
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 22:29:26 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9827109c6e9so317709666b.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 22:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687066165; x=1689658165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/UTGt7iKNdIzFHJhjEBhwjHxC/KeXkq7iK+gyIRePnA=;
        b=QshDGO/8+dQtptQe3oTeB5REZopFkvHAuQfSsiKGAlct6fS75RHbXsjUJ4vH6MYP/w
         wVr+IB5/2Ay8Cra/ELGMyO4M62SI/Is8NUrAB1ZTkq43EXauP+PgbXc81Qdo9gL9M8Uh
         GBIemPdCaTDPg27+tVHwZe2rFUt8KUag/JsGzvgSRBpCecWwSGQqzXUct2vFwKL06yxW
         8PBGS0nqPySf44GUn3lj/TXdCMpslJTlsWleshCYov/2Cw49sxmuIP7eFLta9TU43DF3
         I+Sl/ZI0v3FzZeYVv7tWa8oNZTbuMottFRyrS9N9b3bcWoNuAsbhgdiyx/ATcz09vdcW
         cO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687066165; x=1689658165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/UTGt7iKNdIzFHJhjEBhwjHxC/KeXkq7iK+gyIRePnA=;
        b=jK3wu8JV37q2xV2OdK/u1oIEM9rYvLaz5r8PfUOzOeZMDZns0mKbKkCwKC7tEcVYqQ
         eVB3xxk1Dr+qId+95VF3fNUSEoz4pShSkgOGcDgfB0zIN07k3mxeiofsT562TrNOuQzr
         eN9hJKhFcgJkDxV/ab+2RueD85dRjE8ODha/e8nTE8fEt91z/n4mBEaYkqKtIOLhZC6a
         fm4/FMYpkRIzkonAhaJmWBcQAst2rVOvGeD9KjT2vHyVrswWz5ZjRJmobMwPqC00/wLd
         I8NrHyktaegye7nJQo+mY8BCaeccHdsEUHXIyHxHqi67TunHDLNLfO/BFgeJe9tRcnF4
         ++mw==
X-Gm-Message-State: AC+VfDxbZeeD4zLyCg3bF8OJ/ge5hzCq2iDlfem/gXkdruoWz+bxXVBE
        jbkQG0teMfr6G2UV3QD+i4+7+Prj3lL4+C6jCe/fww==
X-Google-Smtp-Source: ACHHUZ5Owm1j445iAj1AbhlY7ujp9HjjFWMq1Heyx1o80K7E8d2gzF17j4sBfmODCeJ2WmON79zFq5nRPXSLKi1E5IY=
X-Received: by 2002:a17:906:4793:b0:96f:5747:a0de with SMTP id
 cw19-20020a170906479300b0096f5747a0demr5942787ejc.6.1687066164695; Sat, 17
 Jun 2023 22:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230612093815.133504-1-cerasuolodomenico@gmail.com>
 <20230612093815.133504-2-cerasuolodomenico@gmail.com> <20230618043857.GA2417524@google.com>
 <CAJD7tkbRn2txAt94keKTRbAA7--XF3rXSa8vsh9eGZa2CUWP8w@mail.gmail.com> <20230618052526.GB2417524@google.com>
In-Reply-To: <20230618052526.GB2417524@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Sat, 17 Jun 2023 22:28:48 -0700
Message-ID: <CAJD7tkbcf+MEMJdGeruB7XL=J8tJNgkB7_1UQ2S4VEKjob-NQw@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] mm: zswap: add pool shrinking mechanism
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        vitaly.wool@konsulko.com, minchan@kernel.org, linux-mm@kvack.org,
        ddstreet@ieee.org, sjenning@redhat.com, nphamcs@gmail.com,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
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

On Sat, Jun 17, 2023 at 10:25=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (23/06/17 21:48), Yosry Ahmed wrote:
> > > On (23/06/12 11:38), Domenico Cerasuolo wrote:
> > > > +static int zswap_reclaim_entry(struct zswap_pool *pool)
> > > > +{
> > > > +     struct zswap_header *zhdr;
> > > > +     struct zswap_entry *entry;
> > > > +     struct zswap_tree *tree;
> > > > +     pgoff_t swpoffset;
> > > > +     int ret;
> > > > +
> > > > +     /* Get an entry off the LRU */
> > > > +     spin_lock(&pool->lru_lock);
> > > > +     if (list_empty(&pool->lru)) {
> > > > +             spin_unlock(&pool->lru_lock);
> > > > +             return -EINVAL;
> > > > +     }
> > > > +     entry =3D list_last_entry(&pool->lru, struct zswap_entry, lru=
);
> > > > +     list_del_init(&entry->lru);
> > >
> > > A quick question: should we zswap_entry_get() here?
> >
> > We need to hold the tree lock for that, and the lock ordering is tree
> > lock -> lru lock. If we try to grab the tree lock here we may
> > deadlock.
>
> We can deadlock doing this?
>
>         lock tree_lock
>         lock lru_lock
>         list_del_init
>         unlock lru_lock
>         entry_get
>         unlock tree_lock
>         writeback

We don't know which tree the zswap entry belongs to until we get from
the LRU -- so we can't hold the tree lock before getting the entry
from the lru (and to get the entry from the LRU we need the lru_lock).
