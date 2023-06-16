Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB947324C1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 03:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjFPBkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 21:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjFPBkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 21:40:08 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9422959
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 18:40:06 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-970056276acso14623966b.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 18:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686879605; x=1689471605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rc1hgv0w9pIu6RN6uxj2ZcqEyGVaNMB+/vO2dnSoE2M=;
        b=Vxq9AlZSAbYtLe24k3NcJpfl8+3exe3cZ+meB1+4tVbP19Z7U82VSXHbfBSQXgv5vr
         syV5WqKnMtxCJP7q5G6sOXGjTNHlQaClT4F3Giy6YS7fTKN6KHeNibdGEjc79Un1TxbP
         ySnCOZEB2GG1yokV0FOdRsOAjzy+sv3/QRSZwPPpqjsw8xbgHodfLILs94b+Uv3KMcV4
         wHIzyFiWQksAHIRx2hRZ/vqxEOQVlBsLbvPsvamsu6Q1er9/tYvm+vSBkDmVxUOJxE5v
         bsTcf3F0EThaxyYLQoPFhVQaxxNZAIrxizq1I0L17cCjyOojemz/oCCfy3HfXkzuDyhf
         ehQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686879605; x=1689471605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rc1hgv0w9pIu6RN6uxj2ZcqEyGVaNMB+/vO2dnSoE2M=;
        b=AKoO73g1l1B0F3AAYVsJRn5IPnss+iUq5sUcWMO5i3m5sUHD5q09qiZ0C/Mg42CLts
         Lv+PXFsv4i4yeNhB3WFZpuJ1i4j1wbkYdyyoDd5JC6/9EH8CBqGszgW3dV5E/+nKRMpT
         I/+5c2A25R0fmku5Jhq/bUCIGx9cWO5Z/lcYQlqkK+C8uAU1J39niTx2litgXb93dU+o
         3+/8RsY92wrLvj9Gy8IVXas7wTs1Tkskkx6+8C/+gnlP405/c4F0znRWMgmqG498zR5/
         7V5hS+YxUm6MzBYc2zx6cA0Sk/vzT9mYL2n7aTzQViESRAl6g16vjXzs8mDH4G01wf3U
         llCQ==
X-Gm-Message-State: AC+VfDwM6f3wMPSaXoN3vTaRvAZZu3YANJj/+supWykhV/tzGu7qz+JV
        qG2Pj3DMUwTo+cElr/3m4Hg+eEwfM9iQHhTDLP+BhGwJDpfu+WHJlVY=
X-Google-Smtp-Source: ACHHUZ779lZ17Te9wV+ANjzptQwTFMdsa51ddxV8vAA/0PdB5+k5vVmVegOJ1cM+FCvkgxDoSfrGfUYNi7LulQUTUdE=
X-Received: by 2002:a17:907:8a04:b0:96f:bd84:b89c with SMTP id
 sc4-20020a1709078a0400b0096fbd84b89cmr492148ejc.70.1686879605208; Thu, 15 Jun
 2023 18:40:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230615034830.1361853-1-hezhongkun.hzk@bytedance.com>
 <CAOUHufZBUEm1P7gm0nFkPSFkNg2fPbs3v3qhL-R9m5yFNoW2YA@mail.gmail.com> <CA+PVUaTqNTSYkTy9yCFF=Y+xkimgM+3YQRF7EYr1UruesQnJrg@mail.gmail.com>
In-Reply-To: <CA+PVUaTqNTSYkTy9yCFF=Y+xkimgM+3YQRF7EYr1UruesQnJrg@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 15 Jun 2023 18:39:28 -0700
Message-ID: <CAJD7tka-=ppaheVxn2-f6u0egBp8kOHYAK0bBudC62SKkZPk5w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] zram: charge the compressed RAM to the page's memcgroup
To:     Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc:     Yu Zhao <yuzhao@google.com>, minchan@kernel.org,
        senozhatsky@chromium.org, mhocko@suse.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Fabian Deutsch <fdeutsch@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 1:57=E2=80=AFAM Fabian Deutsch <fdeutsch@redhat.com=
> wrote:
>
>
> On Thu, Jun 15, 2023 at 6:59=E2=80=AFAM Yu Zhao <yuzhao@google.com> wrote=
:
>>
>> On Wed, Jun 14, 2023 at 9:48=E2=80=AFPM Zhongkun He
>> <hezhongkun.hzk@bytedance.com> wrote:
>> >
>> > The compressed RAM is currently charged to kernel, not to
>> > any memory cgroup, which is not satisfy our usage scenario.
>> > if the memory of a task is limited by memcgroup, it will
>> > swap out the memory to zram swap device when the memory
>> > is insufficient. In that case, the memory limit will have
>> > no effect.
>> >
>> > So, it should makes sense to charge the compressed RAM to
>> > the page's memory cgroup.
>
>
> While looking at this in the past weeks, I believe that there are two dis=
tinct problems:
> 1. Direct zram usage by process within a cg ie. a process writing to a zr=
am device
> 2. Indirect zram usage by a process within a cg via swap (described above=
)
>
> Both of them probably require different solutions.
> In order to fix #1, accounting a zram device should be accounted towards =
a cgroup. IMHO this is something that should be fixed.
>
> Yu Zhao and Yosry are probably much more familiar with the solution to #2=
.
> WRT per-cgrou-swapfile, to me this is addressing #2, but I agree with Yu =
Zhao, that there are probably better solutions to this.

Thanks Fabian for tagging me.

I am not familiar with #1, so I will speak to #2. Zhongkun, There are
a few parts that I do not understand -- hopefully you can help me out
here:

(1) If I understand correctly in this patch we set the active memcg
trying to charge any pages allocated in a zspage to the current memcg,
yet that zspage will contain multiple compressed object slots, not
just the one used by this memcg. Aren't we overcharging the memcg?
Basically the first memcg that happens to allocate the zspage will pay
for all the objects in this zspage, even after it stops using the
zspage completely?

(2) Patch 3 seems to be charging the compressed slots to the memcgs,
yet this patch is trying to charge the entire zspage. Aren't we double
charging the zspage? I am guessing this isn't happening because (as
Michal pointed out) we are not using __GFP_ACCOUNT here anyway, so
this patch may be NOP, and the actual charging is coming from patch 3
only.

(3) Zswap recently implemented per-memcg charging of compressed
objects in a much simpler way. If your main interest is #2 (which is
what I understand from the commit log), it seems like zswap might be
providing this already? Why can't you use zswap? Is it the fact that
zswap requires a backing swapfile?

Thanks!

>
> Lastly, this patchset, while it will possibly not address the swap issue =
(#2) completely, is it satisfying the needs of #1?
>
> - fabian
>
>>
>> We used to do this a long time ago, but we had per-memcg swapfiles [1[
>> to prevent compressed pages from different memcgs from sharing the
>> same zspage.
>>
>> Does this patchset alone suffer from the same problem, i.e., memcgs
>> sharing zspages?
>>
>> [1] https://lwn.net/Articles/592923/
>>
