Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEDAE65C599
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 19:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238560AbjACSC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 13:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjACSC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 13:02:26 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48430DF4A
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 10:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672768943; x=1704304943;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QaR9m9x2RnpfBuN63lFNnMNIhM7svadcT57mK4Erhv8=;
  b=H/vCu0QBZTGQehVRvjI1pslw6iegFmRJHCDJxDUmCfr/70Z5FerpSNs2
   bkBt/KI6Yw3a4J4YA93aSPvhyMF2s62nKI86gXQF+DURkDj6bU5erh6TI
   qUOR39fImMMHa5OLsJxnNTj6NgxkyAv2XoEgqziCQpWV5cvGOUuXpiqgW
   r+CuUw8Ysxxk6Mk0g0QM9b+dO4ENfrSAlXOKCEDUiz+RacQmaMZh1Idon
   Rh/g7oMNkYdDHAiUGYgkSeVb9iml0v6Io7lfLGBRHKsozIdNhPAe0JVj9
   Y0k8QQfZysRMxY0L+1RYDJahlPJXFzB1qaeBWbg1DIXoR5zQImJQTR2Lp
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="384010630"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="384010630"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 10:02:22 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="654876876"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="654876876"
Received: from araj-ucode.jf.intel.com ([10.23.0.19])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 10:02:24 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH v3 0/6] Some fixes and cleanups for microcode
Date:   Tue,  3 Jan 2023 10:02:06 -0800
Message-Id: <20230103180212.333496-1-ashok.raj@intel.com>
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

Hi Boris

This is a followup after earlier post [1]

Sending the rest of the patches after first 2 patches that were merged.

Please review and consider applying.

Changes since v1:

- Updated comments and added reviewed by from Thomas.
- Moved microcode_check() to where it originally was based on your
  feedback. [2]

[1] https://lore.kernel.org/lkml/20221227192340.8358-1-ashok.raj@intel.com/
[2] https://lore.kernel.org/lkml/Y6tMgcU2aGbx%2F6yt@zn.tnic/

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
 arch/x86/kernel/cpu/common.c          | 29 ++++++++++-----
 arch/x86/kernel/cpu/microcode/core.c  | 17 ++++++---
 arch/x86/kernel/cpu/microcode/intel.c | 52 +++++++++++++--------------
 4 files changed, 60 insertions(+), 41 deletions(-)


base-commit: 88603b6dc419445847923fcb7fe5080067a30f98
-- 
2.34.1

