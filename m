Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543BD7190AA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 04:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjFACp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 22:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjFACp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 22:45:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7403E10C3
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 19:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685587456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P5j1g1ATxz1Tv7AYCJO77SujD8J9ABucgOuKivxgRaM=;
        b=JotbcwTEf8RpN5ojQMUJWkPPO4zzIRe5qqfE+o82NIA1ASauD0dhbKCNQ1zaybpgg35mUz
        CVz5ULjLWSbZkGLmfB1ON//8Z94rKwOsc0/LCpmEeebN1PnQw/MN26JdAjaSi5K9huh8hm
        QDZsn8Zqf1nQBv9FikunxmafwFESfT8=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-ZxJlrQyOO3e8NNR_775r5w-1; Wed, 31 May 2023 22:44:14 -0400
X-MC-Unique: ZxJlrQyOO3e8NNR_775r5w-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2af570dc8daso2408541fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 19:44:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685587453; x=1688179453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P5j1g1ATxz1Tv7AYCJO77SujD8J9ABucgOuKivxgRaM=;
        b=f6IVh8o2yFSV+YNK2I8/As1ybU2FCAuEFG2yvABh0FNoLWrXZ2ZDFh+AAmU+rXDyWM
         vt83Qv7755Rcx7ooAV5JUSRwIlmcuijcBshVC1FVxAINapY1AXgqEAZWME967G2tktYQ
         juW3X13UE2/SrEX/nDT4b6rPFGQUX9EX51shUy6XeGNl5fmfR8NZAWFuYKdtSyq+ga0z
         NnUmijOsb7x6i3B4H/GfBReXoSO3/DFtaDk/pzUd+U/ZN3VmRY/EGm5uoyv9ySaDzoNU
         Nw/1Mthfbmvx+pr6g2mx+4qsxpf0cCqUhmsWlS/yoR3p8WXXQW0MnDdtoxlqWlnrvApx
         5k3w==
X-Gm-Message-State: AC+VfDzNsJ3VoDuz4jMkmnI4mFNuGKBQBcJ1DaZLgSxS+e5m6/dv54wz
        ravPZtQ4bj/ZUVWLINtzNy2AQSgPRgzywUutKL5GoAQQSkjnbXvOO/etEmhHbPEWIkEWXURtjjN
        gNvxvwhgA5pXHbjOXls3l+OiCQKOoyaeGJNpwurHO
X-Received: by 2002:a2e:9349:0:b0:2ab:42c7:cf25 with SMTP id m9-20020a2e9349000000b002ab42c7cf25mr3723680ljh.13.1685587453442;
        Wed, 31 May 2023 19:44:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5SRy8UQO9IwqDcYgSA8oz4ZDB+xL2wjCTAWMJt6bNtw6hK+k0BB5H1rPnhcpKz3t/XB2RpU1CudcWpY8mflfY=
X-Received: by 2002:a2e:9349:0:b0:2ab:42c7:cf25 with SMTP id
 m9-20020a2e9349000000b002ab42c7cf25mr3723676ljh.13.1685587453169; Wed, 31 May
 2023 19:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230522025124.5863-1-michael.christie@oracle.com>
 <20230522025124.5863-4-michael.christie@oracle.com> <20230522123029.GA22159@redhat.com>
 <cfca7764-d210-6df9-e182-2c093101c6cf@oracle.com> <20230522174757.GC22159@redhat.com>
 <20230523121506.GA6562@redhat.com> <26c87be0-8e19-d677-a51b-e6821e6f7ae4@redhat.com>
 <20230531072449.GA25046@redhat.com> <CACGkMEv2kB9J1qGYkGkywk1YHV2gU2fMr7qx4vEv9L5f6qL5mg@mail.gmail.com>
 <20230531091432.GB25046@redhat.com>
In-Reply-To: <20230531091432.GB25046@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 1 Jun 2023 10:44:01 +0800
Message-ID: <CACGkMEvNrC5gc4ppp0QG-SNSbs_snrqwPkNBotffRRDJA1VJjQ@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 5:14=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 05/31, Jason Wang wrote:
> >
> > On Wed, May 31, 2023 at 3:25=E2=80=AFPM Oleg Nesterov <oleg@redhat.com>=
 wrote:
> > >
> > > On 05/31, Jason Wang wrote:
> > > >
> > > > =E5=9C=A8 2023/5/23 20:15, Oleg Nesterov =E5=86=99=E9=81=93:
> > > > >
> > > > >             /* make sure flag is seen after deletion */
> > > > >             smp_wmb();
> > > > >             llist_for_each_entry_safe(work, work_next, node, node=
) {
> > > > >                     clear_bit(VHOST_WORK_QUEUED, &work->flags);
> > > > >
> > > > >I am not sure about smp_wmb + clear_bit. Once we clear VHOST_WORK_=
QUEUED,
> > > > >vhost_work_queue() can add this work again and change work->node->=
next.
> > > > >
> > > > >That is why we use _safe, but we need to ensure that llist_for_eac=
h_safe()
> > > > >completes LOAD(work->node->next) before VHOST_WORK_QUEUED is clear=
ed.
> > > >
> > > > This should be fine since store is not speculated, so work->node->n=
ext needs
> > > > to be loaded before VHOST_WORK_QUEUED is cleared to meet the loop c=
ondition.
> > >
> > > I don't understand you. OK, to simplify, suppose we have 2 global var=
s
> > >
> > >         void *PTR =3D something_non_null;
> > >         unsigned long FLAGS =3D -1ul;
> > >
> > > Now I think this code
> > >
> > >         CPU_0                           CPU_1
> > >
> > >         void *ptr =3D PTR;                if (!test_and_set_bit(0, FL=
AGS))
> > >         clear_bit(0, FLAGS);                    PTR =3D NULL;
> > >         BUG_ON(!ptr);
> > >
> > > is racy and can hit the BUG_ON(!ptr).
> >
> > This seems different to the above case?
>
> not sure,
>
> > And you can hit BUG_ON with
> > the following execution sequence:
> >
> > [cpu 0] clear_bit(0, FLAGS);
> > [cpu 1] if (!test_and_set_bit(0, FLAGS))
> > [cpu 1] PTR =3D NULL;
> > [cpu 0] BUG_ON(!ptr)
>
> I don't understand this part... yes, we can hit this BUG_ON() without mb =
in
> between, this is what I tried to say.

I may miss something, but the above is the sequence that is executed
by the processor (for each CPU, it's just the program order). So where
do you expect to place an mb can help?

>
> > In vhost code, there's a condition before the clear_bit() which sits
> > inside llist_for_each_entry_safe():
> >
> > #define llist_for_each_entry_safe(pos, n, node, member)                =
        \
> >         for (pos =3D llist_entry((node), typeof(*pos), member);        =
          \
> >              member_address_is_nonnull(pos, member) &&                 =
        \
> >                 (n =3D llist_entry(pos->member.next, typeof(*n), member=
), true); \
> >              pos =3D n)
> >
> > The clear_bit() is a store which is not speculated, so there's a
> > control dependency, the store can't be executed until the condition
> > expression is evaluated which requires pos->member.next
> > (work->node.next) to be loaded.
>
> But llist_for_each_entry_safe() doesn't check "n", I mean, it is not that=
 we have
> something like
>
>         n =3D llist_entry(...);
>         if (n)
>                 clear_bit(...);
>
> so I do not see how can we rely on the load-store control dependency.

Just to make sure we are on the same page, the condition expression is

member_address_is_nonnull(pos, member) && (n =3D
llist_entry(pos->member.next, typeof(*n), member), true)

So it's something like:

if (work->node && (work_next =3D work->node->next, true))
    clear_bit(&work->flags);

So two loads from both work->node and work->node->next, and there's a
store which is clear_bit, then it's a load-store control dependencies?

Thanks

>
> Oleg.
>

