Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9972739017
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 21:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjFUTcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 15:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjFUTcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 15:32:06 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADD810EC
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 12:32:05 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-988c495f35fso452817066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 12:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687375924; x=1689967924;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PgiZJ70w+/Yp+LSO5Gv9APJQycIM1pcyZWrwcbbty3w=;
        b=ZA2TjBusX1p8/tru8tq3j17z6ZkW7u2471W4K/4UDcBAttjJSe+YDeEUfKrCLKdG31
         iTKtStliTA8E6BzgIxg7sRfxWkSgt0TO4nkwroLIIol/8TUtxaRiK13moEWW2SbRG4bt
         /WWAUAIicBUWvXzluZ024RV8tqSU3Kjq3ILCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687375924; x=1689967924;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PgiZJ70w+/Yp+LSO5Gv9APJQycIM1pcyZWrwcbbty3w=;
        b=A84qDZlg2kBHtq8FRaZ15cONH62QjtrzkodMwlzWzHJTmN4W2zwN/+KavxJpDBaK3J
         b57aGHg8YL8RYZJHPtqBN3zuMJAa+QoJ1FxacOxGfXhcK8f/xAxzPS+/Tz6557E6bf4I
         LtexkVp5C/G3OCii8YvZLKpd9lRiRRgzArbuv+Gf9QzHovaESQlB2eA+I+R+OWAL9pyj
         6D2UB0pfDOoccu8Mh2xk1FjDbD3z8aGR4c04qCONliaFJNajopWDdPmevLapoDTvWLd1
         o78TUtOEZns/A1ltJ6wuQcAfJtZLa+KI60HRSUEr1dTkn0iTfjwc74QLRObkHLFwUDI2
         9K3Q==
X-Gm-Message-State: AC+VfDzsKXuuXz7f4RtbGBr7YsIfn+3izLBkwCZLeQVFek0sUteDA2Lp
        9gQpOocmQHvN1fy4E2CJ4M6X1tF+vgtBvVLsh8JCQsFc
X-Google-Smtp-Source: ACHHUZ5eRobkEui8GrnhImBSAi5DfnHBhQ3oAt5zhIzXAYhYnVQ0vXqCpWjMeYXi/nnamB3r5gxzWA==
X-Received: by 2002:a17:907:7249:b0:975:bbd:d205 with SMTP id ds9-20020a170907724900b009750bbdd205mr14948750ejc.9.1687375923401;
        Wed, 21 Jun 2023 12:32:03 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id le15-20020a170907170f00b00985bdb7dd5fsm3491219ejc.201.2023.06.21.12.32.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 12:32:02 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-51a3e6a952aso7519917a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 12:32:02 -0700 (PDT)
X-Received: by 2002:a05:6402:1389:b0:51a:441f:75d7 with SMTP id
 b9-20020a056402138900b0051a441f75d7mr9060012edv.6.1687375922354; Wed, 21 Jun
 2023 12:32:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230519001709.2563-1-tj@kernel.org> <ZIewlkGJJJUXPFL0@google.com>
 <ZIfY5zhhHU9IgOqx@slm.duckdns.org> <CAEXTbpconFReyAKxerNCQW5e51CMG=_RU9JHAquyEfSH1aqajA@mail.gmail.com>
 <ZJNMk9oSp1_IYXLU@slm.duckdns.org>
In-Reply-To: <ZJNMk9oSp1_IYXLU@slm.duckdns.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 21 Jun 2023 12:31:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgXoyxy99HnEFcvf+eUZAS5=ekWt_y84LC3P+0osxh6Jw@mail.gmail.com>
Message-ID: <CAHk-=wgXoyxy99HnEFcvf+eUZAS5=ekWt_y84LC3P+0osxh6Jw@mail.gmail.com>
Subject: Re: [PATCHSET v1 wq/for-6.5] workqueue: Improve unbound workqueue
 execution locality
To:     Tejun Heo <tj@kernel.org>
Cc:     Pin-yen Lin <treapking@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        jiangshanlai@gmail.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        joshdon@google.com, brho@google.com, nhuck@google.com,
        agk@redhat.com, snitzer@kernel.org, void@manifault.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2023 at 12:16, Tejun Heo <tj@kernel.org> wrote:
>
> I find that perplexing given that switching to a per-cpu workqueue remedies
> the situation quite a bit, which is how this patchset came to be. #3 is the
> same as per-cpu workqueue, so if you're seeing noticeably different
> performance numbers between #3 and per-cpu workqueue, there's something
> wrong with either the code or test setup.

Or maybe there's some silly thinko in the wq code that is hidden by
the percpu code.

For example, WQ_UNBOUND triggers a lot of other overhead at least on
wq allocation and free. Maybe some of that stuff then indirectly
affects workqueue execution even when strict cpu affinity is set.

Pin-Yen Li - can you do a system-wide profile of the two cases (the
percpu case vs the "strict cpu affinity" one), to see if something
stands out?

             Linus
