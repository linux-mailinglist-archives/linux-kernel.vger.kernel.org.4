Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7092B61129F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbiJ1NZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbiJ1NZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:25:36 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389FC6DAC1;
        Fri, 28 Oct 2022 06:25:34 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id b25so3372495qkk.7;
        Fri, 28 Oct 2022 06:25:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jh+fSXeT51XdQX9MiufjVJfYk9I5Ct95Pw/9sQRm2oE=;
        b=cMuwerX1kjXapGEJoQMcGHcFclUAPma98YP2v+4LjUyfhAGnmnNupS/Mg8QmSbCWwv
         GBBMa+ZieutFVQKqBxEUtaJxZyhcniEmTX5L6+ypFtLAOi83LR1lNj7k2VF478yi8dT3
         KaV23d5ndKUFSOrCLvci3WjJQemzTSq3XAdKPQt5uYyViT/R2RkWHNaJW1mY/OeFNrFH
         DLm4P0wYnbNf08NyiLSVQJoL1pOgUYkZ1LvCsge9bVWSya4K9G812d9BfJ3RZ87F5Eem
         W8Msy5GKDT40NGegrUblEuG7jAs5B+eoS728AdXA/Bdc/wbMl5L9BVFaX+nIroJOu6mH
         v9jQ==
X-Gm-Message-State: ACrzQf06AJ4TI8gpzoPAmoZCKXVWKL7Sds2itnjPaO79Nnpf5yQCaB7E
        R3Ljxzlx4fJ/tN4b491Afewb557ieuqLFA4Zyos=
X-Google-Smtp-Source: AMsMyM7lb5Svw83lnyO2ElFQjxXGM0zLWEuY4WkUFrjUYKAsLybfAftRCi2zKUgzDUn7gQ3I1unthf53yn2yRfotjsk=
X-Received: by 2002:a05:620a:d89:b0:6cf:c98b:744c with SMTP id
 q9-20020a05620a0d8900b006cfc98b744cmr37892604qkl.443.1666963533416; Fri, 28
 Oct 2022 06:25:33 -0700 (PDT)
MIME-Version: 1.0
References: <20221003144914.160547-1-kajetan.puchalski@arm.com>
 <CAJZ5v0hoe=8nY9vR=+Bjvexrg+E6fcO-S=W+PDkfD=Li6Uy__g@mail.gmail.com>
 <Y1F0GYlJJOnFQeYe@e126311.manchester.arm.com> <71438330-dbfe-a10c-f289-24ba25c0d55f@linaro.org>
In-Reply-To: <71438330-dbfe-a10c-f289-24ba25c0d55f@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 28 Oct 2022 15:25:22 +0200
Message-ID: <CAJZ5v0iese2fs30vrz2_NiR5rMgct21L3ddy5MDapqcSPY2DKg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/1] cpuidle: teo: Introduce optional util-awareness
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Kajetan Puchalski <kajetan.puchalski@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, lukasz.luba@arm.com,
        Dietmar.Eggemann@arm.com, dsmythies@telus.net,
        yu.chen.surf@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 9:52 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Kajetan,
>
> On 20/10/2022 18:20, Kajetan Puchalski wrote:
> > Hi Rafael,
> >
> >> The avg_util value tells us nothing about how much the CPU is going to
> >> be idle this time and it also tells us nothing about the
> >> latency-sensitivity of the workload.
> >>
> >> Yes, it tells us how much idle time there was on the given CPU in the
> >> past, on the average, but there is zero information about the
> >> distribution of that idle time in it.
> >>
> >> So in the first place please tell me why it fundamentally makes sense
> >> to use avg_util in CPU idle time management at all.
> >
> > I have an alternative suggestion that could be a reasonable way forward
> > here. Instead of applying util-awareness on top of TEO where it would
> > have to be reconciled with how TEO is currently expected to work, I just
> > wrote a simple completely new governor which operates only on timer
> > events alongside util values.
>
> I second the idea. I took a long time to investigate how to improve the
> governor and reached the conclusion having a dedicated governor for
> mobile platform makes sense.

Please define "mobile".

> Also the behavior is very platform dependent.

I'm not sure what you mean.
