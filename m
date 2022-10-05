Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C8E5F5C58
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 00:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiJEWEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 18:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJEWEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 18:04:09 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582783DBD8
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 15:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665007448; x=1696543448;
  h=from:to:cc:subject:date:message-id;
  bh=IXaUDq1PlLmeeP8m+rBRGDksc3nmzhXkP2oohAgQqvk=;
  b=WbAitGtrNEgohQgzmciqryD8gPHYwJHMS11ztjyYroeMfCJVolDZS5e8
   UpoAHtkfD3hhMWwp5AgydODFDzrtLGUPrDg3qa+5AbquNsyTup9V2H/PM
   TUnHzrNtZ+8nNGtFBF1JzsgZjz6GYcy4wOLDP6uGVQ/oIPe+X1TE6M0Fv
   XYoDdp9j0mk21RW0itDkqx9d8vWXr61iJh7egI070p300mg7aueWenO2R
   SXTYyD8HnCood9T99JchpKv3bZLXnLZ1nSpqv5VgPY4KdWJCVCFfbASPr
   WXVjmOlBmH+xTqHAsCjRfeB2pgCN8iBrCdGDWRAj6RlKVjny4XHWVlmDl
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="365218806"
X-IronPort-AV: E=Sophos;i="5.95,162,1661842800"; 
   d="scan'208";a="365218806"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 15:04:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="602193018"
X-IronPort-AV: E=Sophos;i="5.95,162,1661842800"; 
   d="scan'208";a="602193018"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga006.jf.intel.com with ESMTP; 05 Oct 2022 15:04:07 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, avagin@gmail.com,
        seanjc@google.com, chang.seok.bae@intel.com
Subject: [PATCH v3 0/3] x86/fpu: Fix MXCSR handling and SSE component definition
Date:   Wed,  5 Oct 2022 14:53:54 -0700
Message-Id: <20221005215357.1808-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.4 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Changes from v2 [1]:
* Drop the changes in fpstate_clear_xstate_component().
* Massage the WARNING and the comment in xfeature_get_offset().

If the former function is called for any legacy state, the WARNING is
eventually emitted by the latter function in this call chain:
  fpstate_clear_xstate_component()
    -> get_xsave_addr()
      -> __raw_xsave_addr()
        -> xfeature_get_offset()
So, the change in the outer function (the old patch3) was considered as not
necessary.

Thanks Sean Christopherson for the feedback.

== Regression ==

Recently the XSTATE copy functions were unitized together [2]. At a glance,
this change appears to relapse the ptrace write on the MXCSR state when
the non-compacted format is used in the kernel.

But, this regression appears to root in the XSAVES-enabling code [3] that
introduced the XSTATE conversion along with the MXCSR mistreatment.

== MXCSR Hindsight ==

MXCSR is architecturally part of the SSE component. The MXCSR association
of XSTATE_BV depends on the XSAVE format.

The change [3], however, presumed MXCSR as part of the X87 component and
made the kernel referencing XSTATE_BV regardless of the format.

== Patches ==

* Fix the MXCSR conversion code along with adding the test case.
* The hard-coded legacy state offset and size are adjusted in the end. And
  add a WARN when they are referenced.

These patches can be also found in this repository:
  git://github.com/intel/amx-linux.git mxcsr

Thanks,
Chang

[1] v2: https://lore.kernel.org/lkml/20220922200034.23759-1-chang.seok.bae@intel.com/
[2] Commit 43be46e89698 ("x86/fpu: Sanitize xstateregs_set()")
[3] Commit 91c3dba7dbc1 ("x86/fpu/xstate: Fix PTRACE frames for XSAVES")

Chang S. Bae (3):
  x86/fpu: Fix the MXCSR state reshuffling between userspace and kernel
    buffers
  selftests/x86/mxcsr: Test the MXCSR state write via ptrace
  x86/fpu: Correct the legacy state offset and size information

 arch/x86/kernel/fpu/xstate.c         |  89 ++++++++----
 tools/testing/selftests/x86/Makefile |   2 +-
 tools/testing/selftests/x86/mxcsr.c  | 200 +++++++++++++++++++++++++++
 3 files changed, 262 insertions(+), 29 deletions(-)
 create mode 100644 tools/testing/selftests/x86/mxcsr.c


base-commit: 03c739a21613a1a85f730dd972ff928e573f7235
-- 
2.17.1

