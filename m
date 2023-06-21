Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5C573839D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjFUMWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 08:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjFUMW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 08:22:28 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A522DD
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 05:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687350148; x=1718886148;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jqCndGsSPtaYvXZe06Pf0hU1p+Ie8D2n6eM3RkuyW6c=;
  b=N9CzdB72LEZppdYtoXknv0jBTpeN3HQqfmojD2jyH2E0LpS2v5Z+fNAJ
   jX7jX1OUpUpwC8Enmd3oi/jkXk4XMB6WMVR1d3kNzBJvYx9dNeaWR3IWG
   74WmjW85BEBPJNZKOSl0nEGoJubQdpO1tomn8vChcRQkkyNPK7hPFDUM1
   Ix7XIyedDmwNf4HwjeN0QqXCWSw7JoNrVEmtnWwzJSAXPphipKPWQZEek
   KAahUDoGMgdeaM6GvFAKz50+aEpZnqhfnDUQViflLj6JA02n6+/mBBqkq
   cq2PpKJJoE72vvAX0FVZbKG/BfYMJNBen7f7b4RZRttbNpGqM+SbS7iEN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="360165676"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="360165676"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 05:22:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="888638340"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="888638340"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga005.jf.intel.com with ESMTP; 21 Jun 2023 05:22:26 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        andrew.cooper3@citrix.com, chang.seok.bae@intel.com
Subject: [PATCH v1 0/4] x86/fpu: a few code cleanup
Date:   Wed, 21 Jun 2023 05:09:38 -0700
Message-Id: <20230621120942.121822-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series intends to clean up the x86 FPU code. They do *not* deal
with any urgent issues but considerably apparent cleanups:

- Simplify xstate_calculate_size() and print_xstate_features() as both
  have some inefficient duplications.
- Convert get_xsave_addr() to a local function because it is not
  invoked anywhere else.
- Clean up the unnecessary fpstate_reset() since the invocation makes
  no change in the fpstate container.

The last one might have an unknown reason behind it. Then, I will
revise it with the clarification instead of removing the code.

The series can be found in this repo:
	git://github.com/intel/amx-linux.git x86-fpu-cleanup

Thanks,
Chang

Chang S. Bae (4):
  x86/fpu/xstate: Convert get_xsave_addr() to a static function
  x86/fpu/xstate: Simplify xstate_calculate_size()
  x86/fpu/xstate: Simplify print_xstate_features()
  x86/fpu: Remove the unnecessary fpstate_reset() invocation

 arch/x86/kernel/fpu/init.c   |  1 -
 arch/x86/kernel/fpu/xstate.c | 36 +++++++++++-------------------------
 arch/x86/kernel/fpu/xstate.h |  2 --
 3 files changed, 11 insertions(+), 28 deletions(-)


base-commit: 162d2c2297b731a9918bd26db5a9f779de259c09
-- 
2.34.1

