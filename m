Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A21B609D8D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 11:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiJXJMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 05:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbiJXJMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 05:12:42 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EF8537FD
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 02:12:41 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Mwq3T44Syz15M19;
        Mon, 24 Oct 2022 17:07:49 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 17:12:39 +0800
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 17:12:38 +0800
From:   Tong Tiangen <tongtiangen@huawei.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        <linux-kernel@vger.kernel.org>, <will@kernel.org>,
        <ardb@kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     Tong Tiangen <tongtiangen@huawei.com>,
        <wangkefeng.wang@huawei.com>, Guohanjun <guohanjun@huawei.com>
Subject: [PATCH -next] init/main: Use strtobool for param parsing in set_debug_rodata()
Date:   Mon, 24 Oct 2022 09:38:17 +0000
Message-ID: <20221024093817.3003291-1-tongtiangen@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aftern parsing "full", we can still use strtobool rather than "on" and
"off" parsing in set_debug_rodata().

Fixes: 2e8cff0a0eee ("arm64: fix rodata=full")
Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
---
 init/main.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/init/main.c b/init/main.c
index aa21add5f7c5..f420e20b1fa3 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1463,13 +1463,7 @@ static int __init set_debug_rodata(char *str)
 	if (arch_parse_debug_rodata(str))
 		return 0;
 
-	if (str && !strcmp(str, "on"))
-		rodata_enabled = true;
-	else if (str && !strcmp(str, "off"))
-		rodata_enabled = false;
-	else
-		pr_warn("Invalid option string for rodata: '%s'\n", str);
-	return 0;
+	return strtobool(str, &rodata_enabled);
 }
 early_param("rodata", set_debug_rodata);
 #endif
-- 
2.25.1

