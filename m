Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336A05BFDA1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 14:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiIUMRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 08:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiIUMRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 08:17:50 -0400
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022DBF46;
        Wed, 21 Sep 2022 05:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1663762670; x=1695298670;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FoSrju48YblnYX4Ty9r2bP2vlG4cJThMMYYSTK/n+2o=;
  b=QucOdiLRbGCNcowYiPLufU/9fUI9VcUPmAxH3HiawvRgtgQoGGN41fjd
   z2Xqe9lBnfkDfNzAs1jtb86W+xH7FMmT8h9qgf6OQ976N3oHy09Q3Le1N
   IjdAQQKAG6T2Z8mItbfM1qHfY2kLpObE9fB+7P/ZyIsFTFT0Zklsmpvf2
   Q=;
X-IronPort-AV: E=Sophos;i="5.93,333,1654560000"; 
   d="scan'208";a="132382860"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-b69ea591.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 12:17:27 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1e-b69ea591.us-east-1.amazon.com (Postfix) with ESMTPS id 5735FC0C68;
        Wed, 21 Sep 2022 12:17:25 +0000 (UTC)
Received: from EX19D013UWB002.ant.amazon.com (10.13.138.21) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Wed, 21 Sep 2022 12:17:24 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX19D013UWB002.ant.amazon.com (10.13.138.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Wed, 21 Sep 2022 12:17:24 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP
 Server id 15.0.1497.38 via Frontend Transport; Wed, 21 Sep 2022 12:17:24
 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id F0DC14AF7; Wed, 21 Sep 2022 12:17:23 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <andriy.shevchenko@intel.com>, <sudipm.mukherjee@gmail.com>
CC:     <farbere@amazon.com>, <hhhawa@amazon.com>, <jonnyc@amazon.com>,
        "kernel test robot" <lkp@intel.com>
Subject: [PATCH] hwmon: (mr75203) fix undefined reference to `__divdi3'
Date:   Wed, 21 Sep 2022 12:17:23 +0000
Message-ID: <20220921121723.6726-1-farbere@amazon.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix build error on 32-bit machines.

Fixes: 381a86c545f1 ("hwmon: (mr75203) modify the temperature equation according to series 5 datasheet")
Signed-off-by: Eliav Farber <farbere@amazon.com>
Reported-by: kernel test robot <lkp@intel.com>
---
I will also rework it into the original series (since it's not just a
trivial squash into one previous commit) and you can decide what to use
according to your preference.

 drivers/hwmon/mr75203.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
index 0fea443dc3e1..9c400cf790b5 100644
--- a/drivers/hwmon/mr75203.c
+++ b/drivers/hwmon/mr75203.c
@@ -266,9 +266,9 @@ static long pvt_calc_temp(struct pvt_device *pvt, u32 nbs)
 	struct temp_coeff *ts_coeff = &pvt->ts_coeff;
 
 	s64 tmp = ts_coeff->g +
-		ts_coeff->h * (s64)nbs / ts_coeff->cal5 -
+		div_s64(ts_coeff->h * (s64)nbs, ts_coeff->cal5) -
 		ts_coeff->h / 2 +
-		ts_coeff->j * (s64)pvt->ip_freq / HZ_PER_MHZ;
+		div_s64(ts_coeff->j * (s64)pvt->ip_freq, HZ_PER_MHZ);
 
 	return clamp_val(tmp, PVT_TEMP_MIN_mC, PVT_TEMP_MAX_mC);
 }
-- 
2.37.1

