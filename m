Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1EC5E6CC9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 22:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiIVUKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 16:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbiIVUKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 16:10:39 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09370F08B3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 13:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663877438; x=1695413438;
  h=from:to:cc:subject:date:message-id;
  bh=KYFeZfcYGYw1x0eEgWiAme8TcBwSot6erIbXz0Zy2JU=;
  b=KcJKDBIsuMz5X/74OsqNP85/mGoF27jVSpm0RMek1jJAH18jogsKiXng
   8Y2JRN8MqqC9XUd7/WTxof8qHBM6Wu/fTZGrjDWOvj0+QBF7V8jflQNsX
   2WAgRJZiBrP+w/o9nSNmSOxzyDSjPhLRnCde06A1FmJ9+7labo6fYKfGG
   8WRSt5snf4OsRxaNmYW617jvacOqBerClNNG6d68jSvs0Vko3dqS1FpPX
   BtiM8o7MIEA+eH6cxaqCKsTke9PDg6w8jEP1neAim037yhtEBvkkzgoXw
   oqPbCOOhPGRPlItXbDAibHIMOaDKx6mtm00cWuPXkgqMtZaPvn8zV6PNC
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="300404289"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="300404289"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 13:10:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="597591996"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga006.jf.intel.com with ESMTP; 22 Sep 2022 13:10:36 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, avagin@gmail.com,
        seanjc@google.com, chang.seok.bae@intel.com
Subject: [PATCH v2 0/4] x86/fpu: Fix MXCSR handling and SSE component definition
Date:   Thu, 22 Sep 2022 13:00:30 -0700
Message-Id: <20220922200034.23759-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Changes from v1:
* patch3: revert the function name change and add a warning. Then update
  the changelog and title.

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
* Then, fixing MXCSR, one of the other call sites is also updated to
  exclude legacy states.
* The hard-coded legacy state offset and size are adjusted in the end.

These patches can be also found in this repository:
  git://github.com/intel/amx-linux.git mxcsr

Thanks,
Chang

[1] v1: https://lore.kernel.org/lkml/20220916201158.8072-1-chang.seok.bae@intel.com/
[2] Commit 43be46e89698 ("x86/fpu: Sanitize xstateregs_set()")
[3] Commit 91c3dba7dbc1 ("x86/fpu/xstate: Fix PTRACE frames for XSAVES")

Chang S. Bae (4):
  x86/fpu: Fix the MXCSR state reshuffling between userspace and kernel
    buffers
  selftests/x86/mxcsr: Test the MXCSR state write via ptrace
  x86/fpu: Disallow legacy states from fpstate_clear_xstate_component()
  x86/fpu: Correct the legacy state offset and size information

 arch/x86/kernel/fpu/xstate.c         | 100 ++++++++++----
 tools/testing/selftests/x86/Makefile |   2 +-
 tools/testing/selftests/x86/mxcsr.c  | 200 +++++++++++++++++++++++++++
 3 files changed, 274 insertions(+), 28 deletions(-)
 create mode 100644 tools/testing/selftests/x86/mxcsr.c


base-commit: 08ed00508bc1fa0a0bc6dd2420f982b55051de23
-- 
2.17.1

