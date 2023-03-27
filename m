Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2C76CA40C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 14:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbjC0M0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 08:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbjC0M0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 08:26:06 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FE43AB1;
        Mon, 27 Mar 2023 05:26:02 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id q88so6429034qvq.13;
        Mon, 27 Mar 2023 05:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679919961;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wl8cPkyD63M2WrjeB+dVJJ4uteTT4pJZRjk43EhYKlc=;
        b=NlI15etAT69+2xyPl7OyWL9W5e7d/SsQ3in2104/yfKclte4gZHqyQAzf4Km9U6aAg
         5UznoDAJKwhyk/HNb4bxA4q6N1pYsSSHdRBqpx8yMqhA+y8Ihby87qVrdWYO2SnXbWr3
         uH4Jy89H+ayrdOWz2lg0f+e/rsUW5fw9jf+jcttXhiAcP9HfHz71S93ihUujllOgPz5D
         lDNqm9jjwmlhzti411avKWhPEKsYypBt1tKrT547MtdCb5CCuU1FTdw/2LSwqT0iimuA
         h43AHNbrdQ94zC/D4diAgz5ppGvJArqRtdI/MSKaVi4m52Hz2Aewd8hiV0BHsFSuVZ9/
         B9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679919961;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wl8cPkyD63M2WrjeB+dVJJ4uteTT4pJZRjk43EhYKlc=;
        b=sthkaaoYTJ2ht4XDsh1SXHTFjdeRTt6bkt8Wnja23W7oqQeBPPfY3B9QUIIoJqjCrI
         7NNdMz9jYW4fvw91fPkjjGY8H7fUQM7bplERuwDSQ6qAHxjJxxP1I/Izp6m1CSI6t7Kl
         Ww/GPcUfPjt/vCviTgYhi8/wXBKj4ECydvyKnpEiA+UY4r1tecOoFyVAOO9lfXvkT16z
         C4eIOEbqcNXkBMQWOzv4gFqmPsT3ccpRApFskSC3U73kjrwcCKmVKqGR/REJy7KqVDzU
         iZ8YYMwMNPJjOeWCKztLurcoeyOO4u/9MM+uAON2hv5qTFdeMmwsD59RtYTYwJLsLVy4
         bTAg==
X-Gm-Message-State: AAQBX9et5+5Hyge2icTMFm+LIzYi/pTLAy0igg9ACapBslKvpt3UckvN
        84RBlzqLgJ6q3RA7wVtxYFTkU1vQLWM8hhfZ
X-Google-Smtp-Source: AKy350ZWiJ93r7XU8q/hR4ykUyFJuF1M2ctXwWBV4Zh0mXz2xYDzbyBruEcF6CI9NzQCTTX7X5ODjA==
X-Received: by 2002:a05:6214:5001:b0:5c8:15bc:f638 with SMTP id jo1-20020a056214500100b005c815bcf638mr21345340qvb.38.1679919961265;
        Mon, 27 Mar 2023 05:26:01 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef05:8700:853c:3ba5:d710:3c1d? (p200300f6ef058700853c3ba5d7103c1d.dip0.t-ipconnect.de. [2003:f6:ef05:8700:853c:3ba5:d710:3c1d])
        by smtp.gmail.com with ESMTPSA id c18-20020a0cd612000000b005dd8b9345f0sm2914169qvj.136.2023.03.27.05.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 05:26:00 -0700 (PDT)
Message-ID: <2a108acdd79682f47e3ac923fe005b943a4a00c0.camel@gmail.com>
Subject: Re: [PATCH] Fix IRQ issue by setting IRQ_DISABLE_UNLAZY flag
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Masahiro Honda <honda@mechatrax.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 27 Mar 2023 14:28:02 +0200
In-Reply-To: <CA+Tz-SFbt2RAz3POMRoTHqz+tNyQOn3UsssZV9EvHUhhR+XJbQ@mail.gmail.com>
References: <20230306044737.862-1-honda@mechatrax.com>
         <6e1fe1015235ae7d7eb9ef2526fd64b6d6d628d7.camel@gmail.com>
         <CA+Tz-SHQxNzx=eS8ex=3Hps0th5bTY+K1qSWrZqWC8ryv+d0RA@mail.gmail.com>
         <CA+Tz-SFbt2RAz3POMRoTHqz+tNyQOn3UsssZV9EvHUhhR+XJbQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-03-27 at 18:01 +0900, Masahiro Honda wrote:

Hi Masahiro,

Thanks for looking in more detail into this...

> Hi, Nuno
>=20
> > On Mon, Mar 6, 2023 at 10:30=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail=
.com>
> > wrote:
> > > Another thing that came to my mind is if the data is totally
> > > garbage/wrong or is it just some outstanding sample?
>=20
> I'm sorry for not answering your question. The data is the same as
> the previous conversion even if the input voltage is changed. At this
> time, a logic analyzer shows that the read operation is performed
> immediately after the conversion is performed. The read operation
> returns the previous conversion result because it is performed before
> the completion of the conversion.
>=20

So, my suspicion was right... We are getting stalled data (which is
obviously not good). AFAIU, when disabling the IRQ, we don't
immediately mask the IRQ and we only do it in the next time an
interrupt (sample) comes which means (I think) we'll process (right
away) that outstanding interrupt next time we enable the IRQ.

> > > Some research on this also seems to point that we should (need?)
> > > call
> > > irq_clear_status_flags(irq, IRQ_DISABLE_UNLAZY) when freeing the
> > > IRQ.
>=20
> I have understood that I need to call irq_clear_status_flags.
> However,
> I cannot find a code to free the IRQ in ad_sigma_delta.c and other
> Sigma-Delta ADC driver source files. So, I would like to implement
> only irq_set_status_flags.

Well, that's because we are using devm_request_irq() which is a device
managed API. So, I can see two options in here...=C2=A0

1) You do not use devm_request_irq() and use request_irq() +
devm_add_action_or_reset() and in your release() function you would
call irq_clear_status_flags() + free_irq().

2) You add a devm_add_action_or_reset() after devm_request_irq() and
your release() function would only clear the flag. But in here we would
likely also have to be careful in the case where devm_request_irq()
fails. So option 2) seems a bit more "ugly".

I would likely go to option 1) but maybe Jonathan or others have better
ideas.

- Nuno S=C3=A1
