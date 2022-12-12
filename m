Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7616497E2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 03:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiLLCLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 21:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbiLLCLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 21:11:35 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B2B2C2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 18:11:34 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NVlQP0LmTzJpH2;
        Mon, 12 Dec 2022 10:07:57 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 12 Dec 2022 10:11:32 +0800
From:   Wang Yufen <wangyufen@huawei.com>
To:     <akinobu.mita@gmail.com>, <akpm@linux-foundation.org>,
        <nathan@kernel.org>, <peterz@infradead.org>,
        <keescook@chromium.org>, <ndesaulniers@google.com>,
        <jpoimboe@kernel.org>, <dan.j.williams@intel.com>,
        <ojeda@kernel.org>, <isabbasso@riseup.net>, <vbabka@suse.cz>,
        <linux@rasmusvillemoes.dk>
CC:     <linux-kernel@vger.kernel.org>, <weiyongjun1@huawei.com>
Subject: [PATCH -next v2 2/4] fault-injection: skip stacktrace filtering by default
Date:   Mon, 12 Dec 2022 10:11:14 +0800
Message-ID: <1670811076-38625-3-git-send-email-wangyufen@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1670811076-38625-1-git-send-email-wangyufen@huawei.com>
References: <1670811076-38625-1-git-send-email-wangyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.70]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

If FAULT_INJECTION_STACKTRACE_FILTER is enabled, the depth is default
to 32. This means fail_stacktrace() will iter each entry's stacktrace,
even if filter is not configured.

This patch change to quick return from fail_stacktrace() if stacktrace
filter is not set.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 lib/fault-inject.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/fault-inject.c b/lib/fault-inject.c
index 1421818..fecc4d8 100644
--- a/lib/fault-inject.c
+++ b/lib/fault-inject.c
@@ -71,7 +71,7 @@ static bool fail_stacktrace(struct fault_attr *attr)
 	int n, nr_entries;
 	bool found = (attr->require_start == 0 && attr->require_end == ULONG_MAX);
 
-	if (depth == 0)
+	if (depth == 0 || (found && !attr->reject_start && !attr->reject_end))
 		return found;
 
 	nr_entries = stack_trace_save(entries, depth, 1);
-- 
1.8.3.1

