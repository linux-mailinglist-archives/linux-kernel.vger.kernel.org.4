Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65776F909F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 10:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbjEFIgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 04:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjEFIgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 04:36:41 -0400
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE60659F
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 01:36:40 -0700 (PDT)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4QD19z10Nwz5B15R;
        Sat,  6 May 2023 16:36:39 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.97.17])
        by mse-fl1.zte.com.cn with SMTP id 3468aSm2011905;
        Sat, 6 May 2023 16:36:28 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp02[null])
        by mapi (Zmail) with MAPI id mid31;
        Sat, 6 May 2023 16:36:31 +0800 (CST)
Date:   Sat, 6 May 2023 16:36:31 +0800 (CST)
X-Zmail-TransId: 2afa6456118fffffffffc0a-70564
X-Mailer: Zmail v1.0
Message-ID: <202305061636313011243@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <broonie@kernel.org>
Cc:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <kristina.martsenko@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBhcm02NDogbW06IHVzZSBiaXRtYXBfemVybygpIEFQSQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 3468aSm2011905
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 64561197.000/4QD19z10Nwz5B15R
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
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
 arch/arm64/mm/context.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index e1e0dca01839..ed0bf7f8e8ce 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -95,7 +95,7 @@ static void set_reserved_asid_bits(void)
 	else if (arm64_kernel_unmapped_at_el0())
 		set_kpti_asid_bits(asid_map);
 	else
-		bitmap_clear(asid_map, 0, NUM_USER_ASIDS);
+		bitmap_zero(asid_map, NUM_USER_ASIDS);
 }

 #define asid_gen_match(asid) \
-- 
2.25.1
