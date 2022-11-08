Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BAA6212E3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 14:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234480AbiKHNnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 08:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234323AbiKHNnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 08:43:51 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEEF12751
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 05:43:50 -0800 (PST)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N68PW4N4jzHqLF;
        Tue,  8 Nov 2022 21:40:47 +0800 (CST)
Received: from dggpemm500008.china.huawei.com (7.185.36.136) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 21:43:47 +0800
Received: from huawei.com (10.67.174.191) by dggpemm500008.china.huawei.com
 (7.185.36.136) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 8 Nov
 2022 21:43:47 +0800
From:   Chen Hui <judy.chenhui@huawei.com>
To:     <vgupta@kernel.org>, <Vladislav.Zakharov@synopsys.com>
CC:     <linux-snps-arc@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <judy.chenhui@huawei.com>
Subject: [PATCH] arch: arc: Fix memory leak in show_cpuinfo()
Date:   Tue, 8 Nov 2022 22:12:41 +0800
Message-ID: <20221108141241.42007-1-judy.chenhui@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.191]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500008.china.huawei.com (7.185.36.136)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "cpu_clk" resource is malloced by clk_get(),
it is not released when the function return.

Fixes: 7f35144cea21 ("ARC: get rate from clk driver instead of reading device tree")
Signed-off-by: Chen Hui <judy.chenhui@huawei.com>
---
 arch/arc/kernel/setup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c
index 41f07b3e594e..9457c7ad8707 100644
--- a/arch/arc/kernel/setup.c
+++ b/arch/arc/kernel/setup.c
@@ -637,6 +637,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 			   cpu_id);
 	} else {
 		freq = clk_get_rate(cpu_clk);
+		clk_put(cpu_clk);
 	}
 	if (freq)
 		seq_printf(m, "CPU speed\t: %lu.%02lu Mhz\n",
-- 
2.17.1

