Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC2B6F8A21
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 22:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbjEEUXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 16:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjEEUXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 16:23:01 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B596D7
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 13:23:00 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9659e9bbff5so393163266b.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 13:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683318179; x=1685910179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aL4O4xBkvv61r8l6fiCzi2l8LZqK+hvp7Gt2L2M0kwA=;
        b=Oykg45fTdrjAbY7eTF+V20gWgchrThB6dOjgbfRUrV1Kck6I16pUPviTyqrqjHqAiP
         TnC7UCf+c5OdiFhpfpupimUE29Y1qAdpBx0xAl3K5IQI7MO3FSiWS9bpRvLEJhjcTOaV
         kdakVLv/4CObDj6PG19nXp0JJSbAj+kKnOwwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683318179; x=1685910179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aL4O4xBkvv61r8l6fiCzi2l8LZqK+hvp7Gt2L2M0kwA=;
        b=dz/4f4ssqZ0DPTb56T86Y85xvQFQOQLS6Ahtfn/EbG9UBtpe6i9An7Ipoh2nxEsqKm
         M/8vR+X+glETpLE6/tmC5glc6mOzpUEN3j/u/k+sk1wXSWI3jH4XadCau8o5+OgyxjAF
         NtmPASadmSvJpmUMhhcE0ZfUIXJ7GIkaXT50iagm401+Gu2+yBqksS+niAP2WsWkSSGr
         vwP3Kh/Dn4OoT+vZgI57Ex/MC6cBBwv1/0D/vE+QzAQ+5WnNfRDtDwBr/IeefjlID5GH
         d1qnsNly+jivzmnDYKWf0iv1UGpproGQCiO3A0gq29nrpw8Yr8/sZviP3Nfhr1PfpdIF
         aVjg==
X-Gm-Message-State: AC+VfDzaDWhBpHAwSuyOzwK4tJBfE/tN/V1OfT2eCETYsSzdmisSgpkp
        +Y8a+ZsTX4GR10Uj9fuAVd2CyaANvDfV1o/mHh4hIQ==
X-Google-Smtp-Source: ACHHUZ6b2FnseGJeacE9g9j5UeF41xdQ+CkC7ifsyqeY7Qp5hl3wKzCVSRVea0f1IBfPxs1GDRnwyQ==
X-Received: by 2002:a17:906:7947:b0:94e:dd68:aba1 with SMTP id l7-20020a170906794700b0094edd68aba1mr2398310ejo.67.1683318178654;
        Fri, 05 May 2023 13:22:58 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a19-20020a170906469300b0095004c87676sm1349431ejr.199.2023.05.05.13.22.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 13:22:58 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-9659e9bbff5so393158666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 13:22:57 -0700 (PDT)
X-Received: by 2002:a17:906:9b89:b0:965:a5b5:e075 with SMTP id
 dd9-20020a1709069b8900b00965a5b5e075mr2580600ejc.75.1683318177525; Fri, 05
 May 2023 13:22:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230504200527.1935944-1-mathieu.desnoyers@efficios.com>
 <20230504200527.1935944-13-mathieu.desnoyers@efficios.com>
 <3b017a9f-220d-4da8-2cf6-7f0d6175b30c@efficios.com> <CAHk-=wjzpHjqhybyEhkTzGgTdBP3LZ1FmOw8=1MMXr=-j5OPxQ@mail.gmail.com>
 <3cc72a67-d648-0040-6f60-37663797e360@efficios.com> <CAHk-=wh-x1PL=UUGD__Dv6kd+kyCHjNF-TCHGG9ayLnysf-PdQ@mail.gmail.com>
 <d8dfd1af-5b82-ddd8-24f5-fa9dfbb4b1fb@efficios.com>
In-Reply-To: <d8dfd1af-5b82-ddd8-24f5-fa9dfbb4b1fb@efficios.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 5 May 2023 13:22:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg27iiFZWYmjKmULxwkXisOHuAXq=vbiazBabgh9M1rqg@mail.gmail.com>
Message-ID: <CAHk-=wg27iiFZWYmjKmULxwkXisOHuAXq=vbiazBabgh9M1rqg@mail.gmail.com>
Subject: Re: [RFC PATCH 12/13] blk-mq.h: Fix parentheses around macro
 parameter use
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 5, 2023 at 1:08=E2=80=AFPM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> The reason why I think the lvalue of a "=3D" operator can be argued to be
> "special" is because it is simply invalid to apply many of the C
> operators to an lvalue (e.g. +, -, /, ...),

Mathieu, you are simply objectively wrong.

See here:

  #define m1(x) (x =3D 2)
  #define m2(x) ((x) =3D 2)

and then try using the argument "a =3D b" to those macros.

Guess which one flags it as an error ("lvalue required") and which one does=
 not?

m2 is the only "good" one. Yes, m1 works in 99% of all cases in
practice, but if you want a safer macro, you *will* add the
parentheses.

So *STOP*ARGUING* based on an incorrect "lowest precedence" basis.
Even for the "lowest precedence" case, you have the *same* precedence.

The fact is, assignment is not in any way special operation in macros,
and does not deserve - and should absolutely not have - any special
"doesn't need parentheses around argument" rules.

           Linus
