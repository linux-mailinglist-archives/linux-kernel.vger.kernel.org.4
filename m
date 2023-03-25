Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4823B6C8BB0
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 07:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbjCYGYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 02:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbjCYGYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 02:24:31 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1FA1517B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 23:24:26 -0700 (PDT)
Received: from dggpemm100009.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Pk8941xq1znY0n;
        Sat, 25 Mar 2023 14:21:12 +0800 (CST)
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Sat, 25 Mar
 2023 14:24:22 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Christoph Hellwig <hch@lst.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next v7 2/4] mm/zswap: skip invalid or unchanged parameter
Date:   Sat, 25 Mar 2023 15:14:18 +0800
Message-ID: <20230325071420.2246461-3-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230325071420.2246461-1-liushixin2@huawei.com>
References: <20230325071420.2246461-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If parameter is invalid or no change required, return directly. This can
reduces unnecessary printing.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 mm/zswap.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 6d2b879f091e..d2adc1ffe47d 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -761,15 +761,15 @@ static int __zswap_param_set(const char *val, const struct kernel_param *kp,
 	char *s = strstrip((char *)val);
 	int ret;
 
+	/* no change required */
+	if (!strcmp(s, *(char **)kp->arg) && zswap_has_pool)
+		return 0;
+
 	if (zswap_init_failed) {
 		pr_err("can't set param, initialization failed\n");
 		return -ENODEV;
 	}
 
-	/* no change required */
-	if (!strcmp(s, *(char **)kp->arg) && zswap_has_pool)
-		return 0;
-
 	/* if this is load-time (pre-init) param setting,
 	 * don't create a pool; that's done during init.
 	 */
@@ -864,6 +864,15 @@ static int zswap_zpool_param_set(const char *val,
 static int zswap_enabled_param_set(const char *val,
 				   const struct kernel_param *kp)
 {
+	bool res;
+
+	if (kstrtobool(val, &res))
+		return -EINVAL;
+
+	/* no change required */
+	if (res == *(bool *)kp->arg)
+		return 0;
+
 	if (zswap_init_failed) {
 		pr_err("can't enable, initialization failed\n");
 		return -ENODEV;
-- 
2.25.1

