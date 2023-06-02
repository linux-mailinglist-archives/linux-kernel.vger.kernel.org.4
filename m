Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B847B71F989
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 07:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbjFBFEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 01:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbjFBFEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 01:04:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D497137
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 22:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685682201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sIus8gJyXRsINV2kC7yuh3plUDjK31JMCFZ/y6jp9No=;
        b=A8N78Rlr/gL9P+NJgpPDtSN1LzLG+VBGHlxx8+PZ1zBIa3AAq+vHHeQw4ZyZs362lQnL0/
        mwYYZNbBLketTpui8+yWMoZKKvC8sgfRr8y7kG0uv9lbAkknve7k8Nra9+RuhTGCgGm8xD
        T5Pyha+RjAQTZFq3tvVjPjVUEoSYn3M=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-na6VVbaNOVWM1w8kE1yzJg-1; Fri, 02 Jun 2023 01:03:19 -0400
X-MC-Unique: na6VVbaNOVWM1w8kE1yzJg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b1aa4c942eso3759361fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 22:03:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685682198; x=1688274198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sIus8gJyXRsINV2kC7yuh3plUDjK31JMCFZ/y6jp9No=;
        b=WHMe6fYT69GTyIEFHUSyaJisUsN6FhtB/NZOv2sXTAW4NZxmKXw4F8/0iMDR7omY1p
         zd9B0nYY62xCzsJ0DD1SPOEGIhLl6BaG+ihIcUHJ2O7LHlwzuQ1SEcNgk3fIbqk889rG
         4xTFu+Pln6csOVHvozbJ9hPrPXgTM2YnKgWlCqV4xN0wz8mtl4f+7KADNBNeXsN9nMlD
         CWxVaDd/rwR95iOm9Vfrb9jKFeBZrfQB268Mi4AR+M34VWF1t4x23BFqfxsUanzZY9er
         d8cY0gwvBnGkamAlp3QlZ6X2US91+xJ4iMmo7IJvQhhzxjYXaTrTEeTfAlrfiWbdL89f
         6wmQ==
X-Gm-Message-State: AC+VfDzIXkywfzqD7G1K4xnhPFUTSRFHig9JRgpCZe6Ms3r4Ucfca4G1
        hW7nbROmjsYhtUhpJpFTTX4OPO+fK+EkngonSuwZ10n6us2nAYsrIRAIYXki60znEjiwMs9rsAG
        IAJyfW7b7TcQw6eZ4bL+Q3pcxBFIC4Novjy996/y2
X-Received: by 2002:a2e:9005:0:b0:2ad:ac93:3c7d with SMTP id h5-20020a2e9005000000b002adac933c7dmr834969ljg.38.1685682198387;
        Thu, 01 Jun 2023 22:03:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4acTNwUqkxLVnp1Fp3xQamkPAm5e0xnQ7itKvZifc9MbO7W1sccpL2CPgJri2rUAflF0QjCvNNmlNGwY2oTuk=
X-Received: by 2002:a2e:9005:0:b0:2ad:ac93:3c7d with SMTP id
 h5-20020a2e9005000000b002adac933c7dmr834949ljg.38.1685682198003; Thu, 01 Jun
 2023 22:03:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230522025124.5863-4-michael.christie@oracle.com>
 <20230522123029.GA22159@redhat.com> <cfca7764-d210-6df9-e182-2c093101c6cf@oracle.com>
 <20230522174757.GC22159@redhat.com> <20230523121506.GA6562@redhat.com>
 <26c87be0-8e19-d677-a51b-e6821e6f7ae4@redhat.com> <20230531072449.GA25046@redhat.com>
 <CACGkMEv2kB9J1qGYkGkywk1YHV2gU2fMr7qx4vEv9L5f6qL5mg@mail.gmail.com>
 <20230531091432.GB25046@redhat.com> <CACGkMEvNrC5gc4ppp0QG-SNSbs_snrqwPkNBotffRRDJA1VJjQ@mail.gmail.com>
 <20230601074315.GA13133@redhat.com>
In-Reply-To: <20230601074315.GA13133@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 2 Jun 2023 13:03:06 +0800
Message-ID: <CACGkMEss2LkUiUKaEkhBWwFDBBz31T3N94a0=zSD1d+Fhb1zyQ@mail.gmail.com>
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

On Thu, Jun 1, 2023 at 3:43=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wrot=
e:
>
> On 06/01, Jason Wang wrote:
> >
> > On Wed, May 31, 2023 at 5:14=E2=80=AFPM Oleg Nesterov <oleg@redhat.com>=
 wrote:
> > >
> > > > > I don't understand you. OK, to simplify, suppose we have 2 global=
 vars
> > > > >
> > > > >         void *PTR =3D something_non_null;
> > > > >         unsigned long FLAGS =3D -1ul;
> > > > >
> > > > > Now I think this code
> > > > >
> > > > >         CPU_0                           CPU_1
> > > > >
> > > > >         void *ptr =3D PTR;                if (!test_and_set_bit(0=
, FLAGS))
> > > > >         clear_bit(0, FLAGS);                    PTR =3D NULL;
> > > > >         BUG_ON(!ptr);
> > > > >
> > > > > is racy and can hit the BUG_ON(!ptr).
> > > >
> > > > This seems different to the above case?
> > >
> > > not sure,
> > >
> > > > And you can hit BUG_ON with
> > > > the following execution sequence:
> > > >
> > > > [cpu 0] clear_bit(0, FLAGS);
> > > > [cpu 1] if (!test_and_set_bit(0, FLAGS))
> > > > [cpu 1] PTR =3D NULL;
> > > > [cpu 0] BUG_ON(!ptr)
> > >
> > > I don't understand this part... yes, we can hit this BUG_ON() without=
 mb in
> > > between, this is what I tried to say.
> >
> > I may miss something,
>
> Or me... note that CPU_0 loads the global "PTR" into the local "ptr" befo=
re clear_bit.
> Since you have mentioned the program order: yes this lacks READ_ONCE() or=
 barrier(),
> but the same is true for the code in vhost_worker(). So I still don't und=
erstand.
>
> > but the above is the sequence that is executed
> > by the processor (for each CPU, it's just the program order). So where
> > do you expect to place an mb can help?
>
> before clear_bit:
>
>         CPU_0
>
>         void *ptr =3D PTR;
>         mb();                   // implies compiler barrier as well
>         clear_bit(0, FLAGS);
>         BUG_ON(!ptr);
>
> just in case... mb() in the code above is only for illustration, we can u=
se
> smp_mb__before_atomic() + clear_bit(). Or just clear_bit_unlock(), iiuc t=
he
> one-way barrier is fine in this case.

Ok, but it seems different, in the case of vhost we had a condition
above the clear_bit().

>
>
> > > > In vhost code, there's a condition before the clear_bit() which sit=
s
> > > > inside llist_for_each_entry_safe():
> > > >
> > > > #define llist_for_each_entry_safe(pos, n, node, member)            =
            \
> > > >         for (pos =3D llist_entry((node), typeof(*pos), member);    =
              \
> > > >              member_address_is_nonnull(pos, member) &&             =
            \
> > > >                 (n =3D llist_entry(pos->member.next, typeof(*n), me=
mber), true); \
> > > >              pos =3D n)
> > > >
> > > > The clear_bit() is a store which is not speculated, so there's a
> > > > control dependency, the store can't be executed until the condition
> > > > expression is evaluated which requires pos->member.next
> > > > (work->node.next) to be loaded.
> > >
> > > But llist_for_each_entry_safe() doesn't check "n", I mean, it is not =
that we have
> > > something like
> > >
> > >         n =3D llist_entry(...);
> > >         if (n)
> > >                 clear_bit(...);
> > >
> > > so I do not see how can we rely on the load-store control dependency.
> >
> > Just to make sure we are on the same page, the condition expression is
> >
> > member_address_is_nonnull(pos, member) && (n =3D
> > llist_entry(pos->member.next, typeof(*n), member), true)
> >
> > So it's something like:
> >
> > if (work->node && (work_next =3D work->node->next, true))
> >     clear_bit(&work->flags);
> >
> > So two loads from both work->node and work->node->next, and there's a
> > store which is clear_bit, then it's a load-store control dependencies?
>
> I guess you missed the comma expression...

Probably not, see below:

> Let me rewrite your pseudo-code
> above, it is equivalent to
>
>         if (work->node) {
>                 if ((work_next =3D work->node->next, true))
>                         clear_bit(&work->flags);
>         }
>
> another rewrite:
>
>         if (work->node) {
>                 work_next =3D work->node->next;
>                 if ((work, true))
>                         clear_bit(&work->flags);
>         }
>
> and the final rewrite:
>
>         if (work->node) {
>                 work_next =3D work->node->next;
>                 if (true)
>                         clear_bit(&work->flags);
>         }
>
> so again, I do not see the load-store control dependency.

This kind of optimization is suspicious. Especially considering it's
the control expression of the loop but not a condition.

Looking at the assembly (x86):

   0xffffffff81d46c5b <+75>:    callq  0xffffffff81689ac0 <llist_reverse_or=
der>
   0xffffffff81d46c60 <+80>:    mov    %rax,%r15
   0xffffffff81d46c63 <+83>:    test   %rax,%rax
   0xffffffff81d46c66 <+86>:    je     0xffffffff81d46c3a <vhost_worker+42>
   0xffffffff81d46c68 <+88>:    mov    %r15,%rdi
   0xffffffff81d46c6b <+91>:    mov    (%r15),%r15
   0xffffffff81d46c6e <+94>:    lock andb $0xfd,0x10(%rdi)
   0xffffffff81d46c73 <+99>:    movl   $0x0,0x18(%rbx)
   0xffffffff81d46c7a <+106>:   mov    0x8(%rdi),%rax
   0xffffffff81d46c7e <+110>:   callq  0xffffffff821b39a0
<__x86_indirect_thunk_array>
   0xffffffff81d46c83 <+115>:   callq  0xffffffff821b4d10 <__SCT__cond_resc=
hed>
...

I can see:

1) The code read node->next (+91) before clear_bit (+94)
2) And the it uses a lock prefix to guarantee the execution order

> Not to mention this
> code lacks READ_ONCE().

Work_next is loaded only once for temporary storage, so I don't see
why we need that.

Thanks



>
>
> If we had something like
>
>         if (work->node) {
>                 work_next =3D READ_ONCE(work->node->next);
>                 if (work_next)
>                         clear_bit(&work->flags);
>         }
>
> instead, then yes, we could rely on the LOAD-STORE dependency.
>
> Oleg.
>

