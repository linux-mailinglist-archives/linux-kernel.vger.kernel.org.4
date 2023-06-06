Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D327241F3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235835AbjFFMUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236086AbjFFMTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:19:49 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD7EE67
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 05:19:46 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9768fd99c0cso774548666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 05:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686053984; x=1688645984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XINeOMROcoKiU5lnuNf2dxDyn75tbOYyhZZuyc0/MtU=;
        b=Ht1rRnGWAxNs+fy4VYwbA4YstgOHvi3EWTaNg5g5C22fNHBLKSBnG4HImDtoOf+/zn
         J7DXGNJvF39X/5FeUmXzm5fXrzXHODgTb26c2Keg1LonvWDg5wHcAQ32xUutTLc/jv5P
         jHpML4iPmD1KMvDoxSlQ9b6mOK6a8cKJDepSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686053984; x=1688645984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XINeOMROcoKiU5lnuNf2dxDyn75tbOYyhZZuyc0/MtU=;
        b=QILd8EiWcGBGycrSs3YuYD+JuuXJqge1+YFPU3W5lno+ZhD9i7BLARcTRahODG7xWu
         yXjqU9wZe6P4SZzFwQcDBUoce1R8x8BwCzW0I1agfZNqyz5fNpXZzZRDqWMGVd+VVFQm
         Inbk+/JuhPJA4Z2tFcvPfkK+9A0tJDNzuafnYwPV0Z3M2GlsPzMmuap0ivg22bpJowyg
         GoZkrvaMj8Ec/0hx8MOBJP+U6UXMEDnwb+cAQQnZ7fiNE0E6rIRp0cGx3sU0OCU5Gvyy
         5UBpBKboxZrfVOp1MBVlq/ritt1Ls0j2b15WVbZ9wnMOHtAJ8gZT8P4cFBYVN2DPydXc
         GlzA==
X-Gm-Message-State: AC+VfDxdVrDuD+O1Bv9A5Oi5405KxOvd+IASGCGdcg3vQzlLvggLhm/j
        iVqequAWDLwwFHpFqKO1shtV1bKbPN8uSlX4+1OTgyRs
X-Google-Smtp-Source: ACHHUZ7aEd/FH4eloPoGqclqFKv884x4A9YkCyxtpdGv2JLv5dhq/iz4ZzKO2TVu5dnWBrPLKyFO9g==
X-Received: by 2002:a17:907:96a1:b0:973:e5bf:281e with SMTP id hd33-20020a17090796a100b00973e5bf281emr9049965ejc.27.1686053984635;
        Tue, 06 Jun 2023 05:19:44 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id l12-20020a170906a40c00b00971433ed5fesm5393312ejz.184.2023.06.06.05.19.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 05:19:44 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5147e441c33so12383769a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 05:19:44 -0700 (PDT)
X-Received: by 2002:a05:6402:34c4:b0:516:5b18:a9f1 with SMTP id
 w4-20020a05640234c400b005165b18a9f1mr6873421edc.0.1686053983752; Tue, 06 Jun
 2023 05:19:43 -0700 (PDT)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.2306052334360.29760@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.2306052334360.29760@cbobk.fhfr.pm>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 6 Jun 2023 05:19:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiMbF38KCNhPFiargenpSBoecSXTLQACKS2UMyo_Vu2ww@mail.gmail.com>
Message-ID: <CAHk-=wiMbF38KCNhPFiargenpSBoecSXTLQACKS2UMyo_Vu2ww@mail.gmail.com>
Subject: Re: [GIT PULL] HID regression fix
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
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

On Mon, Jun 5, 2023 at 2:39=E2=80=AFPM Jiri Kosina <jikos@kernel.org> wrote=
:
>
> - Final, confirmed fix for regression causing some devices connected via
>   Logitech HID++ Unifying receiver take too long to initialize (Benjamin
>   Tissoires)

Thanks.

The 'don't use goto' looks good, but can we simplify things further?

In particular, this kind of loop is why "do { } while ()" exists.

But also, testing "ret" in that end condition is all kinds of strange.
It smells of Pascal loops, because Pascal didn't have any sane control
flow (little known fact: in a rare show of self-reflection, "Pascal"
was named to sound like the Finnish word "paska", meaning "shit").

The *sane* thing to do is not to test "ret" in the loop condition, but
just add the obvious control flow - so the code that wants to retry
should just do 'continue' in that loop.

Then the loop itself ends up being just

        do {
                ...
        } while (--max_retries);

and we don't need any fake initialization of 'ret'.

Anyway, just a thought.

It would also simplify things a lot if that function was split up so
that you'd have that whole loop in a helper function. That way it
could just use "return ret" or whatever, with the mutex_lock/unlock in
the caller.

Btw, it does look like the code is mixing two different kinds of
return types in 'ret': regular Linux error numbers as negative
numbers, but then possibly positive "HIDPP status" values that it gets
from the report (ie

        ret =3D response->rap.params[1];

ends up being returned as a value, mixed with

        ret =3D -ETIMEDOUT;

so which is it? A negative error, or a positive HID report byte value? Or b=
oth?

             Linus
