Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17015EBA70
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 08:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiI0GSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 02:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiI0GSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 02:18:17 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550C65E30F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 23:18:15 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mc8TL4dXSzlXG0;
        Tue, 27 Sep 2022 14:13:58 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 14:18:13 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 14:18:13 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Russell King <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v3] ARM: mm: Provide better message when kernel fault
Date:   Tue, 27 Sep 2022 14:21:34 +0800
Message-ID: <20220927062134.99019-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <YzF7X2PBdps2MaG/@shell.armlinux.org.uk>
References: <YzF7X2PBdps2MaG/@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there is a kernel fault, see do_kernel_fault(), we only print
the generic "paging request" or "NULL pointer dereference" message
which don't show read, write or excute information, let's provide
better fault message for them.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
v3: show the infos in die_kernel_fault()
 arch/arm/mm/fault.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 46cccd6bf705..f8fe0ec64c23 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -111,8 +111,9 @@ static void die_kernel_fault(const char *msg, struct mm_struct *mm,
 {
 	bust_spinlocks(1);
 	pr_alert("8<--- cut here ---\n");
-	pr_alert("Unable to handle kernel %s at virtual address %08lx\n",
-		 msg, addr);
+	pr_alert("Unable to handle kernel %s at virtual address %08lx when %s\n",
+		 msg, addr, fsr & FSR_LNX_PF ? "execute" :
+		 fsr & FSR_WRITE ? "write" : "read");
 
 	show_pte(KERN_ALERT, mm, addr);
 	die("Oops", regs, fsr);
-- 
2.35.3

