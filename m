Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5C474E234
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 01:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjGJXYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 19:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjGJXX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 19:23:59 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E700D99
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 16:23:57 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-314313f127fso5244495f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 16:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1689031436; x=1691623436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ax+jVrYfNmxpClqi51wVQRM9DJaaLI9Ll9U+M+qNnIE=;
        b=BLXTGXARwPCt0Z3QY6Hkyqe8P+UvKJuwOcDpcUhFrh7oauHoH7ek9S8FnzkxNKruxX
         h3Fkat+06xrYJVtdH+Ksjd099ymifYhPIVXtCSUuBFupjA4JzaCHCo03hWSvfs1PRNB+
         k5eZnIfD3YabAza1cBlawD8pI6YWJibUkXyDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689031436; x=1691623436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ax+jVrYfNmxpClqi51wVQRM9DJaaLI9Ll9U+M+qNnIE=;
        b=ABZWABWDoF7MKBRO77uBgTvtbdHI/NU4Pqbexdh94IK8iAIFq67mitgJGjIDZAU9qB
         VRnSu1mpa4Lk+KV32MFdOxtrzUiXMoSY+XozdTRMf3d2cWNRZotR6ggV8VhpRhqE0e2w
         yZDAZUjABdjpXmSOJH4LXaXVn8ZyiAPvKbaZDgX7H05v9sfz3bmOtxOEtYmJ1v2qqgIU
         kDambI6O/7DGSbiP80c32w79Vf9epSr0VenhxP+SM64DYI0XIEPxf8c22YEuTQJV0C8g
         +tuuUrMX8eSaLTywf6iq7XYlF84RTIFHb5rZEvDnlW7VKr4jZwQCbbRGsAnnrTdc1qYj
         zFEw==
X-Gm-Message-State: ABy/qLYxA++dtFFP15NaCs9jiOxSYSrVzcMOC32nHZywguJVPRnelRfx
        aje72ih7CZCE61MGw2Sr2QWv8uRZfvm9EM0/idikyA==
X-Google-Smtp-Source: APBJJlGFm5WtVXhSQ1rr5NrU0fVlV2Q2DdNuwoBjwqZ+pOWiiG+QXxeIsX5OhCIZtxaZ8KfCz9A622VrkOCXlZb7k1M=
X-Received: by 2002:a5d:6546:0:b0:314:420c:5ef7 with SMTP id
 z6-20020a5d6546000000b00314420c5ef7mr11980548wrv.11.1689031436427; Mon, 10
 Jul 2023 16:23:56 -0700 (PDT)
MIME-Version: 1.0
References: <CABWYdi0c6__rh-K7dcM_pkf9BJdTRtAU08M43KO9ME4-dsgfoQ@mail.gmail.com>
 <gbqumqkxixvvrbbqh55rw6thgfa67tw2kkcuauc4xj5t6pnivd@3yfkokngo43w>
In-Reply-To: <gbqumqkxixvvrbbqh55rw6thgfa67tw2kkcuauc4xj5t6pnivd@3yfkokngo43w>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Mon, 10 Jul 2023 16:23:45 -0700
Message-ID: <CABWYdi20sL8pK2jjS=v0OG+dPxWnSBXvknVEWeyB47V0F5Wayw@mail.gmail.com>
Subject: Re: Expensive memory.stat + cpu.stat reads
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     cgroups@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 7:44=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> Hello.
>
> On Fri, Jun 30, 2023 at 04:22:28PM -0700, Ivan Babrou <ivan@cloudflare.co=
m> wrote:
> > As you might've noticed from the output, splitting the loop into two
> > makes the code run 10x faster.
>
> That is curious.
>
> > We're running Linux v6.1 (the output is from v6.1.25) with no patches
> > that touch the cgroup or mm subsystems, so you can assume vanilla
> > kernel.
>
> Have you watched for this on older kernels too?

We've been on v6.1 for quite a while now, but it's possible that we
weren't paying enough attention before to notice.

> > I am happy to try out patches or to do some tracing to help understand
> > this better.
>
> I see in your reproducer you tried swapping order of controllers
> flushed.
> Have you also tried flushing same controller twice (in the inner loop)?
> (Despite the expectation is that it shouldn't be different from half the
> scenario where ran two loops.)

Same controller twice is fast (whether it's mem + mem or cpu + cpu):

warm-up
completed: 17.24s [manual / cpu-stat + mem-stat]
completed:  1.02s [manual / mem-stat+mem-stat]
completed:  0.59s [manual / cpu-stat+cpu-stat]
completed:  0.44s [manual / mem-stat]
completed:  0.16s [manual / cpu-stat]
running
completed: 14.32s [manual / cpu-stat + mem-stat]
completed:  1.25s [manual / mem-stat+mem-stat]
completed:  0.42s [manual / cpu-stat+cpu-stat]
completed:  0.12s [manual / mem-stat]
completed:  0.50s [manual / cpu-stat]
