Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8855D683AA4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 00:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjAaXo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 18:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjAaXo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 18:44:56 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C3B2B619;
        Tue, 31 Jan 2023 15:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675208696; x=1706744696;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rRr0dU2Ax3D388aE0RxUG7UZP/5GO+5UGBpNxL+OVL0=;
  b=VL7Sr/rbFqN5pSSkFBT0VkxjOdO29RdwR6T0YCnpT1RLIumPeCdLBZ15
   2GmDHIZ9YxDn4o3xCBds129oTehyTxfLGXEKa8TCjcWIPgWQJzlIg+u6A
   hjwplqm5xLbF7GP9tehVnM7UkEDQcwiE4hLW9/7CqKnWv57QlYXwG6KPc
   hRMmi76xeVJo2J2go01dnPfsekqUbEDcfNVtB1EVoDVGTQi+0u3zv+v/S
   857VODHKlTbJHYnoUq9KUuzGiSqRfxn7F+mnVeAnXDyBEmeHgtwGVJTdb
   osD3OQrzi5uR9w3Se1tywT1P+1a/TQoTv7lTUZronNqjQXAe0XicgfOPn
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="390360409"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="390360409"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 15:44:55 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="773192021"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="773192021"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 15:44:55 -0800
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, rostedt@goodmis.org,
        jithu.joseph@intel.com, ashok.raj@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com,
        thiago.macieira@intel.com, athenas.jimenez.gonzalez@intel.com,
        sohil.mehta@intel.com
Subject: [PATCH 0/5] Add Array BIST test support to IFS
Date:   Tue, 31 Jan 2023 15:42:57 -0800
Message-Id: <20230131234302.3997223-1-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
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

Array BIST is a new type of core test introduced under the Intel Infield
Scan (IFS) suite of tests.

Emerald Rapids (EMR) is the first CPU to support Array BIST.
Array BIST performs tests on some portions of the core logic such as
caches and register files. These are different portions of the silicon
compared to the parts tested by Scan at Field (SAF).

Unlike SAF, Array BIST doesn't require any test content to be loaded.

Jithu Joseph (5):
  x86/include/asm/msr-index.h: Add IFS Array test bits
  platform/x86/intel/ifs: Introduce Array Scan test to IFS
  platform/x86/intel/ifs: Sysfs interface for Array BIST
  platform/x86/intel/ifs: Implement Array BIST test
  platform/x86/intel/ifs: Trace support for array test

 arch/x86/include/asm/msr-index.h         |   2 +
 drivers/platform/x86/intel/ifs/ifs.h     |  18 ++++
 include/trace/events/intel_ifs.h         |  27 ++++++
 drivers/platform/x86/intel/ifs/core.c    |  82 ++++++++++++------
 drivers/platform/x86/intel/ifs/runtest.c | 104 ++++++++++++++++++++++-
 drivers/platform/x86/intel/ifs/sysfs.c   |  17 +++-
 6 files changed, 223 insertions(+), 27 deletions(-)


base-commit: 6d796c50f84ca79f1722bb131799e5a5710c4700
-- 
2.25.1

