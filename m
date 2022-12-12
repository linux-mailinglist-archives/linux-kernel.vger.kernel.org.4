Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5486A6497E4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 03:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbiLLCLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 21:11:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbiLLCLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 21:11:36 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD10A449
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 18:11:35 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NVlTS4MS1zRpy3;
        Mon, 12 Dec 2022 10:10:36 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 12 Dec 2022 10:11:33 +0800
From:   Wang Yufen <wangyufen@huawei.com>
To:     <akinobu.mita@gmail.com>, <akpm@linux-foundation.org>,
        <nathan@kernel.org>, <peterz@infradead.org>,
        <keescook@chromium.org>, <ndesaulniers@google.com>,
        <jpoimboe@kernel.org>, <dan.j.williams@intel.com>,
        <ojeda@kernel.org>, <isabbasso@riseup.net>, <vbabka@suse.cz>,
        <linux@rasmusvillemoes.dk>
CC:     <linux-kernel@vger.kernel.org>, <weiyongjun1@huawei.com>
Subject: [PATCH -next v2 4/4] fault-injection: make stacktrace filter works as expected
Date:   Mon, 12 Dec 2022 10:11:16 +0800
Message-ID: <1670811076-38625-5-git-send-email-wangyufen@huawei.com>
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

stacktrace filter is checked after others, such as fail-nth,
interval and probability. This make it doesn't work well as
expected.

Fix to running stacktrace filter before other filters. It will
speed up fault inject testing for driver modules.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 lib/fault-inject.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/lib/fault-inject.c b/lib/fault-inject.c
index d7819ca..6cff320 100644
--- a/lib/fault-inject.c
+++ b/lib/fault-inject.c
@@ -102,10 +102,16 @@ static inline bool fail_stacktrace(struct fault_attr *attr)
 
 bool should_fail_ex(struct fault_attr *attr, ssize_t size, int flags)
 {
+	bool stack_checked = false;
+
 	if (in_task()) {
 		unsigned int fail_nth = READ_ONCE(current->fail_nth);
 
 		if (fail_nth) {
+			if (!fail_stacktrace(attr))
+				return false;
+
+			stack_checked = true;
 			fail_nth--;
 			WRITE_ONCE(current->fail_nth, fail_nth);
 			if (!fail_nth)
@@ -125,6 +131,9 @@ bool should_fail_ex(struct fault_attr *attr, ssize_t size, int flags)
 	if (atomic_read(&attr->times) == 0)
 		return false;
 
+	if (!stack_checked && !fail_stacktrace(attr))
+		return false;
+
 	if (atomic_read(&attr->space) > size) {
 		atomic_sub(size, &attr->space);
 		return false;
@@ -139,9 +148,6 @@ bool should_fail_ex(struct fault_attr *attr, ssize_t size, int flags)
 	if (attr->probability <= get_random_u32_below(100))
 		return false;
 
-	if (!fail_stacktrace(attr))
-		return false;
-
 fail:
 	if (!(flags & FAULT_NOWARN))
 		fail_dump(attr);
-- 
1.8.3.1

