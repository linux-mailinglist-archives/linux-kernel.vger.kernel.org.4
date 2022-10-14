Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57925FE6C0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 04:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiJNCA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 22:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiJNCAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 22:00:47 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196B87CE37
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 19:00:45 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MpTzb3Q87zpVwV;
        Fri, 14 Oct 2022 09:57:31 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 14 Oct 2022 10:00:44 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 14 Oct 2022 10:00:43 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v3 2/3] ARM: Refactor dump_instr()
Date:   Fri, 14 Oct 2022 09:59:55 +0800
Message-ID: <20221014015956.2006-3-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20221014015956.2006-1-thunder.leizhen@huawei.com>
References: <20221014015956.2006-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Rename local variable 'val16' to 'tmp'. So that the processing
   statements of thumb and arm can be aligned.
2. Prepare for the next patch to avoid repeated judgment.
   Before:
   if (!user_mode(regs)) {
           if (thumb)
           else
   } else {
           if (thumb)
           else
   }

   After:
   if (thumb) {
           if (user_mode(regs))
           else
   } else {
           if (user_mode(regs))
           else
   }

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm/kernel/traps.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index d455c97237e2079..182469a5b28a394 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -178,19 +178,20 @@ static void dump_instr(const char *lvl, struct pt_regs *regs)
 	for (i = -4; i < 1 + !!thumb; i++) {
 		unsigned int val, bad;
 
-		if (!user_mode(regs)) {
-			if (thumb) {
-				u16 val16;
-				bad = get_kernel_nofault(val16, &((u16 *)addr)[i]);
-				val = val16;
-			} else {
-				bad = get_kernel_nofault(val, &((u32 *)addr)[i]);
-			}
-		} else {
-			if (thumb)
-				bad = get_user(val, &((u16 __user *)addr)[i]);
+		if (thumb) {
+			u16 tmp;
+
+			if (user_mode(regs))
+				bad = get_user(tmp, &((u16 __user *)addr)[i]);
 			else
+				bad = get_kernel_nofault(tmp, &((u16 *)addr)[i]);
+
+			val = tmp;
+		} else {
+			if (user_mode(regs))
 				bad = get_user(val, &((u32 __user *)addr)[i]);
+			else
+				bad = get_kernel_nofault(val, &((u32 *)addr)[i]);
 		}
 
 		if (!bad)
-- 
2.25.1

