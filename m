Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130FB678218
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 17:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbjAWQqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 11:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbjAWQqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 11:46:19 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E442BEED
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:46:07 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id v3so9424772pgh.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vWGUNu0aGu5ZM4nyV44fizskyQNi5DbrMxpX2Ig+Ym0=;
        b=FkGh1e+e+kjmYgxeHIOpPR0smd+Hn+zSiA4GrNpQusE8nr/j+vrFqzlYAfpQ7IW4hm
         8WOzAQgge0j/Ut+H1FgBqptleHuq7+YN0+QlDFIbyDlUPni+mFzGIWcs0xzqP7iN3TBf
         kRXng9JNa+RTACtqP4Fca/6/zMwktjVlLgZr01aynq6KceUvpwV+mm2L7URcaxR+jS7k
         9+TnwgRGhNmflN//ylTlNoSRZyuj8dQ8kDz+iTYZyNdBnunnNXoBF40vMxYN1GiuHti5
         F6CsgLJRUFIfrXjjxYyGGaaDUVUAPUSLSaDEecu9U6eWHAdviJNM9cCOqtfTiUYdu9Qe
         NN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vWGUNu0aGu5ZM4nyV44fizskyQNi5DbrMxpX2Ig+Ym0=;
        b=NWcLU1Oz2sit96nvKI8l8EDM7U611F/ffgJ/gI84O72gef5cwgoVrHd9xhGs2AhfqR
         eGbWoRfel406Ep432b23SE6j6mCIAztaXt/C4yvgdeNMin6iCZCzML5fhBwEB+tbFgBx
         nkRBXBr3YviqoA8G6frQsVebuFk0G0/nTFoDy50ojJYjeJ++Pj5CjiJA5ELaCCtghtPt
         PJA/jfnzXIRt0R5YMm9RKZMkeMvwgW6JGF+e9PNvDU7apYiFuOHILF0pcd/SQw8ZPTJ8
         5DaLyS7O2jpWR6TQT0EzJx3/EkII9G/wCEtka2cfuILHA8jTJcESS6FF0yoVvBz/5Fv1
         89hA==
X-Gm-Message-State: AFqh2krvxQeW40Jok+1nelw+8KVmNz78jnjOX+7alvJJcel9h7Ms1OAH
        gl+n/Fr+o7HI39W6CkeEPTVmNad8HLO3Itb7T74=
X-Google-Smtp-Source: AMrXdXtEqhov+LMDDloobzn/rd+ub4SI1+JMziNrVcRSofW/tbjs9MRtJuPnmrs4Yf4JQH3CrHN4qlTAqDPV024jDPk=
X-Received: by 2002:aa7:8046:0:b0:58d:b5d2:fce1 with SMTP id
 y6-20020aa78046000000b0058db5d2fce1mr2622294pfm.21.1674492366745; Mon, 23 Jan
 2023 08:46:06 -0800 (PST)
MIME-Version: 1.0
References: <20230117163543.1049025-1-jannh@google.com>
In-Reply-To: <20230117163543.1049025-1-jannh@google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 23 Jan 2023 17:45:55 +0100
Message-ID: <CA+fCnZfTrxvmQqVd5zo8jo3JY5YqpvQJGx=PSuUvzb8J+KNG3Q@mail.gmail.com>
Subject: Re: [PATCH] fork, vmalloc: KASAN-poison backing pages of vmapped stacks
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 5:35 PM Jann Horn <jannh@google.com> wrote:
>
> KASAN (except in HW_TAGS mode) tracks memory state based on virtual
> addresses. The mappings of kernel stack pages in the linear mapping are
> currently marked as fully accessible.
> Since stack corruption issues can cause some very gnarly errors, let's be
> extra careful and tell KASAN to forbid accesses to stack memory through the
> linear mapping.
>
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> I wrote this after seeing
> https://lore.kernel.org/all/Y8W5rjKdZ9erIF14@casper.infradead.org/
> and wondering about possible ways that this kind of stack corruption
> could be sneaking past KASAN.
> That's proooobably not the explanation, but still...

Hi Jann,

if you decide to keep KASAN poisoning after addressing Dmitry's
comments, please add a KASAN KUnit test for this.

Thank you!
