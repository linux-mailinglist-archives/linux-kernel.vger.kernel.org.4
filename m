Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF39708D03
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 02:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjESAly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 20:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjESAlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 20:41:51 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F36BE47
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:41:50 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-96f40c19477so193557266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684456908; x=1687048908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+uCQGH+JH/K4VchWVE+0Dpdk4YXfHq2W/LOxUcdJ4I=;
        b=gZHVQmgoJERupTN+t23bKn8WqY43aQXiqAgGpux/ddOS8eVWtJrTW5pA9UR3WqXwks
         9NfKDu5dmzycrkz71kUW6vILLpiFz27ins7kzoTrCDXeo/bwe6mfibA88BbJpew8ihi/
         Z/z5vtf3stYqAg7lKrrU4Qazldo9BBFLQNHjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684456908; x=1687048908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s+uCQGH+JH/K4VchWVE+0Dpdk4YXfHq2W/LOxUcdJ4I=;
        b=XkNek4WjdpGE12K+oFDx0l9Y2UrS3CyeLbXvWg1fLXNP9FMig7Oth8Up8idJXveflA
         qNocwq31lWHyq07m/bGakmiQF04nJndKpRP2u4LwI4cHVbyK4wlBhvM0M6WpJEkbE8Aw
         /ypWkI+8kSTz/BRtmGT5suXL2Ke8xVo9Beni6uzrxS2TO8Qqy5ymIqbBuWj6vtign4l3
         F3qDPeYqhYh9029eSYsv5Z+roIY3RE/lyAG5bzNATsceVBv8pekTMutESRpWtGlGC7nN
         H1q25lrY86N182fGxAViYIRtgwSI/6Qu7WjiQFtHdz3QlbaQSOF41b4kYuUKwMs68srZ
         rEPw==
X-Gm-Message-State: AC+VfDzX+2xSaTKJjHALq/OLJXkpzCekuI7V46qDYbXc56Ta7PrQVGCV
        uZWN/8KlU7fhjHKefP5psCpJYsVA3QQuBtvAQrkUK3Xt
X-Google-Smtp-Source: ACHHUZ4DCgmYdzsJ5LAKUqLOYK9pP7LVpadDNipPFPX4ZP4/LZoP2lmUIJu4qMM+MmXX+FpF+wCULg==
X-Received: by 2002:a17:906:9508:b0:969:f54c:dee8 with SMTP id u8-20020a170906950800b00969f54cdee8mr17849ejx.35.1684456908561;
        Thu, 18 May 2023 17:41:48 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id s23-20020a1709066c9700b0094f4d2d81d9sm1587945ejr.94.2023.05.18.17.41.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 17:41:47 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-510dabb3989so3720512a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:41:47 -0700 (PDT)
X-Received: by 2002:a17:907:7f8c:b0:966:1984:9d21 with SMTP id
 qk12-20020a1709077f8c00b0096619849d21mr55686ejc.9.1684456906783; Thu, 18 May
 2023 17:41:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230519001709.2563-1-tj@kernel.org>
In-Reply-To: <20230519001709.2563-1-tj@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 18 May 2023 17:41:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=whA2ztAcVrgsqj39j30LJYhjBSkk6Dju6TY16zGpXpkZQ@mail.gmail.com>
Message-ID: <CAHk-=whA2ztAcVrgsqj39j30LJYhjBSkk6Dju6TY16zGpXpkZQ@mail.gmail.com>
Subject: Re: [PATCHSET v1 wq/for-6.5] workqueue: Improve unbound workqueue
 execution locality
To:     Tejun Heo <tj@kernel.org>
Cc:     jiangshanlai@gmail.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        joshdon@google.com, brho@google.com, briannorris@chromium.org,
        nhuck@google.com, agk@redhat.com, snitzer@kernel.org,
        void@manifault.com
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

On Thu, May 18, 2023 at 5:17=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Most of the patchset are workqueue internal plumbing and probably aren't
> terribly interesting. Howver, the performance picture turned out less
> straight-forward than I had hoped, mostly likely due to loss of
> work-conservation from scheduler in high fan-out scenarios. I'll describe=
 it
> in this cover letter. Please read on.

So my reaction here is that I think your benchmarking was about
throughput, but the recent changes that triggered this discussion were
about latency for random small stuff.

Maybe your "LOW" tests might eb close to that, but looking at that fio
benchmark line you quoted, I don't think so.

IOW, I think that what the fsverity code ended up seeing was literally
*serial* IO that was fast enough that it was better done on the local
CPU immediately, and that that was the reason for why it wanted to
remove WQ_UNBOUND.

IOW, I think you should go even lower than your "LOW", and test
basically "--iodepth=3D1" to a ramdisk. A load where schedulign to any
other CPU is literally *always* a mistake, because the IO is basically
entirely synchronous, and it's better to just do the work on the same
CPU and be done with it.

That may sound like an outlier thing, but I don't think it's
necessarily even all that odd. I think that "depth=3D1" is likely the
common case for many real loads.

That commit f959325e6ac3 ("fsverity: Remove WQ_UNBOUND from fsverity
read workqueue") really talks about startup costs. They are about
things like "page in the executable", which is all almost 100%
serialized with no parallelism at all. Even read-ahead ends up being
serial, in that it's likely one single contiguous IO.

Yes, latency tends to be harder to benchmark than throughput, but I
really think latency trumps throughput 95% of the time. And all your
benchmark loads looked like throughput loads to me: they just weren't
using *all* the CPU capacity you had.

Yes, writeback can have lovely throughput behavior and saturate the IO
because you have lots of parallelism. But reads are often 100% serial
for one thread, and often you don't *have* more than one thread.

So I think your "not enough work to saturate" is still ludicrously
over-the-top. You should not aim for "not enough work to saturate 24
threads". You should aim for "basically completely single-threaded".
Judging by your "CPU utilization of 60-70%", I think your "LOW" is off
by at least an order of magnitude.

                  Linus
