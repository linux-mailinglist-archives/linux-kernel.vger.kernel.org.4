Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06256202A8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 23:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbiKGWys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 17:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiKGWyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 17:54:45 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0291CE0D;
        Mon,  7 Nov 2022 14:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667861685; x=1699397685;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FWqtQaOUoNuwvnHOwhlHlDzFxkPzHGkNFafMl7HFA1U=;
  b=P6V42g0kIBlylydpdKnZ0jP27c/LwOLqDjszUUpHEsxiA0h881Ln0IHj
   rZpn5Zde04LsHHuUhwBwV3U1qLB+dZ6ClpqBqeU11i/gVtn8s5BxxJy0g
   WUIJl9CeiN6yNNnVtOOQh+/tZC4jbZ5r/6RzvE9NHw7G6ebApQ0W6jdjf
   OBt/x8P4BBE+n612wZe94cBEdJ5HuEBJ0yfuHfgZDtIpqo6l6H2du9bsX
   JcQurnQwhH1D4ZiUaWh8Zrdji+CGItIoJBO/wqtT3tWIxGHxlMwIu/yHS
   tn0XTdDbqNEhaXyW3KfEQ/8ofrV+YjVAaGVdgTluvYCbAGEOj9Ye79Rpl
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="293911818"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="293911818"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 14:54:44 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="811012948"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="811012948"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 14:54:44 -0800
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, jithu.joseph@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com,
        thiago.macieira@intel.com, athenas.jimenez.gonzalez@intel.com,
        sohil.mehta@intel.com
Subject: [PATCH v2 00/14] IFS multi test image support and misc changes
Date:   Mon,  7 Nov 2022 14:53:09 -0800
Message-Id: <20221107225323.2733518-1-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221021203413.1220137-1-jithu.joseph@intel.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2
 - Rebased ontop of v6.1-rc4
 Boris
   - Moved exported functions (microcode_sanity_check(),
      find_matching_signature ) from microcode/intel.c to cpu/intel.c 
      (patch4,6)
   - Removed microcode metadata specific code changes to
      microcode_sanity_check() (patch6)
   - Moved find_meta_data() from common to IFS driver (Patch 8)
  Sohil
   - Dropped portions of Patch2 from v1 and folded remaining to Patch12
   - Rewording multiple commits
   - Avoid meta prefix in fields of metadata_header (patch8)
   - Defining MICROCODE_HEADER_VER* into common location (patch6, 9)
   - Elaborating error messages w.r.t processor flags (patch9)
   - Changed sysfs_emit() parameter (patch 11)

v1 patches available from
Link: https://lore.kernel.org/lkml/20221021203413.1220137-1-jithu.joseph@intel.com/

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
Patches 1, and 2: bug fixes
Patch 3: Removes image loading during init path 
Patch 4, 5 and 6: exports a couple of microcode/intel.c functions
                  for use by driver

Rest of them are IFS driver changes
Patches 9: IFS header format changes to make it fully compatible
           to intel microcode header format
Patch 7,8 and 10: microcode/IFS metadata section related
Patches 11, 12 and 13: native support for multiple scan test image files
Patch 14: reverts the broken flag

Ashok Raj (1):
  platform/x86/intel/ifs: Add metadata support

Jithu Joseph (13):
  platform/x86/intel/ifs: Remove unused selection
  platform/x86/intel/ifs: return a more appropriate Error code
  platform/x86/intel/ifs: Remove image loading during init
  x86/microcode/intel: Expose find_matching_signature() for IFS
  x86/microcode/intel: Use appropriate type in microcode_sanity_check()
  x86/microcode/intel: Expose microcode_sanity_check()
  x86/microcode/intel: Use a reserved field for metasize
  platform/x86/intel/ifs: Use generic microcode headers and functions
  platform/x86/intel/ifs: Add metadata validation
  platform/x86/intel/ifs: Remove reload sysfs entry
  platform/x86/intel/ifs: Add current_batch sysfs entry
  Documentation/ABI: Update IFS ABI doc
  Revert "platform/x86/intel/ifs: Mark as BROKEN"

 arch/x86/include/asm/cpu.h                    |   2 +
 arch/x86/include/asm/microcode_intel.h        |   5 +-
 drivers/platform/x86/intel/ifs/ifs.h          |  27 ++-
 arch/x86/kernel/cpu/intel.c                   | 129 +++++++++++
 arch/x86/kernel/cpu/microcode/intel.c         | 146 +------------
 drivers/platform/x86/intel/ifs/core.c         |   7 +-
 drivers/platform/x86/intel/ifs/load.c         | 205 ++++++++++--------
 drivers/platform/x86/intel/ifs/runtest.c      |  10 +-
 drivers/platform/x86/intel/ifs/sysfs.c        |  41 ++--
 .../ABI/testing/sysfs-platform-intel-ifs      |  30 +--
 drivers/platform/x86/intel/ifs/Kconfig        |   4 -
 11 files changed, 330 insertions(+), 276 deletions(-)


base-commit: f0c4d9fc9cc9462659728d168387191387e903cc
-- 
2.25.1

