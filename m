Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3296A70E42E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 20:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238075AbjEWSAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 14:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238045AbjEWSAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 14:00:10 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD1019B
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:59:54 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-96f53c06babso1069899066b.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684864792; x=1687456792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/jS38YpOpIZUfQgeVWHu8QpWCkWMgYcro6Mxr/6pl6k=;
        b=Rmsb/FHc0IcuT6UTO/M3sds6KNAgpvkJ7kIyJ6bgCAiEnFp2R3aZXiK0QPZTwfzJZC
         BpuELkWIx7qgR2koClqv4bFkgPZrgBKWsq1xSTFPaAM1teQnNGyskaJr/T81nhknkHxM
         snyHWsnJqHt2XfJgw0/ZwcTeDfxyDvBBlSRNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684864792; x=1687456792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/jS38YpOpIZUfQgeVWHu8QpWCkWMgYcro6Mxr/6pl6k=;
        b=W+H5Z4QDNlXkoUfPN3gWhrAWy0++I3UN8/aKB1ykkckq5hN50DjO4V1kduBms0Ycei
         tJb6VeXUYPrCW7S8PP3CcT5GFLSCk/2D7D59+W0Gr6F4hHgSsQ1WeRhRPJqKHk3efdFu
         pd3dZQfKBwrMXZ3ALwx1eI5ylbzD45D+LH0rlKyQUwNoIk/CmxvDgaQGSWAHzihEWFkK
         uPv0eLn/dhySh+W3/LnUFNI2l+9HSyTqdOK/0OIk1Pa/xt5sw8ZokeFk1jE0dL/7jQl1
         3Ev7mcs59fSWgLQVI0gO+0xpGu2LmKZW2BEg5QZ3gj1BdsbQNaRs721yXVpXAIeCo+Fd
         LQfQ==
X-Gm-Message-State: AC+VfDwTa2swbqdgRfx5OjSsKWPt9wyvXo0FtFfIJPIAZqgLo29U5OIW
        lI1r2ZgFo6JHIGEwluOd4y3SiQa2w5OR3CWahfXcNKba
X-Google-Smtp-Source: ACHHUZ4pq7lU0tPgcKQJCqIinB16rGmZBhjXfiswf02935zxp6fb7YY7XtxYzoB4dRY3dOtdiApeGQ==
X-Received: by 2002:a17:907:70a:b0:95e:d74d:c4e6 with SMTP id xb10-20020a170907070a00b0095ed74dc4e6mr13339628ejb.25.1684864792073;
        Tue, 23 May 2023 10:59:52 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id br23-20020a170906d15700b0095342bfb701sm4728732ejb.16.2023.05.23.10.59.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 10:59:51 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-96fe88cd2fcso491343066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:59:51 -0700 (PDT)
X-Received: by 2002:a17:907:a4c:b0:96a:2210:add8 with SMTP id
 be12-20020a1709070a4c00b0096a2210add8mr11354597ejc.8.1684864790742; Tue, 23
 May 2023 10:59:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230519001709.2563-1-tj@kernel.org> <CAHk-=whA2ztAcVrgsqj39j30LJYhjBSkk6Dju6TY16zGpXpkZQ@mail.gmail.com>
 <ZGf5rfESYhKYzPSY@slm.duckdns.org> <ZGgAKK-c_DZpvNJB@slm.duckdns.org> <CAHk-=whbP8BjGyGyXcSKi32orb+1+cHSC2HoVAMNVKwmbq8pSg@mail.gmail.com>
In-Reply-To: <CAHk-=whbP8BjGyGyXcSKi32orb+1+cHSC2HoVAMNVKwmbq8pSg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 23 May 2023 10:59:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiH9JLQ0AN98aLKpxiAL4ssbnnq_=3R_qvy7AEGNT_iJg@mail.gmail.com>
Message-ID: <CAHk-=wiH9JLQ0AN98aLKpxiAL4ssbnnq_=3R_qvy7AEGNT_iJg@mail.gmail.com>
Subject: Re: [PATCHSET v1 wq/for-6.5] workqueue: Improve unbound workqueue
 execution locality
To:     Tejun Heo <tj@kernel.org>, Sandeep Dhavale <dhavale@google.com>
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

On Mon, May 22, 2023 at 6:51=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Ok, looks good, consider me convinced.

Ugh, and I just got the erofs pull, which made me aware of how there's
*another* hack for "worker threads don't work well on Android", which
now doubled down on setting special scheduler flags for them too.

See commit cf7f2732b4b8 ("erofs: use HIPRI by default if per-cpu
kthreads are enabled"), but the whole deeper problem goes back much
further (commit 3fffb589b9a6: "erofs: add per-cpu threads for
decompression as an option").

See also

    https://lore.kernel.org/lkml/CAB=3DBE-SBtO6vcoyLNA9F-9VaN5R0t3o_Zn+FW8G=
bO6wyUqFneQ@mail.gmail.com/

I really hate how we have random drivers and filesystems doing random
workarounds for "kthread workers don't work well enough, so add random
tweaks".

> I still would like to hear from the actual arm crowd that caused this
> all and have those odd BIG.little cases.

Sandeep, any chance that you could try out Tejun's series with plain
workers, and compare it to the percpu threads?

See

     https://lore.kernel.org/lkml/20230519001709.2563-1-tj@kernel.org/

for the beginning of this thread. The aim really is to try to figure
out - and hopefully fix - the fact that Android loads seem to trigger
all these random hacks that don't make any sense on a high level, and
seem to be workarounds rather than real fixes. Scheduling percpu
workers is a horrible horrible fix and not at all good in general, and
it would be much better if we could just improve workqueue behavior in
the odd Android situation.

              Linus
