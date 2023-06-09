Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7328E72A649
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 00:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjFIWes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 18:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjFIWeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 18:34:46 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD0935B8
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 15:34:46 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-bacf9edc87bso2153227276.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 15:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686350085; x=1688942085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W81GRpfjhB0fn0UjEwFmdlfLhr9DX7q54fVjX5JcBGg=;
        b=Jtv10dsQTSwjnb3KMyeLUwInuJddeKAVXNSlN9syLvz8CxqBISG95KzggDHC3reL2w
         w1Y7ul4RtKxvRW5N4XVfUlaT8sxd4Lc8Vgj+uh74SpkuHibNLDPnP1EOaAw9aoerEnjb
         YCG0DrI+e5/HK3bln+hTlFdmyqRhN4T7rAvuDPnQMoK2aTl3IIONYrML5POouJAMgL8K
         fIHpI38+96N2+JOTHnTmatoXycHOyrhNA6Pq429ZH3RdrXT/rGlv3eFPRCZbmuSX3jVi
         Wu0ha6MiH4hG9zz4bzkECTS4bs/QhW8CCWyVsh56nIvhOatn/OiSvZgND3QHeYdeOx9/
         OHsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686350085; x=1688942085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W81GRpfjhB0fn0UjEwFmdlfLhr9DX7q54fVjX5JcBGg=;
        b=T3fnEEsqK/zY51ROXxrPBm/64zhYhIqSxyhPHMcXa8p4+eecLdZdASb8y9ggCnLE8y
         BLwA0ErWX1BlQuq5eTATfwdPSa2PxKe6ZUabkTf9GPtnEh3QFWahwysN2pJuBLIbckKO
         BubYVJGosdKySQSPx6oD9uzPO/tHK+zhIBlUZ1jiqqpv9W5pKr2aBRLN+sUm1vZyIBm4
         bfJo7IklgfhkUlH9H1JbOSHT67BGu/XMNLJeJ+F1Y7PCgBTdjuCRG5qTxixv6Y46mvyf
         /KkfNQZyY1/rywqVq0PCIjFhY099i8JXZiq44GYGib2Q+qUc0UbIVq2Zd9I5vdcGL5jX
         4TUA==
X-Gm-Message-State: AC+VfDyELe26jSoK6iVGcWWpBkC6zrV3i0Fc/L8yCXhjpKZ3K1ubZBBh
        Gafnx01iJsZ909UdoJvfY9T8RJ6eOz6eryd+QjaLVA==
X-Google-Smtp-Source: ACHHUZ7hsTTyON0Svm2oxRxKxCgZHMCoT1i24FWMvQdNlGeE+Ok9RI+L6LTUMJj+vWSUjwBi8sB6WPekuQHZJWi3Ud4=
X-Received: by 2002:a25:41c4:0:b0:bac:5d73:7f0a with SMTP id
 o187-20020a2541c4000000b00bac5d737f0amr2420821yba.17.1686350085069; Fri, 09
 Jun 2023 15:34:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230609005158.2421285-1-surenb@google.com> <20230609005158.2421285-3-surenb@google.com>
 <ZIOKxoTlRzWQtQQR@x1n> <ZIONJQGuhYiDnFdg@casper.infradead.org> <ZIOPeNAy7viKNU5Z@x1n>
In-Reply-To: <ZIOPeNAy7viKNU5Z@x1n>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 9 Jun 2023 15:34:34 -0700
Message-ID: <CAJuCfpFAh2KOhpCQ-4b+pzY+1GxOGk=eqj6pBj04gc_8eqB6QQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] mm: handle swap page faults under VMA lock if page
 is uncontended
To:     Peter Xu <peterx@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, mhocko@suse.com, josef@toxicpanda.com,
        jack@suse.cz, ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com, hdanton@sina.com,
        apopple@nvidia.com, ying.huang@intel.com, david@redhat.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
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

On Fri, Jun 9, 2023 at 1:45=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Fri, Jun 09, 2023 at 09:35:49PM +0100, Matthew Wilcox wrote:
> > On Fri, Jun 09, 2023 at 04:25:42PM -0400, Peter Xu wrote:
> > > >  bool __folio_lock_or_retry(struct folio *folio, struct mm_struct *=
mm,
> > > >                    unsigned int flags)
> > > >  {
> > > > + /* Can't do this if not holding mmap_lock */
> > > > + if (flags & FAULT_FLAG_VMA_LOCK)
> > > > +         return false;
> > >
> > > If here what we need is the page lock, can we just conditionally rele=
ase
> > > either mmap lock or vma lock depending on FAULT_FLAG_VMA_LOCK?
> >
> > See patch 5 ...
>
> Just reaching.. :)
>
> Why not in one shot, then?

I like small incremental changes, but I can squash them if that helps
in having a complete picture.

>
> --
> Peter Xu
>
