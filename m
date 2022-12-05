Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8418642C7E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 17:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbiLEQGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 11:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiLEQGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 11:06:32 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFE71CB2C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 08:06:31 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id i186so2894289ybc.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 08:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+MY/IUvw30YWp/2etOEFoGheOlDk2Kwhz5Bed/Q9Gfs=;
        b=hdVT9xjnT/mUWGOgc89ArMhDGZMtR5WPYdwB2jbz+xqcUj/JiKdmyrDrkLgBNcztAs
         RvwQpwT5YfjJSku+hrnr1F1XR/20PHVZd1WuoySUCsUVMGgU8pEwmZn8sBjFR9JsCLM+
         eDUpHYoTTQWbM9YA7BjKU1Q1Dfj2qnFxabwK9Uhs4zA6Bma/WG8pEUr8e45+Ljtx0pVu
         lbXuR5N/VjOsRCY+wN4Kf9nSqkYXEqK6DAaN7Tzf5aiHwtqOGiP5wbkhswlVOK7tisYa
         66lczlLnk6iwUaTIzRYRZ8fhRWp1gvsn7RL2g83kff9nHO0Q0vqXGrYadz5rOkPTSEAu
         bShw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+MY/IUvw30YWp/2etOEFoGheOlDk2Kwhz5Bed/Q9Gfs=;
        b=55YlBmuC/VHuwKjc7tlLnS8hK9lU/2p2EN/DpnkSDLYTbm70lNe9wtU8KZ3WrZP3Sr
         Ja4CBpvJ9i7+F+nU+NWUJtvAxnQeeXuABPrIY6sEoD00e2KAM5iZbQFJ2kfHm4OxRGls
         YU6K6UW2rN4qS/f39gApZrYDl4thZ0x8QPP9gnDkRRxAZnPUfMXtooYe2SGMnqChPwas
         M5leh2GS9xTB+D05ZbC70l9k43WVh2rxmI842oeJhX+neUBPdPTUJepev/neq0dwK4eu
         gx0pN71y6ieVua9RsmzDtb69aZpHvNCYddoztis5NOzJOh/cCVqNEIcITjj9igKF55ei
         5+Gw==
X-Gm-Message-State: ANoB5pnstlPhG1cpHxO+gVx69RQXltcyW1wDzt9haa64uxRRQIGMgJbv
        kThR61smUx+4nO1nxpFlOYqslKV16fWgNBYFUnZGw5z6AQZDgWrf
X-Google-Smtp-Source: AA0mqf7GDOWb8ExTp+r+qkNXfkUAFaF3UWSsBLzoTXMRwcEkSq6J3AsnxRRMzYxuVGchQDw3U7+fxlUjKUHybd+CuDg=
X-Received: by 2002:a25:ca4b:0:b0:6fc:c36a:1cf8 with SMTP id
 a72-20020a25ca4b000000b006fcc36a1cf8mr14981358ybg.363.1670256390841; Mon, 05
 Dec 2022 08:06:30 -0800 (PST)
MIME-Version: 1.0
References: <PH0PR11MB562641BC03630B4B7A227FD7E9189@PH0PR11MB5626.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB562641BC03630B4B7A227FD7E9189@PH0PR11MB5626.namprd11.prod.outlook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 5 Dec 2022 08:06:19 -0800
Message-ID: <CALvZod6FGQyuubJ0tAjvBHrhc7r-wFsaz7so74Yk_Fd8x3yLOQ@mail.gmail.com>
Subject: Re: [Regression] mqueue performance degradation after "The new cgroup
 slab memory controller" patchset.
To:     "Luther, Sven" <Sven.Luther@windriver.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Waiman Long <longman@redhat.com>,
        Alexey Gladkov <legion@kernel.org>,
        "Bonn, Jonas" <Jonas.Bonn@windriver.com>
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

Hi Sven,

On Mon, Dec 5, 2022 at 6:56 AM Luther, Sven <Sven.Luther@windriver.com> wrote:
>
> #regzbot ^introduced 10befea91b61c4e2c2d1df06a2e978d182fcf792
>
> We are making heavy use of mqueues, and noticed a degradation of performance between 4.18 & 5.10 linux kernels.
>
> After a gross per-version tracing, we did kernel bisection between 5.8 and 5.9
> and traced the issue to a 10 patches (of which 9 where skipped as they didn't boot) between:
>
>
> commit 10befea91b61c4e2c2d1df06a2e978d182fcf792 (HEAD, refs/bisect/bad)
> Author: Roman Gushchin <guro@fb.com>
> Date:   Thu Aug 6 23:21:27 2020 -0700
>
>     mm: memcg/slab: use a single set of kmem_caches for all allocations
>
> and:
>
> commit 286e04b8ed7a04279ae277f0f024430246ea5eec (refs/bisect/good-286e04b8ed7a04279ae277f0f024430246ea5eec)
> Author: Roman Gushchin <guro@fb.com>
> Date:   Thu Aug 6 23:20:52 2020 -0700
>
>     mm: memcg/slab: allocate obj_cgroups for non-root slab pages
>
> All of them are part of the "The new cgroup slab memory controller" patchset:
>
>   https://lore.kernel.org/all/20200623174037.3951353-18-guro@fb.com/T/
>
> from Roman Gushchin, which moves the accounting for page level to the object level.
>
> Measurements where done using the a test programmtest, which measures mix/average/max time mqueue_send/mqueue_rcv,
> and average for getppid, both measured over 100 000 runs. Results are shown in the following table
>
> +----------+--------------------------+-------------------------+----------------+
> | kernel   |    mqueue_rcv (ns)       | mqueue_send (ns)        |    getppid     |
> | version  | min avg  max   variation | min avg max   variation | (ns) variation |
> +----------+--------------------------+-------------------------+----------------+
> | 4.18.45  | 351 382 17533     base   | 383 410 13178     base  | 149      base  |
> | 5.8-good | 380 392  7156   -2,55%   | 376 384  6225    6,77%  | 169   -11,83%  |
> | 5.8-bad  | 524 530  5310  -27,92%   | 512 519  8775  -21,00%  | 169   -11,83%  |
> | 5.10     | 520 533  4078  -28,33%   | 518 534  8108  -23,22%  | 167   -10,78%  |
> | 5.15     | 431 444  8440  -13,96%   | 425 437  6170   -6,18%  | 171   -12,87%  |
> | 6.03     | 474 614  3881  -37,79%   | 482 693   931  -40,84%  | 171   -12,87%  |
> +----------+--------------------------+-------------------------+-----------------
>

Is the last kernel 6.0.3? Also we know there is performance impact of
per-object kmem accounting. Can you try the latest i.e. 6.1-rc8? There
are a couple of memcg charging optimization patches merged in this
window.
