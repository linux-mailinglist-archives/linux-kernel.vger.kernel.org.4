Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A18B607FE1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 22:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiJUUj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 16:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJUUjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 16:39:52 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF5542ADC;
        Fri, 21 Oct 2022 13:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666384790; x=1697920790;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xvwzs6JdNeO32KfigzubT6fCl2jWmlRjaM5tQL1JZ1I=;
  b=VMp3Oo68kqkwgrIWYmgQKfR7kIZ42hvUK/+xaHxeY69PPRA3EqpRyZu7
   cA17nQI2fU4ouzFtikJhhbv3vJdm0D2QXmdJhqRZ/kPkFtEd6rDD3nkv8
   AP6KnE8+IY925c2p9k9YcGc1R1tl8LXaqyp5LfaMCEj5sc8mnGKDOmoso
   9K9SOg9pgqOrxpSnoU68CU9GfMahoLDxRsBfX3UJ6+IRzZKNp1nHtip/w
   RH6Jp9zVndupCREd7a9LWklekyiZJ5FBIxxKA7IO/AcyacWCsQiS/T4R1
   2rQpjs+toipqvHgPO9YObQXDyCIf6VYyMCx7/oLqGNufNGORGCrWwl4uC
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="369161168"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="369161168"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 13:35:33 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="735700991"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="735700991"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 13:35:33 -0700
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, jithu.joseph@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com,
        thiago.macieira@intel.com, athenas.jimenez.gonzalez@intel.com
Subject: [PATCH 00/14] IFS multi test image support and misc changes
Date:   Fri, 21 Oct 2022 13:33:59 -0700
Message-Id: <20221021203413.1220137-1-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initial implementation of IFS driver assumed a single IFS test image
file with a fixed name.

Subsequently, it became evident that supporting more than one
test image file is needed to provide more comprehensive
test coverage. (Test coverage in this scenario refers to testing
more transistors in the core to identify faults).

This series makes the driver aware of multiple scan test image files,
modifies IFS test image file headers to make it fully compatible
with microcode headers and adds a few other bug fixes and changes.

Patch organization:
Patches 1, 2, and 3: bug fixes
Patch 4: Removes image loading during init path 
Patch 5, 6 and 7: exports a couple of microcode/intel.c functions
                  for use by driver
Patch 8: Adds Meta-data support in microcode file

Rest of them are IFS driver changes
Patches 9 and 10: IFS header format changes to make it fully compatible
 to intel microcode header format
Patches 11, 12 and 13: native support for multiple scan test image files
Patch 14: reverts the broken flag

Ashok Raj (1):
  x86/microcode/intel: Meta-data support in microcode file

Jithu Joseph (13):
  platform/x86/intel/ifs: Remove unused selection
  platform/x86/intel/ifs: Propagate load failure error code
  platform/x86/intel/ifs: return a more appropriate Error code
  platform/x86/intel/ifs: Remove image loading during init
  x86/microcode/intel: Expose find_matching_signature() for IFS
  x86/microcode/intel: Use appropriate type in microcode_sanity_check()
  x86/microcode/intel: Expose microcode_sanity_check()
  platform/x86/intel/ifs: Use generic microcode headers and functions
  platform/x86/intel/ifs: Add metadata validation
  platform/x86/intel/ifs: Remove reload sysfs entry
  platform/x86/intel/ifs: Add current_batch sysfs entry
  Documentation/ABI: Update IFS ABI doc
  Revert "platform/x86/intel/ifs: Mark as BROKEN"

 arch/x86/include/asm/microcode_intel.h        |  25 ++-
 drivers/platform/x86/intel/ifs/ifs.h          |  27 ++-
 arch/x86/kernel/cpu/microcode/intel.c         |  81 ++++++--
 drivers/platform/x86/intel/ifs/core.c         |   7 +-
 drivers/platform/x86/intel/ifs/load.c         | 174 +++++++++---------
 drivers/platform/x86/intel/ifs/runtest.c      |  10 +-
 drivers/platform/x86/intel/ifs/sysfs.c        |  41 +++--
 .../ABI/testing/sysfs-platform-intel-ifs      |  30 +--
 drivers/platform/x86/intel/ifs/Kconfig        |   4 -
 9 files changed, 243 insertions(+), 156 deletions(-)


base-commit: f76349cf41451c5c42a99f18a9163377e4b364ff
-- 
2.25.1

