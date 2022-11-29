Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573E163BF18
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 12:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbiK2Ldv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 06:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbiK2Ldb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 06:33:31 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3AA398;
        Tue, 29 Nov 2022 03:33:28 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NM0Zt4zlDz4y0vH;
        Tue, 29 Nov 2022 19:33:26 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2ATBXJBD050782;
        Tue, 29 Nov 2022 19:33:19 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Tue, 29 Nov 2022 19:33:22 +0800 (CST)
Date:   Tue, 29 Nov 2022 19:33:22 +0800 (CST)
X-Zmail-TransId: 2af96385ee02ffffffffc820c8b6
X-Mailer: Zmail v1.0
Message-ID: <202211291933224896510@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <rafael@kernel.org>
Cc:     <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBBQ1BJOiBDUFBDOiB1c2Ugc3lzZnNfZW1pdCgpIHRvIGluc3RlYWQgb2Ygc2NucHJpbnRmKCk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2ATBXJBD050782
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.13.novalocal with ID 6385EE06.001 by FangMail milter!
X-FangMail-Envelope: 1669721606/4NM0Zt4zlDz4y0vH/6385EE06.001/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6385EE06.001/4NM0Zt4zlDz4y0vH
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Replace the open-code with sysfs_emit() to simplify the code.

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/acpi/cppc_acpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 093675b1a1ff..0f17b1c32718 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -148,7 +148,7 @@ __ATTR(_name, 0444, show_##_name, NULL)
 		if (ret)						\
 			return ret;					\
 									\
-		return scnprintf(buf, PAGE_SIZE, "%llu\n",		\
+		return sysfs_emit(buf, "%llu\n",		\
 				(u64)st_name.member_name);		\
 	}								\
 	define_one_cppc_ro(member_name)
@@ -174,7 +174,7 @@ static ssize_t show_feedback_ctrs(struct kobject *kobj,
 	if (ret)
 		return ret;

-	return scnprintf(buf, PAGE_SIZE, "ref:%llu del:%llu\n",
+	return sysfs_emit(buf, "ref:%llu del:%llu\n",
 			fb_ctrs.reference, fb_ctrs.delivered);
 }
 define_one_cppc_ro(feedback_ctrs);
-- 
2.25.1
