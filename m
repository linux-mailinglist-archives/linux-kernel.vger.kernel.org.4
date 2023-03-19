Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A476BFF45
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 05:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjCSEDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 00:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjCSEDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 00:03:13 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7F8F12588
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 21:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=M3F5c
        23yEAb6RmFCWHC++naieRb90y1zO1aTuCoWokQ=; b=D5yDxSKvkru507DhW69CM
        pOiVjrtxnzgWP/ZlpUmI7xjIyXpo9Zr+qLtixLa741N7zDYYoe6Gbu6MVJuptvUa
        dVkaqDdkwL2IWHCvI9GdnYfr4WmeBQB/G2F2f8w/yOhhxMNdUlFqHMGDnU/RsDRn
        JCob0OuuYXw0sjwAqG3/rI=
Received: from lizhe.. (unknown [120.245.132.192])
        by zwqz-smtp-mta-g1-3 (Coremail) with SMTP id _____wAXvegviRZksTGxAQ--.36162S4;
        Sun, 19 Mar 2023 12:02:48 +0800 (CST)
From:   Lizhe <sensor1010@163.com>
To:     lee@kernel.org
Cc:     linux-kernel@vger.kernel.org, Lizhe <sensor1010@163.com>
Subject: [PATCH v1] mfd:mcp-core.c : Remove redundant driver match function
Date:   Sun, 19 Mar 2023 12:01:49 +0800
Message-Id: <20230319040149.216919-1-sensor1010@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAXvegviRZksTGxAQ--.36162S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr1kZF4kWr1kGFyUWw1kGrg_yoWDXrc_ua
        4Yvr97Wrs8G3WfKan7Xrn7Zr97trsFqr4rKa10q393A34xWF1Uuw4DZry3J34rurWkZFZr
        Z3yDXr4xuFW7tjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRCxRh5UUUUU==
X-Originating-IP: [120.245.132.192]
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/1tbiSAU3q1+FhPxjlAAAsE
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there is no driver_match function, the driver core assumes that each
candidate pair (driver, device)matches, see driver_match_device()

Signed-off-by: Lizhe <sensor1010@163.com>
---
 drivers/mfd/mcp-core.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/mfd/mcp-core.c b/drivers/mfd/mcp-core.c
index 2fa592c37c6f..281a9369f2b3 100644
--- a/drivers/mfd/mcp-core.c
+++ b/drivers/mfd/mcp-core.c
@@ -20,11 +20,6 @@
 #define to_mcp(d)		container_of(d, struct mcp, attached_device)
 #define to_mcp_driver(d)	container_of(d, struct mcp_driver, drv)
 
-static int mcp_bus_match(struct device *dev, struct device_driver *drv)
-{
-	return 1;
-}
-
 static int mcp_bus_probe(struct device *dev)
 {
 	struct mcp *mcp = to_mcp(dev);
@@ -43,7 +38,6 @@ static void mcp_bus_remove(struct device *dev)
 
 static struct bus_type mcp_bus_type = {
 	.name		= "mcp",
-	.match		= mcp_bus_match,
 	.probe		= mcp_bus_probe,
 	.remove		= mcp_bus_remove,
 };
-- 
2.34.1

