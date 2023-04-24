Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E886E46EB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 13:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjDQL4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 07:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjDQL4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 07:56:47 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F1F98
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 04:55:46 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id kt6so25219005ejb.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 04:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681732535; x=1684324535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hAfhUM23NLqVvA/6Hxfd6Xgc8oePCVqguK6TK2m4xx0=;
        b=YOBGao3Gh4rsypVOuHoE1ytvu3v+zzuIisiDjA+pAPLUyn2lc4W2y580wM0QGqDuBK
         t2E4fbgVIhzJkdNrXON9Fk4ppV/G0uJJY87Mggs8FmMDwvTtrBjmQayh9K/oWmrRXfDT
         w3OPKIPguHHmcs76WPPVys//oHx3UrhionPHUQHviOENI+JaZF1M/wpgoGXe0OqwfSVJ
         amMjGmlYHvk2HrrkdEj7F2j2V2hoSumB9UuA9pw4ITvpp7IPm19MV3XM8v0gk3ZoHHlA
         4y71YZlBrpzkXhBU69R8xFtV1gn1I/z2Ufb4CZ7Dh1rW6T7kjFc6InE6Cpgq/99EkcVp
         jAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681732535; x=1684324535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hAfhUM23NLqVvA/6Hxfd6Xgc8oePCVqguK6TK2m4xx0=;
        b=Lv6a0uUuj/ilooMcn/rcu53JbMtW/nObGu/+wIu8z5cnJn9h2q7ruD/uSNuhcNszyT
         rd5ENc4Bx4V3iag/WffRp4fjfm+C9EoO9GjI1DUjgxPx6pLCDuxv58AGieA5LxIvS0D6
         SSs8Fw7TMsebQZneCbNyB4q4+hcbA36RDEB14pEjeWvMpR04AspZ96znG3xabgPxhuy3
         XMCq90gp5JQTeCCVSYmbp+PhiarV6oEuX5T5R+4KGvNsJWWR/haIjMhjlYCEAlCBWNt2
         QMHnArv4DTExOLQQ/ALf+4nTQqDW9lcFFK4T2TAX5rRpCaZB43Ct7xe2Xt4pKA+OEYX5
         bhkA==
X-Gm-Message-State: AAQBX9fjby74UIIzC15frwIbGdpY+9sOvJ0uxa9iatAbt0M3cfWbPLhH
        VxIjjsM4wqswMYa4zbmy26/OrHWG+YVRBZbVR6La9g==
X-Google-Smtp-Source: AKy350Y5hBUoVr9Q+rVltKOFfeaVq+COPSzaOmznVTOL8PIWcXm7nigxXo7jRIinYg1V6Jm9LgrUetXlRewKTi7ttcs=
X-Received: by 2002:a17:906:2656:b0:94e:5f2a:23fe with SMTP id
 i22-20020a170906265600b0094e5f2a23femr3568963ejc.5.1681732534659; Mon, 17 Apr
 2023 04:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230403220337.443510-1-yosryahmed@google.com>
In-Reply-To: <20230403220337.443510-1-yosryahmed@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 17 Apr 2023 04:54:52 -0700
Message-ID: <CAJD7tkZjoWMXFSgBwAtXao35f3Gmmp9cEordvFAPX_EegC_o1A@mail.gmail.com>
Subject: Re: [PATCH mm-unstable RFC 0/5] cgroup: eliminate atomic rstat
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 3, 2023 at 3:03=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> A previous patch series ([1] currently in mm-unstable) changed most
> atomic rstat flushing contexts to become non-atomic. This was done to
> avoid an expensive operation that scales with # cgroups and # cpus to
> happen with irqs disabled and scheduling not permitted. There were two
> remaining atomic flushing contexts after that series. This series tries
> to eliminate them as well, eliminating atomic rstat flushing completely.
>
> The two remaining atomic flushing contexts are:
> (a) wb_over_bg_thresh()->mem_cgroup_wb_stats()
> (b) mem_cgroup_threshold()->mem_cgroup_usage()
>
> For (a), flushing needs to be atomic as wb_writeback() calls
> wb_over_bg_thresh() with a spinlock held. However, it seems like the
> call to wb_over_bg_thresh() doesn't need to be protected by that
> spinlock, so this series proposes a refactoring that moves the call
> outside the lock criticial section and makes the stats flushing
> in mem_cgroup_wb_stats() non-atomic.
>
> For (b), flushing needs to be atomic as mem_cgroup_threshold() is called
> with irqs disabled. We only flush the stats when calculating the root
> usage, as it is approximated as the sum of some memcg stats (file, anon,
> and optionally swap) instead of the conventional page counter. This
> series proposes changing this calculation to use the global stats
> instead, eliminating the need for a memcg stat flush.
>
> After these 2 contexts are eliminated, we no longer need
> mem_cgroup_flush_stats_atomic() or cgroup_rstat_flush_atomic(). We can
> remove them and simplify the code.
>
> Yosry Ahmed (5):
>   writeback: move wb_over_bg_thresh() call outside lock section
>   memcg: flush stats non-atomically in mem_cgroup_wb_stats()
>   memcg: calculate root usage from global state
>   memcg: remove mem_cgroup_flush_stats_atomic()
>   cgroup: remove cgroup_rstat_flush_atomic()
>
>  fs/fs-writeback.c          | 16 +++++++----
>  include/linux/cgroup.h     |  1 -
>  include/linux/memcontrol.h |  5 ----
>  kernel/cgroup/rstat.c      | 26 ++++--------------
>  mm/memcontrol.c            | 54 ++++++++------------------------------
>  5 files changed, 27 insertions(+), 75 deletions(-)
>
> --
> 2.40.0.348.gf938b09366-goog
>

Any thoughts on this series, anyone? :)
