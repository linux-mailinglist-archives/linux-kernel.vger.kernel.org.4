Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8275B643E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 01:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiILXit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 19:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiILXiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 19:38:46 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43E31D33C;
        Mon, 12 Sep 2022 16:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663025925; x=1694561925;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ULMC7Di4B1xKaASEhwiU8VwSJyMqxghMLy2T9gnp3pQ=;
  b=U+5lvmdLRS797D1513coUVvJJ1kcAiW8Ap1tMWl6qFWVdz9JndaunWqT
   V2zu0OjS52+3geebK4PPzSUUd77oPgSxK3XjpTtwht2JGc13TuypXOjob
   1ZpCqHFnr9UBfkuWa1Z90N0QCynoP0ozoDCpF3NjJlHzv+y6BrNb4gDWf
   CLeKPg5xj42FhBpdl26SDiW+hN64R1H2JDwsy1vOQfhG+m3u5KVFVjIfV
   7F2K1GJdcS8mS7VutV8+HTl0qULmv/NDsCkVV/YclmjtG/Ge5Foo7zm0N
   +1cMGF3sy3NSpnMs8cW3y27C+9PoczxedxHDsGxljTkCe5bhTMy74vjik
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="384291176"
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="384291176"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 16:38:45 -0700
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="758575373"
Received: from sho10-mobl1.amr.corp.intel.com (HELO desk) ([10.251.9.78])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 16:38:44 -0700
Date:   Mon, 12 Sep 2022 16:38:44 -0700
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>, degoede@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        antonio.gomez.iglesias@linux.intel.com
Subject: [PATCH 0/3] Check enumeration before MSR save/restore
Message-ID: <cover.1663025154.git.pawan.kumar.gupta@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.3 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset is to fix the "unchecked MSR access error" [1] during S3
resume. Patch 1/3 adds a feature bit for MSR_IA32_TSX_CTRL.

Patch 2/3 adds a feature bit for MSR_AMD64_LS_CFG.

Patch 3/3 adds check for feature bit before adding any speculation
control MSR to the list of MSRs to save/restore.

[1] https://lore.kernel.org/lkml/20220906201743.436091-1-hdegoede@redhat.com/

Pawan Gupta (3):
  x86/tsx: Add feature bit for TSX control MSR support
  x86/cpu/amd: Add feature bit for MSR_AMD64_LS_CFG enumeration
  x86/pm: Add enumeration check before spec MSRs save/restore setup

 arch/x86/include/asm/cpufeatures.h |  2 ++
 arch/x86/kernel/cpu/amd.c          |  3 +++
 arch/x86/kernel/cpu/tsx.c          | 30 +++++++++++++++---------------
 arch/x86/power/cpu.c               | 23 ++++++++++++++++-------
 4 files changed, 36 insertions(+), 22 deletions(-)


base-commit: 80e78fcce86de0288793a0ef0f6acf37656ee4cf
-- 
2.37.2


