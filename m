Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10DB628A13
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 21:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237418AbiKNUG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 15:06:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235591AbiKNUGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 15:06:24 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E58B43;
        Mon, 14 Nov 2022 12:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668456383; x=1699992383;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Z7vdBH5qB1VYZSaLpKPfeGlUHh3AbGFnYftB56TDl0E=;
  b=BgnAl6/TZXV9GoMsoicNuRT8TE6MW9Vb9UvlZVwntm2EOfOc3no8uqSq
   LWm9/ulBTYMFVnbZcEQowLhtY3LMob5L0QQn7/p+fkjnzB/+ykarK7PCD
   5QyA8K5xalMsTGLvz2ktCzj3zl4rm1YjXvmWu/4kiIaqXFrg27mqRG3CQ
   /c85Oeuvbcew1YCRdPw+uWs4EKLB8OppXVJgT6gPDUd4OnUm0MNAUImLj
   7IrqdP21C4ieYOyYOxhWL0mlpqUBogTy8g7bbxOoUysD7ODuIZzbKNyzB
   bK0J9uC/UaPXIIcYukrTWF1oIN1iiJcqRBZ9/MG3Ciy4DCRALVp6EzF8r
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="310779573"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="310779573"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 12:06:22 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="589508113"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="589508113"
Received: from parandri-mobl.amr.corp.intel.com (HELO guptapa-desk.intel.com) ([10.209.117.50])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 12:06:21 -0800
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>, David.Kaplan@amd.com,
        thomas.lendacky@amd.com, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, hdegoede@redhat.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pavel Machek <pavel@ucw.cz>, Ingo Molnar <mingo@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        antonio.gomez.iglesias@linux.intel.com
Subject: [PATCH v2 0/2] Check enumeration before MSR save/restore
Date:   Mon, 14 Nov 2022 12:06:14 -0800
Message-Id: <cover.1668455932.git.pawan.kumar.gupta@linux.intel.com>
X-Mailer: git-send-email 2.37.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
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
 arch/x86/power/cpu.c               | 23 ++++++++++++++++-------
 3 files changed, 32 insertions(+), 22 deletions(-)

-- 
2.37.3

