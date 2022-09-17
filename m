Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F177F5BB6A2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 08:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiIQG0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 02:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiIQG0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 02:26:32 -0400
Received: from mail-m972.mail.163.com (mail-m972.mail.163.com [123.126.97.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C9A048EA3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 23:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=n9TQa
        rA5HFDvEKCCTRUTj+Y9jic5HRzWblDS8dMVBcs=; b=piZsHqUmKrV9g5gYH+XAj
        slB5OEMIlxz0ZAfscZrxoOeOlX3lAZ/AkcO5Z9mIhOHDuouF0n15Dk/E0G9WNpUR
        CRn6XiG9w8tbgpts5xEtDjRKFKeeaG5xhILoM9KDL/puwJSbz/9Jl3yjoFnqESy0
        vSa0KKfeecrW10IAbF9jsc=
Received: from DESKTOP-CE2KKHI.localdomain (unknown [124.160.210.227])
        by smtp2 (Coremail) with SMTP id GtxpCgC3K+5_aCVj8qg3eQ--.56440S2;
        Sat, 17 Sep 2022 14:26:09 +0800 (CST)
From:   williamsukatube@163.com
To:     nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, William Dean <williamsukatube@163.com>
Subject: [PATH -next] device-dax: simplify code in devm_register_dax_mapping
Date:   Sat, 17 Sep 2022 14:26:06 +0800
Message-Id: <20220917062606.1701-1-williamsukatube@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GtxpCgC3K+5_aCVj8qg3eQ--.56440S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GFWfAFWDuw4xtr1fGFWrGrg_yoW3trX_Gr
        yrAFyxWwnIg3WfGw17Crn3Zry3tF1DuF4fZrs0qa43Gw18Ca1kuF4vyrnrCr97XrWxWr98
        t3Z0gr1FyFnrGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRM5l8DUUUUU==
X-Originating-IP: [124.160.210.227]
X-CM-SenderInfo: xzlozx5dpv3yxdwxuvi6rwjhhfrp/1tbiUQF-g2DEPMIy+wAAs-
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: William Dean <williamsukatube@163.com>

It could directly return 'devm_add_action_or_reset' to simplify code.

Signed-off-by: William Dean <williamsukatube@163.com>
---
 drivers/dax/bus.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 1dad813ee4a6..251c53061764 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -772,11 +772,8 @@ static int devm_register_dax_mapping(struct dev_dax *dev_dax, int range_id)
 		return rc;
 	}
 
-	rc = devm_add_action_or_reset(dax_region->dev, unregister_dax_mapping,
+	return devm_add_action_or_reset(dax_region->dev, unregister_dax_mapping,
 			dev);
-	if (rc)
-		return rc;
-	return 0;
 }
 
 static int alloc_dev_dax_range(struct dev_dax *dev_dax, u64 start,
-- 
2.25.1

