Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815EA6238A2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 02:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbiKJBIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 20:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbiKJBHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 20:07:48 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469BF22503;
        Wed,  9 Nov 2022 17:07:44 -0800 (PST)
Received: from kwepemi500026.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N73bM4f3kzmVnS;
        Thu, 10 Nov 2022 09:07:27 +0800 (CST)
Received: from localhost.localdomain (10.175.104.82) by
 kwepemi500026.china.huawei.com (7.221.188.247) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 09:07:40 +0800
From:   Dong Chenchen <dongchenchen2@huawei.com>
To:     <dan@dlrobertson.com>, <jic23@kernel.org>, <lars@metafoo.de>
CC:     <jagathjog1996@gmail.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>,
        Dong Chenchen <dongchenchen2@huawei.com>
Subject: [Patch] iio: accel: bma400: Fix memory leak in bma400_get_steps_reg()
Date:   Thu, 10 Nov 2022 09:07:26 +0800
Message-ID: <20221110010726.235601-1-dongchenchen2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.82]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500026.china.huawei.com (7.221.188.247)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When regmap_bulk_read() fails, it does not free steps_raw,
which will cause a memory leak issue, this patch fixes it.

Fixes: d221de60eee3 ("iio: accel: bma400: Add separate channel for step counter")
Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
---
 drivers/iio/accel/bma400_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index ad8fce3e08cd..43976cf5a91b 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -805,8 +805,10 @@ static int bma400_get_steps_reg(struct bma400_data *data, int *val)
 
 	ret = regmap_bulk_read(data->regmap, BMA400_STEP_CNT0_REG,
 			       steps_raw, BMA400_STEP_RAW_LEN);
-	if (ret)
+	if (ret) {
+		kfree(steps_raw);
 		return ret;
+	}
 	*val = get_unaligned_le24(steps_raw);
 	kfree(steps_raw);
 	return IIO_VAL_INT;
-- 
2.25.1

