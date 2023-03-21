Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8336C3797
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 18:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjCURDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 13:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjCURDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 13:03:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84F24ECD4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 10:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679418134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ho/MkDDhxFKmrwC0iiq6Sx1XjzmlAyM/mNn4nWOq2f0=;
        b=VkDBg3L6fClBuWnRUZ8RmumLUqvkIR2CRS5eLKcwehGdZhTZyNPdMB2JSt1B0RhVXiBWXa
        YLO9UMG5CrnQEcAEJB2/SRgR9l6ax0f98oR6iaC1C+TgHimI9zOvJpem+W+Y5MhzyrBws1
        Ih6iDScGm9jAC9u3zIzL/T3kXJayqsQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-xYbtQoIOOq245M86REJv5g-1; Tue, 21 Mar 2023 13:02:12 -0400
X-MC-Unique: xYbtQoIOOq245M86REJv5g-1
Received: by mail-qv1-f69.google.com with SMTP id c15-20020a056214070f00b005bb308e7c12so6798664qvz.19
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 10:02:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679418132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ho/MkDDhxFKmrwC0iiq6Sx1XjzmlAyM/mNn4nWOq2f0=;
        b=rg+yD7+Nuj70HsXEelU3gWsAiCKWW5ZBUNCIP2GEhxyr9iwMOtR1dsg3sgPo/jSDjB
         u2Q0e8eSpobfybqRk34yDLcKfDgrzE+2rFrbJemegMwNvGnh1DrUxTOWj3xiLtFRxbHM
         B7SnD/SZp8nO8L/TAwGEFv/zuer/2B86QnuSyOnaEsPlN/pQrD8b0Wd8IlnlJx3FNXvc
         hcvtASFWTK/6RKHyybKPqdjYY5V9L59by1XmghUb17Ub3jT+z7EBA/g+t/Jjlti3mmGS
         sW7r+/3adFuhRNxec7ejA6IyuYBlc/SvxjHfdofSUDXVqfXw6hFZwJ8uIw+YPgb0fM1p
         /o6A==
X-Gm-Message-State: AO0yUKXc6XwdPLUFFFoqoTj8b+41XCEQAR6596hYPxNY7tI3US1frLvf
        xs93fLaMZUuxnqgqgiCj+qkORBcmuXB5GnPXmAqFGn6XRl40+hXBSRHSZYaa5d/Tt9Sq+pGhEgj
        pip+9uIJPl21CyVUBq6ANqBn+fT5Fp24DomvtAqAl
X-Received: by 2002:a05:620a:99b:b0:746:7701:adc6 with SMTP id x27-20020a05620a099b00b007467701adc6mr83476qkx.15.1679418131733;
        Tue, 21 Mar 2023 10:02:11 -0700 (PDT)
X-Google-Smtp-Source: AK7set+FU09tlKowZp3MqkTFriSfnCbbirqmiRsT1Sq8rUKBNylhVkzT4U9TLQte5ISgz90D40NefdWf/i7ObG/cCWk=
X-Received: by 2002:a05:620a:99b:b0:746:7701:adc6 with SMTP id
 x27-20020a05620a099b00b007467701adc6mr83463qkx.15.1679418131346; Tue, 21 Mar
 2023 10:02:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230318080059.1109286-1-leobras@redhat.com> <8f698f49-135a-4263-8471-96f406919cb1@spud>
 <4f35f41c143b02b6b815e7eb527ca3acd8b4aabe.camel@redhat.com> <18e07d0a-7e21-46d0-9166-6ee07817352a@spud>
In-Reply-To: <18e07d0a-7e21-46d0-9166-6ee07817352a@spud>
From:   Leonardo Bras Soares Passos <leobras@redhat.com>
Date:   Tue, 21 Mar 2023 14:01:59 -0300
Message-ID: <CAJ6HWG5zHMB1-vVsuQ+nG3EC12JAi2MP5o8GbSQ9QJfgLEQNnw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] Deduplicating RISCV cmpxchg.h macros
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 4:49=E2=80=AFAM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> On Tue, Mar 21, 2023 at 03:30:35AM -0300, Leonardo Br=C3=A1s wrote:
> > Hello Conor, thanks for the feedback!
> >
> >
> > On Sun, 2023-03-19 at 20:35 +0000, Conor Dooley wrote:
> > > On Sat, Mar 18, 2023 at 05:00:54AM -0300, Leonardo Bras wrote:
> > > > While studying riscv's cmpxchg.h file, I got really interested in
> > > > understanding how RISCV asm implemented the different versions of
> > > > {cmp,}xchg.
> > > >
> > > > When I understood the pattern, it made sense for me to remove the
> > > > duplications and create macros to make it easier to understand what=
 exactly
> > > > changes between the versions: Instruction sufixes & barriers.
> > > >
> > > > I split those changes in 3 levels for each cmpxchg and xchg, result=
ing a
> > > > total of 6 patches. I did this so it becomes easier to review and r=
emove
> > > > the last levels if desired, but I have no issue squashing them if i=
t's
> > > > better.
> > > >
> > > > Please provide comments.
> > > >
> > > > Thanks!
> > > > Leo
> > > >
> > > > Leonardo Bras (6):
> > > >   riscv/cmpxchg: Deduplicate cmpxchg() asm functions
> > > >   riscv/cmpxchg: Deduplicate cmpxchg() macros
> > > >   riscv/cmpxchg: Deduplicate arch_cmpxchg() macros
> > >
> > > >   riscv/cmpxchg: Deduplicate xchg() asm functions
> > >
> > > FWIW, this patch seems to break the build pretty badly:
> > > https://patchwork.kernel.org/project/linux-riscv/patch/20230318080059=
.1109286-5-leobras@redhat.com/
> >
> > Thanks for pointing out!
> >
> > It was an intermediary error:
> > Sufix for amoswap on acquire version was "d.aqrl" instead of the
> > correct".d.aqrl", and that caused the fail.
> >
> > I did not notice anything because the next commit made it more general,=
 and thus
> > removed this line of code. I will send a v2-RFC shortly.
> >
> > I see that patch 4/6 has 5 fails, but on each one of them I can see:
> > "I: build output in /ci/workspace/[...]", or
> > ""I: build output in /tmp/[...]".
>
> I don't push the built artifacts anywhere, just the brief logs -
> although the "failed to build" log isn't very helpful other than telling
> you the build broke.
> That seems like a bug w.r.t. where tuxmake prints its output. I'll try
> to fix that.

Thanks for that :)

>
> > I could not find any reference to where this is saved, though.
> > Could you point where can I find the error output, just for the sake of=
 further
> > debugging?
> >
> > >
> > > Patches 1 & 5 also add quite a lot of sparse issues (like 1000), but =
I
> > > think that may be more of an artifact of the testing process as oppos=
ed
> > > to something caused by this patchset.
> >
> > For those I can see the build output diffs. Both added error lines to
> > conchuod/build_rv64_gcc_allmodconfig.
> > I tried to mimic this with [make allmodconfig + gcc build with
> > CROSS_COMPILE=3Driscv64-linux-gnu- ] but I could not get any error in a=
ny patch.
>
> If you can't replicate them, it's probably because they come from
> sparse. I only really mentioned it here in case you went looking at the
> other patches in the series and were wondering why things were so amiss.

Oh, it makes sense.

>
> > For patch 1/6 it removes as much error lines (-) as it adds (+), and th=
e error
> > messages are mostly the same, apart for an line number.
>
> I don't see a line number difference, but rather an increase in the
> number of times the same error lines have appeared in the output.
> I don't find the single-line output from sparse to really be very
> helpful, I should probably have a bit of a think how to present that
> information better.

Oh, I see.
The number at the beginning relates to the number of times the error happen=
s.
Ok it makes sense to me now :)

>
> > For patch 5/6 it actually adds many more lines, but tracking (some of) =
the
> > errors gave me no idea why.
>
> Probably just sparse being unhappy with some way the macros were
> changed - but some of it ("Should it be static?" bits) look very much
> like the patch causing things to be rebuilt only for the "after the
> patch" build, but somehow not for the "before" build.

Humm, not sure I could understand that last part:
What I get is that the patch 5/6 is causing things to be rebuilt, and
it was not like that on 1-4/6.
Is that what you said?
If so, and you are doing it as an incremental build, changing the
macros in 5/6 should be triggering rebuilds, but it does not make
sense to not be rebuilt in 1-4/6 as they change the same macros.

Thanks for the feedback!

Best regards,
Leo

