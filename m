Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5356FBE8F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 07:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234607AbjEIFPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 01:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234542AbjEIFOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 01:14:53 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F899025
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 22:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683609292; x=1715145292;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XM2Ye2n0y+Kiee92BBLzr685tndOBfrVRty6jZErojY=;
  b=JjgnyBbCuDs7aKilM6wAW+F/Bsbo8W/xr/vlIaMkwKFu0mBlNZIjZStc
   HiDHLGGUy+/clUVcXbqBYtqSfN4QIQK5TytwZpMo7JN6dA/V6cBZBLNO6
   NnOluumkS6GS5WvHRGex5c3UWYPn9SpwRJ/KMpZAHElgpM46O4VEKs4cR
   nJNi4fupJ+f+Yit/03hrecS8rdZw9bl6leixb7pzYDaAhbKD5SPqJmGOq
   EhCtws52pKSBOYckO2Kp6yq2G4BzX5TbWYurzkJ2p4P2dimnHDXyIoUtt
   Wj16uUVwfxpsyStZBXaAXN3T67hAPVWS7Mfo2ID2rIJ5lb8I9ZNXdoK9d
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="339037103"
X-IronPort-AV: E=Sophos;i="5.99,261,1677571200"; 
   d="scan'208";a="339037103"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 22:14:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="873033247"
X-IronPort-AV: E=Sophos;i="5.99,261,1677571200"; 
   d="scan'208";a="873033247"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 22:14:45 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 0/3] Fixed-width mask/bit helpers
Date:   Mon,  8 May 2023 22:14:00 -0700
Message-Id: <20230509051403.2748545-1-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generalize the REG_GENMASK*() and REG_BIT*() macros so they can be used
by other drivers. The intention is to migrate i915 to the generic
helpers and also make use of them on the upcoming xe driver. There are
possibly other users in the kernel that need u32/u16/u8 bit handling.

First patch is one of the possible alternatives in radeon/amdgpu drivers
so they use the U32() that is planned to be used here. Other
alternatives would be to use a amd/radeon prefix or use a _Generic().

Last patch is a temporary one to demonstrate what would be changed on
the i915 side. However instead of replacing the implementation of the
REG_* macros, the goal is to replace the callers as well.

Patches here are currently based on drm-tip branch.

Lucas De Marchi (3):
  drm/amd: Remove wrapper macros over get_u{32,16,8}
  linux/bits.h: Add fixed-width GENMASK and BIT macros
  drm/i915: Temporary conversion to new GENMASK/BIT macros

 drivers/gpu/drm/amd/amdgpu/atom.c       | 212 ++++++++++++------------
 drivers/gpu/drm/amd/include/atom-bits.h |   9 +-
 drivers/gpu/drm/i915/i915_reg_defs.h    |  28 +---
 drivers/gpu/drm/radeon/atom-bits.h      |   9 +-
 drivers/gpu/drm/radeon/atom.c           | 209 +++++++++++------------
 include/linux/bits.h                    |  22 +++
 include/uapi/linux/const.h              |   2 +
 include/vdso/const.h                    |   1 +
 8 files changed, 249 insertions(+), 243 deletions(-)

-- 
2.40.1

