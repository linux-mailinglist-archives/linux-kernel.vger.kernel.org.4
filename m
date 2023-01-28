Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25EF67F28E
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 01:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbjA1AAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 19:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjA1AA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 19:00:29 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE201A24D
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 16:00:28 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id h5so7888573ybj.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 16:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lijrLZpsXTwOwkkTPhsucO7YRqlZ4/gQhAOPSV+Ow1Y=;
        b=ZI6mj7LMKoNI/oOcrUtd9AUED9JuO6xGc225ZP5uALsCXRzd5tFQyZH9QfEgcc0bEJ
         9MyRsCvVZhFftsPfxOsSdKAlZ9GqA6WUrV9aTPd04wtI360xfqHl28+MEAyKXCixyLSk
         v8GrgI9q5COmywhNxiEU2+JydvMvd/BUJNpQDFUYR03wciVHZjv2EuSHGsiQLe/irS5u
         RDJKdxaqaPSErbAgtbt4IW1KQBMdHVynCsJnp7XSUo4WFhOq1Cn2ildO86zTjyE4mi+d
         qY/TAAQK5YagCO/hba9UdT8QCqoflyP2AkBiQBN42R1sMEg9No3XOKucr14HB2VVZKdY
         RBZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lijrLZpsXTwOwkkTPhsucO7YRqlZ4/gQhAOPSV+Ow1Y=;
        b=HhBWqix4bRfGKtmlC+D0XO+V9jZpeopm5e7TYIej4s1+44w40Nojhv7FXkVI2ecZx6
         mpGclf9x4RNtOUb8f4cd4tp8PP/Kv2vUmMA/d0Hzo23YqxzSRasnABn5Q9BQKWWGoU+c
         OpQT5tJKzX+NFHTL80xnUxF3MfE3bJu/vD9IwMEvKlTbewdEAzWRDt8GAserROAb6Xqi
         tPrUNmM3iE0NJc48sfOnSCiMkiRGi/FGWPkjVIggMh3WP9e6BqzFj/ylkmOerXTmBGRI
         QCpmg7pDjSkw8fsyoKYZNSh8KMWdQemGLdbkg4WFpGJxQOkxwzes7hKPdPMXXNZs9a+V
         7m2Q==
X-Gm-Message-State: AFqh2kpwHsnvVwbZFitRYPlMED2rVgHazMhp+2TySoG3PvaWhVmckOoW
        lIe0l6StBqTqOJtyviugEhjiW6i0HCLi6CTyKfbG+A==
X-Google-Smtp-Source: AMrXdXt1DVl+V4XP4vcyqRZaRp4SMPhEnSli2MXcg6xWkpJvGYiDP4ZAV3sZnOd/WucpWORfIrnrxsVJGAKOMpQ5+cE=
X-Received: by 2002:a25:9801:0:b0:7d5:b884:3617 with SMTP id
 a1-20020a259801000000b007d5b8843617mr3722360ybo.380.1674864027905; Fri, 27
 Jan 2023 16:00:27 -0800 (PST)
MIME-Version: 1.0
References: <20230127194110.533103-1-surenb@google.com> <20230127145138.8cc44bf00ebf289dffec0975@linux-foundation.org>
 <Y9Rdmy5h2F1z5yR3@casper.infradead.org>
In-Reply-To: <Y9Rdmy5h2F1z5yR3@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 27 Jan 2023 16:00:16 -0800
Message-ID: <CAJuCfpEq2F4EwWAeP6nLqS9m9XLpUss8n=35ZTgYgtiAJyvsxQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/33] Per-VMA locks
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 3:26 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Jan 27, 2023 at 02:51:38PM -0800, Andrew Morton wrote:
> > On Fri, 27 Jan 2023 11:40:37 -0800 Suren Baghdasaryan <surenb@google.co=
m> wrote:
> >
> > > Per-vma locks idea that was discussed during SPF [1] discussion at LS=
F/MM
> > > last year [2], which concluded with suggestion that =E2=80=9Ca reader=
/writer
> > > semaphore could be put into the VMA itself; that would have the effec=
t of
> > > using the VMA as a sort of range lock. There would still be contentio=
n at
> > > the VMA level, but it would be an improvement.=E2=80=9D This patchset=
 implements
> > > this suggested approach.
> >
> > I think I'll await reviewer/tester input for a while.

Sure, I don't expect the review to be very quick considering the
complexity, however I would appreciate any testing that can be done.

> >
> > > The patchset implements per-VMA locking only for anonymous pages whic=
h
> > > are not in swap and avoids userfaultfs as their implementation is mor=
e
> > > complex. Additional support for file-back page faults, swapped and us=
er
> > > pages can be added incrementally.
> >
> > This is a significant risk.  How can we be confident that these as yet
> > unimplemented parts are implementable and that the result will be good?
>
> They don't need to be implementable for this patchset to be evaluated
> on its own terms.  This patchset improves scalability for anon pages
> without making file/swap/uffd pages worse (or if it does, I haven't
> seen the benchmarks to prove it).

Making it work for all kinds of page faults would require much more
time. So, this incremental approach, when we tackle the mmap_lock
scalability problem part-by-part seems more doable. Even with
anonymous-only support, the patch shows considerable improvements.
Therefore I would argue that the patch is viable even if it does not
support the above-mentioned cases.

>
> That said, I'm confident that I have a good handle on how to make
> file-backed page faults work under RCU.

Looking forward to collaborating on that!
Thanks,
Suren.
