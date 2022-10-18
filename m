Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177D2602CE6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbiJRN0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbiJRN0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:26:30 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46385300C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 06:26:02 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MsF153JNHzJn2p;
        Tue, 18 Oct 2022 21:23:21 +0800 (CST)
Received: from dggpemm500016.china.huawei.com (7.185.36.25) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 21:25:59 +0800
Received: from huawei.com (10.67.174.205) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 21:25:59 +0800
From:   Chen Jiahao <chenjiahao16@huawei.com>
To:     <fweisbec@gmail.com>, <tj@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] samples/hw_breakpoint: mark sample_hbp as static
Date:   Wed, 19 Oct 2022 05:25:39 +0800
Message-ID: <20221018212539.86081-1-chenjiahao16@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.205]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a sparse warning shown below:

samples/hw_breakpoint/data_breakpoint.c:24:19: warning:
symbol 'sample_hbp' was not declared. Should it be static?

Since 'sample_hbp' is only called within data_breakpoint.c,
mark it as static to fix the warning.

Fixes: 44ee63587dce ("percpu: Add __percpu sparse annotations to hw_breakpoint")
Signed-off-by: Chen Jiahao <chenjiahao16@huawei.com>
---
 samples/hw_breakpoint/data_breakpoint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/hw_breakpoint/data_breakpoint.c b/samples/hw_breakpoint/data_breakpoint.c
index 418c46fe5ffc..37c4f0ea8e53 100644
--- a/samples/hw_breakpoint/data_breakpoint.c
+++ b/samples/hw_breakpoint/data_breakpoint.c
@@ -21,7 +21,7 @@
 #include <linux/perf_event.h>
 #include <linux/hw_breakpoint.h>
 
-struct perf_event * __percpu *sample_hbp;
+static struct perf_event * __percpu *sample_hbp;
 
 static char ksym_name[KSYM_NAME_LEN] = "jiffies";
 module_param_string(ksym, ksym_name, KSYM_NAME_LEN, S_IRUGO);
-- 
2.31.1

