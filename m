Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7CED626C32
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 23:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235021AbiKLWsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 17:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiKLWsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 17:48:53 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9017210DE
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 14:48:51 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 136so7226774pga.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 14:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pzirnVX9HS6ZZ0T+SA3bFsjzwhAronLKOoKxUZtrFJo=;
        b=psU90B9zyXa6xsHU9FdgbfSPEmFsooYJOggeAl1ZQjkfuNow9VsMs0h6zbt2KRJWHd
         dI/5PAt3ZJ4wjcLxzG33oQwHYrL4XMRg30LRP9ewmeWwwII6yS4EgY2i9RRCxkp+TFXB
         31DDudEDsDOBIBkNUc7PbhLuP+Hn8jvjPDUYwoL+SVtPCsdQ2K/McCj3io/1D3BvS6eQ
         JatJfuQDp1Jle+1fXUEK0a+/9sHq4Jeu6uMn7kOCYexWd/Wt8LXUyIgKKdU6/k4FAPy9
         qwfbb8EbliNUkACCmDn+lTnLbO22zdTJEx7aaP8KTb06+pgqQsuqoQaigiQy83hQBVBf
         WoCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pzirnVX9HS6ZZ0T+SA3bFsjzwhAronLKOoKxUZtrFJo=;
        b=64OH4xHC26uRlzbAApCyZYMbarpNqktrIPE5noQk5q0XuIYTEr4cxdxsNcwuXuuIEl
         8Q2DX6PUm7voVGV5m25tWTwAWoVm/ROeuqyddoE0Mnx+SwvV+BtlRrC78B6HE+l7eqdq
         uZf99zS3ICpb7QUMa9Z8AR1yBDKfc2nbfJNfk2En0Zh6+XZaInLQrTyyaPfRq5MMuJFc
         lKPdglV9Y7lkbzO4t6WVY/qFHRQQXZfnVgwxdjlG98uk/o+YXGZ/j3Wqh/MmRgIG9M2N
         FAn2UrNSzqnX2Xj7D4pyXDumizxoY4Lp+bC1xQy2nrKzFVAuQVPgOaPY7nYdjGenTqSc
         460w==
X-Gm-Message-State: ANoB5pnSwdtZz5mOTGo7t4pT8EsWLKOCRvKwyVe5iOmRXzbQBRVZqT05
        d+WjIbYaPTJ1wgcFd/q05+5lMg==
X-Google-Smtp-Source: AA0mqf4IyFCvPNuAHmmOus7KBjKRtXN6Hxrsd82gmp+O2SkfhS588FMd618vEdoUgvvoiF/KuPyZQQ==
X-Received: by 2002:aa7:8656:0:b0:562:d99c:2f66 with SMTP id a22-20020aa78656000000b00562d99c2f66mr8200237pfo.42.1668293331106;
        Sat, 12 Nov 2022 14:48:51 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:54c6])
        by smtp.gmail.com with ESMTPSA id f193-20020a6238ca000000b0056d2797bf05sm3739934pfa.217.2022.11.12.14.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 14:48:50 -0800 (PST)
Date:   Sat, 12 Nov 2022 17:48:54 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Joonsoo Kim <js1304@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Hugh Dickins <hughd@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@fb.com
Subject: Re: [PATCH] mm: vmscan: fix extreme overreclaim and swap floods
Message-ID: <Y3Ai1n2sUjbQDq+I@cmpxchg.org>
References: <20220802162811.39216-1-hannes@cmpxchg.org>
 <CAAmzW4OBYPkjPBdhV5H-yhsmzisw8ZdTTsj=QzbW8grY8RqkJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAmzW4OBYPkjPBdhV5H-yhsmzisw8ZdTTsj=QzbW8grY8RqkJQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2022 at 10:59:12AM +0900, Joonsoo Kim wrote:
> I think that we can fix the issue without breaking the fairness.
> Key idea is that doing scan based on the lru having max scan count.
> (aka max-lru)
> As scan is doing on max-lru, do scan the proportional number of
> pages on other lru.
> 
> Pseudo code is here.
> 
> 1. find the lru having max scan count
> 2. calculate nr_to_scan_max for max-lru
> 3. prop = (scanned[max-lru] + nr_to_scan_max) / targets[max-lru]

What's nr_to_scan_max?

AFAICS, prop would round down to 0 pretty quickly for imbalanced LRUs,
at which point it would stop reclaiming the smaller list altogether.

> 3. for_each_lru()
> 3-1. nr_to_scan = (targets[lru] * prop) - scanned[lru]
> 3-2. shrink_list(nr_to_scan)
> 
> With this approach, we can minimize reclaim without breaking the
> fairness.
> 
> Note that actual code needs to handle some corner cases, one of it is
> a low-nr_to_scan case to improve performance.

Right.

The main problem I see is that the discrepancies between LRU sizes can
be many orders bigger than common reclaim goals. Even when one LRU is
just 10x bigger, it'll be difficult to be both fair and still have
efficient batch sizes when the goal is only 32 pages total.

I think a proper way to do fairness would have to track scan history
over multiple cycles. (I think mglru does that, but I can't be sure.)
