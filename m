Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B29662A3C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 16:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237258AbjAIPkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 10:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237248AbjAIPkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 10:40:15 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2303DD11D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 07:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673278573; x=1704814573;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2AmLZWszWuw638YALuGUl0lylDGhgDgq1zoB+1DNQoo=;
  b=I6/RQ+rpD0A2AoCTYmTQA81TJ72+nbiTlTSNC1sjNf0p/zYrWXc9iVg/
   rKZosS+ccHNPkbHA/EruK11/3xIqnvLwQ5bHc1Hxx3sCnUNauUc/8LNKu
   4dQ+dGJAY0vs4+k7GL+TliTKh4PwZdLYFvu1lfsZMQSoU5ObdLakvdIji
   M66w46OxAgRGlGmS2fJNCcPY8SZJwMDt4L+I9c9poLLNJbWtMJdUtKTYI
   kiAjSljRVc3Zee9uTbZ7mdIWhG7b2R1yC9vqGwNcLGiPQUKP9XyIl0lSd
   16WIAEmq2b65P1qv9NowGHD9iruWZ/gyLRFF6kwJLsMExGwUVlmg/CEsp
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="385203545"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="385203545"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 07:36:11 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="902023875"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="902023875"
Received: from araj-ucode.jf.intel.com ([10.23.0.19])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 07:36:10 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ingo Molnar <mingo@kernel.org>, alison.schofield@intel.com,
        reinette.chatre@intel.com
Subject: [PATCH v4 0/6] Some fixes and cleanups for microcode
Date:   Mon,  9 Jan 2023 07:35:49 -0800
Message-Id: <20230109153555.4986-1-ashok.raj@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

Here is a followup after v3[1] with all comments addressed.

Please review and apply.

Changes since v3:

Tony, Ingo
	- Display clear message when microcode load fails.

Boris
	- Changed function names microcode_store_cpu_caps() ->
	  store_cpu_caps().
	- Fix commit logs 
	- Document new parameter to microcode_check()

Dave Hansen
	- Fix commit log
	- Change parameter names from generic to something that's
	  meaningful.

[1] https://lore.kernel.org/lkml/20230103180212.333496-1-ashok.raj@intel.com/

Ashok Raj (6):
  x86/microcode: Add a parameter to microcode_check() to store CPU
    capabilities
  x86/microcode/core: Take a snapshot before and after applying
    microcode
  x86/microcode: Display revisions only when update is successful
  x86/microcode/intel: Use a plain revision argument for
    print_ucode_rev()
  x86/microcode/intel: Print old and new rev during early boot
  x86/microcode/intel: Print when early microcode loading fails

 arch/x86/include/asm/processor.h      |  3 +-
 arch/x86/kernel/cpu/common.c          | 48 ++++++++++++++++++-------
 arch/x86/kernel/cpu/microcode/core.c  | 20 ++++++++---
 arch/x86/kernel/cpu/microcode/intel.c | 52 +++++++++++++--------------
 4 files changed, 77 insertions(+), 46 deletions(-)


base-commit: b7bfaa761d760e72a969d116517eaa12e404c262
prerequisite-patch-id: 450e9658e9f802a2f3f784ba18267bc47ee878b8
-- 
2.34.1

