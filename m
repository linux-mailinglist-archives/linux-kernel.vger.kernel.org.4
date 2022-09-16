Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5801B5BB369
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 22:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiIPUWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 16:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiIPUV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 16:21:58 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F03A99F2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 13:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663359717; x=1694895717;
  h=from:to:cc:subject:date:message-id;
  bh=TFzU5cNGC3kT0081tbIPcYTZ977rZ6o1QozBEG50zJE=;
  b=LTSAuTxHEri1AOdI517eIlwSrI68tAYLCUXszVLFc5gXydbFRi49hHWf
   rqGaljhcXge/gHfjycdILv6hZiTVX3b6XqUoaZkAifwhbDNSPtTCzY/XR
   s3LtE9jw+pS4GCTfix7Xl8GBO/gCwJf9NSEfB09zFHHvnJT2cf4XfBo5T
   ECI25QqkIz5jPvEOSSkbRqRIbtG6CCEYP4FRRitX286D7Q0NEKY97IFi8
   pBCln1bVEMSJNQ7sPuqhUZpn9kb0MS1ZpdU0v4bABdxeM7AjDwErOOfwN
   h1EAXjwkM1uu67raYihjWlB/O2KkIa3XHsf7GrH466P+LSmnKhfokh0OF
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="278801379"
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="278801379"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 13:21:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="680092285"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by fmsmga008.fm.intel.com with ESMTP; 16 Sep 2022 13:21:57 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, avagin@gmail.com,
        chang.seok.bae@intel.com
Subject: [PATCH 0/4] x86/fpu: Fix MXCSR handling and SSE component definition
Date:   Fri, 16 Sep 2022 13:11:54 -0700
Message-Id: <20220916201158.8072-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.4 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Andrei's report [1] triggered reviewing the MXCSR-related code. My
responded change [2] has been revised along with some additional fixes in
this series.

While Dave Hansen alluded another version [3] for the fix, as I couldn't
locate it so far, sending patches as one of proposals in this regard.

== Regression ==

Recently the XSTATE copy functions were unitized together [4]. At a glance,
this change appears to relapse the ptrace write on the MXCSR state when
the non-compacted format is used in the kernel.

But, this regression appears to root in the XSAVES-enabling code [5] that
introduced the XSTATE conversion along with the MXCSR mistreatment.

== MXCSR Hindsight ==

MXCSR is architecturally part of the SSE component. The MXCSR association
of XSTATE_BV depends on the XSAVE format.

The change [5], however, presumed MXCSR as part of the X87 component and
made the kernel referencing XSTATE_BV regardless of the format.

== Patches ==

* Fix the MXCSR conversion code along with adding the test case.
* Then, fixing MXCSR, one of the other call sites is also updated to
  exclude legacy states.
* The hard-coded legacy state offset and size are adjusted in the end.

These patches can be also found in this repository:
  git://github.com/intel/amx-linux.git mxcsr

Thanks,
Chang

[1] https://lore.kernel.org/lkml/CANaxB-wkcNKWjyNGFuMn6f6H2DQSGwwQjUgg1eATdUgmM-Kg+A@mail.gmail.com/
[2] https://lore.kernel.org/lkml/37ba2de3-26b3-12eb-6a9d-c0f0572b832c@intel.com/
[3] https://lore.kernel.org/lkml/1660cdf4-96c1-b6bb-a3be-d02c7a3affb9@intel.com/
[4] Commit 43be46e89698 ("x86/fpu: Sanitize xstateregs_set()")
[5] Commit 91c3dba7dbc1 ("x86/fpu/xstate: Fix PTRACE frames for XSAVES")

Chang S. Bae (4):
  x86/fpu: Fix the MXCSR state reshuffling between userspace and kernel
    buffers
  selftests/x86/mxcsr: Test the MXCSR state write via ptrace
  x86/fpu: Clarify the XSTATE clearing only for extended components
  x86/fpu: Correct the legacy state offset and size information

 arch/x86/include/asm/fpu/api.h       |   2 +-
 arch/x86/kernel/fpu/xstate.c         |  98 +++++++++----
 arch/x86/kvm/x86.c                   |   4 +-
 tools/testing/selftests/x86/Makefile |   2 +-
 tools/testing/selftests/x86/mxcsr.c  | 200 +++++++++++++++++++++++++++
 5 files changed, 273 insertions(+), 33 deletions(-)
 create mode 100644 tools/testing/selftests/x86/mxcsr.c


base-commit: 82eedfedea446ae448f0975f1db7d1631cd24330
-- 
2.17.1

