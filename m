Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A8B6F0D9C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 23:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344169AbjD0VJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 17:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344115AbjD0VJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 17:09:16 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D97A35BB
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 14:09:14 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-506c04dd879so15654209a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 14:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682629753; x=1685221753;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=FIPY/AsEk9VaaX6Ftm9Kn+pTNQ+Lf9NUsugsitn3Cfs=;
        b=OciFjJxMCoLoY11urAU20r7fBv49TndA+cxFy4+WAA720uGUP4YA5Kingp+SDjHJdZ
         O9eCxMayHkR3vv2Asi2IlDaUJcOEfVW/jlWO1Pi/mS7eMom1zomYhUNeEckaUWxgq7ZU
         MUT27ub/dV/mdVzIBfU2LsuuKvpT710Ip7pqBZPOw8z+9vUAn1OrUefmpxqYtvRSB1//
         YsRKZ6FEdCTLmg4MTkdcvMoBSK7w8frntBpzUdjfwHqaugZ7v/J07pAwJ2sVT7fiwASS
         FrI6qsk+mD44P8Cei5z0hVoqJ23TKWnTcYhNkcXRYBnYKBp1WUP5+AGWSdiqtNab/37k
         yFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682629753; x=1685221753;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FIPY/AsEk9VaaX6Ftm9Kn+pTNQ+Lf9NUsugsitn3Cfs=;
        b=AAiElIRECwIjvIVIVsxDMQ4l6Ezr7kF+Djclr4R4yY4DoxkO2Holn+3T2rGzhpDAz7
         A4hONa97iBuL2x0EN1MunX/bmyVT/Mg7Qt/PUAmoMq7YM5XWSUmxZi4H12n92wylw/w0
         81bJLAee/e73k9Dku6HNELxWwCEjPsmPUcyEe8shBO23kT/6dPSEQhNYVM2RFgym4UQl
         QB1Zy+efTurhQkGa3QBFl+G/2wjW2ghhJ+16RuzIODnzmnWM5qBzKEBVFhv+xulFgdN8
         TGPZu49InyZhStuoFPcU9tBgS0alzs9VCe2D2TwVT3FqclDtCrGvJJUqHU92l8P8fw+f
         i7GQ==
X-Gm-Message-State: AC+VfDxNHubZLJixCaLNBrmVTkHVoUEsHONaCiGn9OhdBL3F4ucBLT7/
        itG9SkT7F24EGZ7WKjGLDnY=
X-Google-Smtp-Source: ACHHUZ4jXgOQv4v+Qggvhypzif6sgPBdgeN6c1LPn3O53sXG04lepbWlMEpUcmh6q9yb6pbepHva4w==
X-Received: by 2002:a17:907:701:b0:94f:2347:ce8e with SMTP id xb1-20020a170907070100b0094f2347ce8emr2962691ejb.70.1682629753066;
        Thu, 27 Apr 2023 14:09:13 -0700 (PDT)
Received: from gmail.com (1F2EF38A.nat.pool.telekom.hu. [31.46.243.138])
        by smtp.gmail.com with ESMTPSA id q27-20020a170906361b00b0094e1026bc66sm10238642ejb.140.2023.04.27.14.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 14:09:10 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 27 Apr 2023 23:09:08 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [GIT PULL] SMP cross-call changes for v6.4
Message-ID: <ZErkdNBn7OLkQZWC@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the latest smp/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-core-2023-04-27

   # HEAD: 5c3124975e15c1fadd5af1c61e4d627cf6d97ba2 trace,smp: Trace all smp_function_call*() invocations

SMP cross-CPU function-call updates for v6.4:

 - Remove diagnostics and adjust config for CSD lock diagnostics

 - Add a generic IPI-sending tracepoint, as currently there's no easy
   way to instrument IPI origins: it's arch dependent and for some
   major architectures it's not even consistently available.

 Thanks,

	Ingo

------------------>
Paul E. McKenney (4):
      locking/csd_lock: Add Kconfig option for csd_debug default
      locking/csd_lock: Remove added data from CSD lock debugging
      locking/csd_lock: Remove per-CPU data indirection from CSD lock debugging
      kernel/smp: Make csdlock_debug= resettable

Peter Zijlstra (2):
      trace: Add trace_ipi_send_cpu()
      trace,smp: Trace all smp_function_call*() invocations

Valentin Schneider (7):
      trace: Add trace_ipi_send_cpumask()
      sched, smp: Trace IPIs sent via send_call_function_single_ipi()
      smp: Trace IPIs sent via arch_send_call_function_ipi_mask()
      irq_work: Trace self-IPIs sent via arch_irq_work_raise()
      treewide: Trace IPIs sent via smp_send_reschedule()
      smp: reword smp call IPI comment
      sched, smp: Trace smp callback causing an IPI


 Documentation/admin-guide/kernel-parameters.txt |  17 +-
 arch/alpha/kernel/smp.c                         |   2 +-
 arch/arc/kernel/smp.c                           |   2 +-
 arch/arm/kernel/smp.c                           |   3 +-
 arch/arm/mach-actions/platsmp.c                 |   2 +
 arch/arm64/kernel/smp.c                         |   3 +-
 arch/csky/kernel/smp.c                          |   2 +-
 arch/hexagon/kernel/smp.c                       |   2 +-
 arch/ia64/kernel/smp.c                          |   4 +-
 arch/loongarch/kernel/smp.c                     |   4 +-
 arch/mips/include/asm/smp.h                     |   2 +-
 arch/mips/kernel/rtlx-cmp.c                     |   2 +
 arch/openrisc/kernel/smp.c                      |   2 +-
 arch/parisc/kernel/smp.c                        |   4 +-
 arch/powerpc/kernel/smp.c                       |   6 +-
 arch/powerpc/kvm/book3s_hv.c                    |   3 +
 arch/powerpc/platforms/powernv/subcore.c        |   2 +
 arch/riscv/kernel/smp.c                         |   4 +-
 arch/s390/kernel/smp.c                          |   2 +-
 arch/sh/kernel/smp.c                            |   2 +-
 arch/sparc/kernel/smp_32.c                      |   2 +-
 arch/sparc/kernel/smp_64.c                      |   2 +-
 arch/x86/include/asm/smp.h                      |   2 +-
 arch/x86/kvm/svm/svm.c                          |   4 +
 arch/x86/kvm/x86.c                              |   2 +
 arch/xtensa/kernel/smp.c                        |   2 +-
 include/linux/smp.h                             |  11 +-
 include/trace/events/ipi.h                      |  44 ++++
 kernel/irq_work.c                               |  12 +-
 kernel/sched/core.c                             |  22 +-
 kernel/sched/smp.h                              |   2 +-
 kernel/smp.c                                    | 313 ++++++------------------
 lib/Kconfig.debug                               |   9 +
 virt/kvm/kvm_main.c                             |   3 +
 34 files changed, 219 insertions(+), 281 deletions(-)
