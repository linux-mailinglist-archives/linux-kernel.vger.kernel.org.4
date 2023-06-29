Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C667E74237E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 11:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjF2Jtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 05:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjF2Jtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 05:49:40 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A74C2118
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 02:49:39 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-34271602c32so1913455ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 02:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688032178; x=1690624178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TAVGxraTdF0jlMOrg7ntj6lybpeMD144G6in0dHdRZA=;
        b=GpRxs+aleVtUN6747CSY0iOpvbhoyhuMWoIGQlWKBzrWJE550cx2lgDWbgdZMl4Djk
         v3p3zJiHeZkivIAblRrYzwYBRfZgLITuLcl8AKwSl5Zng5c/gAP40SUW3KiSY6YbipKn
         krLwu4gnBt0ZHFuIOJGyE/8ULH3hsht2UkKdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688032178; x=1690624178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TAVGxraTdF0jlMOrg7ntj6lybpeMD144G6in0dHdRZA=;
        b=l39xS+AWxwQeOQ1qrqgZMh+P4cuG9Oz+IAlOambNN9lbAE044Sp6vMnoiXBduf4oCd
         GJWwL7MV7AYf1F1+U0MykeK/rENJ1M10vPcwBUYzASYbujrZf6F6p3M8bykhkCNjgvfm
         Agm2Aekc8rJceNDi4KdHnKrvs6JLz8fr+MP2pqQr28WoQNFkvZ4TQXaGywZ9g6lLEJtl
         MsLK8KWM4dc/2pb++X1wQDqT4U+pH7bWsbTYkq+HWmsYGNE883G5pBV1CTY90yqOPg0y
         p6x3Ph8iwJxsHd+MZtaOgcihWcVGcwzTI7gq5vhy9M29gMOUP+vA6AK1qU0YDf09KG6e
         +ApQ==
X-Gm-Message-State: AC+VfDwBN6ZpmH4YwzbDyAOA42rfH3B5kKUoqfRa+MB8lNxSzAwjFJPk
        R9BG+4eboy96kmgyjZtkK2kOKHrUPYSkN/qDS8Fi1g==
X-Google-Smtp-Source: ACHHUZ7mK7Q+1Xafu/kxH685oMb9yrF8QB4qddorUULJqvyJQ6sKfxgGtNUFrxxp4MjgbtdUD6tVGkWijqgxIANzikA=
X-Received: by 2002:a92:dc0e:0:b0:345:baef:842b with SMTP id
 t14-20020a92dc0e000000b00345baef842bmr6733308iln.25.1688032178627; Thu, 29
 Jun 2023 02:49:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230519001709.2563-1-tj@kernel.org> <ZIewlkGJJJUXPFL0@google.com>
 <ZIfY5zhhHU9IgOqx@slm.duckdns.org> <CAEXTbpconFReyAKxerNCQW5e51CMG=_RU9JHAquyEfSH1aqajA@mail.gmail.com>
 <ZJNMk9oSp1_IYXLU@slm.duckdns.org> <CAHk-=wgXoyxy99HnEFcvf+eUZAS5=ekWt_y84LC3P+0osxh6Jw@mail.gmail.com>
In-Reply-To: <CAHk-=wgXoyxy99HnEFcvf+eUZAS5=ekWt_y84LC3P+0osxh6Jw@mail.gmail.com>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Thu, 29 Jun 2023 17:49:27 +0800
Message-ID: <CAEXTbpcDS4SV=h41QKE_HkBhsmSa6Pe=63JtQZW8h2Fpc8Vo0w@mail.gmail.com>
Subject: Re: [PATCHSET v1 wq/for-6.5] workqueue: Improve unbound workqueue
 execution locality
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Brian Norris <briannorris@chromium.org>, jiangshanlai@gmail.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, joshdon@google.com, brho@google.com,
        nhuck@google.com, agk@redhat.com, snitzer@kernel.org,
        void@manifault.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus and Tejun,

On Thu, Jun 22, 2023 at 3:32=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 21 Jun 2023 at 12:16, Tejun Heo <tj@kernel.org> wrote:
> >
> > I find that perplexing given that switching to a per-cpu workqueue reme=
dies
> > the situation quite a bit, which is how this patchset came to be. #3 is=
 the
> > same as per-cpu workqueue, so if you're seeing noticeably different
> > performance numbers between #3 and per-cpu workqueue, there's something
> > wrong with either the code or test setup.
>
In our case, per-cpu workqueue (removing WQ_UNBOUND) doesn't bring us
better results. But given that pinning tasks to a single CPU core
helps, we thought that the regression is related to the behavior of
WQ_UNBOUND. Our findings are listed in [1].

We already use WQ_SYSFS and the sysfs interface to pin the tasks, but
thanks for the suggestion.

[1]: https://lore.kernel.org/all/ZFvpJb9Dh0FCkLQA@google.com/

> Or maybe there's some silly thinko in the wq code that is hidden by
> the percpu code.
>
> For example, WQ_UNBOUND triggers a lot of other overhead at least on
> wq allocation and free. Maybe some of that stuff then indirectly
> affects workqueue execution even when strict cpu affinity is set.
>
> Pin-Yen Li - can you do a system-wide profile of the two cases (the
> percpu case vs the "strict cpu affinity" one), to see if something
> stands out?

The two actually have similar performances, so I guess the profiling
is not interesting for you. Please let me know if you want to see any
data and I'll be happy to collect them and update here.

Best regards,
Pin-yen
>
>              Linus
