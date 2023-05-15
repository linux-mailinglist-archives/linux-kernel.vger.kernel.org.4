Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1403702554
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240266AbjEOGu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240170AbjEOGus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:50:48 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDE72699
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684133438; x=1715669438;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xKsOmGgpfRTaoYi/C0Rex9lD4JYFMvLzVqkjtEvqo9k=;
  b=G9lxGxSw372a26MCw7DfcNPWonstBGIqWG1Rvv0liJ+h1tginpiDrVKY
   YVbasQqng62u0zT33XIEtAB/KoJdN1goq3YFListrqGYT/EXNoVOUXSd7
   h5dtdFVl2wETI1ymY1yQZdmFlf9OZ7XejBMVJzQIUXzWWuHN7HxIeNbsE
   ZkU0Fh/z3/OAjzSZZGfaxxLkC0X4uaXMGwjdaDZYbQb/wn0qbIANCRzif
   3Br/5IVqnsF+fZkoHINikTUfsLZg1n/yACQmO5PPvT/lToI1/NIZHfnA2
   LuLlKa0jj/LGI8Q3s7DeOg98iBh0o1s3cLbmR32f37Xq14AV3qMytz13a
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="349966331"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200"; 
   d="scan'208";a="349966331"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 23:50:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="694908641"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200"; 
   d="scan'208";a="694908641"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 23:50:35 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org, broonie@kernel.org,
        tiwai@suse.de
Cc:     linux-kernel@vger.kernel.org, vinod.koul@linaro.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH v2 07/26] soundwire: intel: add eml_lock in the interface for new platforms
Date:   Mon, 15 May 2023 15:10:23 +0800
Message-Id: <20230515071042.2038-8-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230515071042.2038-1-yung-chuan.liao@linux.intel.com>
References: <20230515071042.2038-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

In existing Intel/SoundWire systems, all the SoundWire configuration
is 'self-contained', with the 'shim_lock' mutex used to protect access
to shared registers in multi-link configurations.

With the move of part of the SoundWire registers to the HDaudio
multi-link structure, we need a unified lock. The hda-mlink
implementation provides an 'eml_lock' that is used to protect shared
registers such as LCTL and LSYNC, we can pass it to the SoundWire
side. There is no issue with possible dangling pointers since the
SoundWire auxiliary devices are children of the PCI device, so the
'eml_lock' cannot be removed while the SoundWire side is in use.

This patch only adds the interface for now.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 include/linux/soundwire/sdw_intel.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index c4281aa06e2e..bafc6f2554b0 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -327,6 +327,8 @@ struct sdw_intel_ctx {
  * @alh_base: sdw alh base.
  * @ext: extended HDaudio link support
  * @hbus: hdac_bus pointer, needed for power management
+ * @eml_lock: mutex protecting shared registers in the HDaudio multi-link
+ * space
  */
 struct sdw_intel_res {
 	const struct sdw_intel_hw_ops *hw_ops;
@@ -343,6 +345,7 @@ struct sdw_intel_res {
 	u32 alh_base;
 	bool ext;
 	struct hdac_bus *hbus;
+	struct mutex *eml_lock;
 };
 
 /*
-- 
2.25.1

