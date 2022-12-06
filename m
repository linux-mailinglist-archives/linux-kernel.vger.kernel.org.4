Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD742643EDF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 09:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbiLFIkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 03:40:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbiLFIkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 03:40:02 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAB4E78;
        Tue,  6 Dec 2022 00:40:00 -0800 (PST)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NRDKT0SrszJp6D;
        Tue,  6 Dec 2022 16:36:29 +0800 (CST)
Received: from huawei.com (10.67.175.83) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 6 Dec
 2022 16:39:58 +0800
From:   ruanjinjie <ruanjinjie@huawei.com>
To:     <robh+dt@kernel.org>, <frowand.list@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH] of: overlay: fix null pointer dereferencing in find_dup_cset_node_entry() and find_dup_cset_prop()
Date:   Tue, 6 Dec 2022 16:36:57 +0800
Message-ID: <20221206083657.3202856-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.83]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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
 drivers/of/overlay.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index bd8ff4df723d..49c066b51148 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -545,6 +545,11 @@ static int find_dup_cset_node_entry(struct overlay_changeset *ovcs,
 
 		fn_1 = kasprintf(GFP_KERNEL, "%pOF", ce_1->np);
 		fn_2 = kasprintf(GFP_KERNEL, "%pOF", ce_2->np);
+		if (!fn_1 || !fn_2) {
+			kfree(fn_1);
+			kfree(fn_2);
+			return -ENOMEM;
+		}
 		node_path_match = !strcmp(fn_1, fn_2);
 		kfree(fn_1);
 		kfree(fn_2);
@@ -580,6 +585,11 @@ static int find_dup_cset_prop(struct overlay_changeset *ovcs,
 
 		fn_1 = kasprintf(GFP_KERNEL, "%pOF", ce_1->np);
 		fn_2 = kasprintf(GFP_KERNEL, "%pOF", ce_2->np);
+		if (!fn_1 || !fn_2) {
+			kfree(fn_1);
+			kfree(fn_2);
+			return -ENOMEM;
+		}
 		node_path_match = !strcmp(fn_1, fn_2);
 		kfree(fn_1);
 		kfree(fn_2);
-- 
2.25.1

