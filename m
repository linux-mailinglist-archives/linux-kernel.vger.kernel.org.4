Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341A0653F41
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 12:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235332AbiLVLrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 06:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiLVLr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 06:47:26 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEB318E1D;
        Thu, 22 Dec 2022 03:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671709645; x=1703245645;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jJG0WtbR+rCKPAOFXgAECJpdIQA2qxIhAt/9hS9GHCs=;
  b=RrpQORyS/I890Lp0DquOSsvUNL1GKaH1JDdSTSfNsl2C1m725bEPTtYd
   2gbPUxW6rcwn6XEFWvFWW5Vljmnv1bqmkMYjA4O1Eazo+91b0tyAReZoq
   Jzo9fDbWXUBuHRqYWWEneTPW4GW4TJMhW2VBV3vKMnfdYzztJJhFGaebP
   UtUHILqYAS2Hk6ZAaJRPkBPIP4yZZSmNg5AkBl8Kq7mP68UO8EySb/Iqo
   Muq2mYslgd589BVFyOqvIZZvBwi2BYR9zQZt0q9fDUAzlVtw/MY9lAf+u
   NeVGoPH4Y/CKHh41k1phIEUbHFYielmoedk8nF9P9Tc2KOONHmYWfyAya
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="318804416"
X-IronPort-AV: E=Sophos;i="5.96,265,1665471600"; 
   d="scan'208";a="318804416"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2022 03:47:24 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="629504298"
X-IronPort-AV: E=Sophos;i="5.96,265,1665471600"; 
   d="scan'208";a="629504298"
Received: from lab-ah.igk.intel.com ([10.91.215.196])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2022 03:47:18 -0800
From:   Andrzej Hajda <andrzej.hajda@intel.com>
To:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 00/19] Introduce __xchg, non-atomic xchg
Date:   Thu, 22 Dec 2022 12:46:16 +0100
Message-Id: <20221222114635.1251934-1-andrzej.hajda@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I hope there will be place for such tiny helper in kernel.
Quick cocci analyze shows there is probably few thousands places
where it could be useful.
I am not sure who is good person to review/ack such patches,
so I've used my intuition to construct to/cc lists, sorry for mistakes.
This is the 2nd approach of the same idea, with comments addressed[0].

The helper is tiny and there are advices we can leave without it, so
I want to present few arguments why it would be good to have it:

1. Code readability/simplification/number of lines:

Real example from drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c:
-       previous_min_rate = evport->qos.min_rate;
-       evport->qos.min_rate = min_rate;
+       previous_min_rate = __xchg(evport->qos.min_rate, min_rate);

For sure the code is more compact, and IMHO more readable.

2. Presence of similar helpers in other somehow related languages/libs:

a) Rust[1]: 'replace' from std::mem module, there is also 'take'
    helper (__xchg(&x, 0)), which is the same as private helper in
    i915 - fetch_and_zero, see latest patch.
b) C++ [2]: 'exchange' from utility header.

If the idea is OK there are still 2 qestions to answer:

1. Name of the helper, __xchg follows kernel conventions,
    but for me Rust names are also OK.
2. Where to put the helper:
a) as in this patchset include/linux/non-atomic/xchg.h,
    proposed by Andy Shevchenko,
b) include/linux/utils.h ? any better name? Some kind
    of container for simple helpers.

Structure of the patchset:
17 patches releasing __xchg name from arch files
1 patch adding __xchg
1 patch adding users of __xchg

Arnd thanks for convienient set of cross compilers, it was very helpful.

So many words for so small helper :)

[0]: https://lore.kernel.org/lkml/Y5OFSvaYbv4XCxhE@smile.fi.intel.com/T/
[1]: https://doc.rust-lang.org/std/mem/index.html
[2]: https://en.cppreference.com/w/cpp/header/utility

Regards
Andrzej

Andrzej Hajda (19):
  arch/alpha: rename internal name __xchg to __arch_xchg
  arch/arc: rename internal name __xchg to __arch_xchg
  arch/arm: rename internal name __xchg to __arch_xchg
  arch/arm64: rename internal name __xchg to __arch_xchg
  arch/hexagon: rename internal name __xchg to __arch_xchg
  arch/ia64: rename internal name __xchg to __arch_xchg
  arch/loongarch: rename internal name __xchg to __arch_xchg
  arch/m68k: rename internal name __xchg to __arch_xchg
  arch/mips: rename internal name __xchg to __arch_xchg
  arch/openrisc: rename internal name __xchg to __arch_xchg
  arch/parisc: rename internal name __xchg to __arch_xchg
  arch/powerpc: correct logged function names in xchg helpers
  arch/riscv: rename internal name __xchg to __arch_xchg
  arch/s390: rename internal name __xchg to __arch_xchg
  arch/sh: rename internal name __xchg to __arch_xchg
  arch/sparc: rename internal name __xchg to __arch_xchg
  arch/xtensa: rename internal name __xchg to __arch_xchg
  linux/include: add non-atomic version of xchg
  drm/i915/gt: use __xchg instead of internal helper

 arch/alpha/include/asm/cmpxchg.h              |  6 +++---
 arch/arc/include/asm/cmpxchg.h                |  4 ++--
 arch/arm/include/asm/cmpxchg.h                |  4 ++--
 arch/arm64/include/asm/cmpxchg.h              |  4 ++--
 arch/hexagon/include/asm/cmpxchg.h            |  6 +++---
 arch/ia64/include/asm/cmpxchg.h               |  2 +-
 arch/ia64/include/uapi/asm/cmpxchg.h          |  4 ++--
 arch/loongarch/include/asm/cmpxchg.h          |  4 ++--
 arch/m68k/include/asm/cmpxchg.h               |  6 +++---
 arch/mips/include/asm/cmpxchg.h               |  4 ++--
 arch/openrisc/include/asm/cmpxchg.h           |  4 ++--
 arch/parisc/include/asm/cmpxchg.h             |  4 ++--
 arch/powerpc/include/asm/cmpxchg.h            |  4 ++--
 arch/riscv/include/asm/atomic.h               |  2 +-
 arch/riscv/include/asm/cmpxchg.h              |  4 ++--
 arch/s390/include/asm/cmpxchg.h               |  4 ++--
 arch/sh/include/asm/cmpxchg.h                 |  4 ++--
 arch/sparc/include/asm/cmpxchg_32.h           |  4 ++--
 arch/sparc/include/asm/cmpxchg_64.h           |  4 ++--
 arch/xtensa/include/asm/cmpxchg.h             |  4 ++--
 drivers/gpu/drm/i915/gt/intel_engine_cs.c     |  2 +-
 .../gpu/drm/i915/gt/intel_engine_heartbeat.c  |  4 ++--
 .../drm/i915/gt/intel_execlists_submission.c  |  4 ++--
 drivers/gpu/drm/i915/gt/intel_ggtt.c          |  4 ++--
 drivers/gpu/drm/i915/gt/intel_gsc.c           |  2 +-
 drivers/gpu/drm/i915/gt/intel_gt.c            |  4 ++--
 drivers/gpu/drm/i915/gt/intel_gt_pm.c         |  2 +-
 drivers/gpu/drm/i915/gt/intel_lrc.c           |  6 +++---
 drivers/gpu/drm/i915/gt/intel_migrate.c       |  2 +-
 drivers/gpu/drm/i915/gt/intel_rc6.c           |  2 +-
 drivers/gpu/drm/i915/gt/intel_rps.c           |  2 +-
 drivers/gpu/drm/i915/gt/selftest_context.c    |  2 +-
 .../drm/i915/gt/selftest_ring_submission.c    |  2 +-
 drivers/gpu/drm/i915/gt/selftest_timeline.c   |  2 +-
 drivers/gpu/drm/i915/gt/uc/intel_gsc_uc.c     |  2 +-
 drivers/gpu/drm/i915/gt/uc/intel_uc.c         |  2 +-
 drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c      |  2 +-
 drivers/gpu/drm/i915/i915_utils.h             |  1 +
 include/linux/non-atomic/xchg.h               | 19 +++++++++++++++++++
 39 files changed, 84 insertions(+), 64 deletions(-)
 create mode 100644 include/linux/non-atomic/xchg.h

-- 
2.34.1

