Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C95710ABB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 13:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240902AbjEYLUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 07:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240549AbjEYLUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 07:20:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18FE191
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 04:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685013575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5F4e37hxoARs4fANzF7y1sP1lg39Ahh3is7WLZy58tg=;
        b=Yt5A+1wDIUJoq8Ks+hO+1/7au9veR/2Kfp3Q/CaoP5OSMG9ChVWif9t22vnKhFgam3HxHR
        oFK+HLx6WeoKxNK0Vr/Mz6NC++i5iV1t+jiRNiL3t0I/2I0k3h0plZxNKuRSlXSrYBZqWB
        dh/xcb2IvBIuaquVuzBwDxJu+jdn6MA=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-55paiocSNGyxwGE2tiUmVQ-1; Thu, 25 May 2023 07:19:33 -0400
X-MC-Unique: 55paiocSNGyxwGE2tiUmVQ-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-564f529a663so7013817b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 04:19:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685013573; x=1687605573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5F4e37hxoARs4fANzF7y1sP1lg39Ahh3is7WLZy58tg=;
        b=lDhEwXTkWGP9pyDVT3tVFJx1zFrzYifTpSa+USYvyfIE1WXK0DKk6LEh29Hw2AUEqd
         3Lv8qe7J1N43BfHlSSKDN7R93C4+MXxZOfilSO3CLWrGY3RRDIu4k4DT4dhh2kQalfmv
         IlnhXb/rN4lVJYTW6B+XdM4YX2s/O5/eH1ewBitKIqBrowAj0ZmZp/gfKzo6Cnc5aqSK
         s05X/rmhxOslGgi7VTTkS5ZGyEtqDi0okWQkpxywg2a1gfs3GRTSJWC6AD/cKKnmSaoZ
         xKrBMJPzFAP30wm4NxCWwgdoM1+zPQXlYg4GssEVHgVL45yxyHqjK2sUSifJnqCBxA+K
         fcJQ==
X-Gm-Message-State: AC+VfDydS1YlIihAboAKH7cScG/dN3wi6xyZrSFMvu7+bGEKlJkiyklE
        LqbPxadRQ0oXaOSCyFXxgvE4kBTadANnnhMgBjpnREMaju0O+2fZDzq0bs3965JwWMjsf1Wuzsp
        vtnpuqW8PPNIKhi93lcoc9Cahf+ZUeZaeh6LDqF2R
X-Received: by 2002:a81:ab50:0:b0:559:f0f3:a70c with SMTP id d16-20020a81ab50000000b00559f0f3a70cmr19851882ywk.12.1685013573162;
        Thu, 25 May 2023 04:19:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6uB9DAQkrMEquIR6syhwbVUNGJWsd/VlbaeioKuhEaPtSmmy9bo7FcYhuxxAEI9jgxoQgmmwWiMV2nq6b9mj8=
X-Received: by 2002:a81:ab50:0:b0:559:f0f3:a70c with SMTP id
 d16-20020a81ab50000000b00559f0f3a70cmr19851866ywk.12.1685013572969; Thu, 25
 May 2023 04:19:32 -0700 (PDT)
MIME-Version: 1.0
References: <9b987585-0834-bb8c-3414-283c29f3f2ab@leemhuis.info>
 <bec024d5-4088-00ae-f7b5-7188868b1707@leemhuis.info> <b7717c43-74bf-b91d-d3ce-874493df602c@gmail.com>
 <CAO-hwJ+At1J_yUpX2q_dJekzZ-PoTDAvxmkTk_e4Yu0Z338bEA@mail.gmail.com>
 <55dda0bb-fe42-6dee-28ea-00121554d092@leemhuis.info> <CAHk-=whvhkSk6m8_AidhofgR9nq0Md+HbNad5r1RE69tZgbv6Q@mail.gmail.com>
 <nycvar.YFH.7.76.2305231422180.29760@cbobk.fhfr.pm> <CAO-hwJ+MTRu9KxqwQc7UYFBsa0kkrnYfwVB30KsLZnw=wfcOMg@mail.gmail.com>
 <nycvar.YFH.7.76.2305251308471.29760@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.2305251308471.29760@cbobk.fhfr.pm>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 25 May 2023 13:19:21 +0200
Message-ID: <CAO-hwJJW1TDuZ2YXLf4pZhKO4UnM4ibUNsH=rpCyVjwNqixZtQ@mail.gmail.com>
Subject: Re: [regression] Since kernel 6.3.1 logitech unify receiver not
 working properly
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@riseup.net>,
        Bastien Nocera <hadess@hadess.net>,
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

On Thu, May 25, 2023 at 1:10=E2=80=AFPM Jiri Kosina <jikos@kernel.org> wrot=
e:
>
> On Wed, 24 May 2023, Benjamin Tissoires wrote:
>
> > > > That bug is pre-existing (ie the problem was not introduced by that
> > > > commit), but who knows if the retry makes things worse (ie if it th=
en
> > > > triggers on a retry, the response data will be the *previous* respo=
nse).
> > > >
> > > > The whole "goto exit" games should be removed too, because we're in=
 a
> > > > for-loop, and instead of "goto exit" it should just do "break".
> > > >
> > > > IOW, something like this might be worth testing.
> > > >
> > > > That said, while I think the code is buggy, I doubt this is the act=
ual
> > > > cause of the problem people are reporting. But it would be lovely t=
o
> > > > hear if the attached patch makes any difference, and I think this i=
s
> > > > fixing a real - but unlikely - problem anyway.
> >
> > FWIW, Linus, your patch is
> > Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> >
> > Feel free to submit it to us or to apply it directly if you prefer as
> > this is clearly a fix for a code path issue.
>
> It would be nice to hear from the people who were able to reproduce the
> issue whether this makes any observable difference in behavior though. I
> don't currently think it would, as it fixes a potential NULL pointer
> dereference, which is not what has been reported.

Well, yes, I didn't mean it would fix the bug. But this is an obvious
fix that we need to take given that we now see it :)

>
> Has anyone of the affected people tried to bisect the issue?

I just checked the BZ linked above, and... it still doesn't work
(which is not surprising):
https://bugzilla.kernel.org/show_bug.cgi?id=3D217412#c33

Cheers,
Benjamin

