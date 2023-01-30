Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBB0681CF5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 22:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbjA3VkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 16:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbjA3VkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 16:40:15 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09D11BDD
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 13:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675114814; x=1706650814;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=po+hm6syr+s5qGUoV/Tr6ngou/rZmwoyEYw4cRv2gog=;
  b=f4VMYbalw4yCh+QGTAgtRH4+GPZQXJUyAe+g+YDc5dbGDxRLymiOZ+Ox
   axu7SWgvLz4/VJ2SAvuBRSZtp+Yw+Kks1lLIgnwYnUn7Izw+1I86TI2Qo
   2NTZHq9XvxrumvNq6JRx4h1zuM86D8WcV+E0i1pU56XmH5R41nqpeuZAP
   Z2SGreJdpcKzZgy0WaSK9w/ZzM6ZRtZIiTcV/ZVxAcglv/hhNNy3+TBnH
   PYbv/3nCuIozUKudmgTtkMWYQO/5FqKDAD04lYMF/vX9xhAylbI9kM6RZ
   4pVtsdNCLR5iYlQulx6R17s3FearJXuRKvmEYVQdBLqWjua8wqvV5JuJt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="328955467"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="328955467"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 13:40:12 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="696571853"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="696571853"
Received: from araj-ucode.jf.intel.com ([10.23.0.19])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 13:40:12 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Stefan Talpalaru <stefantalpalaru@yahoo.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Peter Zilstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Martin Pohlack <mpohlack@amazon.de>
Subject: [Patch v3 Part2 0/9] x86/microcode: Declare microcode safe for late loading
Date:   Mon, 30 Jan 2023 13:39:46 -0800
Message-Id: <20230130213955.6046-1-ashok.raj@intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

Here is v3 of part2. v1 Part2 is here[1]
These address feedback from Thomas here [2] posted as "Part2 v2[cleanup]"

Thanks Thomas for the feedback, and Tony for fixes to my commit logs adding
more clarity!

This series  should apply on top of tip/x86/microcode.

Please help with review and apply.

Patch 1-4:
	Cleanup patches that were in response to comments from
	Thomas[2].

Patch 5: Preparatory patch to keep warning and taint in same function.
Patch 6: Add minimum revision ID for Intel microcode
Patch 7: Add a generic mechanism to declare safe late loading.
Patch 8: Drop the unneeded wbinvd() after the minimum rev update
Patch 9: Optional - Allows testing with override minrev.

Tests Done:

1. For values other than 1 to reload file, will not report an error.
   For e.g. 

   echo 2 > reload
   bash: echo: write error: Invalid argument

2. In cases where there is no file OR no new update found, echo 1 will not
   report an error

   echo 1 > reload

3. When trying to load a file with minrev=0, there will be a log in dmesg
   and will also return -EINVAL in response to the write to "reload".

[105682.501898] microcode: Late loading denied: Microcode header does not specify a required min version

root@araj-ucode:/sys/devices/system/cpu/microcode# cat /proc/sys/kernel/tainted
0

4. Offline a primary CPU and attempt to load, must not taint the kernel.

# echo 0 > cpu2/online

[  378.725868] smpboot: CPU 2 is now offline

#echo 1 > /sys/devices/system/cpu/microcode/reload

[  388.024968] microcode: Not all CPUs online, aborting microcode update.

#cat /proc/sys/kernel/tainted
0
# echo 1 cpu2/online

[  398.664452] smpboot: Booting Node 0 Processor 2 APIC 0x4

5. When using the optional patch 9 to override minrev, kernel will be
   tainted.

root@araj-ucode:/sys/devices/system/cpu/microcode# cat /proc/sys/kernel/tainted
0
   echo Y > /sys/kernel/debug/microcode/override_minrev
   echo 1 > /sys/devices/system/cpu/microcode/reload

[  491.489986] microcode: Bypassing minrev enforcement via debugfs
[  491.649550] microcode: updated to revision 0x2b000070, date = 2022-08-22
[  493.595267] microcode: Reload succeeded, microcode revision: 0x2b000041 -> 0x2b000070
[  493.595360] microcode: Microcode late loading tainted the kernel

root@araj-ucode:/sys/devices/system/cpu/microcode# cat /proc/sys/kernel/tainted
4

[1] https://lore.kernel.org/lkml/20230113172920.113612-1-ashok.raj@intel.com/
[2] https://lore.kernel.org/lkml/87y1pygiyf.ffs@tglx/

Cheers,
Ashok

Ashok Raj (9):
  x86/microcode: Taint kernel only if microcode loading was successful
  x86/microcode: Report invalid writes to reload sysfs file
  x86/microcode/intel: Fix collect_cpu_info() to reflect current
    microcode
  x86/microcode: Do not call apply_microcode() on sibling threads
  x86/microcode: Move late load warning to the same function that taints
    kernel
  x86/microcode/intel: Add minimum required revision to microcode header
  x86/microcode: Add a generic mechanism to declare support for minrev
  x86/microcode/intel: Drop wbinvd() from microcode loading
  x86/microcode: Provide an option to override minrev enforcement

 arch/x86/include/asm/microcode.h       |  4 ++
 arch/x86/include/asm/microcode_intel.h |  3 +-
 arch/x86/kernel/cpu/microcode/core.c   | 71 +++++++++++++++++++-------
 arch/x86/kernel/cpu/microcode/intel.c  | 71 +++++++++++++++++++++-----
 arch/x86/Kconfig                       |  7 +--
 5 files changed, 119 insertions(+), 37 deletions(-)


base-commit: a9a5cac225b0830d1879640e25231a37e537f0da
-- 
2.37.2

Cc: LKML <linux-kernel@vger.kernel.org>
Cc: x86 <x86@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Thomas Gleixner (Intel) <tglx@linutronix.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Stefan Talpalaru <stefantalpalaru@yahoo.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Peter Zilstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Andrew Cooper <Andrew.Cooper3@citrix.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Martin Pohlack <mpohlack@amazon.de>
