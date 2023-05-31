Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE0F7179CD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235173AbjEaISf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234698AbjEaISd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:18:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F72BE
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 01:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685521061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kSz+dEeNYH+4ngZm7IwuL2caHNvp+UxojfSLvR5hzoc=;
        b=ackYPBYGUWFuy9OxlOLeGCOynGDE+gevcuY3QSco1/WRnhirM/dr+5xlxkzfweJpWvD3v5
        vA2pWyoBNT1cMQDmiC+DjHewi5S9yMbNMKwsdloJ9GXTtu94iFRBWpgN+oclr10NZCkDT7
        Q5oqpyomV73Kji7FUoZ9Yx/ODsHSJQk=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-mdIkjwTgMVCCoX49-1eJhQ-1; Wed, 31 May 2023 04:17:40 -0400
X-MC-Unique: mdIkjwTgMVCCoX49-1eJhQ-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2af1a18584bso28571471fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 01:17:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685521059; x=1688113059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kSz+dEeNYH+4ngZm7IwuL2caHNvp+UxojfSLvR5hzoc=;
        b=gOP5CsnwiEpFUKxftWSyr/QJYcOPRKyJbZvcOu6mUp1ZUGadAqA2h/StH9yI1QLetR
         qG6MHNQdebQ/F52Z/hyyVDkIkgx5xFHIkNcK+eNPKVLBGMivmS2rnAqSD3XU3F5R803x
         qI8hiR8tENaUpRvctfcy7llnu7ZWmo0Emzfqgkp0K5ou0HD8kV1k03b3Ipds8n/ydItX
         ZXT3lFWCTH6Ad4J8IkIPdNv7WV6vRLrGLax+kPj9p75+sS/BuR2snEp9v6jIkM9gHTAZ
         CuB6C9OdsT8MSjnbbajTRsY8QjfTBUbc21q1cuamAN51Do8dJ/d1xJu68G/+ZI7YYGcY
         to2A==
X-Gm-Message-State: AC+VfDwUwVGqi1+DBy791orFclalgjxynp/dBsWHASvHOUyGlUXfN3El
        a7K26RzGUrkzDSi6fpJYBBrxDibSQYvA8nMSij84Ppw1l42mQDGfXHSZ8LFJNQF6g1ccVxHJOor
        ZgXZFlZ1MRnbEBApCdK9VlttzC+v01XAm4n91iTYW
X-Received: by 2002:a05:651c:112:b0:2ad:92b9:83b4 with SMTP id a18-20020a05651c011200b002ad92b983b4mr1940395ljb.5.1685521059039;
        Wed, 31 May 2023 01:17:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4W9YPS64wIKnQUYIqsmxXjeO0NPXfY7EevU0tX2ZqFX30ZAyvOoYCnOyPk0y8CnFb/TcsnmbVC7HuBZyZHL5U=
X-Received: by 2002:a05:651c:112:b0:2ad:92b9:83b4 with SMTP id
 a18-20020a05651c011200b002ad92b983b4mr1940387ljb.5.1685521058739; Wed, 31 May
 2023 01:17:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230522025124.5863-1-michael.christie@oracle.com>
 <20230522025124.5863-4-michael.christie@oracle.com> <20230522123029.GA22159@redhat.com>
 <cfca7764-d210-6df9-e182-2c093101c6cf@oracle.com> <20230522174757.GC22159@redhat.com>
 <20230523121506.GA6562@redhat.com> <26c87be0-8e19-d677-a51b-e6821e6f7ae4@redhat.com>
 <20230531072449.GA25046@redhat.com>
In-Reply-To: <20230531072449.GA25046@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 31 May 2023 16:17:27 +0800
Message-ID: <CACGkMEv2kB9J1qGYkGkywk1YHV2gU2fMr7qx4vEv9L5f6qL5mg@mail.gmail.com>
Subject: Re: [PATCH 3/3] fork, vhost: Use CLONE_THREAD to fix freezer/ps regression
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Mike Christie <michael.christie@oracle.com>, linux@leemhuis.info,
        nicolas.dichtel@6wind.com, axboe@kernel.dk, ebiederm@xmission.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, stefanha@redhat.com, brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 3:25=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 05/31, Jason Wang wrote:
> >
> > =E5=9C=A8 2023/5/23 20:15, Oleg Nesterov =E5=86=99=E9=81=93:
> > >
> > >             /* make sure flag is seen after deletion */
> > >             smp_wmb();
> > >             llist_for_each_entry_safe(work, work_next, node, node) {
> > >                     clear_bit(VHOST_WORK_QUEUED, &work->flags);
> > >
> > >I am not sure about smp_wmb + clear_bit. Once we clear VHOST_WORK_QUEU=
ED,
> > >vhost_work_queue() can add this work again and change work->node->next=
.
> > >
> > >That is why we use _safe, but we need to ensure that llist_for_each_sa=
fe()
> > >completes LOAD(work->node->next) before VHOST_WORK_QUEUED is cleared.
> >
> > This should be fine since store is not speculated, so work->node->next =
needs
> > to be loaded before VHOST_WORK_QUEUED is cleared to meet the loop condi=
tion.
>
> I don't understand you. OK, to simplify, suppose we have 2 global vars
>
>         void *PTR =3D something_non_null;
>         unsigned long FLAGS =3D -1ul;
>
> Now I think this code
>
>         CPU_0                           CPU_1
>
>         void *ptr =3D PTR;                if (!test_and_set_bit(0, FLAGS)=
)
>         clear_bit(0, FLAGS);                    PTR =3D NULL;
>         BUG_ON(!ptr);
>
> is racy and can hit the BUG_ON(!ptr).

This seems different to the above case? And you can hit BUG_ON with
the following execution sequence:

[cpu 0] clear_bit(0, FLAGS);
[cpu 1] if (!test_and_set_bit(0, FLAGS))
[cpu 1] PTR =3D NULL;
[cpu 0] BUG_ON(!ptr)

In vhost code, there's a condition before the clear_bit() which sits
inside llist_for_each_entry_safe():

#define llist_for_each_entry_safe(pos, n, node, member)                    =
    \
        for (pos =3D llist_entry((node), typeof(*pos), member);            =
      \
             member_address_is_nonnull(pos, member) &&                     =
    \
                (n =3D llist_entry(pos->member.next, typeof(*n), member), t=
rue); \
             pos =3D n)

The clear_bit() is a store which is not speculated, so there's a
control dependency, the store can't be executed until the condition
expression is evaluated which requires pos->member.next
(work->node.next) to be loaded.

>
> I guess it is fine on x86, but in general you need smp_mb__before_atomic(=
)
> before clear_bit(), or clear_bit_unlock().
>
> > >                     __set_current_state(TASK_RUNNING);
> > >
> > >Why do we set TASK_RUNNING inside the loop? Does this mean that work->=
fn()
> > >can return with current->state !=3D RUNNING ?
> >
> > It is because the state were set to TASK_INTERRUPTIBLE in the beginning=
 of
> > the loop otherwise it might be side effect while executing work->fn().
>
> Again, I don't understand you. So let me repeat: can work->fn() return wi=
th
> current->_state !=3D TASK_RUNNING ? If not (and I'd say it should not), y=
ou can
> do __set_current_state(TASK_RUNNING) once, before llist_for_each_entry_sa=
fe().
>

Ok, that should be fine.

Thanks


> > >Now the main question. Whatever we do, SIGKILL/SIGSTOP/etc can come ri=
ght
> > >before we call work->fn(). Is it "safe" to run this callback with
> > >signal_pending() or fatal_signal_pending() ?
> >
> > It looks safe since:
> >
> > 1) vhost hold refcnt of the mm
> > 2) release will sync with the worker
>
> Well, that's not what I asked... nevermind, please forget.
>
> Thanks.
>
> Oleg.
>

