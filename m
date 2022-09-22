Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39D65E63AD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 15:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbiIVNfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 09:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbiIVNe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 09:34:58 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260EC543C1;
        Thu, 22 Sep 2022 06:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663853698; x=1695389698;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0YqEgmScZ7iCevfwtvTs2m+pgaAQ/CAZCiyAmFzqCHE=;
  b=QsWs8cn4Vw6n/gjbJNMquKBY/CmFT/Db9QnJsLnFR4Rl5d+gnv/WrjbD
   kgxBxBoVZEb8c3McGZpdLDDXNoEdGWon0EaCBGtE4qPYX5A/2jqFdD3KM
   Buk6IKkWqgvpFsd0pEiBpFUJBSV/B0/QH1DDoFtwhtESWBVragr6L+Jh1
   KIJFNmwCJhZW18DkrokCVOOi59789nanOaO2RcUyG34mNrcY5JxDV//jW
   GQEcJ8UwaT1XKheHW0rW+MWkioIrsff/WPYBBts5JT12j0E3273ZUhkaU
   TpjseR9bs3ZLaaugDHyzAD8GcIvVcA0v1bNRScjjFrqZWStmK/su3woNd
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="297894084"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="297894084"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 06:34:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="619793786"
Received: from power-sh.sh.intel.com ([10.239.183.122])
  by orsmga002.jf.intel.com with ESMTP; 22 Sep 2022 06:34:54 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hwmon@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        corbet@lwn.net, fenghua.yu@intel.com, jdelvare@suse.com,
        linux@roeck-us.net, len.brown@intel.com, rui.zhang@intel.com
Subject: [PATCH V3 0/8] x86/topology: Improve CPUID.1F handling
Date:   Thu, 22 Sep 2022 21:37:52 +0800
Message-Id: <20220922133800.12918-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Intel AlderLake-N platforms where there are Ecores only, the Ecore
Module topology is enumerated via CPUID.1F Module level, which has not
been supported by Linux kernel yet.

This exposes two issues in current CPUID.1F handling code.
1. Linux interprets the Module ID bits as package ID and erroneously
   reports a multi module system as a multi-package system.
2. Linux excludes the unknown Module ID bits from the core ID, and results
   in duplicate core ID’s shown in a package after the first issue solved.

Plus that, a third problem is observed on Intel Hybrid ADL-S/P platforms.
The return value of CPUID.1F SMT level EBX (number of siblings) differs on
Pcore CPUs and Ecore CPUs, and results in inconsistent smp_num_siblings
value based on the Pcore/Ecore CPU enumeration order. This could bring
some potential issues although we have not observed any functionalities
issues so far.

This patch series fixes these three problems in CPUID.1F handling code,
together with some related fixes and document updates.

thanks,
-rui

---
Changes since V2:
 - changelog improvements based on Peter' feedback
 - Remove combined tags

Changes since V1:
 - fix/improve changelog/comment wording issues
 - reorder the patches to eliminate bisection breakage window
 - add a new patch for coretemp driver variable renaming
 - update coretemp driver patch to fix a case of ida_free(&ida, -2)
