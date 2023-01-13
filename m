Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2113E66930F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 10:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241142AbjAMJew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 04:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241264AbjAMJbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 04:31:46 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047021A212
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 01:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673602041; x=1705138041;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aD/lfRR8F8fjWyTEE25We7aJuQghHG33UM+A1dXJgGo=;
  b=jl/RicU3vP2eBa5PqQ14uGsuNMjconaiOKdg3UL02o4ghs19JhFKpgOB
   M5GYQBV8nTdgSuKK6Pk3cLHURjvNidM84GBvNQT65Gk02b/3xNUA7H93k
   MhW7OLOmRESXgTEk9NQW+mgXBR5PSngTyOJr6wEz4bKDxvEJVC21RvCKp
   DzMr4Fd0vywtYnb4i8ylCTWTBzGLE+0O6FzSmgiq/NelKPYx7imdd7hBc
   rp2CkdudFT4NStSbZod+3OMoT43WZ38u0nQvMH/udl0vfj8BRXiPuQAj+
   dET5zDPoR+0tCjlWDeUxKx/DHAd3foaFdfUZyOxD9s34H1dqN9nnjuZUS
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="351189427"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="351189427"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 01:27:20 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="608116081"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="608116081"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 01:27:18 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 0/5] soundwire: better error handling in deferred transfers
Date:   Fri, 13 Jan 2023 17:35:27 +0800
Message-Id: <20230113093532.3872113-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a generic cleanup series.

Pierre-Louis Bossart (5):
  soundwire: stream: uniquify dev_err() logs
  soundwire: stream: use consistent pattern for freeing buffers
  soundwire: bus: remove sdw_defer argument in sdw_transfer_defer()
  soundwire: cadence: use directly bus sdw_defer structure
  soundwire: cadence: further simplify low-level xfer_msg_defer()
    callback

 drivers/soundwire/bus.c            | 12 +++++-------
 drivers/soundwire/bus.h            |  3 +--
 drivers/soundwire/cadence_master.c | 20 ++++++++++----------
 drivers/soundwire/cadence_master.h |  5 +----
 drivers/soundwire/stream.c         | 22 ++++++++++++----------
 include/linux/soundwire/sdw.h      |  6 +++---
 6 files changed, 32 insertions(+), 36 deletions(-)

-- 
2.25.1

