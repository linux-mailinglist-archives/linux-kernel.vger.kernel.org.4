Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294D46D017F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 12:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjC3KnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 06:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjC3KnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:43:21 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB7A7682
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 03:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680173000; x=1711709000;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ygo93piNDua7J8VtxEGX71H4GSn6S2H4oKkR/7x2I1U=;
  b=fWwtd6i/MBTP2J1tsO/Ilti1N3WLMNLmKhxJZ6OR/nkrKd/3lUERvdds
   M3hZYxZpfMN/ctUfZsEBW/ppSzDPPmZYa2EM6DIjOiAqUZ1nFBOAbFOQp
   N7lNL3RwEAXAnPl3eg2sybMFBqBt4idEC/h982Q3QLwtLwXth5MguGnCN
   AlWvy1Huj/QZQ3/9uAhySxAPEf7LyuoeojjRpVQZ5oWkS6+pSmznOxR9L
   Q30zkvTwD+R7gu9VAaxNubAVHpv6CjwpO1+sPIh3LXSyC+XkBAq5KEe0F
   jmlAsX2Rjns9b+Uku2NLVPGAIMxRfiaw/lydtOcAoyuSHK8wk8YLuw3kg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="406096325"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="406096325"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 03:43:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="687197227"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="687197227"
Received: from unknown (HELO localhost) ([10.237.66.160])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 03:43:17 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        jani.nikula@intel.com, Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Gow <davidgow@google.com>
Subject: [PATCH 0/4] log2: make is_power_of_2() more generic
Date:   Thu, 30 Mar 2023 13:42:39 +0300
Message-Id: <20230330104243.2120761-1-jani.nikula@intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

is_power_of_2() only works for types <= sizeof(unsigned long) and it's
also not a constant expression. There are a number of places in kernel
where is_power_of_2() is called on u64, which fails on 32-bit
builds. Try to remedy that. While at it, make it a constant expression
when possible.

I admit I've only lightly tested this, and I haven't tried it with
allmodconfig.


Jani Nikula (4):
  log2: add helper __IS_POWER_OF_2()
  log2: have is_power_of_2() support bigger types than unsigned long
  log2: allow use of is_power_of_2() in constant expressions
  drm/i915/reg: use is_power_of_2() from log2.h

 drivers/gpu/drm/i915/i915_reg_defs.h |  7 +------
 include/linux/log2.h                 | 25 ++++++++++++++++++++-----
 2 files changed, 21 insertions(+), 11 deletions(-)

-- 
2.39.2

