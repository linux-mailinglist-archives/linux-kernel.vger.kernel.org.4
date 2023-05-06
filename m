Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12046F909B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 10:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjEFIfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 04:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjEFIf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 04:35:29 -0400
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412F9659F
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 01:35:28 -0700 (PDT)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4QD18Z4Cwvz8RTWg;
        Sat,  6 May 2023 16:35:26 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
        by mse-fl1.zte.com.cn with SMTP id 3468ZJaB010724;
        Sat, 6 May 2023 16:35:19 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp02[null])
        by mapi (Zmail) with MAPI id mid31;
        Sat, 6 May 2023 16:35:22 +0800 (CST)
Date:   Sat, 6 May 2023 16:35:22 +0800 (CST)
X-Zmail-TransId: 2afa6456114affffffffb0e-6c46c
X-Mailer: Zmail v1.0
Message-ID: <202305061635221161194@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <linux@armlinux.org.uk>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBBUk06IG1tOiB1c2UgYml0bWFwX3plcm8oKSBBUEk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 3468ZJaB010724
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6456114E.000/4QD18Z4Cwvz8RTWg
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Xingchen <ye.xingchen@zte.com.cn>

bitmap_zero() is faster than bitmap_clear(), so use bitmap_zero()
instead of bitmap_clear().

Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
---
 arch/arm/mm/context.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/context.c b/arch/arm/mm/context.c
index 4204ffa2d104..2e95a707eb93 100644
--- a/arch/arm/mm/context.c
+++ b/arch/arm/mm/context.c
@@ -139,7 +139,7 @@ static void flush_context(unsigned int cpu)
 	u64 asid;

 	/* Update the list of reserved ASIDs and the ASID bitmap. */
-	bitmap_clear(asid_map, 0, NUM_USER_ASIDS);
+	bitmap_zero(asid_map, NUM_USER_ASIDS);
 	for_each_possible_cpu(i) {
 		asid = atomic64_xchg(&per_cpu(active_asids, i), 0);
 		/*
-- 
2.25.1
