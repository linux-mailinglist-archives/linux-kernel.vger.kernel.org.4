Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DB769F2CE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 11:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjBVKga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 05:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjBVKg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 05:36:27 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F9136687;
        Wed, 22 Feb 2023 02:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677062186; x=1708598186;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ofUmRpvhNVTg3+A6hyPOFASnnH8za9ygTzj8N8YfXSk=;
  b=Oa1y8iBaEkwy6fMvhe8oHhodd0xu0As0Cvn/STEHYeZTWBGyfJe7EiEm
   6mSrg3MYKSIj57s2gHXQABHZjXgh0qtnz8ySVm6qQeJyCvOuGb4tmLl/i
   ODkBGj8NRNmFmO/zJQkENaevWgOePr99Uw2LrDfsA71eM4ha127NIJGZp
   bCHCoWB8AsMbRlZS/pSYtspvgmv35WrA4X9gEpfyLPG+CgCn4UpRcV5v1
   qwKQeXDm3DQv4XTKuWY2dKn1nW505DyJPI+fQqri+uwh1CV8IXCxKtwVN
   fmv6q43VzWYXBl2v2uMj/nIILB4fKAQtBRNyqRlFQDE8BcQ/YGRkTqXLC
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="321031748"
X-IronPort-AV: E=Sophos;i="5.97,318,1669104000"; 
   d="scan'208";a="321031748"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2023 02:36:25 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="781379853"
X-IronPort-AV: E=Sophos;i="5.97,318,1669104000"; 
   d="scan'208";a="781379853"
Received: from ahajda-mobl.ger.corp.intel.com (HELO [10.213.26.51]) ([10.213.26.51])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2023 02:36:19 -0800
Message-ID: <50c1806b-f153-da48-ddf4-53923fa90334@intel.com>
Date:   Wed, 22 Feb 2023 11:36:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [Intel-gfx] [PATCH v5 0/7] Introduce __xchg, non-atomic xchg
Content-Language: en-US
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
Cc:     Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20230118153529.57695-1-andrzej.hajda@intel.com>
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20230118153529.57695-1-andrzej.hajda@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Ping on the series.
Arnd, Andrew is there anything more I can do to push the process forward?

Regards
Andrzej


On 18.01.2023 16:35, Andrzej Hajda wrote:
> Hi all,
> 
> The helper is tiny and there are advices we can live without it, so
> I want to present few arguments why it would be good to have it:
> 
> 1. Code readability/simplification/number of lines:
>    - decreases number of lines,
>    - it often eliminates local variables,
>    - for real examples see patches 3+.
> 
> 2. Presence of similar helpers in other somehow related languages/libs:
> 
> a) Rust[1]: 'replace' from std::mem module, there is also 'take'
>      helper (__xchg(&x, 0)), which is the same as private helper in
>      i915 - fetch_and_zero, see latest patch.
> b) C++ [2]: 'exchange' from utility header.
> 
> If the idea is OK there are still 2 questions to answer:
> 
> 1. Name of the helper, __xchg follows kernel conventions,
>      but for me Rust names are also OK.
> 2. Where to put the helper:
> a) as in this patchset include/linux/non-atomic/xchg.h,
>      proposed by Andy Shevchenko,
> b) include/linux/utils.h ? any better name? Some kind
>      of container for simple helpers.
> 
> All __xchg conversions were performed using cocci script,
> then manually adjusted if necessary.
> 
> There is lot of places it can be used in, I have just chosen
> some of them. I can provide cocci script to detect others (not all),
> if necessary.
> 
> Changes:
> v2: squashed all __xchg -> __arch_xchg t one patch (Arnd)
> v3: fixed alpha/xchg_local (lkp@intel.com)
> v4: adjusted indentation (Heiko)
> v5: added more __xchg conversions - patches 3-6, added tags
> 
> [1]: https://doc.rust-lang.org/std/mem/index.html
> [2]: https://en.cppreference.com/w/cpp/header/utility
> 
> Regards
> Andrzej
> 
> Andrzej Hajda (7):
>    arch: rename all internal names __xchg to __arch_xchg
>    linux/include: add non-atomic version of xchg
>    arch/*/uprobes: simplify arch_uretprobe_hijack_return_addr
>    llist: simplify __llist_del_all
>    io_uring: use __xchg if possible
>    qed: use __xchg if possible
>    drm/i915/gt: use __xchg instead of internal helper
> 
>   arch/alpha/include/asm/cmpxchg.h              | 10 +++++-----
>   arch/arc/include/asm/cmpxchg.h                |  4 ++--
>   arch/arm/include/asm/cmpxchg.h                |  7 ++++---
>   arch/arm/probes/uprobes/core.c                |  8 ++------
>   arch/arm64/include/asm/cmpxchg.h              |  7 +++----
>   arch/arm64/kernel/probes/uprobes.c            |  9 ++-------
>   arch/csky/kernel/probes/uprobes.c             |  9 ++-------
>   arch/hexagon/include/asm/cmpxchg.h            | 10 +++++-----
>   arch/ia64/include/asm/cmpxchg.h               |  2 +-
>   arch/ia64/include/uapi/asm/cmpxchg.h          |  4 ++--
>   arch/loongarch/include/asm/cmpxchg.h          |  4 ++--
>   arch/m68k/include/asm/cmpxchg.h               |  6 +++---
>   arch/mips/include/asm/cmpxchg.h               |  4 ++--
>   arch/mips/kernel/uprobes.c                    | 10 ++--------
>   arch/openrisc/include/asm/cmpxchg.h           | 10 +++++-----
>   arch/parisc/include/asm/cmpxchg.h             |  4 ++--
>   arch/powerpc/include/asm/cmpxchg.h            |  4 ++--
>   arch/powerpc/kernel/uprobes.c                 | 10 ++--------
>   arch/riscv/include/asm/atomic.h               |  2 +-
>   arch/riscv/include/asm/cmpxchg.h              |  4 ++--
>   arch/riscv/kernel/probes/uprobes.c            |  9 ++-------
>   arch/s390/include/asm/cmpxchg.h               |  8 ++++----
>   arch/s390/kernel/uprobes.c                    |  7 ++-----
>   arch/sh/include/asm/cmpxchg.h                 |  4 ++--
>   arch/sparc/include/asm/cmpxchg_32.h           |  4 ++--
>   arch/sparc/include/asm/cmpxchg_64.h           |  6 +++---
>   arch/sparc/kernel/uprobes.c                   |  7 ++-----
>   arch/xtensa/include/asm/cmpxchg.h             |  4 ++--
>   drivers/gpu/drm/i915/gt/intel_engine_cs.c     |  2 +-
>   .../gpu/drm/i915/gt/intel_engine_heartbeat.c  |  4 ++--
>   .../drm/i915/gt/intel_execlists_submission.c  |  4 ++--
>   drivers/gpu/drm/i915/gt/intel_ggtt.c          |  4 ++--
>   drivers/gpu/drm/i915/gt/intel_gsc.c           |  2 +-
>   drivers/gpu/drm/i915/gt/intel_gt.c            |  4 ++--
>   drivers/gpu/drm/i915/gt/intel_gt_pm.c         |  2 +-
>   drivers/gpu/drm/i915/gt/intel_lrc.c           |  6 +++---
>   drivers/gpu/drm/i915/gt/intel_migrate.c       |  2 +-
>   drivers/gpu/drm/i915/gt/intel_rc6.c           |  2 +-
>   drivers/gpu/drm/i915/gt/intel_rps.c           |  2 +-
>   drivers/gpu/drm/i915/gt/selftest_context.c    |  2 +-
>   .../drm/i915/gt/selftest_ring_submission.c    |  2 +-
>   drivers/gpu/drm/i915/gt/selftest_timeline.c   |  2 +-
>   drivers/gpu/drm/i915/gt/uc/intel_gsc_uc.c     |  2 +-
>   drivers/gpu/drm/i915/gt/uc/intel_uc.c         |  2 +-
>   drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c      |  2 +-
>   drivers/gpu/drm/i915/i915_utils.h             |  1 +
>   include/linux/llist.h                         |  6 ++----
>   include/linux/non-atomic/xchg.h               | 19 +++++++++++++++++++
>   include/linux/qed/qed_chain.h                 | 19 +++++++------------
>   io_uring/io_uring.c                           |  7 ++-----
>   io_uring/slist.h                              |  6 ++----
>   51 files changed, 126 insertions(+), 155 deletions(-)
>   create mode 100644 include/linux/non-atomic/xchg.h
> 

