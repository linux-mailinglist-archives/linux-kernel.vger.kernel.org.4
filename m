Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3441691C10
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 10:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbjBJJ6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 04:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbjBJJ6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 04:58:34 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA2D76D2E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 01:58:32 -0800 (PST)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PCq1H3C2HzdbBV;
        Fri, 10 Feb 2023 17:58:11 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 10 Feb 2023 17:58:30 +0800
From:   Longlong Xia <xialonglong1@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <chenwandun@huawei.com>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <sunnanyong@huawei.com>,
        <wangkefeng.wang@huawei.com>, <xialonglong1@huawei.com>
Subject: [PATCH -next v2 2/3] devtmpfs: add debug info to handle()
Date:   Fri, 10 Feb 2023 09:54:43 +0000
Message-ID: <20230210095444.4067307-3-xialonglong1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230210095444.4067307-1-xialonglong1@huawei.com>
References: <20230210095444.4067307-1-xialonglong1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because handle() is the core function for processing devtmpfs requests,
Let's add some debug info in handle() to help users know why failed.

Signed-off-by: Longlong Xia <xialonglong1@huawei.com>
---
 drivers/base/devtmpfs.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index ae72d4ba8547..7789b7be4ee5 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -389,10 +389,18 @@ static __initdata DECLARE_COMPLETION(setup_done);
 static int handle(const char *name, umode_t mode, kuid_t uid, kgid_t gid,
 		  struct device *dev)
 {
+	int ret;
+
 	if (mode)
-		return handle_create(name, mode, uid, gid, dev);
+		ret = handle_create(name, mode, uid, gid, dev);
 	else
-		return handle_remove(name, dev);
+		ret = handle_remove(name, dev);
+
+	if (ret)
+		dev_err(dev, "failed to %s %s, ret = %d\n",
+			mode ? "create" : "remove", name, ret);
+
+	return ret;
 }
 
 static void __noreturn devtmpfs_work_loop(void)
-- 
2.25.1

