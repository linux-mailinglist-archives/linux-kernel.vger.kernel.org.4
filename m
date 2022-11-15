Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1F2628F7D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 02:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbiKOBr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 20:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiKOBr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 20:47:56 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D1317421
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 17:47:55 -0800 (PST)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NB8F80DcdzHvtb;
        Tue, 15 Nov 2022 09:47:24 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 09:47:53 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <beaub@linux.microsoft.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] tracing/user_events: Fix memory leak in user_event_create()
Date:   Tue, 15 Nov 2022 09:44:45 +0800
Message-ID: <20221115014445.158419-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before current_user_event_group(), it has allocated memory and save it
in @name, this should freed before return error.

Fixes: e5d271812e7a ("tracing/user_events: Move pages/locks into groups to prepare for namespaces")
Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 kernel/trace/trace_events_user.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index ae78c2d53c8a..539b08ae7020 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1100,8 +1100,10 @@ static int user_event_create(const char *raw_command)
 
 	group = current_user_event_group();
 
-	if (!group)
+	if (!group) {
+		kfree(name);
 		return -ENOENT;
+	}
 
 	mutex_lock(&group->reg_mutex);
 
-- 
2.17.1

