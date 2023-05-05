Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58956F7F04
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 10:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjEEI2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 04:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbjEEI2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 04:28:11 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61778160B7
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 01:27:00 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9659e9bbff5so255421466b.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 01:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683275214; x=1685867214;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=0hyn8NYwW9LMLDI5Pp4aBUT4KrWJa1GZeVTbKPgtw74=;
        b=alZ8OEzfg5f1WGEMKOjSps+IfdnMKgjR1pJV0T30D1zGArwkcUKmlpVi7IbosoF2dS
         KriFb57zjsBIVOdBMjFmarZghvCGYzrkwGovGEIEh1eWJu8EGqURbIXKq+ZWIaMlrO0r
         fMFnEdVEjuzQJYbJslgALHo1T66SFHtCNdDvZJIAq9NXnxG6iojIRe+mzrRe/YDpOOGY
         TfaoaDOk8LzKPmPFRiDzzDG5M8t4XGPU2Jzgat+Qu4rmZD+aI7f9U7vUcZ39HLWnRmAH
         hjnkpNFKtIUnJ1uGHgSf66p5YceCxCHU5LgXj45nvGQgqzfqi5BZ8cuNTTCFs1fwBCsf
         TlSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683275214; x=1685867214;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0hyn8NYwW9LMLDI5Pp4aBUT4KrWJa1GZeVTbKPgtw74=;
        b=P2nXY+VG38GyI5NNMHRzXQ3HUgivZd99yZxdYQVHc4V+ERTHeADgh7E49VVaFQ9tj+
         4ttvAu4mLJXDQedxsd8KNH2UT91Qh/aKBvHB5OeT0DYCfLIMLinZejOjsSvCz4OGwndP
         +U3f2cnk8UzI07Uk1lK2ED+y1xFUA6t6+5p3KqUCPH8MgIMrccM2o8i6uzoucEspusQp
         +WRVi/iJAaeIExQCc51Nkay++PwkbUi0QkP+i/uWKp1iWyLRhwprM57o7WXYoH/nDebb
         4cTUM3pY5B6giwnWA7RNa1nuYGIAGpv0sxMhTfKLeDBRzOfsCRALcxfvRoi0fOxpJGGg
         YyvA==
X-Gm-Message-State: AC+VfDzsIf/fBPWoqrNG0vollathsMTbMo/yosk508nh0IQmp64nJbUI
        7eeD4V4xF4cIRkhC1NIDD74LRjHQEy0=
X-Google-Smtp-Source: ACHHUZ6jS/dVXw+ygD2uLyjpMPDevWOTRZpeNjwrRJ0YJboI7mEr1WoFqNLHr8F4QWiikMRkKa42hw==
X-Received: by 2002:a17:907:9345:b0:958:4870:8d09 with SMTP id bv5-20020a170907934500b0095848708d09mr397186ejc.37.1683275214453;
        Fri, 05 May 2023 01:26:54 -0700 (PDT)
Received: from gmail.com (1F2EF00B.nat.pool.telekom.hu. [31.46.240.11])
        by smtp.gmail.com with ESMTPSA id gz4-20020a170907a04400b0094f49f58019sm645965ejc.27.2023.05.05.01.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 01:26:52 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 5 May 2023 10:26:47 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>
Subject: [GIT PULL, v2] locking changes for v6.4
Message-ID: <ZFS9x7CHvtGrmCE6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the latest locking/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2023-05-05

   # HEAD: ec570320b09f76d52819e60abdccf372658216b6 locking/atomic: Correct (cmp)xchg() instrumentation

Locking changes in v6.4:

 - Introduce local{,64}_try_cmpxchg() - a slightly more optimal
   primitive, which will be used in perf events ring-buffer code.

 - Simplify/modify rwsems on PREEMPT_RT, to address writer starvation.

 - Misc cleanups/fixes.

 Thanks,

	Ingo

------------------>
Andrzej Hajda (1):
      locking/arch: Rename all internal __xchg() names to __arch_xchg()

Mark Rutland (1):
      locking/atomic: Correct (cmp)xchg() instrumentation

Sebastian Andrzej Siewior (1):
      locking/rwbase: Mitigate indefinite writer starvation

Uros Bizjak (4):
      locking/atomic: Add generic try_cmpxchg{,64}_local() support
      locking/generic: Wire up local{,64}_try_cmpxchg()
      locking/arch: Wire up local_try_cmpxchg()
      locking/x86: Define arch_try_cmpxchg_local()


 arch/alpha/include/asm/cmpxchg.h            | 10 ++--
 arch/alpha/include/asm/local.h              | 12 +++-
 arch/arc/include/asm/cmpxchg.h              |  4 +-
 arch/arm/include/asm/cmpxchg.h              |  7 ++-
 arch/arm64/include/asm/cmpxchg.h            |  7 +--
 arch/hexagon/include/asm/cmpxchg.h          | 10 ++--
 arch/ia64/include/asm/cmpxchg.h             |  2 +-
 arch/ia64/include/uapi/asm/cmpxchg.h        |  4 +-
 arch/loongarch/include/asm/cmpxchg.h        |  4 +-
 arch/loongarch/include/asm/local.h          | 13 ++++-
 arch/m68k/include/asm/cmpxchg.h             |  6 +-
 arch/mips/include/asm/cmpxchg.h             |  4 +-
 arch/mips/include/asm/local.h               | 13 ++++-
 arch/openrisc/include/asm/cmpxchg.h         | 10 ++--
 arch/parisc/include/asm/cmpxchg.h           |  4 +-
 arch/powerpc/include/asm/cmpxchg.h          |  4 +-
 arch/powerpc/include/asm/local.h            | 11 ++++
 arch/riscv/include/asm/atomic.h             |  2 +-
 arch/riscv/include/asm/cmpxchg.h            |  4 +-
 arch/s390/include/asm/cmpxchg.h             |  8 +--
 arch/sh/include/asm/cmpxchg.h               |  4 +-
 arch/sparc/include/asm/cmpxchg_32.h         |  4 +-
 arch/sparc/include/asm/cmpxchg_64.h         |  6 +-
 arch/x86/include/asm/cmpxchg.h              |  6 ++
 arch/x86/include/asm/local.h                | 13 ++++-
 arch/xtensa/include/asm/cmpxchg.h           |  4 +-
 include/asm-generic/local.h                 |  1 +
 include/asm-generic/local64.h               | 12 +++-
 include/linux/atomic/atomic-arch-fallback.h | 24 +++++++-
 include/linux/atomic/atomic-instrumented.h  | 86 +++++++++++++++++------------
 kernel/locking/rwbase_rt.c                  |  9 ---
 scripts/atomic/gen-atomic-fallback.sh       |  4 ++
 scripts/atomic/gen-atomic-instrumented.sh   |  8 +--
 33 files changed, 209 insertions(+), 111 deletions(-)
