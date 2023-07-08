Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BEE74BCE9
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 10:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjGHI5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 04:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjGHI5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 04:57:33 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1A51FEE
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 01:57:31 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QykbZ0mThztQRv;
        Sat,  8 Jul 2023 16:54:34 +0800 (CST)
Received: from huawei.com (10.174.151.185) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 8 Jul
 2023 16:57:28 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 1/8] mm: memory-failure: fix potential permanently locked hpage
Date:   Sat, 8 Jul 2023 16:57:37 +0800
Message-ID: <20230708085744.3599311-2-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230708085744.3599311-1-linmiaohe@huawei.com>
References: <20230708085744.3599311-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If hpage isn't Hugetlb page, MF_DELAYED is returned without unlock hpage
leading to hpage permanently locked. But this shouldn't trigger in the
real world because this PageHuge() check is just for potential problems.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index a6221a4bc5ea..d21ee27ad412 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1187,8 +1187,10 @@ static int me_huge_page(struct page_state *ps, struct page *p)
 	struct address_space *mapping;
 	bool extra_pins = false;
 
-	if (!PageHuge(hpage))
+	if (!PageHuge(hpage)) {
+		unlock_page(hpage);
 		return MF_DELAYED;
+	}
 
 	mapping = page_mapping(hpage);
 	if (mapping) {
-- 
2.33.0

