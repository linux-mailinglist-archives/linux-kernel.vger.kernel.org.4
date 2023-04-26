Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B361E6EF793
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 17:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241282AbjDZPOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 11:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241280AbjDZPOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 11:14:48 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83F54C1E
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 08:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682522087; x=1714058087;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to;
  bh=a4tnm3fwJS5ag19L8vGA9PFPuKrEXPbjh7N3g3Z0zMY=;
  b=T+VTCqasEg4m73b5bXyMHq62RPL5g6fiwudIv/2n8B9GqC3UvnscifYk
   45z4DTsxiZn99zuBBfafDsrnWuzUYCGPqXKBWOW0OXp4LjytKwlsLTnU7
   xiF45+OzoG6z5J5Ju9sqCLyooHfUx2zan2wYU/vDZZDcrfNhkGdQh4HIy
   +Wd1dQC6dPihf0dj94Gi5wzLLe7xtE1Jk4NZ0UnjaJbq0hmPB90llVbtI
   VNGtttTJ17raQA4M3Z7ULWGp+MI9zvi9G+ZFkbnnVJQ0Fyy4ImzfEEBsF
   QNsTK3khXGBYDExx1JSwuCGGl9S3+hpuXYONvh7bqoKXodOy+fBxYvu/n
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="412444652"
X-IronPort-AV: E=Sophos;i="5.99,228,1677571200"; 
   d="scan'208";a="412444652"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 08:14:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="671366410"
X-IronPort-AV: E=Sophos;i="5.99,228,1677571200"; 
   d="scan'208";a="671366410"
Received: from lab-ah.igk.intel.com ([10.102.138.202])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 08:14:29 -0700
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Subject: [PATCH v7 0/2] drm/i915: Hugepage manager and test for MTL
Date:   Wed, 26 Apr 2023 17:14:10 +0200
Message-Id: <20230425-hugepage-migrate-v7-0-fa6605a986c9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMI/SWQC/02Nyw6CMBBFf4V0bZs+FMWV/2FcDDDQSaCQaTEYw
 r9bXLk89+bkbCIiE0ZxLzbB+KZIU8hwPRWi8RB6lNRmFlZbp8/2Iv3S4wx5H6lnSCjNrawAOmeg
 bEXWaogoa4bQ+ENseZSJ5uOZGTtaf7HnK3PHU/48I/wljLXGaX1TlalKp6WVEFpS0X8SPQYKy6o
 oJBxUM41i379z622EwQAAAA==
To:     intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jonathan Cavitt <jonathan.cavitt@intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Matthew Auld <matthew.auld@intel.com>
X-Mailer: b4 0.11.1
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset patches sent by Jonathan and Andi, with 
addressed CI failures:
1. Fixed checking alignment of 64K pages on both Pre-Gen12 and Gen12.
2. Fixed start alignment of 2M pages.

Regards
Andrzej

Jonathan Cavitt (2):
  drm/i915: Migrate platform-dependent mock hugepage selftests to live
  drm/i915: Use correct huge page manager for MTL

.../gpu/drm/i915/gem/selftests/huge_pages.c   | 88 +++++++++++++++----
 drivers/gpu/drm/i915/gt/gen8_ppgtt.c          |  3 +-
 2 files changed, 71 insertions(+), 20 deletions(-)

Cc: intel-gfx@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: Jonathan Cavitt <jonathan.cavitt@intel.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
-- 
2.39.2

---
Jonathan Cavitt (2):
      drm/i915: Migrate platform-dependent mock hugepage selftests to live
      drm/i915: Use correct huge page manager for MTL

 drivers/gpu/drm/i915/gem/selftests/huge_pages.c | 105 ++++++++++++++++++------
 drivers/gpu/drm/i915/gt/gen8_ppgtt.c            |   3 +-
 2 files changed, 82 insertions(+), 26 deletions(-)
---
base-commit: 4d0066a1c0763d50b6fb017e27d12b081ce21b57
change-id: 20230425-hugepage-migrate-1869aaf31a6d

Best regards,
-- 
Andrzej Hajda <andrzej.hajda@intel.com>
