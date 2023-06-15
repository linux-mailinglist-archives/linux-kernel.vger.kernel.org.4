Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833A273192E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 14:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245313AbjFOMuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 08:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240680AbjFOMtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 08:49:47 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D78C212B;
        Thu, 15 Jun 2023 05:49:45 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Qhhrc2k6dzpW4f;
        Thu, 15 Jun 2023 20:47:12 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 15 Jun
 2023 20:49:42 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] net: sched: Remove unused qdisc_l2t()
Date:   Thu, 15 Jun 2023 20:48:10 +0800
Message-ID: <20230615124810.34020-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is unused since switch to psched_l2t_ns().

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 include/net/sch_generic.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 12eadecf8cd0..e92f73bb3198 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -1190,20 +1190,6 @@ static inline int qdisc_drop_all(struct sk_buff *skb, struct Qdisc *sch,
 	return NET_XMIT_DROP;
 }
 
-/* Length to Time (L2T) lookup in a qdisc_rate_table, to determine how
-   long it will take to send a packet given its size.
- */
-static inline u32 qdisc_l2t(struct qdisc_rate_table* rtab, unsigned int pktlen)
-{
-	int slot = pktlen + rtab->rate.cell_align + rtab->rate.overhead;
-	if (slot < 0)
-		slot = 0;
-	slot >>= rtab->rate.cell_log;
-	if (slot > 255)
-		return rtab->data[255]*(slot >> 8) + rtab->data[slot & 0xFF];
-	return rtab->data[slot];
-}
-
 struct psched_ratecfg {
 	u64	rate_bytes_ps; /* bytes per second */
 	u32	mult;
-- 
2.34.1

