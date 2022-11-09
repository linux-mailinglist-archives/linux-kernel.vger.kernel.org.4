Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B3F622767
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 10:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiKIJqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 04:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiKIJqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:46:14 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D8322BE4
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 01:46:13 -0800 (PST)
Received: from kwepemi500015.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N6g864XHkzmVpD;
        Wed,  9 Nov 2022 17:45:58 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemi500015.china.huawei.com
 (7.221.188.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 17:46:11 +0800
From:   Wang Wensheng <wangwensheng4@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <rostedt@goodmis.org>,
        <mhiramat@kernel.org>, <mark.rutland@arm.com>
CC:     <xuqiang36@huawei.com>, <weiyongjun1@huawei.com>,
        <wangwensheng4@huawei.com>
Subject: [PATCH -next 3/3] ftrace: Delete unused variable ftrace_update_time
Date:   Wed, 9 Nov 2022 09:44:34 +0000
Message-ID: <20221109094434.84046-4-wangwensheng4@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221109094434.84046-1-wangwensheng4@huawei.com>
References: <20221109094434.84046-1-wangwensheng4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500015.china.huawei.com (7.221.188.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ftrace_update_time is not used anywhere else after initialization. So
delete it together with its initial code.

Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
---
 kernel/trace/ftrace.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 43a958b28022..3e102c44b117 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3110,7 +3110,6 @@ int ftrace_shutdown(struct ftrace_ops *ops, int command)
 	return 0;
 }
 
-static u64		ftrace_update_time;
 unsigned long		ftrace_update_tot_cnt;
 unsigned long		ftrace_number_of_pages;
 unsigned long		ftrace_number_of_groups;
@@ -3130,13 +3129,10 @@ static int ftrace_update_code(struct module *mod, struct ftrace_page *new_pgs)
 	bool init_nop = ftrace_need_init_nop();
 	struct ftrace_page *pg;
 	struct dyn_ftrace *p;
-	u64 start, stop;
 	unsigned long update_cnt = 0;
 	unsigned long rec_flags = 0;
 	int i;
 
-	start = ftrace_now(raw_smp_processor_id());
-
 	/*
 	 * When a module is loaded, this function is called to convert
 	 * the calls to mcount in its text to nops, and also to create
@@ -3173,8 +3169,6 @@ static int ftrace_update_code(struct module *mod, struct ftrace_page *new_pgs)
 		}
 	}
 
-	stop = ftrace_now(raw_smp_processor_id());
-	ftrace_update_time = stop - start;
 	ftrace_update_tot_cnt += update_cnt;
 
 	return 0;
-- 
2.17.1

