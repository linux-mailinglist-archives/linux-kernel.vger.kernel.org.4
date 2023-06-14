Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C983730060
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 15:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245103AbjFNNrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 09:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245076AbjFNNrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:47:35 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED9CED
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 06:47:34 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-977e0fbd742so100750466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 06:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686750453; x=1689342453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76di/i2mInmVCxeVKqtSRBrcXSBLthtuA5QqmKpv0gg=;
        b=jlp8OxtI66wmx6ofvYbecBCQapH2lREmqablzfBh+9OExysu5k9h76l1tCeV8/J90c
         4Z1ZouQnIxyCpFC63R+Y2e/3+b2Jxk5JrOBGOCsPtQ8f8vMjLIC0eQU8nmbwpRYwQPz+
         zcnti9QTI56yIvgkrHHGpaaUQcJKbnO76la6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686750453; x=1689342453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=76di/i2mInmVCxeVKqtSRBrcXSBLthtuA5QqmKpv0gg=;
        b=ek196A20SfrD+Z2i2wjc15xrZL2WR5dgOmPAeKZ2wznzzaRRT/2lrYL/TSOeTE9GDI
         ow2WIYyKbEhQ7IWLXZfm4DLPYVTccBRSgP7fDhKEbJLJdcOfEnSoRmf0+CYJRw7L6csM
         jPMBAIOiePA04wm5dGrAKwPEL1PAHbR0idVrG1JdzJZQt8U66avoxWMRvFcz02hoOdb6
         8TgilmfyhzXGy1yNRvTfIU8yI2ybPrCQUvtskcxR0IM3uhLaZpyZgM7yKNRAsQ4uRXbV
         l4fR/Rjn0Nk5pLyKj4l9fPzsxjkZnbrFm62aizwjwR5JWahNVJSKgFT4n8ZstINZYVsm
         XHjg==
X-Gm-Message-State: AC+VfDxWCENcK+Ry9iskHym+883TEjbXFOtF05tq6D1XC1Uga/avdd40
        35Kmd9r3Dtmx7fB80R0BqD7X0eHkkJNexQ50i0y9RRlP
X-Google-Smtp-Source: ACHHUZ7wGmrcV1Ij6MM9wjApng7KxphUFw/H9Ovx9xlxNP2VhCqbiQrJvjPzux14c6RLbDK7Ugc9DA==
X-Received: by 2002:a17:907:d24:b0:94e:e30e:7245 with SMTP id gn36-20020a1709070d2400b0094ee30e7245mr17255728ejc.8.1686750452838;
        Wed, 14 Jun 2023 06:47:32 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id y11-20020a170906914b00b0098278f0903fsm607744ejw.38.2023.06.14.06.47.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 06:47:32 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-516500163b2so8283a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 06:47:31 -0700 (PDT)
X-Received: by 2002:a50:9f82:0:b0:50b:c48c:8a25 with SMTP id
 c2-20020a509f82000000b0050bc48c8a25mr104476edf.6.1686750451172; Wed, 14 Jun
 2023 06:47:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230607152432.5435-1-pmladek@suse.com> <20230607152432.5435-3-pmladek@suse.com>
 <CAD=FV=WRzaLbLQ65usGeFq3ya=DV8cYyHQina_721EFoSTdBGA@mail.gmail.com>
 <ZIG1Qi0iUjTKICQM@alley> <CAD=FV=XzueJia--Zv4cAofzk7yocmP-7K8wa4doAN8pzED_hZA@mail.gmail.com>
 <ZImWd62fXjsZildv@alley>
In-Reply-To: <ZImWd62fXjsZildv@alley>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 14 Jun 2023 06:47:19 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WP39nUmdeNjjTGx-XWhS4AgG5haHCfYjFUCEKckYVZDA@mail.gmail.com>
Message-ID: <CAD=FV=WP39nUmdeNjjTGx-XWhS4AgG5haHCfYjFUCEKckYVZDA@mail.gmail.com>
Subject: Re: [PATCH 2/7] watchdog/hardlockup: Make the config checks more straightforward
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        sparclinux@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 14, 2023 at 3:29=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> It seems that we have entered into a bike shedding mode.
> The following questions come to my mind:
>
>    1. Does this patchset improve the current state?
>
>    2. Maybe, it is not black&white. Is it possible to summarize
>       what exactly got better and what got worse?
>
> Maybe, there is no need to do bike-shedding about every step
> if the final result is reasonable and the steps are not
> completely wrong.
>
> I just followed my intuition and tried to do some changes step
> by step. I got lost many times so maybe the steps are not
> ideal. Anyway, the steps helped me to understand the logic
> and stay reasonably confident that they did not change
> the behavior.
>
> I could rework the patchset. But I first need to know what
> exactly is bad in the result. And eventually if there is more
> logical way how to end there.

Sure. I still feel like the end result of the CONFIG options after
your whole patchset is easier to understand / cleaner by adjusting the
dependencies as I have suggested. That being said, I agree that it is
the type of thing that can be more a matter of personal preference. I
do agree that, even if you don't take my suggestion of adjusting the
dependencies, the end result of your patchset still makes things
better than they were.

...so if you really feel strongly that things are more understandable
with the dependencies specified as you have, I won't stand in the way.
I still think you need a v2, though, just to address other nits.

-Doug
