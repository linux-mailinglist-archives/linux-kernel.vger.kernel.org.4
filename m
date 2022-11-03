Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BCB6186CD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 19:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbiKCSAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 14:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbiKCR71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:59:27 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2679272A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 10:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667498358; x=1699034358;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NQ4E60fCi8s4w3s9Y4QOIThnoOsfGkUiX9/Gqm0HWwI=;
  b=gwcQa7BeIlBl2XD27PYwtOdEdIl1Ccq/In7CzvGDOtkE48vtJDG4o+xn
   ZJCQGLVd+Q2vUklJVKfhDxXnRx6kTi7qL+2D2T3TwkPDIdUA3ZjYl31aI
   sS4x+ZTtLL4FjD8hlPr7YPSpEQ9NJrifRS/LZck2dP8OT29aPNW56TGHc
   T0pAhEQ6VEkRr8bGw5j2TfuySrNjpxTAI++Nv5xoje8s8V2lp1WHpbh+8
   lkpvaLN48juwsjWYH9XIB2TAs1yXE7flolWwy7JwqH/4Ni85LXnZASNI2
   1RwQ+W9x+ppJEqGqQre40nr15zVjsHPkmVYAHfYs71i+0BUNCUAWFBJIj
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="308476961"
X-IronPort-AV: E=Sophos;i="5.96,134,1665471600"; 
   d="scan'208";a="308476961"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 10:59:18 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="809762537"
X-IronPort-AV: E=Sophos;i="5.96,134,1665471600"; 
   d="scan'208";a="809762537"
Received: from araj-dh-work.jf.intel.com ([10.165.157.158])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 10:59:17 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     "LKML Mailing List" <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Arjan van de Ven <arjan.van.de.ven@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jacon Jun Pan <jacob.jun.pan@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: [v2 00/13] Make microcode late loading more robust
Date:   Thu,  3 Nov 2022 17:58:48 +0000
Message-Id: <20221103175901.164783-1-ashok.raj@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas & Boris

This series is based on the recent cleanup series from Boris, here below:

https://lore.kernel.org/lkml/20221028142638.28498-1-bp@alien8.de/

Previous post here:

https://lore.kernel.org/lkml/20221014200913.14644-1-ashok.raj@intel.com/

Ashok Raj (12):
  x86/microcode/intel: Prevent printing updated microcode rev multiple
    times
  x86/microcode/intel: Print old and new rev after early microcode
    update
  x86/microcode/intel: Fix a hang if early loading microcode fails
  x86/microcode: Fix microcode_check() compare after a new uCode update
  x86/microcode: Move late-load warning to earlier where kernel taint
    happens
  x86/microcode: Place siblings in NMI loop while update in progress
  x86/mce: Warn of a microcode update is in progress when MCE arrives
  x86/microcode/intel: Add minimum required revision to microcode header
  x86/microcode: Add a generic mechanism to declare support for minrev
  x86/microcode/intel: Drop wbinvd() from microcode loading
  x86/microcode: Display revisions only when update is successful
  x86/microcode/intel: Add ability to update microcode even if rev is
    unchanged

Jacob Pan (1):
  x86/ipi: Support sending NMI_VECTOR as self ipi

 arch/x86/include/asm/microcode.h       |  43 ++++++
 arch/x86/include/asm/microcode_intel.h |   4 +-
 arch/x86/include/asm/processor.h       |   1 -
 arch/x86/kernel/apic/ipi.c             |   6 +-
 arch/x86/kernel/apic/x2apic_phys.c     |   6 +-
 arch/x86/kernel/cpu/common.c           |  32 ----
 arch/x86/kernel/cpu/mce/core.c         |   5 +
 arch/x86/kernel/cpu/microcode/amd.c    |   2 +-
 arch/x86/kernel/cpu/microcode/core.c   | 200 +++++++++++++++++++++++--
 arch/x86/kernel/cpu/microcode/intel.c  |  96 ++++++++----
 arch/x86/kernel/cpu/microcode/nmi.c    |  71 +++++++++
 arch/x86/kernel/nmi.c                  |   7 +
 arch/x86/kernel/nmi_selftest.c         |  32 ++++
 arch/x86/Kconfig                       |   7 +-
 arch/x86/kernel/cpu/microcode/Makefile |   1 +
 15 files changed, 427 insertions(+), 86 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/microcode/nmi.c

-- 
2.34.1

