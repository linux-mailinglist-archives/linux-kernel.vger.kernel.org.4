Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0601A5B679E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 08:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiIMGIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 02:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiIMGIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 02:08:20 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8965A326E7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 23:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663049299; x=1694585299;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Y7VhadoA018q59bn5ZPzWPazPOfvofoB2SRsB0RygtQ=;
  b=iY2QhdYdpIw/hC7sgY08ykK3Sz/vzoEJscOAmAkjBk2VZxCDyctX44nH
   Xw6QwG4iH/gr/Rj0smc+BPIPc1I4BMf1zCP/uM0+QRRs8JWQygxH5nCKd
   QxugP0LSTM5N7k0uOjJe8mjbaGJchpZI16L8cUTZiFVEnBYsgSLIW5V0Y
   p7zWzoFKKYGl16sioibpIBjPf77fq72yk3CxTJCslvtR4tgK5uA1yyap/
   DEYzDg9V5w4swSHbaH9Vn//yj6CaRetv++XzkOugueb7zkpWKok892XLu
   WF3OkIcMc4ntNjSDrv9VGgUPtqDHwFN/MOpr3+52C9j/zEw2Su9tFUAbh
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="299386369"
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="299386369"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 23:08:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="612020816"
Received: from pglc0392.png.intel.com ([10.221.87.70])
  by orsmga007.jf.intel.com with ESMTP; 12 Sep 2022 23:08:17 -0700
From:   adrian.ho.yin.ng@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org, adrian.ho.yin.ng@intel.com
Subject: [PATCH] firmware: stratix10-svc: increase args array
Date:   Tue, 13 Sep 2022 14:08:15 +0800
Message-Id: <20220913060815.27025-1-adrian.ho.yin.ng@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Ng Ho Yin <adrian.ho.yin.ng@intel.com>

Increase args array from 3 to 6, which is used for args to be passed
via registers and not physically mapped buffer.

Signed-off-by: Adrian Ng Ho Yin <adrian.ho.yin.ng@intel.com>
---
 drivers/firmware/stratix10-svc.c                    | 5 ++++-
 include/linux/firmware/intel/stratix10-svc-client.h | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index b4081f4d88a3..580494fb187f 100644
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
@@ -997,6 +997,9 @@ int stratix10_svc_send(struct stratix10_svc_chan *chan, void *msg)
 	p_data->arg[0] = p_msg->arg[0];
 	p_data->arg[1] = p_msg->arg[1];
 	p_data->arg[2] = p_msg->arg[2];
+	p_data->arg[3] = p_msg->arg[3];
+	p_data->arg[4] = p_msg->arg[4];
+	p_data->arg[5] = p_msg->arg[5];
 	p_data->size = p_msg->payload_length;
 	p_data->chan = chan;
 	pr_debug("%s: put to FIFO pa=0x%016x, cmd=%x, size=%u\n", __func__,
diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
index 0c16037fd08d..24bbcbc6ec67 100644
--- a/include/linux/firmware/intel/stratix10-svc-client.h
+++ b/include/linux/firmware/intel/stratix10-svc-client.h
@@ -183,7 +183,7 @@ struct stratix10_svc_client_msg {
 	void *payload_output;
 	size_t payload_length_output;
 	enum stratix10_svc_command_code command;
-	u64 arg[3];
+	u64 arg[6];
 };

 /**
--
2.25.1

