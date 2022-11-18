Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CF962F303
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 11:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241154AbiKRKyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 05:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbiKRKyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 05:54:50 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16509151B;
        Fri, 18 Nov 2022 02:54:48 -0800 (PST)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NDDDs5V2LzmVvk;
        Fri, 18 Nov 2022 18:54:21 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemi500024.china.huawei.com
 (7.221.188.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 18 Nov
 2022 18:54:46 +0800
From:   Zeng Heng <zengheng4@huawei.com>
To:     <frowand.list@gmail.com>, <pantelis.antoniou@konsulko.com>,
        <grant.likely@linaro.org>, <robh+dt@kernel.org>
CC:     <liwei391@huawei.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] of: overlay: fix memory leak in add_changeset_node()
Date:   Fri, 18 Nov 2022 18:53:08 +0800
Message-ID: <20221118105308.370474-1-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500024.china.huawei.com (7.221.188.100)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In of_changeset_action(), we have called of_node_get() to increase
refcount of a node.

Therefore, when tchild (duplicated by __of_node_dup()) is done,
of_node_put() needs to call and release the device_node.

Otherwise, there are some memory leak reported about the node:

unreferenced object 0xffff88810cd1e800 (size 256):
  backtrace:
    kmalloc_trace
    __of_node_dup
    add_changeset_node (inlined)
    build_changeset_next_level

unreferenced object 0xffff888113721240 (size 16):
  backtrace:
    __kmalloc_node_track_caller
    kstrdup
    __of_node_dup
    add_changeset_node (inlined)
    build_changeset_next_level

unreferenced object 0xffff88810a38d400 (size 128):
  backtrace:
    kmalloc_trace
    __of_prop_dup
    add_changeset_property
    build_changeset_next_level

Fixes: 7518b5890d8a ("of/overlay: Introduce DT overlay support")
Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 drivers/of/overlay.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index bd8ff4df723d..a5189a0ec0a3 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -436,8 +436,10 @@ static int add_changeset_node(struct overlay_changeset *ovcs,
 		of_node_set_flag(tchild, OF_OVERLAY);
 
 		ret = of_changeset_attach_node(&ovcs->cset, tchild);
-		if (ret)
+		if (ret) {
+			of_node_put(tchild);
 			return ret;
+		}
 
 		target_child.np = tchild;
 		target_child.in_livetree = false;
-- 
2.25.1

