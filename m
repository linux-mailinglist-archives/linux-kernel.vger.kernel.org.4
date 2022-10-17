Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E1E6009BB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiJQJAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbiJQJA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:00:26 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3205D1C429
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 02:00:19 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MrW6c6SnXz1P7DS;
        Mon, 17 Oct 2022 16:55:36 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 17 Oct 2022 17:00:17 +0800
Received: from huawei.com (10.175.100.227) by kwepemm600008.china.huawei.com
 (7.193.23.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 17:00:17 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <rostedt@goodmis.org>, <acme@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     <namhyung@kernel.org>, <shangxiaojing@huawei.com>
Subject: [PATCH] tools lib traceevent: Fix double free in event_read_fields()
Date:   Mon, 17 Oct 2022 16:59:37 +0800
Message-ID: <20221017085937.8583-1-shangxiaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600008.china.huawei.com (7.193.23.88)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a double free in event_read_fields(). After calling free_token()
to free the token, if append() failed, then goto fail, which will call
free_token() again. Triggered by compiling with perf and run "perf sched
record". Fix the double free by goto fail_expect instead of fail while
append() failed, which won't call redundant free_token().

BUG: double free
free(): double free detected in tcache 2
Aborted

Fixes: d286447f23cd ("tools lib traceevent: Handle realloc() failure path")
Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
---
 tools/lib/traceevent/event-parse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 8e24c4c78c7f..e0a5a22fe702 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -1594,7 +1594,7 @@ static int event_read_fields(struct tep_event *event, struct tep_format_field **
 			ret = append(&brackets, "", "]");
 			if (ret < 0) {
 				free(brackets);
-				goto fail;
+				goto fail_expect;
 			}
 
 			/* add brackets to type */
-- 
2.17.1

