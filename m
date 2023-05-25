Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC857110CE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 18:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239601AbjEYQUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 12:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbjEYQUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 12:20:42 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBD010B
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 09:20:41 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-50bcb00a4c2so4155658a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 09:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685031639; x=1687623639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ku5sOb6PtVoCvGfeJzKGQIZVhFagEKIux+ec1ZmkO4g=;
        b=AEs1DUE4e6Dkn0FAL7fqRZCkOBdPGQ4UuhqutRZLYk8l4cLOLGJjHRRj7OWKTNPBcI
         XL+6/yZ72PWNHLQObpXU/MPesFy7TQuuBKavv5b5iICHB3pwxMPPGiwy8E6bKx4HeZWU
         6wmIxTBiLBA5L1ZAxBs7MKrKDYnidHxVu75Ss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685031639; x=1687623639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ku5sOb6PtVoCvGfeJzKGQIZVhFagEKIux+ec1ZmkO4g=;
        b=L8Gl6f/5fnl3KdxGScFimyL2+xWu6jXh5pP19jEFbljRtQ3owAjDY3XayR73xRW1QO
         PL8M4/BWGLtqb0kdSC/NIW+i18ehru0u9MjuY+fBA9FTczeM3tbH/ExgJVgPYIuN221D
         HLqKJjEIywvje4q1MiM1kdNyTcYru9O1xh1uDuospIUTl71LVPdO9a0fm/vksKJ+ZgHw
         ecU9sZWlketnT0mNH7lAqoKBbKhXQetp5EYste6cRbtGCNyUoA5EGJc6zPySiSrDp22T
         N6rXPlUUiJImBOJcJa42F0DbfIH24/hAPQIvcS5Idw3SAZuchAFMrG/5/e0tS6aN6KTi
         4H4A==
X-Gm-Message-State: AC+VfDwNcUwpTquzs/m3mRhhCpg1gAj9IUoOsMwTl//wihoOL8YhYu7L
        GZuUuJKPctax9jsf4A6EgUrzqwsgFs9iny+26GrrNXEQ
X-Google-Smtp-Source: ACHHUZ6cZvcQxfSueIyDvW4mDOtXS6dFK1Is8I5RO1mgH6TBNrO/CkBPMdFAgERYde4IzOc62xycog==
X-Received: by 2002:a17:907:3f0a:b0:973:afe2:a01 with SMTP id hq10-20020a1709073f0a00b00973afe20a01mr2037116ejc.75.1685031639378;
        Thu, 25 May 2023 09:20:39 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id b25-20020aa7cd19000000b0050bd19ec39bsm694018edw.83.2023.05.25.09.20.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 09:20:37 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-96ff9c0a103so132122366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 09:20:37 -0700 (PDT)
X-Received: by 2002:a17:907:7207:b0:96f:7e14:3084 with SMTP id
 dr7-20020a170907720700b0096f7e143084mr2270332ejc.44.1685031636699; Thu, 25
 May 2023 09:20:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230522025124.5863-1-michael.christie@oracle.com>
 <20230522025124.5863-4-michael.christie@oracle.com> <20230522123029.GA22159@redhat.com>
 <cfca7764-d210-6df9-e182-2c093101c6cf@oracle.com> <20230522174757.GC22159@redhat.com>
 <20230523121506.GA6562@redhat.com> <87bkib6nxr.fsf@email.froward.int.ebiederm.org>
 <20230524141022.GA19091@redhat.com> <87ttw1zt4i.fsf@email.froward.int.ebiederm.org>
 <20230525115512.GA9229@redhat.com> <87y1lcxwcj.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87y1lcxwcj.fsf@email.froward.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 May 2023 09:20:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj4DS=2F5mW+K2P7cVqrsuGd3rKE_2k2BqnnPeeYhUCvg@mail.gmail.com>
Message-ID: <CAHk-=wj4DS=2F5mW+K2P7cVqrsuGd3rKE_2k2BqnnPeeYhUCvg@mail.gmail.com>
Subject: Re: [PATCH 3/3] fork, vhost: Use CLONE_THREAD to fix freezer/ps regression
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Mike Christie <michael.christie@oracle.com>,
        linux@leemhuis.info, nicolas.dichtel@6wind.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 8:30=E2=80=AFAM Eric W. Biederman <ebiederm@xmissio=
n.com> wrote:
>
> Basically with no patches that is where Linus's kernel is.
>
> User complained about the new thread showing up in ps.

Well, not only that, but it actively broke existing workflows for
managing things. Showing up in 'ps' wasn't just some purely cosmetic
issue, but had semantic meaning.

And honestly, I think the core issue is that we should just make this
work. Kernel threads randomly switching to user memory threads was
wrong, so CLONE_VM is absolutely the right thing to do.

But while "CLONE_VM without real threading" is a very traditional
thing in Linux - it was the original model for clone(), after all - I
don't believe it is the *correct* model. There was a very real reason
clone() has grown CLONE_THREAD and friends.

So honestly, I really think we want to complete the vhost move to
CLONE_THREAD (and thus CLONE_SIGNAL).

Not because the old kthread model didn't _work_, but because it's
really really wrong to try to randomly take on user-space attributes
at run-time.

And once you do the "user threads in kernel space" model, at that
point you really do want to act like a proper thread. Both because of
that 'ps' issue (which is really just "show the world what your
relationship is), but simply because that is the modern threading
model that we use for everything else, and special cases are bad.

So I'd really like to finish this. Even if we end up with a hack or
two in signal handling that we can hopefully fix up later by having
vhost fix up some of its current assumptions.

It has worked wonderfully well for io_uring - but we *did* have quite
a bit of conversion patches over some time as people found issues.
Which is why I don't expect the vhost conevrsion to be entirely
pain-free either, and I don't think we necessarily have to get to a
"perfect and clean" state immediately, just a "working and
conceptually in the right direction" state.

             Linus
