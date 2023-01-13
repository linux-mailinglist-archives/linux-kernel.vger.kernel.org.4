Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A4266A0E5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 18:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjAMRnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 12:43:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjAMRnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 12:43:09 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC028B775
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 09:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673630972; x=1705166972;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JIm27/Zc/uch3n2kZrsorIE+84Bcpxcmdtm6i5sjCRA=;
  b=mtyt9kqedLZ2WBsjGhTcwTpwSxyuYotoxpLWfQapcOZ/WKPliIB7YBtI
   qwPc+e60eleHHnRdc6OSPZKjauLqArRulgVM4lRwFVLgNdkHD7R+P03PG
   1L2R9UqgzFGFOa2TfVLejmSCRpNuCRg4T5xl4W5inE2o/RlKIViZgPhaV
   qjUiDxJUS3QFfUvpogiWYsGVIrP8p7FEf6NBA6sxy9TOVtyh17M/Hcvgh
   arg0x/gnKQlwmgUIbEwnKQ1sn2RLtKmCP3RyKoo3+HpiUHEJzlW0muZYm
   tqUPGxvKLqhGsrN9KcQa90eUZbLlynIvLreqeiZdZ623JGTUVGEAr2LUP
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="304429985"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="304429985"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 09:29:32 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="766089912"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="766089912"
Received: from araj-ucode.jf.intel.com ([10.23.0.19])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 09:29:31 -0800
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
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: [PATCH v1 Part2 0/5] Declare safe late loadable microcode
Date:   Fri, 13 Jan 2023 09:29:15 -0800
Message-Id: <20230113172920.113612-1-ashok.raj@intel.com>
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

Hi Boris & Thomas,

Attached is a series that adds support for microcode to declare a minimum
revision number that is safe for late loading.

Late loading was disabled[1] in 5.19 due to lack of an ability to declare
when a microcode is safe for late loading. 

This series is inspired by recommendations from Thomas [2]. 

This series is part2 and applies on top of that cleanup series part1[3].

- Move where the warning and tainting is done to the same function. It
  helps when later patches enable late loading, to issue the warning only
  when the vendor doesn't support a mechanism for declaring a microcode
  for safe late loading.

- Add meta-data for Intel microcode to specify a minimum revision that the
  CPU must be on before attempting to load this microcode.

- Extend this as a generic mechanism to allow the common infrastructure to
  permit late loading.

- Some CPUs required a wbinvd() to be issued before attempting to load a
  microcode. These were later addressed via microcode patches. Now there
  exists a mechanism to declare a minimum revision, those flushes aren't
  required any longer.

- Provide a mechanism to override minrev as a way to bypass during the
  transition. It is recommended to always use early loading, especially if
  one is moving to a newer kernel. This is a chicken bit option :) and
  completely optional.

[1] https://lore.kernel.org/lkml/20220524185324.28395-3-bp@alien8.de/
[2] https://lore.kernel.org/linux-kernel/alpine.DEB.2.21.1909062237580.1902@nanos.tec.linutronix.de/
[3] https://lore.kernel.org/lkml/20230109153555.4986-1-ashok.raj@intel.com/

Cheers,
Ashok

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


Ashok Raj (5):
  x86/microcode: Move late load warning to the same function that taints
    kernel
  x86/microcode/intel: Add minimum required revision to microcode header
  x86/microcode: Add a generic mechanism to declare support for minrev
  x86/microcode/intel: Drop wbinvd() from microcode loading
  x86/microcode: Provide an option to override minrev enforcement

 arch/x86/include/asm/microcode.h       |  4 ++
 arch/x86/include/asm/microcode_intel.h |  3 +-
 arch/x86/kernel/cpu/microcode/core.c   | 36 ++++++++++++++---
 arch/x86/kernel/cpu/microcode/intel.c  | 55 ++++++++++++++++++++------
 arch/x86/Kconfig                       |  7 ++--
 5 files changed, 83 insertions(+), 22 deletions(-)

-- 
2.34.1

