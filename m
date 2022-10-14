Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4A95FF44E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 22:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiJNUJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 16:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiJNUJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 16:09:23 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB3F1D3742
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 13:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665778162; x=1697314162;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=I4+VozkQrlkKojN9mA8awXbzm9vqUsTpiTc6xON/JXg=;
  b=iMxuIXlDHVcHvFook3AKIkVmS3AwYZdTwN4XH47vhqj/GsMu8sqiSR2I
   Rd3LgucMKI2r7ISZjIo6NP+ndB+fIM6aK6o/NHqudwu+31NWfVVZifsOz
   8mHwmitYZYIdy1pFOauDGJ+FtrgzVfTSB+qRN2M+IjEa0DnvpSvi/jNiT
   D1qp44qPHuHOZj5FC1AaLTDjpkJQj7wsW4hPYjPlv39kYceXdE3yYsANc
   ZeycUpHI/dopOLwESYSHcu8cyEA6AFmPQsc4Xmc5bin1Otzr3lYrM/SVE
   pDdQPcgfdqgzfQLjHml0bq+EwKndUS9ATzJYX4dIYBtUXifpg2OCAxwq/
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="304202147"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="304202147"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 13:09:22 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="716870109"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="716870109"
Received: from araj-ucode.jf.intel.com ([10.23.0.19])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 13:09:22 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Arjan van de Ven <arjan.van.de.ven@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>
Subject: [PATCH 00/13] Make microcode loading more robust
Date:   Fri, 14 Oct 2022 13:09:00 -0700
Message-Id: <20221014200913.14644-1-ashok.raj@intel.com>
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

This series adds more robustness to microcode loading.

- Adds proper quiesce to sibling threads in an NMI handler.
- Fixes some nasty early loading bugs that are there for a long time.
- Adds a minimum revision ID to Intel patch meta-data, requested by Thomas.
- Turns microcode late loading back on by default.
- Adds some debugfs support to provide ability to test the microcode flows
  without the need for a new microcode.

This series has too many changes from previous post, but for anecdotal
references. 

https://lore.kernel.org/lkml/20220817051127.3323755-1-ashok.raj@intel.com/

Here is a summary of those patches.

patch1: Allow printing the old and new rev during an early update
patch2: Fix a potential bug during CPU hot-add flow for microcode update.
patch3: Fixes a nasty early loading bug that locks up with endless retries.
patch4: Add a helper to perform self NMI
patch5: Drop siblings in NMI while primary thread updates the microcode.
patch6: Rename refresh_fw to late_loading, in preparation for min-rev patches.
patch7: Move late loading warning to the same function as where taint happens.
patch8: Adds support for microcode meta-data to declare a minimum version 
patch9: Add a generic way to declare support for min-rev across vendors.
patch10: Drop wbinvd(), its not required after patch7.
patch11: Print microcode updated messages only when its successfully loaded
patch12: Issue a warning if MCE arrives while a microcode update is in progress.
patch13: Debug patch: To permit testing repeated loading of microcode.

Ashok Raj (12):
  x86/microcode/intel: Print old and new rev after early microcode
    update
  x86/microcode: Do not load from filesystem for CPU hot add
  x86/microcode/intel: Fix a hang if early loading microcode fails
  x86/microcode: Place siblings in NMI loop while update in progress
  x86/microcode: Rename refresh_fw to late_loading
  x86/microcode: Move late-load warning to earlier where kernel taint
    happens
  x86/microcode/intel: Add minimum required revision to microcode header
  x86/microcode: Add a generic mechanism to declare support for minrev
  x86/microcode/intel: Drop wbinvd() from microcode loading
  x86/microcode: Display revisions only when update is successful
  x86/mce: Warn of a microcode update is in progress when MCE arrives
  x86/microcode/intel: Add ability to update microcode even if rev is
    unchanged

Jacob Pan (1):
  x86/x2apic: Support x2apic self IPI with NMI_VECTOR

 arch/x86/include/asm/microcode.h       |  39 ++++++-
 arch/x86/include/asm/microcode_intel.h |   4 +-
 arch/x86/kernel/apic/x2apic_phys.c     |   6 +-
 arch/x86/kernel/cpu/mce/core.c         |   5 +
 arch/x86/kernel/cpu/microcode/amd.c    |   6 +-
 arch/x86/kernel/cpu/microcode/core.c   | 156 ++++++++++++++++++++++---
 arch/x86/kernel/cpu/microcode/intel.c  |  85 +++++++++-----
 arch/x86/kernel/cpu/microcode/nmi.c    |  72 ++++++++++++
 arch/x86/kernel/nmi.c                  |   7 ++
 arch/x86/Kconfig                       |   7 +-
 arch/x86/kernel/cpu/microcode/Makefile |   1 +
 11 files changed, 332 insertions(+), 56 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/microcode/nmi.c

-- 
2.34.1

