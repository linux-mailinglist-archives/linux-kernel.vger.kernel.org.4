Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B19669307
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 10:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240834AbjAMJeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 04:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241274AbjAMJb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 04:31:58 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C87665AEE
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 01:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673602044; x=1705138044;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C9eEbKq5usd6ckHzGy5EN+JxgZQpOybLQsyYvmgo4Hg=;
  b=gyZSANpiOtOXk23IyjUnV455ZzTIC6pixeJbeROaiKKn60e47LitZZ5C
   LDa7M38ObG1FasYiFZSIGuguZZAn5C54R8K9afQ1G6q2iMsRa1oEapDN1
   wEzpESZcrtexSpF2u20F7qC93aP18uhUgDpjxG74pcFDCHxpb/4bdBeiX
   Kzk4QVm2n4SVmITNInkxxve3Qa1Qdw9tt9UIg5KS7AifZ+wr55xppTA8v
   y5WOYVy9h50/N+A2QdBmdJIRXoknSexl1Q1hYgj+ool8Dhja4z/jIFxC2
   WSVjn1JhFKG3gCBdv9D/02LoDrJEbyo/fhRQgqX/gwPAg/ZCtQC0Wqlzs
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="351189439"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="351189439"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 01:27:23 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="608116093"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="608116093"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 01:27:22 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 2/5] soundwire: stream: use consistent pattern for freeing buffers
Date:   Fri, 13 Jan 2023 17:35:29 +0800
Message-Id: <20230113093532.3872113-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230113093532.3872113-1-yung-chuan.liao@linux.intel.com>
References: <20230113093532.3872113-1-yung-chuan.liao@linux.intel.com>
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

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The code should free the message buffer used for data, the message
structure used for control and assign the latter to NULL. The last
part is missing for multi-link cases, and the order is inconsistent
for single-link cases.

Link: https://github.com/thesofproject/linux/issues/4056
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/stream.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index e0eae0b98267..f27bd37b154d 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -723,8 +723,8 @@ static int sdw_bank_switch(struct sdw_bus *bus, int m_rt_count)
 	}
 
 	if (!multi_link) {
-		kfree(wr_msg);
 		kfree(wbuf);
+		kfree(wr_msg);
 		bus->defer_msg.msg = NULL;
 		bus->params.curr_bank = !bus->params.curr_bank;
 		bus->params.next_bank = !bus->params.next_bank;
@@ -769,6 +769,7 @@ static int sdw_ml_sync_bank_switch(struct sdw_bus *bus)
 	if (bus->defer_msg.msg) {
 		kfree(bus->defer_msg.msg->buf);
 		kfree(bus->defer_msg.msg);
+		bus->defer_msg.msg = NULL;
 	}
 
 	return 0;
@@ -867,6 +868,7 @@ static int do_bank_switch(struct sdw_stream_runtime *stream)
 		if (bus->defer_msg.msg) {
 			kfree(bus->defer_msg.msg->buf);
 			kfree(bus->defer_msg.msg);
+			bus->defer_msg.msg = NULL;
 		}
 	}
 
-- 
2.25.1

