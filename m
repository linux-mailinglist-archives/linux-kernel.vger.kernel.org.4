Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722936E6AB2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 19:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbjDRROJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 13:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjDRRNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 13:13:46 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F38C4486;
        Tue, 18 Apr 2023 10:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681838025; x=1713374025;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iTkmhO2EWTXZhiVPA9Hfnj37ykV3H/JPTRrj0SU8z5A=;
  b=Qmi0CwX9y897PEEIOES2ah4kvNApdrlp98ep81EGboj4TI6xrj8NRaqg
   iXrhBZ5NF4w5RNjzQXqQFKdAdcs4vLaaVPdSMruEVEuSIoLmuYd6bLzkM
   pUfd1FFqK7yE4+VOMrrBB8y4XeD78TzsYGYz99WY/gprveKlin6tydPRy
   hUG5162fF7I03VNtRTerN5g2pvG5CCicvQ3pFWrWVrwHoFWXI2OcH6TX4
   hx6htQuN+yhNnlUCPj2YiN11c9AGLHryY2y/WSyMQkSzX7O43o3TX4011
   dMGhaspk/CKTtN3MqGwMWEau6ZlIIJTZKTj616g8XJH89kNLtV4EE+92X
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="347084251"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="347084251"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 10:13:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="755762649"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="755762649"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga008.fm.intel.com with ESMTP; 18 Apr 2023 10:13:43 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 0/3] Uncore frequency scaling using TPMI 
Date:   Tue, 18 Apr 2023 10:13:37 -0700
Message-Id: <20230418171340.681662-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement support of uncore frequency control via TPMI (Topology Aware
Register and PM Capsule Interface). This driver provides the similar
functionality as the current uncore frequency driver using MSRs.

Previously I posted only 1/3 and got reviewed and addressed with
this submission. The other two patches were links in the submission.

But it is better that all three patches considered together.
I know this is close to merge window for 6.4, so it is fine to differ.

Srinivas Pandruvada (3):
  platform/x86/intel-uncore-freq: Uncore frequency control via TPMI
  platform/x86/intel-uncore-freq: Support for cluster level controls
  platform/x86/intel-uncore-freq: tpmi: Provide cluster level control

 .../pm/intel_uncore_frequency_scaling.rst     |  57 ++-
 .../x86/intel/uncore-frequency/Kconfig        |   4 +
 .../x86/intel/uncore-frequency/Makefile       |   2 +
 .../uncore-frequency-common.c                 |  51 ++-
 .../uncore-frequency-common.h                 |  16 +-
 .../uncore-frequency/uncore-frequency-tpmi.c  | 418 ++++++++++++++++++
 .../intel/uncore-frequency/uncore-frequency.c |   1 +
 7 files changed, 545 insertions(+), 4 deletions(-)
 create mode 100644 drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c

-- 
2.38.1

