Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9AC55FEB3F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 10:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiJNI7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 04:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiJNI7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 04:59:11 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C6C15626F;
        Fri, 14 Oct 2022 01:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665737949; x=1697273949;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xPNLdY9aqxLBPfxMLeiFDhGq4Ci6uGyirD+WbIXdUpE=;
  b=byluB3+Rezwe9cl+6bgMFKn6nkrEHhs8naUL2nHMAg9dy/WBrD/KWm9G
   6EFZJncXOUH0+apQIKrbBwEI03iPMgYq9H0aDBl1ZHXwFyNKfwR6mzQLd
   JbWMt7083iwv765KA1P4dtSUtH7N1WhfrBbNHbfaC6PNNipklzgev1bA3
   r3intpfaAGwOeE3kx/Wv+J4s96H4NpZzUyjznK4oZD9dWeFSWsGqhicb+
   RqBgZyMNA5wtQY3/mOvjX+yHERZ26Xq/N0g2p3G4DYy3RLSTypgpksFVL
   ukITce+ihHEgQ8O3b4JDHCWTq5afEmA1FLDnIsrGRiwVhy9YII25guNSY
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="391635344"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="391635344"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 01:59:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="696234480"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="696234480"
Received: from power-sh.sh.intel.com ([10.239.183.122])
  by fmsmga004.fm.intel.com with ESMTP; 14 Oct 2022 01:59:05 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hwmon@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        jdelvare@suse.com, linux@roeck-us.net, len.brown@intel.com,
        rui.zhang@intel.com
Subject: [PATCH V4 0/4] x86/topology: Fix CPUID.1F handling
Date:   Fri, 14 Oct 2022 17:01:43 +0800
Message-Id: <20221014090147.1836-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handling for CPUID.1F is introduced by commit 7745f03eb395 ("x86/topology:
Add CPUID.1F multi-die/package support").
And only SMT/Core/Die level types are supported at that time.

On Intel AlderLake-N platforms where there are Ecores only, the Ecore
Module topology is enumerated via CPUID.1F Module level.

This exposes two bugs in the CPUID.1F handling code,
1. Linux interprets the Module ID bits as package ID and erroneously
   reports a multi module system as a multi-package system.
2. Linux excludes the unknown Module ID bits from the core ID, and results
   in duplicate core ID’s shown in a package after the first issue solved.

Patch 3/4 and 4/4 fixes these two problems in CPUID.1F handling code, and
patch 1/4 and 2/4 are needed to avoid potential regressions.

thanks,
-rui

---
Changes in V4:
 - Drop a fix for a potential issue, as well as document cleanups/updates.
   So this patch series only contains bug fixes (stable candidates).
 - Integrate the patch subject/changelog improvements from Dave.
 - Add Fixes tags.

Changes in V3:
 - changelog improvements based on Peter' feedback
 - Remove combined tags

Changes in V2:
 - fix/improve changelog/comment wording issues
 - reorder the patches to eliminate bisection breakage window
 - add a new patch for coretemp driver variable renaming
 - update coretemp driver patch to fix a case of ida_free(&ida, -2)
