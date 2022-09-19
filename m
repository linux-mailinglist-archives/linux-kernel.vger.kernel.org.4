Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F555BCB7B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 14:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiISMIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 08:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiISMIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 08:08:04 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C0D2A423;
        Mon, 19 Sep 2022 05:08:02 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MWNd32spCzmVRF;
        Mon, 19 Sep 2022 20:04:07 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (7.185.36.74) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 20:08:00 +0800
Received: from localhost.localdomain (10.67.164.66) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 20:08:00 +0800
From:   Yang Shen <shenyang39@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <gregkh@linuxfoundation.org>
Subject: [RFC PATCH 1/6] moduleparams: Add hexulong type parameter
Date:   Mon, 19 Sep 2022 20:05:32 +0800
Message-ID: <20220919120537.39258-2-shenyang39@huawei.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20220919120537.39258-1-shenyang39@huawei.com>
References: <20220919120537.39258-1-shenyang39@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the bitmap.h uses a unsigned long pointer for bitmap variable,
Add an 'hexulong' is more convenient.

Signed-off-by: Yang Shen <shenyang39@huawei.com>
---
 include/linux/moduleparam.h | 7 ++++++-
 kernel/params.c             | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index 962cd41a2cb5..9e0828fa3946 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -118,7 +118,7 @@ struct kparam_array
  * you can create your own by defining those variables.
  *
  * Standard types are:
- *	byte, hexint, short, ushort, int, uint, long, ulong
+ *	byte, hexint, hexulong, short, ushort, int, uint, long, ulong
  *	charp: a character pointer
  *	bool: a bool, values 0/1, y/n, Y/N.
  *	invbool: the above, only sense-reversed (N = true).
@@ -455,6 +455,11 @@ extern int param_set_hexint(const char *val, const struct kernel_param *kp);
 extern int param_get_hexint(char *buffer, const struct kernel_param *kp);
 #define param_check_hexint(name, p) param_check_uint(name, p)
 
+extern const struct kernel_param_ops param_ops_hexulong;
+extern int param_set_hexulong(const char *val, const struct kernel_param *kp);
+extern int param_get_hexulong(char *buffer, const struct kernel_param *kp);
+#define param_check_hexulong(name, p) param_check_ulong(name, p)
+
 extern const struct kernel_param_ops param_ops_charp;
 extern int param_set_charp(const char *val, const struct kernel_param *kp);
 extern int param_get_charp(char *buffer, const struct kernel_param *kp);
diff --git a/kernel/params.c b/kernel/params.c
index 5b92310425c5..f367f0c1f228 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -242,6 +242,7 @@ STANDARD_PARAM_DEF(long,	long,			"%li",		kstrtol);
 STANDARD_PARAM_DEF(ulong,	unsigned long,		"%lu",		kstrtoul);
 STANDARD_PARAM_DEF(ullong,	unsigned long long,	"%llu",		kstrtoull);
 STANDARD_PARAM_DEF(hexint,	unsigned int,		"%#08x", 	kstrtouint);
+STANDARD_PARAM_DEF(hexulong,	unsigned long,		"%#016lx",	kstrtoul);
 
 int param_set_uint_minmax(const char *val, const struct kernel_param *kp,
 		unsigned int min, unsigned int max)
-- 
2.24.0

