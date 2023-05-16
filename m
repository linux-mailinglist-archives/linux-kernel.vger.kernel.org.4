Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE50F704F66
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 15:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbjEPNfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 09:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbjEPNfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 09:35:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89139DC
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 06:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684244077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=45UqYriNQVtdBFesR+jleqsSy4ksjE6lhJMxVSYplvo=;
        b=jImryifERTRRuLIyl4VEko9QE84zkBWlKRJfKrqxVyrKkdFNbNh1aQa9O8NzWnIyg/h+fo
        SUfHZjqptjJN3yhUyvWKs3MK9Zcz8mNpb/JUZPldGcwG6AcAFfdGTIH7TDrWx2iwcnfXVC
        vxrVUOT/Z8pQD2q0EGqLbx4SSsPF0aI=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-I5iNzZwfMO-OpIq7-EMWdw-1; Tue, 16 May 2023 09:34:36 -0400
X-MC-Unique: I5iNzZwfMO-OpIq7-EMWdw-1
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-ba71ed074ceso5311312276.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 06:34:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684244075; x=1686836075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=45UqYriNQVtdBFesR+jleqsSy4ksjE6lhJMxVSYplvo=;
        b=Kw352jkAfNuO3DHsRjFO36H+pz6qQXZWYwT/p+u/2IvmDn7IH/Rn14FTxh+Se7P8Y0
         KoI/vX9yJu2FBlTzp6fImA3n/Me8fe5HqgfCkrMvx+sJ7huwL/De/b1hcEB6wL9epSPM
         47goHq7jaYoI8umxDHvj4yI3W7QGyOQ5QDUl8y2Iu/3XHaVL1bmKrrqf6YBQi3bej+z3
         QZckilXnlouVeYPMMx9Mg9X3XQXTlleKDht6leo47aFsrntFAx2n2/ZNF1nnUvQIj+u+
         U4I7w/eP0+xXtp/UPMfGAoxU8uCAMTOh0a0e/kASymMSFTg7EcWgxAOfgI40/mGtg0SV
         TgJw==
X-Gm-Message-State: AC+VfDxNByN1jPi+PNDnAyO06QhT92m3MYKXaun5h8gG0/psCIMLG3mE
        SNNyrxcTivHyWnvMyZMGn5oT4T+dtIrRKokn4mO8EmDe6kNHoaWdD2naBmrtHSdfEBItc6eUQwp
        yasVxp5bT5x2crg0XixaiH1EYHyvPxEAqU6oOw8+l
X-Received: by 2002:a0d:d847:0:b0:561:b246:77df with SMTP id a68-20020a0dd847000000b00561b24677dfmr491852ywe.16.1684244075581;
        Tue, 16 May 2023 06:34:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5a8XsAcCfmDEhTwmeBSPI5gRAlk+fKBy37/4QgPjAyDxSQYLttDSUO8ua8sZeUNWVP3Ts21WU0gwhJWqir3M4=
X-Received: by 2002:a0d:d847:0:b0:561:b246:77df with SMTP id
 a68-20020a0dd847000000b00561b24677dfmr491841ywe.16.1684244075332; Tue, 16 May
 2023 06:34:35 -0700 (PDT)
MIME-Version: 1.0
References: <9b987585-0834-bb8c-3414-283c29f3f2ab@leemhuis.info>
 <bec024d5-4088-00ae-f7b5-7188868b1707@leemhuis.info> <b7717c43-74bf-b91d-d3ce-874493df602c@gmail.com>
In-Reply-To: <b7717c43-74bf-b91d-d3ce-874493df602c@gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 16 May 2023 15:34:24 +0200
Message-ID: <CAO-hwJ+At1J_yUpX2q_dJekzZ-PoTDAvxmkTk_e4Yu0Z338bEA@mail.gmail.com>
Subject: Re: [regression] Since kernel 6.3.1 logitech unify receiver not
 working properly
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@riseup.net>,
        Bastien Nocera <hadess@hadess.net>,
        Jiri Kosina <jikos@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, guy.b@bluewin.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 3:25=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmail.com=
> wrote:
>
> On 5/11/23 18:58, Thorsten Leemhuis wrote:
> > Hi, Thorsten here, the Linux kernel's regression tracker.
> >
> > On 08.05.23 11:55, Linux regression tracking (Thorsten Leemhuis) wrote:
> >> Hi, Thorsten here, the Linux kernel's regression tracker.
> >>
> >> I noticed a regression report in bugzilla.kernel.org. As many (most?)
> >> kernel developers don't keep an eye on it, I decided to forward it by =
mail.
> >>
> >> Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=3D217412 :
> >
> > TWIMC: a few other users (three or four iirc) showed up in that ticket
> > and reported problems with the receiver, albeit the symptoms are not
> > exactly the same for all of them, so there might be more than one probl=
em.
> >
> > I'll try to motivate the affected users to perform a bisection. But
> > would be great if those with more knowledge about this code could
> > briefly look into the ticket, maybe the details the users shared allows
> > one of you to guess what causes this.
> >
>
> Hmm,
>
> You noted in the similar report [1] that developers involved here
> ignore this regressions. I wonder if Linus has to be hired in
> this case, and if it is the case, let's take a look and hear closely what
> he will say.

Sigh... Not answering an email is bad, but maybe you can also
understand that developers can take days off?

And it turns out that I was waiting for Bastien to chime in, but I can
access his calendar too and just found out that he was AFK for the
entire month, except for the first week, which I wasn't aware. May is
a time where people in France have a lot of public holidays and is
also the cut to use those time off or they expire.

For me, I'll also be taking time off the rest of this week, so I won't
be able to have a look at this until next week at the earliest.

Cheers,
Benjamin

>
> Thanks.
>
>
> [1]: https://lore.kernel.org/regressions/8941c5f2-3861-da68-06ca-adc68a37=
e53b@leemhuis.info/
>
> --
> An old man doll... just what I always wanted! - Clara
>

