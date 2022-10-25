Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E5B60CBA0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 14:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbiJYMSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 08:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJYMSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 08:18:12 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1D0181961
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 05:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666700291; x=1698236291;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hya8Tm6uWhSoN9X5jdakzzilVn+QolLFFXHEJnbl6mU=;
  b=GOSJx7wrENkaUPBOrL/GXGMdSThzgdrhGl1zKfeKLnBFih1M+lQ5JiPG
   93mM7A12BHnlmrxX2mF58h47QaWivZa+nqZSIpvQv+qTF+uxcWoLYLyYl
   x1RYhcCJAvCYCtkMD+q6y/T8R4oN6GlvRuk2Spk8SAtlGVsgL4R9tzwNB
   fb2NtMxm9FCxYholDSjkJcLnFwolyT6ikCtRAk9TEvn2D/QrSwoRbfgxA
   sfgP7b87Axip6d00Wity5sEoYTjbEv//ql2heOyQuFs6Uuobtde6W2hJe
   XyS+uayJDsGBoENws5r321TcVhyCZhurKsWZA1NrH1cl/wtc6d4lmGvtJ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="305270620"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="305270620"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 05:18:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="634073933"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="634073933"
Received: from sunyi-station.sh.intel.com (HELO sunyi-station..) ([10.239.159.10])
  by fmsmga007.fm.intel.com with ESMTP; 25 Oct 2022 05:18:08 -0700
From:   Yi Sun <yi.sun@intel.com>
To:     dave.hansen@intel.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     sohil.mehta@intel.com, ak@linux.intel.com,
        ilpo.jarvinen@linux.intel.com, heng.su@intel.com,
        tony.luck@intel.com, dave.hansen@linux.intel.com,
        Yi Sun <yi.sun@intel.com>
Subject: [RESEND PATCH v5 0/2] x86: Add xsave/xrstor Latency Trace Events and Consuming Script
Date:   Tue, 25 Oct 2022 20:17:47 +0800
Message-Id: <20221025121749.584519-1-yi.sun@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces trace events that can leak the latency of xsave and
xrstor instructions for the x86 platform to tell when XSAVE/XRSTOR are becoming
more or less expensive, and get the RFBM and XINUSE to figure out why.

We conducted extensive internal testing and compared several latency computation
methodologies. We believe it could be improved. Also included in the series is
a script for consuming trace logs that uses sqlite3 to display statistics data
such as max, min, latency, and 97% tail latency.

- Change from v4 to v5:
  - Rebase patch to the most recent tag v6.1-rc2, no conflict.

- Change from v3 to v4:
  - Rebase patch set to the latest tag v6.0-rc3, replacing
    ALTERNATIVE_2 with ALTERNATIVE_3

- Change from v2 to v3:
  - Move the script xsave-latency-trace.sh to folder tools/testing/fpu/
    (Ingo Molnar)

- Change from v1 to v2:
  - Reword the comments. (Laight, David; Mehta, Sohil)
  - Rename all variable 'dtsc' to 'latency'. (Mehta, Sohil)

Yi Sun (2):
  x86/fpu: Measure the Latency of XSAVE and XRSTOR
  tools/testing/fpu: Add script to consume trace log of xsave latency

 arch/x86/include/asm/trace/fpu.h         |  35 ++++
 arch/x86/kernel/fpu/xstate.h             |  49 ++++-
 tools/testing/fpu/xsave-latency-trace.sh | 227 +++++++++++++++++++++++
 3 files changed, 306 insertions(+), 5 deletions(-)
 create mode 100755 tools/testing/fpu/xsave-latency-trace.sh

-- 
2.34.1

