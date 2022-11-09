Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141B6623333
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 20:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbiKITKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 14:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiKITK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 14:10:28 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3241F61D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 11:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668021027; x=1699557027;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=56Y9PEQQoXVoveTTRPDD6LAVS+X+5X0NWYvqIh44RYI=;
  b=m+MbuyW3XN5qja9smSRbSYL8PWgqgXX5ObUcWh2AbsSor3e/Qic83gmJ
   ptmTCKl+pMyyiXc+SSiVoPMfxWVST46xrLKyXdT5zjyPMgmYSK2szUcyB
   NgfieB7lziGjkkHjXnRsptblu0ms62eOaeIR67y3r9clCoEQbuCIpQ8bX
   1oGofSnuK5QrocatfEbVNZinR5O8VOa/kArqZOznSsZjaJwn1vaqPqKdo
   riGVBoAoqN/FtzGzS5t0orUHaC65FnDnHNXHNHsC3WdLm6RKQsHzaGgNp
   YpYUp8zNSEA2GqEuQjr948/DBV4xedwA0w+SMFcO1vR1tETk6Nn1TfPG0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="311072220"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="311072220"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 11:10:23 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="668105796"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="668105796"
Received: from jkrzyszt-mobl1.ger.corp.intel.com ([10.213.6.201])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 11:10:18 -0800
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris.p.wilson@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Fix timeout handling when retiring requests
Date:   Wed,  9 Nov 2022 20:09:34 +0100
Message-Id: <20221109190937.64155-1-janusz.krzysztofik@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes for issues discovered via code review while working on
https://gitlab.freedesktop.org/drm/intel/issues/7349.

Janusz Krzysztofik (3):
  drm/i915: Fix timeout handling when retiring requests
  drm/i915: Fix unintended submission flush after retire times out
  drm/i915: Fix 0 return value from DMA fence wait on i915 requests

 drivers/gpu/drm/i915/gt/intel_gt_requests.c | 19 +++++++++++++++----
 drivers/gpu/drm/i915/i915_request.c         |  2 +-
 2 files changed, 16 insertions(+), 5 deletions(-)

-- 
2.25.1

