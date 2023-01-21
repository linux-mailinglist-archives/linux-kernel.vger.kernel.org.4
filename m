Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD39D67699E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 22:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjAUVf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 16:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjAUVfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 16:35:25 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761D123D9F
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 13:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674336924; x=1705872924;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LKIASuZL+SUAUvnx3JEGaFL86U5oJY7Zlr6H840H48o=;
  b=BfM+BUZB99hzpPIGOVbfLxS3rPJdA25zxmlAqrkHk9Jf104CAQMDT521
   WKwy1fpx+8yjhbXti9kP42jsRFNGJ/Dk9tEiyUmKZcdrb8By351wuTP1Q
   9RRmr1tR6gieWiP4Z7SKmTcWIGtCVBSieBruAO7mQPFp7Tqy5nJ9Yun52
   C58SMh9NdgfgHRYeI5kW+5WW0tENT/BvK5bK8TMY107ZygpgX38PW4qNt
   oPRaTshF6/q5mn7ZaafgM33CcQqPInwYXM095HoPIjKkPSN8TCKrWasLg
   aIJyxWLH4/BRrdoZRDhnRh+mtjnYW8uhuOVbq56SZK34/USGKcrGKGeK+
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10597"; a="412066295"
X-IronPort-AV: E=Sophos;i="5.97,235,1669104000"; 
   d="scan'208";a="412066295"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2023 13:35:22 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10597"; a="784946307"
X-IronPort-AV: E=Sophos;i="5.97,235,1669104000"; 
   d="scan'208";a="784946307"
Received: from araj-ucode.jf.intel.com ([10.23.0.19])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2023 13:35:21 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
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
Subject: [Part 2 v2[cleanup] 0/4] Some additional cleanups in microcode
Date:   Sat, 21 Jan 2023 13:35:08 -0800
Message-Id: <20230121213512.251578-1-ashok.raj@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <87y1pygiyf.ffs@tglx>
References: <87y1pygiyf.ffs@tglx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas and Boris,

This mini series is in response to Thomas's feedback here[1].

I hope this addresses all/most of your concerns you raised in this thread.

Sorry if I missed any, drop more hints and I'll fix them up.

Patch3 needs an AMD change as well. I wasn't confident looking at the
source that was returning the patchid vs reading fromt he real MSR. I'll
check with Boris to confirm before I submit this again.

[1] https://lore.kernel.org/lkml/87y1pygiyf.ffs@tglx/

Now that the other patches are now staged in tip/x86/microcode,
this series applies on top of that.

Cheers,
Ashok

Ashok Raj (4):
  x86/microcode: Taint kernel only if microcode loading was successful
  x86/microcode: Report invalid writes to reload sysfs file
  x86/microcode/intel: Fix collect_cpu_info() to reflect current
    microcode
  x86/microcode: Do not call apply_microde() on sibling threads

 arch/x86/kernel/cpu/microcode/core.c  | 28 ++++++++++++++-------------
 arch/x86/kernel/cpu/microcode/intel.c | 10 +++++++++-
 2 files changed, 24 insertions(+), 14 deletions(-)

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

-- 
2.34.1

