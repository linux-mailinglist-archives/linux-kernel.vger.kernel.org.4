Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2862C6EFC7C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 23:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240005AbjDZV3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 17:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239988AbjDZV3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 17:29:32 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1269C3AA7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 14:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682544570; x=1714080570;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to;
  bh=XYLQIHkvfKeSvWSU6i9mepXyNVzspIxyZg3CCSkjC+Q=;
  b=iPWCCsEI76HX+MKpMSSghhbFLoZbKJueQlIGo2v8+vKhrenxb3YOuWK4
   6CUyewK1x4KyGwvnqDpq/WTVyF6CcT/dcaYUdsViHYomLRpZyZqTFUCRb
   RmhIdEbCEFqtktwHXAkkpVt+rnqWt1GEL8yLKITgNmxEX0QVWVrA0EZLD
   l9CnqkEFolj67lqwpr1kd6VBIcZuM2wBPg6nFmRjlqKH7xhccff2Y8Riq
   lbigjL65gUn+Bq+nIe44zkXfj8s2Gb9pqPRDv6NUSiEh+6wI1g1ihMuCf
   b6BUIQGu5eu4g5ZEcQ2luB9DRo/odk9hPO0cFq8p4nWSteL11p1fgXwDZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="344691025"
X-IronPort-AV: E=Sophos;i="5.99,229,1677571200"; 
   d="scan'208";a="344691025"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 14:29:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="805679866"
X-IronPort-AV: E=Sophos;i="5.99,229,1677571200"; 
   d="scan'208";a="805679866"
Received: from lab-ah.igk.intel.com ([10.102.138.202])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 14:29:27 -0700
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Subject: [PATCH v8 0/2] drm/i915: Hugepage manager and test for MTL
Date:   Wed, 26 Apr 2023 23:28:48 +0200
Message-Id: <20230425-hugepage-migrate-v8-0-7868d54eaa27@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJCXSWQC/32PwY7CMAxEfwXljKskXULDif9AHEzrNpZoWjmhA
 qH++6Zcdk8cx6N543mrRMKU1Gn3VkILJ55iEc1+p9qAcSDgrmhlta31jz1AeAw0Y7mPPAhmAtM4
 j9jXBl2nSuyGieAmGNuwBTsZIfO8ObNQz89P2eVadC9T8YIQ/qsw1ppa66byxrtagwWMHVcpvDK
 f7xwfz4pjpnvVTuMGDZzyJK/PgOW4ob/8uhxBQ4/O6QP6xrX+/Me6ruv6CzEJP/kPAQAA
To:     intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jonathan Cavitt <jonathan.cavitt@intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Matthew Auld <matthew.auld@intel.com>
X-Mailer: b4 0.11.1
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
Changes in v8:
- described in patches
- Link to v7: https://lore.kernel.org/r/20230425-hugepage-migrate-v7-0-fa6605a986c9@intel.com

---
Jonathan Cavitt (2):
      drm/i915: Migrate platform-dependent mock hugepage selftests to live
      drm/i915: Use correct huge page manager for MTL

 drivers/gpu/drm/i915/gem/selftests/huge_pages.c | 106 ++++++++++++++++++------
 drivers/gpu/drm/i915/gt/gen8_ppgtt.c            |   3 +-
 2 files changed, 83 insertions(+), 26 deletions(-)
---
base-commit: 4d0066a1c0763d50b6fb017e27d12b081ce21b57
change-id: 20230425-hugepage-migrate-1869aaf31a6d

Best regards,
-- 
Andrzej Hajda <andrzej.hajda@intel.com>
