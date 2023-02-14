Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877946970B1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 23:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjBNWZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 17:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjBNWZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 17:25:29 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E743C0D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 14:25:27 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-51ba4b1b9feso226491247b3.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 14:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8bgAe2igf/hCFL5193lqh4W3BC+LMmOpmmIMy4BqG2M=;
        b=EoH9xRAPCFIHp8WoTlVamm6ThhbbQ0uYq0PMBL8dQBn5QZFvSX8ivJVnikTX7WiMCY
         IayePmTCzjFvXETiNXa9qD22IyVya/8sYFIubfyJEpqgA/SOaxUOm2kKzfPXGE4SF5Yf
         BZBaHS6Vzl62Gbpchye1oMGiJxpAUyUKpQNgDdb6ihYuQAlXrJNcyvUUp9KhlCQlGmL+
         jPZ9rCLnRhzqK2meDJARy6HWtYckWE0s/a2Zd7/pZLnY67SKFGeFUPKK68mK2s3zdv7t
         zLgmwC6jKb9SmEqJXdQGgQwyPMNeJ4NfM66XUn87SPF6Y2C52Q/cV7tl6uH52Pm0m+vn
         1ubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8bgAe2igf/hCFL5193lqh4W3BC+LMmOpmmIMy4BqG2M=;
        b=kFqMmLWA9873IUYsQ8y9m9xyv+/eniwSXHmm/C1SYRk2+xBqM9BPxFptEopZeJDUrN
         fVCbZ+LHRTHpvEGOuaSb+CM2AK6eQU+hDeN+bR4p/a2tyyICxnMIUBl2eAbzazCaJCHq
         uZR40TWy4kFDoq+IeUsWrS01Fwnjd7HV4izyEGFA5jURJQTH0DqL3rhP5HmBdPWQxLXk
         HR73hJ6eBDWbDf0litWHB25f5dgmZuipZHmDOKDhx1TV9d+d4RHswTbFSobMbIneB7Ru
         3HF+/2H9htvq5yMJ5xpNAEdOSO/CpiNqPctG9VQJwi4hdMeOb6ixWg3tfQfCBF3doU93
         Eefg==
X-Gm-Message-State: AO0yUKWGzL7xFBbWo/wGPEbXbBXw2BytIalkWSWB3nHcbDWKXXdTvt2F
        KwdQoh+FWoDBygIMINJ5pUwsjXoc8mdCHZbqCjQjagBZRe8xbR4=
X-Google-Smtp-Source: AK7set9f6cl9XubtZuBQSuU7sNClTZLDrlWEyP2zqBZ5xAUkeZBUJLv0a7IYiwTXA6VR86DgpBiuZo86o39RecYfzqM=
X-Received: by 2002:a0d:d346:0:b0:52e:fb6b:fd61 with SMTP id
 v67-20020a0dd346000000b0052efb6bfd61mr15841ywd.271.1676413527026; Tue, 14 Feb
 2023 14:25:27 -0800 (PST)
MIME-Version: 1.0
References: <CGME20230210045651epcas1p1392354722c8ad6d4ffad6f934ba78742@epcms1p7>
 <20230210045608.23274-1-jaewon31.kim@samsung.com> <20230210050333epcms1p7c0bd93b385828aeed9689d1d17ff6789@epcms1p7>
In-Reply-To: <20230210050333epcms1p7c0bd93b385828aeed9689d1d17ff6789@epcms1p7>
From:   John Stultz <jstultz@google.com>
Date:   Tue, 14 Feb 2023 14:25:15 -0800
Message-ID: <CANDhNCranMg0aFx_M50UtRsoNZYZ=mWSmN4_M1im19=+ZtzxiA@mail.gmail.com>
Subject: Re: [PATCH v2] dma-buf: system_heap: avoid reclaim for order 4
To:     jaewon31.kim@samsung.com
Cc:     "tjmercier@google.com" <tjmercier@google.com>,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 9, 2023 at 9:03 PM Jaewon Kim <jaewon31.kim@samsung.com> wrote:
>
> >Using order 4 pages would be helpful for IOMMUs mapping, but trying to get order 4 pages could spend quite much time in the page allocation.
> >From the perspective of responsiveness, the deterministic memory allocation speed, I think, is quite important.
> >
> >The order 4 allocation with __GFP_RECLAIM may spend much time in reclaim and compation logic. __GFP_NORETRY also may affect. These cause unpredictable delay.
> >
> >To get reasonable allocation speed from dma-buf system heap, use HIGH_ORDER_GFP for order 4 to avoid reclaim. And let me remove meaningless __GFP_COMP for order 0.
> >
> >According to my tests, order 4 with MID_ORDER_GFP could get more number of order 4 pages but the elapsed times could be very slow.
> >
> >         time  order 8 order 4 order 0
> >     584 usec  0       160     0
> >  28,428 usec  0       160     0
> > 100,701 usec  0       160     0
> >  76,645 usec  0       160     0
> >  25,522 usec  0       160     0
> >  38,798 usec  0       160     0
> >  89,012 usec  0       160     0
> >  23,015 usec  0       160     0
> >  73,360 usec  0       160     0
> >  76,953 usec  0       160     0
> >  31,492 usec  0       160     0
> >  75,889 usec  0       160     0
> >  84,551 usec  0       160     0
> >  84,352 usec  0       160     0
> >  57,103 usec  0       160     0
> >  93,452 usec  0       160     0
> >
> >If HIGH_ORDER_GFP is used for order 4, the number of order 4 could be decreased but the elapsed time results were quite stable and fast enough.
> >
> >         time  order 8 order 4 order 0
> >   1,356 usec  0       155     80
> >   1,901 usec  0       11      2384
> >   1,912 usec  0       0       2560
> >   1,911 usec  0       0       2560
> >   1,884 usec  0       0       2560
> >   1,577 usec  0       0       2560
> >   1,366 usec  0       0       2560
> >   1,711 usec  0       0       2560
> >   1,635 usec  0       28      2112
> >     544 usec  10      0       0
> >     633 usec  2       128     0
> >     848 usec  0       160     0
> >     729 usec  0       160     0
> >   1,000 usec  0       160     0
> >   1,358 usec  0       160     0
> >   2,638 usec  0       31      2064
> >
> >Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
> >---
> > drivers/dma-buf/heaps/system_heap.c | 5 ++---
> > 1 file changed, 2 insertions(+), 3 deletions(-)
> >
> >diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
> >index e8bd10e60998..920db302a273 100644
> >--- a/drivers/dma-buf/heaps/system_heap.c
> >+++ b/drivers/dma-buf/heaps/system_heap.c
> >@@ -41,12 +41,11 @@ struct dma_heap_attachment {
> >       bool mapped;
> > };
> >
> >-#define LOW_ORDER_GFP (GFP_HIGHUSER | __GFP_ZERO | __GFP_COMP) -#define MID_ORDER_GFP (LOW_ORDER_GFP | __GFP_NOWARN)
> >+#define LOW_ORDER_GFP (GFP_HIGHUSER | __GFP_ZERO)
> > #define HIGH_ORDER_GFP  (((GFP_HIGHUSER | __GFP_ZERO | __GFP_NOWARN \
> >                               | __GFP_NORETRY) & ~__GFP_RECLAIM) \
> >                               | __GFP_COMP)
> >-static gfp_t order_flags[] = {HIGH_ORDER_GFP, MID_ORDER_GFP, LOW_ORDER_GFP};
> >+static gfp_t order_flags[] = {HIGH_ORDER_GFP, HIGH_ORDER_GFP,
> >+LOW_ORDER_GFP};
> > /*
> >  * The selection of the orders used for allocation (1MB, 64K, 4K) is designed
> >  * to match with the sizes often found in IOMMUs. Using order 4 pages instead
> >--
> >2.17.1
> >
> >
>
> added John Stultz <jstultz@google.com>

Sorry for the delay!
Reviewed-by: John Stultz <jstultz@google.com>

thanks
-john
