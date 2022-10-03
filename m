Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D435F328F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 17:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiJCPev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 11:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiJCPer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 11:34:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B097665F3
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 08:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664811283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9/KaIUZ8WcfYAhdfeSSOczSjyK1vIpjeWwpilZoktRE=;
        b=GNR1DI0aFerMy0LXuFIDqMXh9EKNY3/sqao7KMRdGTjdJvmkGt/HyieJarH9QxDWk7uDUC
        QGf7qq6Fe38Im3wCWGRFIE6WAuRIAr9WH1GCl3ZVrd+fj4k9ye9bm9iHnPO7icOs7zQu12
        kwovOxq/IDN4SHLDTD4P4TdZencXsGk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-247-MWellHWVMseN4Q6X3pnJbQ-1; Mon, 03 Oct 2022 11:34:42 -0400
X-MC-Unique: MWellHWVMseN4Q6X3pnJbQ-1
Received: by mail-wm1-f71.google.com with SMTP id t14-20020a1c770e000000b003b4856a6ecaso3002829wmi.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 08:34:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=9/KaIUZ8WcfYAhdfeSSOczSjyK1vIpjeWwpilZoktRE=;
        b=7DwR1jBJwAuEp1c0A2KNe8CW6nILSM3/L1CgYLIACWNpzJ3LhOmNQPp71F6q3ERcB0
         /qsaH5w0MdOFBOKe4DQyWsOGpk+uQDnIZb9sbP/Vd6uSL4EwaBMimyistE6F17ZFPaW8
         huItmRkmquYY7lUCQjB+f/6suOZjsDFaBZMLJQgIL+wNzT7wVXOIQE20rMAUQJaVg6Ri
         OXnPctfvmSPhIbynFVW3g9wmap5VYNahM/XCwvnFTiNqbzkCpctk1hLQarkH2dA7ELyd
         GhZG98eh13SCa2kjLQtk2b51nZqetOxD7zzEWv0zmCv6Gjr1D3bstYssQ6R6jD2pALig
         WCXA==
X-Gm-Message-State: ACrzQf07+mqHTwznwVpqgCEUAJd9Y8x/6lDSat8qnpoSk/X+r8fzOqoF
        DICVA+lmzw1OiLaalw8oeO9z9Q7oHJdYx9rNmOaPSllWEDiAsZ8PR6LLjkpIYJhtsnXnJtuM91x
        pyEKhwUUZwfBy+LiIXJy2Cknc
X-Received: by 2002:a5d:6dc1:0:b0:22b:1256:c3e5 with SMTP id d1-20020a5d6dc1000000b0022b1256c3e5mr14192797wrz.336.1664811281059;
        Mon, 03 Oct 2022 08:34:41 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5MSdMQHVCu5bw/khyaPuqLPgcIvcggY9w1GfE9Ep4o5wwBn4hHdqI6JmJCkVHAu/ZvAjcn/Q==
X-Received: by 2002:a5d:6dc1:0:b0:22b:1256:c3e5 with SMTP id d1-20020a5d6dc1000000b0022b1256c3e5mr14192782wrz.336.1664811280807;
        Mon, 03 Oct 2022 08:34:40 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id o9-20020a05600c510900b003a5c244fc13sm18343151wms.2.2022.10.03.08.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 08:34:40 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH bitmap-for-next 0/5] bitmap,cpumask: Add for_each_cpu_andnot()
Date:   Mon,  3 Oct 2022 16:34:15 +0100
Message-Id: <20221003153420.285896-1-vschneid@redhat.com>
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

As suggested by Yury, this is the bitmap/cpumask specific bits of [1]. This now
also contains an extra fix for blk_mq.

This is based on top of Yury's bitmap-for-next [2].

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

[1]: https://lore.kernel.org/all/20220923132527.1001870-1-vschneid@redhat.com/
[2]: https://github.com/norov/linux.git/ -b bitmap-for-next

Cheers,
Valentin

Valentin Schneider (5):
  blk_mq: Fix cpumask_check() warning in blk_mq_hctx_next_cpu()
  lib/find_bit: Introduce find_next_andnot_bit()
  cpumask: Introduce for_each_cpu_andnot()
  lib/test_cpumask: Add for_each_cpu_and(not) tests
  sched/core: Merge cpumask_andnot()+for_each_cpu() into
    for_each_cpu_andnot()

 block/blk-mq.c          |  9 +++++++--
 include/linux/cpumask.h | 18 ++++++++++++++++++
 include/linux/find.h    | 38 ++++++++++++++++++++++++++++++++++++++
 kernel/sched/core.c     |  5 +----
 lib/cpumask_kunit.c     | 19 +++++++++++++++++++
 lib/find_bit.c          |  9 +++++++++
 6 files changed, 92 insertions(+), 6 deletions(-)

--
2.31.1

