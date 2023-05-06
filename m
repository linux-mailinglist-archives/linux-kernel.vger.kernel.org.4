Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC096F90D1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 11:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbjEFJL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 05:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjEFJL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 05:11:56 -0400
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9117C1BF4
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 02:11:55 -0700 (PDT)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4QD1yf11sMz8RTWg;
        Sat,  6 May 2023 17:11:54 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.97.17])
        by mse-fl1.zte.com.cn with SMTP id 3469BcJB042686;
        Sat, 6 May 2023 17:11:39 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp02[null])
        by mapi (Zmail) with MAPI id mid31;
        Sat, 6 May 2023 17:11:41 +0800 (CST)
Date:   Sat, 6 May 2023 17:11:41 +0800 (CST)
X-Zmail-TransId: 2afa645619cdfffffffff19-ec7f7
X-Mailer: Zmail v1.0
Message-ID: <202305061711417142802@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <paul.walmsley@sifive.com>
Cc:     <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <guoren@kernel.org>,
        <sergey.matyukevich@syntacore.com>, <dylan@andestech.com>,
        <ajones@ventanamicro.com>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSByaXNjdjogbW06IHVzZSBiaXRtYXBfemVybygpIEFQSQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 3469BcJB042686
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 645619DA.000/4QD1yf11sMz8RTWg
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
 arch/riscv/mm/context.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index 12e22e7330e7..217fd4de6134 100644
--- a/arch/riscv/mm/context.c
+++ b/arch/riscv/mm/context.c
@@ -67,7 +67,7 @@ static void __flush_context(void)
 	lockdep_assert_held(&context_lock);

 	/* Update the list of reserved ASIDs and the ASID bitmap. */
-	bitmap_clear(context_asid_map, 0, num_asids);
+	bitmap_zero(context_asid_map, num_asids);

 	/* Mark already active ASIDs as used */
 	for_each_possible_cpu(i) {
-- 
2.25.1
