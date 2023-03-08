Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373286B0D17
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 16:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjCHPkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 10:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbjCHPkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:40:09 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E87724CA7
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 07:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678289988; x=1709825988;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=JZPPyfomcM6RPed2Z6objclkx7X74pCD0nLjOtDOZ2w=;
  b=BewPIDW2s1lUAFJmrD3svTH+TDr4N1YC9+DKseXgH39XW1jTMdqaYfn5
   kFUUfql1xvibcUZ2nsTodVWrQ5bu63sPucqcH0mUrKzYbnc53IXyIzEcV
   UkJ+/1yubu16wh56uT4cWqmRwCS3gOxeksWcG3ilVfYeFGM4PW40p82bV
   siZ9YogQBmd3iHo/xcOrUe/sumdzSmi/qCQ3Esb+pndNIRTo3HqkAsnP5
   OQo55KxuhJ19Xlc32tFmWjdtxU8bnW3Hj09iglOnBtexBNRnisZge2TBh
   /DL/puCIrLnkN/PFt/ye3wX/PUj+DY5NQ3Vt+Wv101O2+uOmKvHLxrkYn
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="337703533"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="337703533"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 07:39:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="787160232"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="787160232"
Received: from lab-ah.igk.intel.com ([10.102.42.211])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 07:39:42 -0800
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Subject: [PATCH v5 0/4] drm/i915: add guard page to ggtt->error_capture
Date:   Wed, 08 Mar 2023 16:39:03 +0100
Message-Id: <20230308-guard_error_capture-v5-0-6d1410d13540@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABesCGQC/x2N0QqDMAwAf0XyvEAxE2S/IkNim2oerCXVMRD/f
 XWPx3HcCUVMpcCrOcHko0W3VKF7NOAXTrOghsrQupYcuR7ngy2MYrbZ6DnvhwlGikRPEd93EWo5
 cRGcjJNf7jbYirvm22STqN//b3hf1w9xA2EcfwAAAA==
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Chris Wilson <chris.p.wilson@linux.intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>
X-Mailer: b4 0.11.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch tries to diminish plague of DMAR read errors present
in CI for ADL*, RPL*, DG2 platforms, see for example [1] (grep DMAR).
CI is usually tolerant for these errors, so the scale of the problem
is not really visible.
To show it I have counted lines containing DMAR read errors in dmesgs
produced by CI for all three versions of the patch, but in contrast to v2
I have grepped only for lines containing "PTE Read access".
Below stats for kernel w/o patchset vs patched one.
v1: 210 vs 0
v2: 201 vs 0
v3: 214 vs 0
Apparently the patchset fixes all common PTE read errors.

Changelog:
v2:
    - modified commit message (I hope the diagnosis is correct),
    - added bug checks to ensure scratch is initialized on gen3 platforms.
      CI produces strange stacktrace for it suggesting scratch[0] is NULL,
      to be removed after resolving the issue with gen3 platforms.
v3:
    - removed bug checks, replaced with gen check.
v4:
    - change code for scratch page insertion to support all platforms,
    - add info in commit message there could be more similar issues
v5:
    - changed to patchset adding nop_clear_range related code,
    - re-insert scratch PTEs on resume

To: Jani Nikula <jani.nikula@linux.intel.com>
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: Andi Shyti <andi.shyti@linux.intel.com>
Cc: Chris Wilson <chris.p.wilson@linux.intel.com>
Cc: Nirmoy Das <nirmoy.das@intel.com>

Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>

---
Andrzej Hajda (4):
      drm/i915/gt: make nop_clear_range public
      drm/i915/display: use nop_clear_range instead of local function
      drm/i915/selftests: use nop_clear_range instead of local function
      drm/i915: add guard page to ggtt->error_capture

 drivers/gpu/drm/i915/display/intel_dpt.c  |  7 +-----
 drivers/gpu/drm/i915/gt/intel_ggtt.c      | 38 ++++++++++++++++++++++++++-----
 drivers/gpu/drm/i915/gt/intel_gtt.h       |  2 ++
 drivers/gpu/drm/i915/selftests/mock_gtt.c |  9 ++------
 4 files changed, 37 insertions(+), 19 deletions(-)
---
base-commit: 3cd6c251f39c14df9ab711e3eb56e703b359ff54
change-id: 20230308-guard_error_capture-f3f334eec85f

Best regards,
-- 
Andrzej Hajda <andrzej.hajda@intel.com>
