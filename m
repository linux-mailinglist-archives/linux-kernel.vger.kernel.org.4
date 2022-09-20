Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601B65BDA52
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 04:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiITCnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 22:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiITCnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 22:43:12 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB6F3C16E;
        Mon, 19 Sep 2022 19:43:11 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1663641790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vAncZByPkoCFOTjOp+egDegb9m3Yz/Q5WDR2S9gSIZM=;
        b=mdAsRzbX3cbw0X7FfrIXOW6xyR2tuRo5rZkfDSxbdwF2e8g5IXjOKRnou7uh3gCNHpK9S+
        vU9ueURLYSSJrvDIT78/NAa7P2cyu+11tpEcwMbK0wodjDSlUjQEKLFYO3xNw19u9A9vtA
        UAIZ3Dq41GcY/8wPy+TNwVeXA8A2A2s=
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] mm: memcontrol: make cgroup_memory_noswap a static
 key
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20220919180634.45958-3-ryncsn@gmail.com>
Date:   Tue, 20 Sep 2022 10:43:04 +0800
Cc:     cgroups@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <54AAE1A0-8C5A-4771-AC96-7A2919F07645@linux.dev>
References: <20220919180634.45958-1-ryncsn@gmail.com>
 <20220919180634.45958-3-ryncsn@gmail.com>
To:     Kairui Song <kasong@tencent.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 20, 2022, at 02:06, Kairui Song <ryncsn@gmail.com> wrote:
>=20
> From: Kairui Song <kasong@tencent.com>
>=20
> cgroup_memory_noswap is used in many hot path, so make it a static key
> to lower the kernel overhead.
>=20
> Using 8G of ZRAM as SWAP, benchmark using `perf stat -d -d -d --repeat =
100`
> with the following code snip in a non-root cgroup:
>=20
>   #include <stdio.h>
>   #include <string.h>
>   #include <linux/mman.h>
>   #include <sys/mman.h>
>   #define MB 1024UL * 1024UL
>   int main(int argc, char **argv){
>      void *p =3D mmap(NULL, 8000 * MB, PROT_READ | PROT_WRITE,
>                     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>      memset(p, 0xff, 8000 * MB);
>      madvise(p, 8000 * MB, MADV_PAGEOUT);
>      memset(p, 0xff, 8000 * MB);
>      return 0;
>   }
>=20
> Before:
>          7,021.43 msec task-clock                #    0.967 CPUs =
utilized            ( +-  0.03% )
>             4,010      context-switches          #  573.853 /sec       =
              ( +-  0.01% )
>                 0      cpu-migrations            #    0.000 /sec
>         2,052,057      page-faults               #  293.661 K/sec      =
              ( +-  0.00% )
>    12,616,546,027      cycles                    #    1.805 GHz        =
              ( +-  0.06% )  (39.92%)
>       156,823,666      stalled-cycles-frontend   #    1.25% frontend =
cycles idle     ( +-  0.10% )  (40.25%)
>       310,130,812      stalled-cycles-backend    #    2.47% backend =
cycles idle      ( +-  4.39% )  (40.73%)
>    18,692,516,591      instructions              #    1.49  insn per =
cycle
>                                                  #    0.01  stalled =
cycles per insn  ( +-  0.04% )  (40.75%)
>     4,907,447,976      branches                  #  702.283 M/sec      =
              ( +-  0.05% )  (40.30%)
>        13,002,578      branch-misses             #    0.26% of all =
branches          ( +-  0.08% )  (40.48%)
>     7,069,786,296      L1-dcache-loads           #    1.012 G/sec      =
              ( +-  0.03% )  (40.32%)
>       649,385,847      L1-dcache-load-misses     #    9.13% of all =
L1-dcache accesses  ( +-  0.07% )  (40.10%)
>     1,485,448,688      L1-icache-loads           #  212.576 M/sec      =
              ( +-  0.15% )  (39.49%)
>        31,628,457      L1-icache-load-misses     #    2.13% of all =
L1-icache accesses  ( +-  0.40% )  (39.57%)
>         6,667,311      dTLB-loads                #  954.129 K/sec      =
              ( +-  0.21% )  (39.50%)
>         5,668,555      dTLB-load-misses          #   86.40% of all =
dTLB cache accesses  ( +-  0.12% )  (39.03%)
>               765      iTLB-loads                #  109.476 /sec       =
              ( +- 21.81% )  (39.44%)
>         4,370,351      iTLB-load-misses          # 214320.09% of all =
iTLB cache accesses  ( +-  1.44% )  (39.86%)
>       149,207,254      L1-dcache-prefetches      #   21.352 M/sec      =
              ( +-  0.13% )  (40.27%)
>=20
>           7.25869 +- 0.00203 seconds time elapsed  ( +-  0.03% )
>=20
> After:
>          6,576.16 msec task-clock                #    0.953 CPUs =
utilized            ( +-  0.10% )
>             4,020      context-switches          #  605.595 /sec       =
              ( +-  0.01% )
>                 0      cpu-migrations            #    0.000 /sec
>         2,052,056      page-faults               #  309.133 K/sec      =
              ( +-  0.00% )
>    11,967,619,180      cycles                    #    1.803 GHz        =
              ( +-  0.36% )  (38.76%)
>       161,259,240      stalled-cycles-frontend   #    1.38% frontend =
cycles idle     ( +-  0.27% )  (36.58%)
>       253,605,302      stalled-cycles-backend    #    2.16% backend =
cycles idle      ( +-  4.45% )  (34.78%)
>    19,328,171,892      instructions              #    1.65  insn per =
cycle
>                                                  #    0.01  stalled =
cycles per insn  ( +-  0.10% )  (31.46%)
>     5,213,967,902      branches                  #  785.461 M/sec      =
              ( +-  0.18% )  (30.68%)
>        12,385,170      branch-misses             #    0.24% of all =
branches          ( +-  0.26% )  (34.13%)
>     7,271,687,822      L1-dcache-loads           #    1.095 G/sec      =
              ( +-  0.12% )  (35.29%)
>       649,873,045      L1-dcache-load-misses     #    8.93% of all =
L1-dcache accesses  ( +-  0.11% )  (41.41%)
>     1,950,037,608      L1-icache-loads           #  293.764 M/sec      =
              ( +-  0.33% )  (43.11%)
>        31,365,566      L1-icache-load-misses     #    1.62% of all =
L1-icache accesses  ( +-  0.39% )  (45.89%)
>         6,767,809      dTLB-loads                #    1.020 M/sec      =
              ( +-  0.47% )  (48.42%)
>         6,339,590      dTLB-load-misses          #   95.43% of all =
dTLB cache accesses  ( +-  0.50% )  (46.60%)
>               736      iTLB-loads                #  110.875 /sec       =
              ( +-  1.79% )  (48.60%)
>         4,314,836      iTLB-load-misses          # 518653.73% of all =
iTLB cache accesses  ( +-  0.63% )  (42.91%)
>       144,950,156      L1-dcache-prefetches      #   21.836 M/sec      =
              ( +-  0.37% )  (41.39%)
>=20
>           6.89935 +- 0.00703 seconds time elapsed  ( +-  0.10% )
>=20
> The performance is clearly better. There is no significant hotspot
> improvement according to perf report, as there are quite a few
> callers of memcg_swap_enabled and do_memsw_account (which calls
> memcg_swap_enabled). Many pieces of minor optimizations resulted
> in lower overhead for the branch predictor, and bettter performance.
>=20
> Acked-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>

Acked-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

