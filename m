Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D144E6D0024
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 11:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjC3Jsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 05:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjC3JsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 05:48:19 -0400
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EA693E0;
        Thu, 30 Mar 2023 02:47:24 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0Vf-9mI6_1680169623;
Received: from srmbuffer011165236051.sqa.net(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0Vf-9mI6_1680169623)
          by smtp.aliyun-inc.com;
          Thu, 30 Mar 2023 17:47:11 +0800
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ruidong Tian <tianruidong@linux.alibaba.com>
Subject: [PATCH] perf/arm-cmn: fix regitster offset of CMN_MXP__CONNECT_INFO_P2-5
Date:   Thu, 30 Mar 2023 17:47:00 +0800
Message-Id: <1680169620-26012-1-git-send-email-renyu.zj@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the CMN700 specification, it is described that the address offset
of the mxp_device_connect_info_p0-5 register is 16'h8 + #{8*index}.
Therefore, the address offset of the CMN_MXP__CONNECT_INFO_P2-5 macro
defined in the code is wrong, which causes the cmn700 topology map
incorrect printed in debugfs.

So correct the address offset value to make the cmn700 topology map
correct in debugfs.

Fixes: 60d1504070c2 ("perf/arm-cmn: Support new IP features")
Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 drivers/perf/arm-cmn.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 1deb61b..e9f844b 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -59,10 +59,10 @@
 /* XPs also have some local topology info which has uses too */
 #define CMN_MXP__CONNECT_INFO_P0	0x0008
 #define CMN_MXP__CONNECT_INFO_P1	0x0010
-#define CMN_MXP__CONNECT_INFO_P2	0x0028
-#define CMN_MXP__CONNECT_INFO_P3	0x0030
-#define CMN_MXP__CONNECT_INFO_P4	0x0038
-#define CMN_MXP__CONNECT_INFO_P5	0x0040
+#define CMN_MXP__CONNECT_INFO_P2	0x0018
+#define CMN_MXP__CONNECT_INFO_P3	0x0020
+#define CMN_MXP__CONNECT_INFO_P4	0x0028
+#define CMN_MXP__CONNECT_INFO_P5	0x0030
 #define CMN__CONNECT_INFO_DEVICE_TYPE	GENMASK_ULL(4, 0)
 
 /* PMU registers occupy the 3rd 4KB page of each node's region */
-- 
1.8.3.1

