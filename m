Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C1462A1BB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 20:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiKOTRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 14:17:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKOTRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 14:17:15 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E38C12083;
        Tue, 15 Nov 2022 11:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668539835; x=1700075835;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FToTQPyRjIxLXdNXVm0cHUyM2kP3nOSLSd0/1P/9+G8=;
  b=X3JWrru5SLdBG2ZPJCg8WIaHyRMaJ35pSwQrRw4DX4Qno5pBAfBG5aJu
   oR2qZGUViasa+GqegxBAI5/7xz4yha6vWz8X2v9tTnDPl6ktV3kNdBmGI
   8blFyM3OCqh3Wn1x+BjdZafas2RT1zMWNTnvvMZYG6rR4oeOa0fXZkL94
   jnHZpR18zG1hkq1WBQ3aLdVc1eB4PE/oxTATMl8A14Ys6aPWOtbn2LYWG
   v8YEBSRRcj7SGVeaIAfmCyAwl4NNVoVu7fqzxRsKIQToIj6Yhzb05ZBLT
   XVpwcfXXi1Qt5+5TgtC6NNIRhbiQuX9NqbonB3/QLMnAhLz+MatjtPMF/
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="312349970"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="312349970"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 11:17:14 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="616872696"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="616872696"
Received: from slmckinn-mobl.amr.corp.intel.com (HELO guptapa-desk.intel.com) ([10.255.231.2])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 11:17:14 -0800
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Andrew Cooper <Andrew.Cooper3@citrix.com>, thomas.lendacky@amd.com,
        "H. Peter Anvin" <hpa@zytor.com>, hdegoede@redhat.com,
        Ingo Molnar <mingo@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Pavel Machek <pavel@ucw.cz>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David.Kaplan@amd.com, Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        antonio.gomez.iglesias@linux.intel.com
Subject: [PATCH v3 0/2] Check enumeration before MSR save/restore
Date:   Tue, 15 Nov 2022 11:17:04 -0800
Message-Id: <cover.1668539735.git.pawan.kumar.gupta@linux.intel.com>
X-Mailer: git-send-email 2.37.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3:
- Rebased to latest upstream.
- Made MSR_AMD64_DE_CFG restore depend on X86_FEATURE_LFENCE_RDTSC.

v2: https://lore.kernel.org/lkml/cover.1668455932.git.pawan.kumar.gupta@linux.intel.com/
- Dropped patch for X86_FEATURE_AMD64_LS_CFG, using X86_FEATURE_AMD64_LS_CFG_SSBD instead.
- Commit message updated.

v1: https://lore.kernel.org/lkml/cover.1663025154.git.pawan.kumar.gupta@linux.intel.com/

Hi,

This patchset is to fix the "unchecked MSR access error" [1] during S3
resume. Patch 1/3 adds a feature bit for MSR_IA32_TSX_CTRL.

Patch 2/3 adds a feature bit for MSR_AMD64_LS_CFG.

Patch 3/3 adds check for feature bit before adding any speculation
control MSR to the list of MSRs to save/restore.

[1] https://lore.kernel.org/lkml/20220906201743.436091-1-hdegoede@redhat.com/

Thanks,
Pawan

Pawan Gupta (2):
  x86/tsx: Add feature bit for TSX control MSR support
  x86/pm: Add enumeration check before spec MSRs save/restore setup

 arch/x86/include/asm/cpufeatures.h |  1 +
 arch/x86/kernel/cpu/tsx.c          | 30 +++++++++++++++---------------
 arch/x86/power/cpu.c               | 25 +++++++++++++++++--------
 3 files changed, 33 insertions(+), 23 deletions(-)

-- 
2.37.3

