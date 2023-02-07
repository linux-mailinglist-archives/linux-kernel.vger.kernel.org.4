Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F1168D026
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 08:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjBGHJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 02:09:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjBGHJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 02:09:08 -0500
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46521423C;
        Mon,  6 Feb 2023 23:09:06 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vb64zFn_1675753742;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0Vb64zFn_1675753742)
          by smtp.aliyun-inc.com;
          Tue, 07 Feb 2023 15:09:03 +0800
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
To:     axboe@kernel.dk, ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com,
        Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Subject: [PATCH RESEND 2/3] ublk: mention WRITE_ZEROES in comment of ublk_complete_rq()
Date:   Tue,  7 Feb 2023 15:08:38 +0800
Message-Id: <20230207070839.370817-3-ZiyangZhang@linux.alibaba.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20230207070839.370817-1-ZiyangZhang@linux.alibaba.com>
References: <20230207070839.370817-1-ZiyangZhang@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WRITE_ZEROES won't return bytes returned just like FLUSH and DISCARD,
and we can end it directly. Add missing comment for it in
ublk_complete_rq().

Signed-off-by: Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
---
 drivers/block/ublk_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 55fccce68a9c..06eddefdf02a 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -665,7 +665,7 @@ static void ublk_complete_rq(struct request *req)
 	}
 
 	/*
-	 * FLUSH or DISCARD usually won't return bytes returned, so end them
+	 * FLUSH, DISCARD or WRITE_ZEROES usually won't return bytes returned, so end them
 	 * directly.
 	 *
 	 * Both the two needn't unmap.
-- 
2.18.4

