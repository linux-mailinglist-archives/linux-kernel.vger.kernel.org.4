Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA537134C3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 14:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbjE0MgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 08:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbjE0MgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 08:36:11 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3A91BB
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 05:35:51 -0700 (PDT)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QT1V75096zTkf3;
        Sat, 27 May 2023 20:35:43 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 27 May 2023 20:35:47 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Eric Biederman <ebiederm@xmission.com>,
        Baoquan He <bhe@redhat.com>, <kexec@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amerigo Wang <amwang@redhat.com>
Subject: [PATCH 2/6] kexec: delete a useless check in crash_shrink_memory()
Date:   Sat, 27 May 2023 20:34:35 +0800
Message-ID: <20230527123439.772-3-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20230527123439.772-1-thunder.leizhen@huawei.com>
References: <20230527123439.772-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The check '(crashk_res.parent != NULL)' is added by
commit e05bd3367bd3 ("kexec: fix Oops in crash_shrink_memory()"), but it's
stale now. Because if 'crashk_res' is not reserved, it will be zero in
size and will be intercepted by the above 'if (new_size >= old_size)'.

Ago:
	if (new_size >= end - start + 1)

Now:
	old_size = (end == 0) ? 0 : end - start + 1;
	if (new_size >= old_size)

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 kernel/kexec_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 22acee18195a591..d1ab139dd49035e 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1137,7 +1137,7 @@ int crash_shrink_memory(unsigned long new_size)
 	end = start + new_size;
 	crash_free_reserved_phys_range(end, crashk_res.end);
 
-	if ((start == end) && (crashk_res.parent != NULL))
+	if (start == end)
 		release_resource(&crashk_res);
 
 	ram_res->start = end;
-- 
2.25.1

