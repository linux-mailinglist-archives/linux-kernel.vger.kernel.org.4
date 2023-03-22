Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7ED86C3F26
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 01:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjCVAiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 20:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCVAiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 20:38:03 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E304ED5;
        Tue, 21 Mar 2023 17:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679445482; x=1710981482;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZxB32O6Iv7U5Jbftu+YxAK0tBw87zvrNYtcPargQ4lY=;
  b=aAS4uWqrj5ZmyQF+DxuvebDmCk/Y/8i4xrTqfXmx4o7mdN8v3CTPbfX8
   Gt4kHX9JSqxZcKyaqbCKrplv+wLnlXv8mQ1RFXw8NxxJKPa8GOjZeIsXN
   H8o+w6DObsAUWKLBZuNQrIw13vIY0hjVk4U9Wh2p7fopsTXjdfV0d0OK3
   sXxWShk6hAckkadN3CrTPoE3ccIBtHK3xoWhRjf0L1bmxuTHRwdXBfyXM
   t+gBVe57U3UGprDtyx4tk+FU9RRDlBT8i8H2ntsPpvyGUajj8zZqUjMxk
   +7Xzdow2QXnabyc8HfWl4iV/8qYgy1GYkM9+lPW/TVWZbC2JdPy9I1mav
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="322934880"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="322934880"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 17:38:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="675076024"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="675076024"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 17:38:00 -0700
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
Subject: [PATCH v4 0/9] Add Array BIST test support to IFS
Date:   Tue, 21 Mar 2023 17:33:50 -0700
Message-Id: <20230322003359.213046-1-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230301015942.462799-1-jithu.joseph@intel.com>
References: <20230301015942.462799-1-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v4
 - Hans de Goede
     - Separate patch 1/9 (Separate ifs_pkg_auth) from reorganize
        driver data patch
     - Rework patch 2/9 (Reorganize driver data) to define const
       ifs_test_caps struct and associate its pointer to miscdevice
       and to remove dynamic allocation for ifs_data as was done in v3
     - Move load check from run_test_store to do_core_test()
     - Expand ABI doc to qualify which devices support which attribrutes
       and the device instance to test mapping

V3 submission:
Link: https://lore.kernel.org/lkml/20230301015942.462799-1-jithu.joseph@intel.com/

Changes in v3
 - GregKH 
    -  Separating read-only fields from rw fields in
       struct ifs_device (patch 1/8)
    -  Remove the subdirectory intel_ifs/<n> for devicenode (patch 2/8)
    -  Replaced an enum with #define (patch 4/8)
 - Dave Hansen
    - Remove tracing patch
    - ifs_array_test_core() (patch 6/8)
        - fix an initialization bug
        - other suggested changes
    - Use basic types in ifs_array for first two fields. (kept
      the union to avoid type castings)

v2 submission:
Link: https://lore.kernel.org/lkml/20230214234426.344960-1-jithu.joseph@intel.com/

Changes in v2
 - remove duplicate initializations from ifs_array_test_core()
   (Dave Hansen, patch 4/7)
 - remove bit parsing from tracing fast path to tracing 
   output (Steven Rostedt, patch 5/7)
 - move "ATTRIBUTE_GROUPS(plat_ifs_array)" to core.c and remove
   exporting function ifs_get_array_groups() (Greg KH, patch 3/7)
 - Generalized doc and ABI doc (Greg KH, patches 6/7 and 7/7)

v1 submission:
Link: https://lore.kernel.org/lkml/20230131234302.3997223-1-jithu.joseph@intel.com/

Array BIST is a new type of core test introduced under the Intel Infield
Scan (IFS) suite of tests.

Emerald Rapids (EMR) is the first CPU to support Array BIST.
Array BIST performs tests on some portions of the core logic such as
caches and register files. These are different portions of the silicon
compared to the parts tested by Scan at Field (SAF).

Unlike SAF, Array BIST doesn't require any test content to be loaded.

Jithu Joseph (9):
  platform/x86/intel/ifs: Separate ifs_pkg_auth from ifs_data
  platform/x86/intel/ifs: Reorganize driver data
  platform/x86/intel/ifs: IFS cleanup
  x86/include/asm/msr-index.h: Add IFS Array test bits
  platform/x86/intel/ifs: Introduce Array Scan test to IFS
  platform/x86/intel/ifs: Sysfs interface for Array BIST
  platform/x86/intel/ifs: Implement Array BIST test
  platform/x86/intel/ifs: Update IFS doc
  Documentation/ABI: Update IFS ABI doc

 arch/x86/include/asm/msr-index.h              |  2 +
 drivers/platform/x86/intel/ifs/ifs.h          | 68 ++++++++++----
 drivers/platform/x86/intel/ifs/core.c         | 81 +++++++++++-----
 drivers/platform/x86/intel/ifs/load.c         |  9 +-
 drivers/platform/x86/intel/ifs/runtest.c      | 94 ++++++++++++++++++-
 drivers/platform/x86/intel/ifs/sysfs.c        | 21 ++---
 .../ABI/testing/sysfs-platform-intel-ifs      | 17 +++-
 7 files changed, 229 insertions(+), 63 deletions(-)


base-commit: e8d018dd0257f744ca50a729e3d042cf2ec9da65
-- 
2.25.1

