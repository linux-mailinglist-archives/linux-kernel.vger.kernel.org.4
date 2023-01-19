Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2957672F3F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 03:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjASCva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 21:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjASCv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 21:51:28 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FF8689C0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 18:51:25 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4Ny6b02HyDz501RM;
        Thu, 19 Jan 2023 10:51:24 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
        by mse-fl1.zte.com.cn with SMTP id 30J2pHJo048709;
        Thu, 19 Jan 2023 10:51:17 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Thu, 19 Jan 2023 10:51:18 +0800 (CST)
Date:   Thu, 19 Jan 2023 10:51:18 +0800 (CST)
X-Zmail-TransId: 2af963c8b026ffffffffd66c3ac3
X-Mailer: Zmail v1.0
Message-ID: <202301191051184033370@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <andrew@lunn.ch>
Cc:     <gregory.clement@bootlin.com>, <sebastian.hesselbarth@gmail.com>,
        <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBBUk06IG12ZWJ1OiBwb3RlbnRpYWwgZGVyZWZlcmVuY2Ugb2YgbnVsbCBwb2ludGVy?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 30J2pHJo048709
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63C8B02C.000/4Ny6b02HyDz501RM
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

The return value of kzalloc() needs to be checked.
To avoid use of null pointer in case of the failure of alloc.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 arch/arm/mach-mvebu/board-v7.c  | 4 ++++
 arch/arm/mach-mvebu/coherency.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
index fd5d0c8ff695..3c031b2efe16 100644
--- a/arch/arm/mach-mvebu/board-v7.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@ -125,11 +125,15 @@ static void __init i2c_quirk(void)
 		struct property *new_compat;

 		new_compat = kzalloc(sizeof(*new_compat), GFP_KERNEL);
+		if (!new_compat)
+			return;

 		new_compat->name = kstrdup("compatible", GFP_KERNEL);
 		new_compat->length = sizeof("marvell,mv78230-a0-i2c");
 		new_compat->value = kstrdup("marvell,mv78230-a0-i2c",
 						GFP_KERNEL);
+		if (!new_compat->name || !new_compat->value)
+			return;

 		of_update_property(np, new_compat);
 	}
diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
index a6b621ff0b87..8291185c52cc 100644
--- a/arch/arm/mach-mvebu/coherency.c
+++ b/arch/arm/mach-mvebu/coherency.c
@@ -191,7 +191,11 @@ static void __init armada_375_380_coherency_init(struct device_node *np)
 		struct property *p;

 		p = kzalloc(sizeof(*p), GFP_KERNEL);
+		if (!p)
+			return;
 		p->name = kstrdup("arm,io-coherent", GFP_KERNEL);
+		if (!p->name)
+			return;
 		of_add_property(cache_dn, p);
 	}
 }
-- 
2.25.1
