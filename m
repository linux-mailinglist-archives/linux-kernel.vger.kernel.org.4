Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DD56D9120
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 10:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234878AbjDFIFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 04:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbjDFIFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 04:05:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBBA7AAD
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 01:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680768256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kBR23GZ8+/B49HpGt9RtYBgTJWOQz/g1P9XKqxTbjRU=;
        b=Y1J37HTVBwGF4DrWoE8G/7rFElnNYpJZKbxxT0q7ThoZuvrtk0Ut7PYhNVOdnPbW+DtJR/
        v1bCRvgQQqZkV+oGo8ZrM0PomzWECbkSjHIRlvPbGtpRqfX+VhKa1/2dvVO7tNWBQP0DnN
        f0tX8VlU2Jjk55MJzJexS0Fl6+SxGG0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-VjybiymmODicHCMMiq5_EQ-1; Thu, 06 Apr 2023 04:04:14 -0400
X-MC-Unique: VjybiymmODicHCMMiq5_EQ-1
Received: by mail-qk1-f199.google.com with SMTP id b142-20020ae9eb94000000b007486a8b9ae9so14735014qkg.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 01:04:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680768254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kBR23GZ8+/B49HpGt9RtYBgTJWOQz/g1P9XKqxTbjRU=;
        b=rSiNvwCCUcYXPI81+tTQw6bzN2DyavNGgzE6tV1YHoUzk9wzV+MwjO9MUDtcSuLjQY
         SpCTkOI9kFb8c9r3NOGDIIGw4ZnX2KwFPwXusC8DMjzX1P/FFChwFZi5cRsgl9YI5OgC
         59MFGnrie6XTtOrdh2xn916VEBcwS3EseSyBBs7iFarebT+4p9vKk2cC2BRl26TrEsZ5
         Bx0f/QPoI+lp7fkokKY/14rZunTw3bX8vGj6Qgne/LDdovhFWf+7jft6TlBGg2HbGFq4
         dQQfbYIenbOcj+EdJcEChbln9jtMxWmZiZtinS4UGNp+wCufT87b3zLT81vTU+zYJrpj
         MZ1w==
X-Gm-Message-State: AAQBX9eOyYAH4df4GQDAn4P9WQImC0XbTJg1un5QTikTGJ7BYTJ4ZGRs
        GKaEOVENnaBbLxvSSk2guMnobsTVaZAuTmfpX0RFVAkxianE7sl7o7RGbKUYgS8tSFiw8DfR57M
        YaQAnzc1YfVlmKFlI1+xxBwlPEovH8908E30gWzft
X-Received: by 2002:a05:620a:1a87:b0:74a:580:c44f with SMTP id bl7-20020a05620a1a8700b0074a0580c44fmr1997127qkb.15.1680768254369;
        Thu, 06 Apr 2023 01:04:14 -0700 (PDT)
X-Google-Smtp-Source: AKy350b40gp56Owd1MrZXFq8AS5omv9qC9T8NSJdmJvSJPLqoBm/VcSbTdIPTRAal/ociNgaDksnkXTN5J9GdZSFRV8=
X-Received: by 2002:a05:620a:1a87:b0:74a:580:c44f with SMTP id
 bl7-20020a05620a1a8700b0074a0580c44fmr1997118qkb.15.1680768254137; Thu, 06
 Apr 2023 01:04:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230404163741.2762165-1-leobras@redhat.com> <CAJF2gTTBm7_krSFjfSjD62pbfcaUOrfUhXzoHUD1-DKQ_SCLhA@mail.gmail.com>
In-Reply-To: <CAJF2gTTBm7_krSFjfSjD62pbfcaUOrfUhXzoHUD1-DKQ_SCLhA@mail.gmail.com>
From:   Leonardo Bras Soares Passos <leobras@redhat.com>
Date:   Thu, 6 Apr 2023 05:04:03 -0300
Message-ID: <CAJ6HWG56G+0CiSwDzkEjCiRf-2TQqqDBN7ABPYYeVQMdtm8iAA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/6] Deduplicating RISCV cmpxchg.h macros
To:     Guo Ren <guoren@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
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

On Wed, Apr 5, 2023 at 11:40=E2=80=AFPM Guo Ren <guoren@kernel.org> wrote:
>
> Thx Leonardo,
>
> It's a good point for cleaning up.

Hello Guo,
Thanks for the feedback!

>
> On Wed, Apr 5, 2023 at 12:37=E2=80=AFAM Leonardo Bras <leobras@redhat.com=
> wrote:
> >
> > While studying riscv's cmpxchg.h file, I got really interested in
> > understanding how RISCV asm implemented the different versions of
> > {cmp,}xchg.
> >
> > When I understood the pattern, it made sense for me to remove the
> > duplications and create macros to make it easier to understand what exa=
ctly
> > changes between the versions: Instruction sufixes & barriers.
> >
> > I split those changes in 3 levels for each cmpxchg and xchg, resulting =
a
> But how about merging 3 levels into one? (I mean one for cmpxchg and
> one for xchg, resulting in 2 patches.)

Sure, as mentioned below, I have no issue squashing the patches, so 2
should work fine.

I was previously worried about the changes, so I split them in 3 so
it's easier to understand my thought process.

I will resend it in a couple minutes.

>
> > total of 6 patches. I did this so it becomes easier to review and remov=
e
> > the last levels if desired, but I have no issue squashing them if it's
> > better.
> >
> > Please provide comments.
> >
> > Thanks!
> > Leo
> >
> > Changes since v2:
> > - Fixed  macros that depend on having a local variable with a magic nam=
e
> > - Previous cast to (long) is now only applied on 4-bytes cmpxchg
> >
> > Changes since v1:
> > - Fixed patch 4/6 suffix from 'w.aqrl' to '.w.aqrl', to avoid build err=
or
> >
> >
> > Leonardo Bras (6):
> >   riscv/cmpxchg: Deduplicate cmpxchg() asm functions
> >   riscv/cmpxchg: Deduplicate cmpxchg() macros
> >   riscv/cmpxchg: Deduplicate arch_cmpxchg() macros
> >   riscv/cmpxchg: Deduplicate xchg() asm functions
> >   riscv/cmpxchg: Deduplicate xchg() macros
> >   riscv/cmpxchg: Deduplicate arch_xchg() macros
> >
> >  arch/riscv/include/asm/cmpxchg.h | 319 +++++++------------------------
> >  1 file changed, 67 insertions(+), 252 deletions(-)
> >
> > --
> > 2.40.0
> >
>
>
> --
> Best Regards
>  Guo Ren
>

Best regards,
Leo

