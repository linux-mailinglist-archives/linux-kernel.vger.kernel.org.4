Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76F9622C6C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 14:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiKINdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 08:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiKINc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 08:32:58 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A644B2EF39
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 05:32:56 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4N6m9z25qSz8QrkZ;
        Wed,  9 Nov 2022 21:32:55 +0800 (CST)
Received: from szxlzmapp01.zte.com.cn ([10.5.231.85])
        by mse-fl2.zte.com.cn with SMTP id 2A9DWnZt099946;
        Wed, 9 Nov 2022 21:32:49 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp03[null])
        by mapi (Zmail) with MAPI id mid14;
        Wed, 9 Nov 2022 21:32:53 +0800 (CST)
Date:   Wed, 9 Nov 2022 21:32:53 +0800 (CST)
X-Zmail-TransId: 2b05636bac05ffffffff8eb2a033
X-Mailer: Zmail v1.0
Message-ID: <202211092132530746481@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <xu.panda@zte.com.cn>, <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIGJsb2NrOiB1c2Ugc3Ryc2NweSgpIGlzIG1vcmUgcm9idXN0IGFuZCBzYWZlcg==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2A9DWnZt099946
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 636BAC07.000 by FangMail milter!
X-FangMail-Envelope: 1668000775/4N6m9z25qSz8QrkZ/636BAC07.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 636BAC07.000/4N6m9z25qSz8QrkZ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu Panda <xu.panda@zte.com.cn>

The implementation of strscpy() is more robust and safer.
That's now the recommended way to copy NUL terminated strings.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
Signed-off-by: Yang Yang <yang.yang29@zte.com>
---
 block/elevator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/elevator.c b/block/elevator.c
index a5bdc3b1e7e5..0885b66c3868 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -749,7 +749,7 @@ ssize_t elv_iosched_store(struct request_queue *q, const char *buf,
 	if (!elv_support_iosched(q))
 		return count;

-	strlcpy(elevator_name, buf, sizeof(elevator_name));
+	strscpy(elevator_name, buf, sizeof(elevator_name));
 	ret = elevator_change(q, strstrip(elevator_name));
 	if (!ret)
 		return count;
-- 
2.15.2
