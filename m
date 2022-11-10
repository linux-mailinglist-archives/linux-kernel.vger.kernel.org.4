Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4416462403C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 11:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbiKJKr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 05:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKJKr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 05:47:57 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FE654B0C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 02:47:56 -0800 (PST)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N7JNr3x33zpWMc;
        Thu, 10 Nov 2022 18:44:12 +0800 (CST)
Received: from kwepemm600014.china.huawei.com (7.193.23.54) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 18:47:54 +0800
Received: from ubuntu1804.huawei.com (10.67.175.28) by
 kwepemm600014.china.huawei.com (7.193.23.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 18:47:53 +0800
From:   Yi Yang <yiyang13@huawei.com>
To:     <rostedt@goodmis.org>, <mhiramat@kernel.org>, <ast@kernel.org>,
        <yiyang13@huawei.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix a potential memleak in rethook_alloc()
Date:   Thu, 10 Nov 2022 18:44:38 +0800
Message-ID: <20221110104438.88099-1-yiyang13@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.28]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600014.china.huawei.com (7.193.23.54)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In rethook_alloc(), the variable rh is not freed or passed out
if handler is NULL, which could lead to a memleak, fix it.

Fixes: 54ecbe6f1ed5 ("rethook: Add a generic return hook")
Signed-off-by: Yi Yang <yiyang13@huawei.com>
---
 kernel/trace/rethook.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
index 01df98db2fbe..f50aebc7698e 100644
--- a/kernel/trace/rethook.c
+++ b/kernel/trace/rethook.c
@@ -91,8 +91,10 @@ struct rethook *rethook_alloc(void *data, rethook_handler_t handler, gfp_t gfp,
 {
 	struct rethook *rh = kzalloc(sizeof(struct rethook), GFP_KERNEL);
 
-	if (!rh || !handler)
+	if (!rh || !handler) {
+		kfree(rh);
 		return NULL;
+	}
 
 	rh->data = data;
 	rh->handler = handler;
-- 
2.17.1

