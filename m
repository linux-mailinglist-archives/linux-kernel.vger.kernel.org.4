Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7B36AD6CE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 06:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjCGFby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 00:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjCGFbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 00:31:52 -0500
X-Greylist: delayed 1811 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Mar 2023 21:31:50 PST
Received: from m126.mail.126.com (m126.mail.126.com [123.126.96.241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F88A6B5C3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 21:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=mwbUX
        KOEJhtts3eLN23hd0BPVEyQqp55SlFwfXBgx4E=; b=OWd6UCelCCTlMbdnKnXXd
        9qC6hwK2poYJb3/M3JepDALXlXI31hn27mZ1i/Ui5UmwbVjqrDetuppWCZdAvLfe
        RjJuQL5ecrmA7LmFlcvnn9HHOVgTjm14P19qHMtQDkaE1gryKtUE53Ss2XZq0PLK
        j0uVsyNQfM2aGYqVqcMfEs=
Received: from localhost.localdomain (unknown [113.91.40.179])
        by smtp13 (Coremail) with SMTP id feRpCgCnrkolxQZkYHntBg--.54585S2;
        Tue, 07 Mar 2023 13:01:27 +0800 (CST)
From:   Xujun Leng <lengxujun2007@126.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, Xujun Leng <lengxujun2007@126.com>
Subject: [PATCH] driver core: platform: added arguments check for platform_device_add_resources()
Date:   Tue,  7 Mar 2023 13:01:16 +0800
Message-Id: <20230307050116.12019-1-lengxujun2007@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: feRpCgCnrkolxQZkYHntBg--.54585S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr1DWFyruw15Xr17JFy5urg_yoWDXFbE9a
        10gF1xJr1rCF4kK34jk3W7CrsavFZxWr95WFy3Ka4Sg3y3X3W29ryUWryUJa4UXr10kFyq
        q3srGr13Z34akjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRNyxR7UUUUU==
X-Originating-IP: [113.91.40.179]
X-CM-SenderInfo: pohqw5hxmx0jqqqxqiyswou0bp/1tbikgcrd1pEJy-g7QAAsS
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the follow two cases, platform_device_add_resources() can lead an
invalid address access:
1) If (!res && num > 0), pdev->resource will be set to NULL but
   pdev->num_resources > 0, then a later platform_get_resource() will
   cause invalid address access.
2) If (res && num == 0), because num == 0 cause kmalloc_slab() returns
   ZERO_SIZE_PTR, then kmemdup() will copy data to the invalid address
   ZERO_SIZE_PTR.

Signed-off-by: Xujun Leng <lengxujun2007@126.com>
---
 drivers/base/platform.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 77510e4f47de..a060941c3076 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -606,6 +606,9 @@ int platform_device_add_resources(struct platform_device *pdev,
 {
 	struct resource *r = NULL;
 
+	if ((!res && num > 0) || (res && num == 0))
+		return -EINVAL;
+
 	if (res) {
 		r = kmemdup(res, sizeof(struct resource) * num, GFP_KERNEL);
 		if (!r)
-- 
2.25.1

