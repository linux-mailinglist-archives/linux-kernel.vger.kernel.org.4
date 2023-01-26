Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B34D67D0C9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 17:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbjAZQB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 11:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbjAZQBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 11:01:24 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFC449950
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 08:01:22 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id h5so2497555ybj.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 08:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7iT09H71Dme3Q3L2MGkwR4iQszyIGWWfBf0bjQrq8xA=;
        b=h9de1i7T+L/7qnwBfp1S8fAzJvvQC2x2oi3vaG0TabJnrPiEBHWMEBUMQXNE++gvMw
         0tvtDLc0gqU4SRrHQyLqiExsMlL/VWO5wXXXCyd4EfosvDm71I8QvFY9h9dh4v0odaek
         rqxRskgYYgAwXV/VpRufMlPSe3KjlzDDMsziRrkBRXl9kqFNnahRRoF7T3nsICDVigSD
         M9djwB9/VxsVfyDOcI98ZfLuT3Eimz5ul1kQFCbvVp6FsrPyT95Rr+ConemDfB7nun1a
         z0oNevShUsT5s5sUR+jodRgmCNuCA3ig4D6U+61xYKrnx3Cx6jPyfSahl9izAuY1q4Iw
         /Sug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7iT09H71Dme3Q3L2MGkwR4iQszyIGWWfBf0bjQrq8xA=;
        b=Id7ArL+coJ9IA+tHsZARvMNDMtFJ1w2+FvuwSer17An4FM14qqeRfzAP3Zr8j86nb7
         tpMKw6XJV1SL3FCRv71DY5hBb7C4w7BjaD56fnzW/qkPe0osELxcvjF25IL9jYXmmOTW
         GgkWRIg8ALYv/19ctgs2Ken7YZWJUZSr856bBXwN8Og4YKcigFkOvhPEwnImFaMMSZtK
         DlaAefT2BKNxyUTxPshB16LoUroHXt4rmLddE+BcamhUJV7jBULZvrp5eXfh9pjjdjRJ
         3JJEdAaEL0S1YMJKfqDCBK5OpSTS1N7P7dxNd+J5JdQ9rIWUPoCcLw6/u3cA1T8ONd/B
         pibA==
X-Gm-Message-State: AO0yUKWO/zs11qHXUo/XburEh0FWonFaLauN0w9ixPl1Mpssh4Vkq8D5
        lKr05s1M8A9CEha9IuutcFU2ULMmT356EeVgSFATIQ==
X-Google-Smtp-Source: AK7set99qRZVqRtIv3KrfALWAP/G2LmVplScKaMgMWNFGGAbZHIOd3N3iLzS8k8hn4NEwWK4eNRhXhPnLf2Bk2V7g6Y=
X-Received: by 2002:a25:5209:0:b0:80b:5988:2045 with SMTP id
 g9-20020a255209000000b0080b59882045mr1083640ybb.59.1674748881333; Thu, 26 Jan
 2023 08:01:21 -0800 (PST)
MIME-Version: 1.0
References: <20230125233554.153109-1-surenb@google.com> <20230125233554.153109-3-surenb@google.com>
 <20230126135815.7hjwrrv77y2en2ku@techsingularity.net>
In-Reply-To: <20230126135815.7hjwrrv77y2en2ku@techsingularity.net>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 26 Jan 2023 08:01:10 -0800
Message-ID: <CAJuCfpHvz8tbgQU_15nxQu2vTjRv9OWjOg5cXBkS_whUC92nxA@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] mm: introduce vma->vm_flags wrapper functions
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, dave@stgolabs.net, willy@infradead.org,
        liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, hughlynch@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
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

On Thu, Jan 26, 2023 at 5:58 AM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Wed, Jan 25, 2023 at 03:35:49PM -0800, Suren Baghdasaryan wrote:
> > vm_flags are among VMA attributes which affect decisions like VMA merging
> > and splitting. Therefore all vm_flags modifications are performed after
> > taking exclusive mmap_lock to prevent vm_flags updates racing with such
> > operations. Introduce modifier functions for vm_flags to be used whenever
> > flags are updated. This way we can better check and control correct
> > locking behavior during these updates.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> With or without the suggested rename;
>
> Acked-by: Mel Gorman <mgorman@techsingularity.net>

Thanks! I'll make the renames and repost the patchset.
vm_flags_init(), vm_flags_reset(), etc. sounds like a good naming for
this.

>
> --
> Mel Gorman
> SUSE Labs
