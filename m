Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2E76491FC
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 03:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiLKCgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 21:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiLKCgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 21:36:38 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161D313E31;
        Sat, 10 Dec 2022 18:36:37 -0800 (PST)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NV84s2916z15N1r;
        Sun, 11 Dec 2022 10:35:41 +0800 (CST)
Received: from huawei.com (10.67.175.83) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 11 Dec
 2022 10:36:34 +0800
From:   ruanjinjie <ruanjinjie@huawei.com>
To:     <robh+dt@kernel.org>, <frowand.list@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH v2] of: overlay: fix null pointer dereferencing in find_dup_cset_node_entry() and find_dup_cset_prop()
Date:   Sun, 11 Dec 2022 10:33:37 +0800
Message-ID: <20221211023337.592266-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.83]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when kmalloc() fail to allocate memory in kasprintf(), fn_1 or fn_2 will
be NULL, strcmp() will cause null pointer dereference.

Fixes: 2fe0e8769df9 ("of: overlay: check prevents multiple fragments touching same property")
Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
---
v2:
- not care return code, so check whether fn_1 or fn_2 is NULL in assigning node_path_match
---
 drivers/of/overlay.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index bd8ff4df723d..ed4e6c144a68 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -545,7 +545,7 @@ static int find_dup_cset_node_entry(struct overlay_changeset *ovcs,
 
 		fn_1 = kasprintf(GFP_KERNEL, "%pOF", ce_1->np);
 		fn_2 = kasprintf(GFP_KERNEL, "%pOF", ce_2->np);
-		node_path_match = !strcmp(fn_1, fn_2);
+		node_path_match = !fn_1 || !fn_2 || !strcmp(fn_1, fn_2);
 		kfree(fn_1);
 		kfree(fn_2);
 		if (node_path_match) {
@@ -580,7 +580,7 @@ static int find_dup_cset_prop(struct overlay_changeset *ovcs,
 
 		fn_1 = kasprintf(GFP_KERNEL, "%pOF", ce_1->np);
 		fn_2 = kasprintf(GFP_KERNEL, "%pOF", ce_2->np);
-		node_path_match = !strcmp(fn_1, fn_2);
+		node_path_match = !fn_1 || !fn_2 || !strcmp(fn_1, fn_2);
 		kfree(fn_1);
 		kfree(fn_2);
 		if (node_path_match &&
-- 
2.25.1

