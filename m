Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27A26C413A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 04:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjCVDoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 23:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCVDn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 23:43:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D22B75F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 20:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679456591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lrf/XdNOsvLMGRhBjqf6cL2fHtpUXGfZ7Je7JgZAOhA=;
        b=TOCLE8AKstLaTwu7F6ADtbRjvvSRqNN8mXZmFgzDy4i41/Mv2qUogVElAAnQvp5bQinD61
        JoUHNqEyulkqd0fyT3ZA7SbSnk6ogN3u3+ieqOnPgXZuU6NLTVyjXQsrabStroH4AITcAs
        Nhn0bguxGZfATV+pSpzvb2Zx+aa50Rw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-Wj7QvMQeOWGrCc70nl61Iw-1; Tue, 21 Mar 2023 23:43:08 -0400
X-MC-Unique: Wj7QvMQeOWGrCc70nl61Iw-1
Received: by mail-qt1-f198.google.com with SMTP id f36-20020a05622a1a2400b003deb2fa544bso6182249qtb.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 20:43:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679456587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lrf/XdNOsvLMGRhBjqf6cL2fHtpUXGfZ7Je7JgZAOhA=;
        b=sXt/KuiOkgb5N+MPWojvGA0+cR7LToMnNWm9nkN478u/ggkjMquLleX8il8nIyGqjl
         jQgqbZgTM5ewxQQ+UVg9jLiW+pvgn9KcVyDhxZ4nleynlynO/qsJQHaM65+vRv68MuXG
         3O/C9QUgCejnUT1BUqxdyIk1wBtqd6FS6l2L5oX27ydHvK0rGbl5dwQDlNeTKkft5tpg
         hyXyMY7Aop8G+X2jc9hwFAbe0ODMow4t3gXjOpGAvm8YUHA/L0tnCyV7qIGWyJ4J9pFg
         +VkGT2jI2S5TOu6fvHj0+PrFzcLXLuNY6pV+1Svwc9oL2TM9i3ES+YRdLXtChuUzF5h+
         D3Ng==
X-Gm-Message-State: AO0yUKXQlUDu1vpZKqjmGjDjQn3hmySCe2aQTt1AY8WGEi62ab3t+1dx
        BIJd6chnlFr6Uorm/U0dj+Yl5oOEkmTIS54l63IWahdBXqtnmO4tpdFdeLOtxOw2VaR/8voLT/7
        Zw8mS3NRYb5t8ycz/SzCLgL5/VeeAXMVBSj++EkcT
X-Received: by 2002:a05:6214:8c7:b0:537:7476:41f7 with SMTP id da7-20020a05621408c700b00537747641f7mr495417qvb.3.1679456587566;
        Tue, 21 Mar 2023 20:43:07 -0700 (PDT)
X-Google-Smtp-Source: AK7set8k6gBfjyU341I6MjXPfux6c1GDT0SwUyfeQ7CTHdY7SEbJ+BMisEVgrchSL00Hu3VqCV/zeZYFl4LygEDRQtA=
X-Received: by 2002:a05:6214:8c7:b0:537:7476:41f7 with SMTP id
 da7-20020a05621408c700b00537747641f7mr495413qvb.3.1679456587241; Tue, 21 Mar
 2023 20:43:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230318080059.1109286-1-leobras@redhat.com> <8f698f49-135a-4263-8471-96f406919cb1@spud>
 <4f35f41c143b02b6b815e7eb527ca3acd8b4aabe.camel@redhat.com>
 <18e07d0a-7e21-46d0-9166-6ee07817352a@spud> <CAJ6HWG5zHMB1-vVsuQ+nG3EC12JAi2MP5o8GbSQ9QJfgLEQNnw@mail.gmail.com>
 <4d9770c7-3cb6-42d6-891f-1247a02742e9@spud>
In-Reply-To: <4d9770c7-3cb6-42d6-891f-1247a02742e9@spud>
From:   Leonardo Bras Soares Passos <leobras@redhat.com>
Date:   Wed, 22 Mar 2023 00:42:56 -0300
Message-ID: <CAJ6HWG5+5f_z7HaVb70w4wxtTbyMMxwTAwpk5gv4C4JiSve5iA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] Deduplicating RISCV cmpxchg.h macros
To:     Conor Dooley <conor@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 4:48=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Tue, Mar 21, 2023 at 02:01:59PM -0300, Leonardo Bras Soares Passos wro=
te:
> > On Tue, Mar 21, 2023 at 4:49=E2=80=AFAM Conor Dooley <conor.dooley@micr=
ochip.com> wrote:
> > > On Tue, Mar 21, 2023 at 03:30:35AM -0300, Leonardo Br=C3=A1s wrote:
> > > > On Sun, 2023-03-19 at 20:35 +0000, Conor Dooley wrote:
> > > > > On Sat, Mar 18, 2023 at 05:00:54AM -0300, Leonardo Bras wrote:
> > > > > > While studying riscv's cmpxchg.h file, I got really interested =
in
> > > > > > understanding how RISCV asm implemented the different versions =
of
> > > > > > {cmp,}xchg.
> > > > > >
> > > > > > When I understood the pattern, it made sense for me to remove t=
he
> > > > > > duplications and create macros to make it easier to understand =
what exactly
> > > > > > changes between the versions: Instruction sufixes & barriers.
> > > > > >
> > > > > > I split those changes in 3 levels for each cmpxchg and xchg, re=
sulting a
> > > > > > total of 6 patches. I did this so it becomes easier to review a=
nd remove
> > > > > > the last levels if desired, but I have no issue squashing them =
if it's
> > > > > > better.
> > > > > >
> > > > > > Please provide comments.
> > > > > >
> > > > > > Thanks!
> > > > > > Leo
> > > > > >
> > > > > > Leonardo Bras (6):
> > > > > >   riscv/cmpxchg: Deduplicate cmpxchg() asm functions
> > > > > >   riscv/cmpxchg: Deduplicate cmpxchg() macros
> > > > > >   riscv/cmpxchg: Deduplicate arch_cmpxchg() macros
> > > > >
> > > > > >   riscv/cmpxchg: Deduplicate xchg() asm functions
> > > > >
> > > > > FWIW, this patch seems to break the build pretty badly:
> > > > > https://patchwork.kernel.org/project/linux-riscv/patch/2023031808=
0059.1109286-5-leobras@redhat.com/
> > > >
> > > > Thanks for pointing out!
> > > >
> > > > It was an intermediary error:
> > > > Sufix for amoswap on acquire version was "d.aqrl" instead of the
> > > > correct".d.aqrl", and that caused the fail.
> > > >
> > > > I did not notice anything because the next commit made it more gene=
ral, and thus
> > > > removed this line of code. I will send a v2-RFC shortly.
> > > >
> > > > I see that patch 4/6 has 5 fails, but on each one of them I can see=
:
> > > > "I: build output in /ci/workspace/[...]", or
> > > > ""I: build output in /tmp/[...]".
> > >
> > > I don't push the built artifacts anywhere, just the brief logs -
> > > although the "failed to build" log isn't very helpful other than tell=
ing
> > > you the build broke.
> > > That seems like a bug w.r.t. where tuxmake prints its output. I'll tr=
y
> > > to fix that.
> >
> > Thanks for that :)
>
> I've pushed what I think is a fix, the wrong log file was being grepped
> for errors in the case of a failed build.

Thanks!

>
> > > > I could not find any reference to where this is saved, though.
> > > > Could you point where can I find the error output, just for the sak=
e of further
> > > > debugging?
> > > >
> > > > >
> > > > > Patches 1 & 5 also add quite a lot of sparse issues (like 1000), =
but I
> > > > > think that may be more of an artifact of the testing process as o=
pposed
> > > > > to something caused by this patchset.
> > > >
> > > > For those I can see the build output diffs. Both added error lines =
to
> > > > conchuod/build_rv64_gcc_allmodconfig.
> > > > I tried to mimic this with [make allmodconfig + gcc build with
> > > > CROSS_COMPILE=3Driscv64-linux-gnu- ] but I could not get any error =
in any patch.
> > >
> > > If you can't replicate them, it's probably because they come from
> > > sparse. I only really mentioned it here in case you went looking at t=
he
> > > other patches in the series and were wondering why things were so ami=
ss.
> >
> > Oh, it makes sense.
> >
> > >
> > > > For patch 1/6 it removes as much error lines (-) as it adds (+), an=
d the error
> > > > messages are mostly the same, apart for an line number.
> > >
> > > I don't see a line number difference, but rather an increase in the
> > > number of times the same error lines have appeared in the output.
> > > I don't find the single-line output from sparse to really be very
> > > helpful, I should probably have a bit of a think how to present that
> > > information better.
> >
> > Oh, I see.
> > The number at the beginning relates to the number of times the error ha=
ppens.
> > Ok it makes sense to me now :)
> >
> > >
> > > > For patch 5/6 it actually adds many more lines, but tracking (some =
of) the
> > > > errors gave me no idea why.
> > >
> > > Probably just sparse being unhappy with some way the macros were
> > > changed - but some of it ("Should it be static?" bits) look very much
> > > like the patch causing things to be rebuilt only for the "after the
> > > patch" build, but somehow not for the "before" build.
> >
> > Humm, not sure I could understand that last part:
> > What I get is that the patch 5/6 is causing things to be rebuilt, and
> > it was not like that on 1-4/6.
> > Is that what you said?
> > If so, and you are doing it as an incremental build, changing the
> > macros in 5/6 should be triggering rebuilds, but it does not make
> > sense to not be rebuilt in 1-4/6 as they change the same macros.
>
> Right, it is an incremental build.
> First it builds the tree with a patch applied, then it checks out HEAD~1
> and builds that tree. Then it goes back to the tree with the patch
> applied and builds it again. The output from builds 2 & 3 are compared
> to see if any errors snuck in.
> In theory, that should ensure that, as builds 2 & 3 have had the same
> diff to the previous one just in opposite directions, the same files get
> rebuilt - but I am a little worried that ccache gets involved sometimes
> and leads to the before/after builds not being exactly the same.

Makes sense to me.

>
> They may very well be real issues as your refactor has caused the
> casting in the macros to change or w/e. Not my area of expertise by any
> stretch of the imagination, but the lkp sparse is out of date & doesn't
> run any more so I figure it's better to be running the stuff, even if it
> does sometimes result in a splurge of errors like this than forget about
> poor aul sparse.

I agree with you.
Better deal with sporadic spurious errors than not testing at all.

>
> Cheers,
> Conor.

Best regards,
Leo

