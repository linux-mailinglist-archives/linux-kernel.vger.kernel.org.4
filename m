Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19DF6C5EE5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 06:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjCWFcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 01:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjCWFbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 01:31:44 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9AE212A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 22:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679549468; x=1711085468;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q80CBcxn2QOQK8sFpcJ2zT5Gn5sp4JMMdHxIOJazfZ4=;
  b=lJTvWVUstMjMBb0jeCDsoQIZukw3dI/GGzt7ltKqkuptKrOME2a4vG29
   GRy3eGiTQxhfS+6ECvvCXxQ8ePBWi6dBbKy4ynXBovIrGGlc1l+aRyPZ5
   W9mBjBOC7qZIo8WOFk+R4zXh8JFbgZUu94fTf/CrVPFOZOox/XYeiMy7C
   ZNCPpxe1EGYWgTijm7gZCQXVde6KZP8mxOLAdBHU7KdJIcqD5SIbWmNoL
   Cavak/lL3vYJLcj8hqo6F68tDYKwG1tGTFGnMY10QErcqsAXFi4InVeVX
   9ms5Fe+qfSDphee++OlHwQ7SFzaRX7Gw7leuJqhAG9eK7xdZtVYEeyl+N
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="327779468"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="327779468"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 22:30:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="675567220"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="675567220"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 22:30:28 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org, broonie@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com,
        tiwai@suse.de
Subject: [PATCH 16/20] soundwire: intel_ace2x: use common helpers for bus start/stop
Date:   Thu, 23 Mar 2023 13:44:48 +0800
Message-Id: <20230323054452.1543233-17-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230323054452.1543233-1-yung-chuan.liao@linux.intel.com>
References: <20230323054452.1543233-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The sequences are so far identical, so the abstraction is a bit
over-engineered. In time we will simplify if there is no need to
special case or work-around programming sequences.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel_ace2x.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/soundwire/intel_ace2x.c b/drivers/soundwire/intel_ace2x.c
index 20b8806f7de6..2e33e8a00b55 100644
--- a/drivers/soundwire/intel_ace2x.c
+++ b/drivers/soundwire/intel_ace2x.c
@@ -316,6 +316,12 @@ const struct sdw_intel_hw_ops sdw_intel_lnl_hw_ops = {
 
 	.register_dai = intel_register_dai,
 
+	.check_clock_stop = intel_check_clock_stop,
+	.start_bus = intel_start_bus,
+	.start_bus_after_reset = intel_start_bus_after_reset,
+	.start_bus_after_clock_stop = intel_start_bus_after_clock_stop,
+	.stop_bus = intel_stop_bus,
+
 	.link_power_up = intel_link_power_up,
 	.link_power_down = intel_link_power_down,
 
-- 
2.25.1

