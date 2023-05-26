Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D36712B3E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 18:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjEZQ51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 12:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236772AbjEZQ5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 12:57:24 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDEA1B0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 09:57:13 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-96fb1642b09so140725366b.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 09:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685120231; x=1687712231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ja0in5TBjui7p3/oTjd6x+SMy6lwZFw3t5bIyVH8ZoE=;
        b=EgpyCWMxWlEshViGGzD8bgABvTUenjyo4lKUXIN/W+C5GFL3GuoNiG+MLL9NLsqN2y
         TBBZYnE+K3GfVyYiZKmqmdtCb1SfVx4tHcGhf4Ut6SI1G/PBAztZmryJl9GnLxS7JeAX
         mASMl5vqGIOSeAxkFWXhAAjRFecncD27wPuFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685120231; x=1687712231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ja0in5TBjui7p3/oTjd6x+SMy6lwZFw3t5bIyVH8ZoE=;
        b=DVgXn8UjgkSnd/PJRQgSqRmYKq0I9miazi38yUNpNCsVEXrfiC/al6PDYlxgX/KsE+
         CHKrZCMpz/UcfbuDZRp4n3OecwF+cvqqN9551vCfH0AIgrKufCTfEY6+Wbft7BAFt+Qa
         zdeanzccF4sDWumJPorvc0rewFV7Of1ob0WGrl3iPQAxo4x/NKGnTXxQErlYMoyx5XtU
         TUOV/0sVhZONErX4rHppI5xrxx8K5xVRnfjtjXTlEUKAaNdqv/m2WW/eEn7/8Lm5TprR
         UC/X9gxWWvikUvX0Wkct6uXAFAByoX8QZpIZpnpCz/nuxnuQfare0RxlEixPsvgo8H4s
         Xiig==
X-Gm-Message-State: AC+VfDwl1MaQ4yVq6Od/ikL1KLkuPjpAqF2hcx2l7c/pAcQDjxtI7MjS
        9zyVkNiUGL61EcR//E8Nd964nTKhZaQ2tBT5C1G0M7Yp
X-Google-Smtp-Source: ACHHUZ7CYQ83/Q9zdSl/XeS8q9y3ycR444sEQXIz5bsEHfwRkg2NJGzDP6z+zI1/pFnzSJKmFes5nw==
X-Received: by 2002:a17:907:a4b:b0:970:73f0:19c9 with SMTP id be11-20020a1709070a4b00b0097073f019c9mr2463234ejc.71.1685120231385;
        Fri, 26 May 2023 09:57:11 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id me21-20020a170906aed500b0096a16e49b0fsm2340051ejb.51.2023.05.26.09.57.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 09:57:10 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5147f4bbfdaso713282a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 09:57:10 -0700 (PDT)
X-Received: by 2002:a17:906:ef06:b0:973:92d4:9f4e with SMTP id
 f6-20020a170906ef0600b0097392d49f4emr2458863ejs.53.1685120230471; Fri, 26 May
 2023 09:57:10 -0700 (PDT)
MIME-Version: 1.0
References: <CANn89iKUbyrJ=r2+_kK+sb2ZSSHifFZ7QkPLDpAtkJ8v4WUumA@mail.gmail.com>
 <CAHk-=whqNMUPbjCyMjyxfH_5-Xass=DrMkPT5ZTJbFrtU=qDEQ@mail.gmail.com> <CANn89i+bExb_P6A9ROmwqNgGdO5o8wawVZ5r3MHnz0qfhxvTtA@mail.gmail.com>
In-Reply-To: <CANn89i+bExb_P6A9ROmwqNgGdO5o8wawVZ5r3MHnz0qfhxvTtA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 May 2023 09:56:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wig6VizZHtRznz7uAWa-hHWjrCNANZ9B+1G=aTWPiVH4g@mail.gmail.com>
Message-ID: <CAHk-=wig6VizZHtRznz7uAWa-hHWjrCNANZ9B+1G=aTWPiVH4g@mail.gmail.com>
Subject: Re: x86 copy performance regression
To:     Eric Dumazet <edumazet@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
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

On Fri, May 26, 2023 at 9:37=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Hmm.. my build environment does not like this yet :)

Ahh, I tested it in an allmodconfig build, but only building that one
file, and not trying to link it. And gas was apparent;y perfectly
happy just leaving that undefined feature as a relocation.

I assume that if you just add a

   #include <asm/cpufeatures.h>

to the includes, it magically works for you?

             Linus
