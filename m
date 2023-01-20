Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6956759BC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjATQTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjATQTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:19:40 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62ED54490
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674231579; x=1705767579;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6tstgeiA8M5RCL6APE+7P6EVA/i1StlatlS96Xt6uqc=;
  b=HJOXrB9MO8RNUYA8pDZPN+Fha+0CN/V3ai8fFRMoc+Y//rIc2cxc4B/U
   punJs5cR4CQNdrbU6RCUazyfKK6n2tn6uXO2zN1dS6xvOR/09NSRFlKxB
   Lzhs1t1i0CyOVmkHTe9jZkUwdkzdDeXbvvxvi4JJErPex4+u6fOPG3Fsc
   gBI0q0cjS1jEG2VJfnNxlQTDoVUSzsM7zARzR72OesmaTEUWWyUZ7VFB6
   U9YArlKNcrv50rf6/yTliA/w55y3mrf2m4YNa741VTZPTq1f1BTGYut9c
   rNkmPYtwG/2ZERApzriJ49jFJTlmk1aTPqxcnWQKhqiFX2GPww+AcAB1i
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="411846544"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="411846544"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 08:19:37 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="653836362"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="653836362"
Received: from araj-ucode.jf.intel.com ([10.23.0.19])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 08:19:37 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Boris Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>
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
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [Patch v5 0/5] Some fixes and cleanups for microcode
Date:   Fri, 20 Jan 2023 08:19:18 -0800
Message-Id: <20230120161923.118882-1-ashok.raj@intel.com>
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

Here is a followup after v4[1] with all comments addressed.

Please review and apply.

Changes since v4[1]:

Boris:
	- Fix compile errors for 32bit.
	- Drop last patch that displays loading failure during early load.

Changes since v3[2]:

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

[1] https://lore.kernel.org/lkml/20230109153555.4986-1-ashok.raj@intel.com/
[2] https://lore.kernel.org/lkml/20230103180212.333496-1-ashok.raj@intel.com/

Ashok Raj (5):
  x86/microcode: Add a parameter to microcode_check() to store CPU
    capabilities
  x86/microcode/core: Take a snapshot before and after applying
    microcode
  x86/microcode: Display revisions only when update is successful
  x86/microcode/intel: Use a plain revision argument for
    print_ucode_rev()
  x86/microcode/intel: Print old and new rev during early boot

 arch/x86/include/asm/processor.h      |  3 +-
 arch/x86/kernel/cpu/common.c          | 48 +++++++++++++++++++--------
 arch/x86/kernel/cpu/microcode/core.c  | 20 ++++++++---
 arch/x86/kernel/cpu/microcode/intel.c | 41 +++++++++--------------
 4 files changed, 69 insertions(+), 43 deletions(-)


base-commit: 5dc4c995db9eb45f6373a956eb1f69460e69e6d4

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
-- 
2.34.1

