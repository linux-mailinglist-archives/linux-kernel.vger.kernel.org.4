Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE596E2853
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 18:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjDNQas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 12:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDNQaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 12:30:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525398A62
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 09:30:45 -0700 (PDT)
Message-ID: <20230414162755.281993820@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681489843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=c+unp6injjwLp32rDRhFKdS15pYib3N33LpCMho7UDw=;
        b=T8SDQEIlUJAsUrnY50V68zec8cQsBn3NrlF9A9FDxDlkD22dBhjIx3mMXVQdg1VvSvrbFh
        32+WnQIsXxLhEasQ0D2xSrGtMIRLeFc7Wm9qMDGcqifNCEj/We9F2QvsmsOLtDkjBHvazP
        FlT1ZGceUGsMOvbBDq8+0pb8yhzHlTEDLN9vTg2cJ2S6fb6Ddau6rxAyJaS8XXyvWA/oX7
        OiOLI1s44qTn56vp0AMFdMkegqEIoIbPOqcoFRGSDoI24PDRlEcAyaqt3uJ5pV8jWVH+wE
        Ap5Pw61kRrU2Jvv4BJktNSSFDJJkLTCMs8KCNMjVQJXaJeQThzu8q1IiIg6vxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681489843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=c+unp6injjwLp32rDRhFKdS15pYib3N33LpCMho7UDw=;
        b=tLLNUNn2IybA12zVsUJc/Wcbt3VorXkST75UUn9vq56G0ASHyaO6NmAx/tpBs4WP3+GVXe
        BZr11lVUYB0Yd5AQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Dave Chinner <dchinner@redhat.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ye Bin <yebin10@huawei.com>, linux-mm@kvack.org
Subject: [patch 0/3] lib/percpu_counter, cpu/hotplug: Cure the cpu_dying_mask woes
Date:   Fri, 14 Apr 2023 18:30:42 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

The cpu_dying_mask is not only undocumented but also to some extent a
misnomer. It's purpose is to capture the last direction of a cpu_up() or
cpu_down() operation taking eventual rollback operations into account.

cpu_dying mask is not really useful for general consumption. The
cpu_dying_mask bits are sticky even after cpu_up() or cpu_down() completes.

A recent fix to plug a race in the per CPU counter code picked
cpu_dying_mask to cure it. Unfortunately this does not work as the author
probably expected and the behaviour of cpu_dying_mask is not easy to change
without breaking the only other and initial user, the scheduler.

This series addresses this by:

   1) Reworking the per CPU counter hotplug mechanism so the race is fully
      plugged without using cpu_dying_mask

   2) Replacing the cpu_dying_mask logic with hotplug core internal state
      which is exposed to the scheduler with a properly documented
      function.

The series is also available from git:

  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git smp/dying_mask

Thanks

	tglx
---
 include/linux/cpuhotplug.h |    2 -
 include/linux/cpumask.h    |   21 ----------------
 kernel/cpu.c               |   45 +++++++++++++++++++++++++++++------
 kernel/sched/core.c        |    4 +--
 kernel/smpboot.h           |    2 +
 lib/percpu_counter.c       |   57 +++++++++++++++++++--------------------------
 6 files changed, 67 insertions(+), 64 deletions(-)
