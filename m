Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7B75E7BC6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 15:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbiIWN0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 09:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbiIWNZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 09:25:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739E8145C93
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 06:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663939551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tAeIGOVStX2Lw3qzLzs/LetnOg1f7KwuoITGfiRfzZM=;
        b=FVUj4gEOzx5/E1LvWkT1HQyCQPfQvtH0CwKhGinPeKID6mtt0dwKsaSnp5bQkPyIrnhxN+
        0M5fsd+iSCRzmoezx8wXe3dXkgd/kxJZjvJyzFFnK0FzRHKbuj1AKBmV+6/mIRLDKZGubV
        MngOiv363qLqtVuMlWuLlK+qXQOwLow=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-147-nJdpykjHOPWnRlGFbNI8eA-1; Fri, 23 Sep 2022 09:25:50 -0400
X-MC-Unique: nJdpykjHOPWnRlGFbNI8eA-1
Received: by mail-wm1-f71.google.com with SMTP id k21-20020a7bc415000000b003b4fac53006so28542wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 06:25:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=tAeIGOVStX2Lw3qzLzs/LetnOg1f7KwuoITGfiRfzZM=;
        b=fJTYm/z8jTPWufkMVCSpdWTWqDLqQy9X9vbaIHKJ2x3nQCrpscdUKKUJERpU+TCUXD
         QhnItPVx4rxZKvWZYBGDiK40Eo/VMuZeVRsDY6G7vdCMgrgQiCl+zn76IWvuxMCXddNn
         /m5bFOH6qF7K6vC5l/giyjc/gSRTCcIJ6liuTs3SZctxnXbVa+0fu4BgjkRtqTUTZg7/
         MZd0iPvI7cAjHLv+PCMv/9ohBH/FHc1Zy8nCaiNdxkpCvWi/ve704GGuMaBXOvMGkGXF
         f1dkAXkHT3OYHqP1JGA0x4cJg1XAYtUzQFzKE1R4/Pw7B8h7h4lQ3bWA9theT4F517lJ
         Xlcw==
X-Gm-Message-State: ACrzQf0xwV3mQOO5WSC+SPShDwBvNYYEEd/05u4n7wkVaDdnBws0Ob/q
        H0z/NHMy4/mc1OQRAwCj9ZMmV6T9uD3/Yl8vUK0eJejPtPBjfHOCf/R00Tv72yhA1Dz9C4Z8cM5
        UQV7ums7+rFI+5UZmp1MSIE+0
X-Received: by 2002:a5d:444c:0:b0:22a:e6a2:c498 with SMTP id x12-20020a5d444c000000b0022ae6a2c498mr5314724wrr.531.1663939549562;
        Fri, 23 Sep 2022 06:25:49 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4N/wjIavqBpF3kB6Ziv8ZKrFuJVNi73SNzDhIEw6012kl5eNx3Mxay36+E6T46Vl3hMVXh3Q==
X-Received: by 2002:a5d:444c:0:b0:22a:e6a2:c498 with SMTP id x12-20020a5d444c000000b0022ae6a2c498mr5314710wrr.531.1663939549350;
        Fri, 23 Sep 2022 06:25:49 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id q5-20020a5d6585000000b0022add5a6fb1sm7067306wru.30.2022.09.23.06.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 06:25:48 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gal Pressman <gal@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: [PATCH v4 0/7] sched, net: NUMA-aware CPU spreading interface
Date:   Fri, 23 Sep 2022 14:25:20 +0100
Message-Id: <20220923132527.1001870-1-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

Tariq pointed out in [1] that drivers allocating IRQ vectors would benefit
from having smarter NUMA-awareness (cpumask_local_spread() doesn't quite cut
it).

The proposed interface involved an array of CPUs and a temporary cpumask, and
being my difficult self what I'm proposing here is an interface that doesn't
require any temporary storage other than some stack variables (at the cost of
one wild macro).

Please note that this is based on top of Yury's bitmap-for-next [2] to leverage
his fancy new FIND_NEXT_BIT() macro.

[1]: https://lore.kernel.org/all/20220728191203.4055-1-tariqt@nvidia.com/
[2]: https://github.com/norov/linux.git/ -b bitmap-for-next

A note on treewide use of for_each_cpu_andnot()
===============================================

I've used the below coccinelle script to find places that could be patched (I
couldn't figure out the valid syntax to patch from coccinelle itself):

,-----
@tmpandnot@
expression tmpmask;
iterator for_each_cpu;
position p;
statement S;
@@
cpumask_andnot(tmpmask, ...);

...

(
for_each_cpu@p(..., tmpmask, ...)
	S
|
for_each_cpu@p(..., tmpmask, ...)
{
	...
}
)

@script:python depends on tmpandnot@
p << tmpandnot.p;
@@
coccilib.report.print_report(p[0], "andnot loop here")
'-----

Which yields (against c40e8341e3b3):

.//arch/powerpc/kernel/smp.c:1587:1-13: andnot loop here
.//arch/powerpc/kernel/smp.c:1530:1-13: andnot loop here
.//arch/powerpc/kernel/smp.c:1440:1-13: andnot loop here
.//arch/powerpc/platforms/powernv/subcore.c:306:2-14: andnot loop here
.//arch/x86/kernel/apic/x2apic_cluster.c:62:1-13: andnot loop here
.//drivers/acpi/acpi_pad.c:110:1-13: andnot loop here
.//drivers/cpufreq/armada-8k-cpufreq.c:148:1-13: andnot loop here
.//drivers/cpufreq/powernv-cpufreq.c:931:1-13: andnot loop here
.//drivers/net/ethernet/sfc/efx_channels.c:73:1-13: andnot loop here
.//drivers/net/ethernet/sfc/siena/efx_channels.c:73:1-13: andnot loop here
.//kernel/sched/core.c:345:1-13: andnot loop here
.//kernel/sched/core.c:366:1-13: andnot loop here
.//net/core/dev.c:3058:1-13: andnot loop here

A lot of those are actually of the shape

  for_each_cpu(cpu, mask) {
      ...
      cpumask_andnot(mask, ...);
  }

I think *some* of the powerpc ones would be a match for for_each_cpu_andnot(),
but I decided to just stick to the one obvious one in __sched_core_flip().
  
Revisions
=========

v3 -> v4
++++++++

o Rebased on top of Yury's bitmap-for-next
o Added Tariq's mlx5e patch
o Made sched_numa_hop_mask() return cpu_online_mask for the NUMA_NO_NODE &&
  hops=0 case

v2 -> v3
++++++++

o Added for_each_cpu_and() and for_each_cpu_andnot() tests (Yury)
o New patches to fix issues raised by running the above

o New patch to use for_each_cpu_andnot() in sched/core.c (Yury)

v1 -> v2
++++++++

o Split _find_next_bit() @invert into @invert1 and @invert2 (Yury)
o Rebase onto v6.0-rc1

Cheers,
Valentin

Tariq Toukan (1):
  net/mlx5e: Improve remote NUMA preferences used for the IRQ affinity
    hints

Valentin Schneider (6):
  lib/find_bit: Introduce find_next_andnot_bit()
  cpumask: Introduce for_each_cpu_andnot()
  lib/test_cpumask: Add for_each_cpu_and(not) tests
  sched/core: Merge cpumask_andnot()+for_each_cpu() into
    for_each_cpu_andnot()
  sched/topology: Introduce sched_numa_hop_mask()
  sched/topology: Introduce for_each_numa_hop_cpu()

 drivers/net/ethernet/mellanox/mlx5/core/eq.c | 13 +++++-
 include/linux/cpumask.h                      | 39 ++++++++++++++++
 include/linux/find.h                         | 33 +++++++++++++
 include/linux/topology.h                     | 49 ++++++++++++++++++++
 kernel/sched/core.c                          |  5 +-
 kernel/sched/topology.c                      | 31 +++++++++++++
 lib/cpumask_kunit.c                          | 19 ++++++++
 lib/find_bit.c                               |  9 ++++
 8 files changed, 192 insertions(+), 6 deletions(-)

--
2.31.1

