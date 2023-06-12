Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0FD72CD3A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236071AbjFLRvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 13:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235386AbjFLRvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:51:45 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4B498
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 10:51:44 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9745d99cfccso806949166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 10:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686592302; x=1689184302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgioPKcaHc+2ScCYWNcCop9oGPk4yLITypWHe3V71TQ=;
        b=ZITGtXB29M2sUayESWUa4yYDVHxmeRumG3nNzNMoACaIgIv9DKL3lms2+WphPAMwo9
         nqmPR9r8HDoOikRrGFyhIJlqgbyEHUfHwA8Nbtar8VVlX2+H6BxJzkaFq4760a61t3KQ
         YVWsuDad5G/oZ8MWSQwr8X2XJHqQ9zvF4tZYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686592302; x=1689184302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HgioPKcaHc+2ScCYWNcCop9oGPk4yLITypWHe3V71TQ=;
        b=CMaRqZKPUvenIEQsDs6eezQsYj8C7Zk+gxWz54MGzBLzH8102G0CPtGX7k4BCIMfDC
         LWdNBk1zsd4Eb52QLqPoAv7B0QLAJlWp1M8mgX3Obv0Qat/ET+t+xJmQpPq3ZDEtlFuR
         qcBt7PJuv+PxofFk5b+LWdxgPRBfvWsYqSZpAbTnGaWZdOOcdKbXJJpQwMqo1Jw8FHDy
         nqw+h/szgDL5G8CiqCkx4qPnBw7bhbcn+FmBv4DsKQ1tWQxUE59JB48cXU8zo2OGFYjJ
         S5kWuTAmqn5lxl065BiJnRPLJSERLEayNSoEAQBwBy21VK0c8OKs5+gtEbs1KzgYgTR2
         BFbg==
X-Gm-Message-State: AC+VfDxxaE723Diax25JcBf2Z/8vFl0mfrKDB0tGuFZaxeFqcmeqZe03
        Ujjf3WXsP4mTN8uvEU73610MO7P7OhrTiMcH0ls/iFtO
X-Google-Smtp-Source: ACHHUZ7WDoT7njQmrLphpNUnarsxnf/JQZAQv25XM59ReDRf2UOSo7P534Qdta6qzby4BzI0A/gojQ==
X-Received: by 2002:a17:907:70a:b0:96f:a935:8997 with SMTP id xb10-20020a170907070a00b0096fa9358997mr10864309ejb.12.1686592302298;
        Mon, 12 Jun 2023 10:51:42 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id n24-20020a170906165800b00977c7566ccbsm5482386ejd.164.2023.06.12.10.51.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 10:51:41 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5149b63151aso7804441a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 10:51:41 -0700 (PDT)
X-Received: by 2002:aa7:d753:0:b0:516:af22:bccc with SMTP id
 a19-20020aa7d753000000b00516af22bcccmr5384633eds.21.1686592301040; Mon, 12
 Jun 2023 10:51:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230611124836.whfktwaumnefm5z5@zlang-mailbox>
 <ZIZSPyzReZkGBEFy@dread.disaster.area> <20230612015145.GA11441@frogsfrogsfrogs>
 <ZIaBQnCKJ6NsqGhd@dread.disaster.area> <CAHk-=whJqZLKPR-cpX-V4wJTXVX-_tG5Vjuj2q9knvKGCPdfkg@mail.gmail.com>
 <20230612153629.GA11427@frogsfrogsfrogs> <CAHk-=wiN-JcUh4uhDNmA4hp26Mg+c2DTuzgWY2fZ6hytDtOMCg@mail.gmail.com>
 <af31cadf-8c15-8d88-79fb-066dc87f0324@kernel.dk> <13d9e4f2-17c5-0709-0cc0-6f92bfe9f30d@kernel.dk>
 <CAHk-=wgdBfqyNHk0iNyYpEuBUdVgq1KMzHMuEqn=ADtfyK_pkQ@mail.gmail.com>
 <212a190c-f81e-2876-cf14-6d1e37d47192@kernel.dk> <CAHk-=wh0hrFjcU5C8uHvLBThrT5vQsFHb7Jk6HRP3LAJqdNx1A@mail.gmail.com>
 <ff34a007-fdd0-8575-8482-919ead39fc88@kernel.dk>
In-Reply-To: <ff34a007-fdd0-8575-8482-919ead39fc88@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Jun 2023 10:51:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=whXt9+-YfhgjBYxT9_ATjHbMDZ0yJdK7umrJGU8zBVZ9w@mail.gmail.com>
Message-ID: <CAHk-=whXt9+-YfhgjBYxT9_ATjHbMDZ0yJdK7umrJGU8zBVZ9w@mail.gmail.com>
Subject: Re: [6.5-rc5 regression] core dump hangs (was Re: [Bug report]
 fstests generic/051 (on xfs) hang on latest linux v6.5-rc5+)
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Zorro Lang <zlang@redhat.com>, linux-xfs@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Mike Christie <michael.christie@oracle.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 10:29=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote=
:
>
> Looks fine to me to just kill it indeed, whatever we did need this
> for is definitely no longer the case. I _think_ we used to have
> something in the worker exit that would potentially sleep which
> is why we killed it before doing that, now it just looks like dead
> code.

Ok, can you (and the fsstress people) confirm that this
whitespace-damaged patch fixes the coredump issue:


  --- a/io_uring/io-wq.c
  +++ b/io_uring/io-wq.c
  @@ -221,9 +221,6 @@ static void io_worker_exit(..
        raw_spin_unlock(&wq->lock);
        io_wq_dec_running(worker);
        worker->flags =3D 0;
  -     preempt_disable();
  -     current->flags &=3D ~PF_IO_WORKER;
  -     preempt_enable();

        kfree_rcu(worker, rcu);
        io_worker_ref_put(wq);

Jens, I think that the two lines above there, ie the whole

        io_wq_dec_running(worker);
        worker->flags =3D 0;

thing may actually be the (partial?) reason for those PF_IO_WORKER
games. It's basically doing "now I'm doing stats by hand", and I
wonder if now it decrements the running worker one time too much?

Ie when the finally *dead* worker schedules away, never to return,
that's when that io_wq_worker_sleeping() case triggers and decrements
things one more time.

So there might be some bookkeeping reason for those games, but it
looks like if that's the case, then that

        worker->flags =3D 0;

will have already taken care of it.

I wonder if those two lines could just be removed too. But I think
that's separate from the "let's fix the core dumping" issue.

           Linus
