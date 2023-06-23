Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C7E73AF05
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 05:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjFWDWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 23:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbjFWDVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 23:21:48 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488F926A8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 20:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687490496; x=1719026496;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bv5AUhZ1u35oQiaSgzYVL8SY0P2BMsU+aJWWHHTUqN8=;
  b=TkzEoEIySSC5kC3m5xgyt0OL4yYB2ZyKGaoXwOSbR+Ws4L88YBiMQNtl
   NFEvfwLxWOsSOAhMQfZKzep/jhGftgwnTckzwBZSXm+QVqx6bgLQ3v9ie
   Sjlcu1nP9AL5Mpt7m9Kb1z9KeMSwX2lm5islb6KPVtUmbL4FKQeKdO13l
   4qxiIPs91mJAhX5FO+umaM5LPa9O2ylCvXwlO1jSRc3hkesiZO/gj3BqU
   5zEYz/xngbSU4p3iJ/UEjzSt1hsb0B77kE9ClbtsUY0UqpD1vl7yCF1v5
   XJE6oVeyRo26joVpzOI6su0RP/cVl/AZ+0AmTOl0O+yNjdefi0Qa2sUKA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="359539561"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="359539561"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 20:21:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="692526450"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="692526450"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.90])
  by orsmga006.jf.intel.com with ESMTP; 22 Jun 2023 20:21:34 -0700
From:   tien.sung.ang@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Ang Tien Sung <tien.sung.ang@intel.com>
Subject: [PATCH 04/12] firmware: stratix10-svc: increase msg arg size
Date:   Fri, 23 Jun 2023 11:20:21 +0800
Message-Id: <20230623032029.1755017-5-tien.sung.ang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230623032029.1755017-1-tien.sung.ang@intel.com>
References: <20230623032029.1755017-1-tien.sung.ang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ang Tien Sung <tien.sung.ang@intel.com>

Increase args array from 3 to 6, which is used for args to be passed
via registers and not physically mapped buffer. This is to cater
for the new SDM crypto commands that requires the extra arguments
to contain the physical address of shared buffers.

Signed-off-by: Ang Tien Sung <tien.sung.ang@intel.com>
---
 drivers/firmware/stratix10-svc.c                    | 6 ++++--
 include/linux/firmware/intel/stratix10-svc-client.h | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index d7a11f7a43f3..37f188a1e927 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -117,7 +117,7 @@ struct stratix10_svc_data {
 	size_t size_output;
 	u32 command;
 	u32 flag;
-	u64 arg[3];
+	u64 arg[6];
 };
 
 /**
@@ -1084,7 +1084,9 @@ int stratix10_svc_send(struct stratix10_svc_chan *chan, void *msg)
 	p_data->arg[0] = p_msg->arg[0];
 	p_data->arg[1] = p_msg->arg[1];
 	p_data->arg[2] = p_msg->arg[2];
-	p_data->size = p_msg->payload_length;
+	p_data->arg[3] = p_msg->arg[3];
+	p_data->arg[4] = p_msg->arg[4];
+	p_data->arg[5] = p_msg->arg[5];
 	p_data->chan = chan;
 	pr_debug("%s: put to FIFO pa=0x%016x, cmd=%x, size=%u\n", __func__,
 	       (unsigned int)p_data->paddr, p_data->command,
diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
index 2d4a016468ae..bdcdc895993d 100644
--- a/include/linux/firmware/intel/stratix10-svc-client.h
+++ b/include/linux/firmware/intel/stratix10-svc-client.h
@@ -216,7 +216,7 @@ struct stratix10_svc_client_msg {
 	void *payload_output;
 	size_t payload_length_output;
 	enum stratix10_svc_command_code command;
-	u64 arg[3];
+	u64 arg[6];
 };
 
 /**
-- 
2.25.1

