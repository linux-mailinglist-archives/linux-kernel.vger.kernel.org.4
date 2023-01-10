Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC876638ED
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 06:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjAJF5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 00:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjAJF4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 00:56:05 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2639D3FC83
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 21:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673330139; x=1704866139;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DgV1AXfsERPzBUNSWsN/EI6A0q7Rm64Lv3PZr/gyKts=;
  b=Z/CvEcCdhxuees7dhQphJZPv29Yyv7heb/P36vHQPYp4Iv4Ng3KcgMAT
   5VcibQqRkKhgoFwNbdLedOppd8rh4jbRgbm14Dn07u5blufHLCswOP3Ov
   4K2qJG7nFGYPYvn1/gkfLkLU8Skgd2XtdUSr45AM1D7uTLqM1o8XG5I1h
   w/ht3B+vOi2ajCPAOi2HxDFKYPSLx/cvd+aR20bXgUfSQL1vnGT/o+e0I
   OmdtU3us4to8sbMa+7xdLHeUbVYOin00yrNx3T0yXE8/T77uq5cYvRurR
   SWZFGrLf9V8Iemfyg+o4ezzxPwbGhfwyv6LrQVAAJg3JTX82QUGU3/zcz
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="350289952"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="350289952"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 21:55:38 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="634483730"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="634483730"
Received: from oux.sc.intel.com ([10.3.52.57])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 21:55:38 -0800
From:   Yian Chen <yian.chen@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Paul Lai <paul.c.lai@intel.com>,
        Yian Chen <yian.chen@intel.com>
Subject: [PATCH 0/7]  Enable LASS (Linear Address space Separation)
Date:   Mon,  9 Jan 2023 21:51:57 -0800
Message-Id: <20230110055204.3227669-1-yian.chen@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

LASS (Linear Address Space Separation) is a security
extension that prevents speculative address accesses across 
user/kernel mode. The LASS details have been published in
Chapter 11 in 
https://cdrdv2.intel.com/v1/dl/getContent/671368

LASS works in 64-bit mode only and partitions the 64-bit
virtual address space into two halves:
    1. Lower half (LA[63]=0) --> user space
    2. Upper half (LA[63]=1) --> kernel space
When LASS is enabled, a general protection #GP(0) fault will
be generated if software accesses the address from the half in
which it resides to another half, e.g., either from user space
to upper half, or from kernel space to lower half. This
protection applies to data access, code execution, cache line
flushing instructions.

Almost all kernel accesses are to the upper half of the virtual
address space. However, there are valid reasons for kernel to
access the lower half. For these cases,  kernel can temporarily
suspend the enforcement of LASS by disabling SMAP (Supervisor
Mode Access Prevention).

Kernel access to copy data to/from user addresses already
disables SMAP using the stac()/clac() functions. New functions
low_addr_access_begin()/low_addr_access_end() are added to
also disable/enable SMAP around other code that legitimately
needs to access the lower half of the virtual address space.

User space cannot use any kernel address while LASS is
enabled. Less fortunately, legacy vsyscall functions used
by old version of glibc are located in the address range
0xffffffffff600000-0xffffffffff601000 and emulated in kernel.
Therefore, to comply with LASS policy, the legacy vsyscall is
disabled by default. I am looking for input from Andy and
others if this approach is acceptable.

This patch set by default enforces LASS when the platform
supports it. It can be disabled via the command line parameter
"clearcpuid" or by setting "vsyscall=emulate/xonly".

As of now there is no publicly available CPU supporting LASS.
The first one to support LASS is Sierra Forest line. The Intel
Simics® Simulator was used as software development and testing
vehicle for this patch set.

Paul Lai (1):
  x86/kvm: Expose LASS feature to VM guest

Yian Chen (6):
  x86/cpu: Enumerate LASS CPUID and CR4 bits
  x86: Add CONFIG option X86_LASS
  x86/cpu: Disable kernel LASS when patching kernel alternatives
  x86/vsyscall: Setup vsyscall to compromise LASS protection
  x86/cpu: Enable LASS (Linear Address Space Separation)
  x86/cpu: Set LASS as pinning sensitive CR4 bit

 .../admin-guide/kernel-parameters.txt         | 12 +++++++----
 arch/x86/Kconfig                              | 10 +++++++++
 arch/x86/entry/vsyscall/vsyscall_64.c         | 14 +++++++++++++
 arch/x86/include/asm/cpufeatures.h            |  1 +
 arch/x86/include/asm/disabled-features.h      |  8 ++++++-
 arch/x86/include/asm/kvm_host.h               |  3 ++-
 arch/x86/include/asm/smap.h                   | 13 ++++++++++++
 arch/x86/include/uapi/asm/processor-flags.h   |  2 ++
 arch/x86/kernel/Makefile                      |  2 ++
 arch/x86/kernel/alternative.c                 | 21 +++++++++++++++++--
 arch/x86/kernel/cpu/common.c                  | 20 +++++++++++++++++-
 arch/x86/kvm/cpuid.c                          |  2 +-
 tools/arch/x86/include/asm/cpufeatures.h      |  1 +
 .../arch/x86/include/asm/disabled-features.h  |  8 ++++++-
 tools/objtool/arch/x86/special.c              |  2 ++
 15 files changed, 108 insertions(+), 11 deletions(-)

-- 
2.34.1

