Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9C75BF254
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 02:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbiIUAoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 20:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiIUAoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 20:44:19 -0400
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9E0481EC
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 17:44:16 -0700 (PDT)
Received: from ([60.208.111.195])
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id PZN00112;
        Wed, 21 Sep 2022 08:44:12 +0800
Received: from localhost.localdomain (10.200.104.97) by
 jtjnmail201608.home.langchao.com (10.100.2.8) with Microsoft SMTP Server id
 15.1.2507.12; Wed, 21 Sep 2022 08:44:12 +0800
From:   Bo Liu <liubo03@inspur.com>
To:     <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <dave.jiang@intel.com>
CC:     <nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        Bo Liu <liubo03@inspur.com>
Subject: [PATCH v2 1/1] dax: Check dev_set_name() return value
Date:   Tue, 20 Sep 2022 20:44:06 -0400
Message-ID: <20220921004406.2560-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.200.104.97]
tUid:   20229210844123c3628e480bf2508a5a076800163e699
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's possible that dev_set_name() returns -ENOMEM, catch and handle this.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 Changes from v1:
 -use put_device() replace free()
	
 drivers/dax/bus.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 1dad813ee4a6..2e736c7df46c 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -765,7 +765,12 @@ static int devm_register_dax_mapping(struct dev_dax *dev_dax, int range_id)
 	device_initialize(dev);
 	dev->parent = &dev_dax->dev;
 	dev->type = &dax_mapping_type;
-	dev_set_name(dev, "mapping%d", mapping->id);
+	rc = dev_set_name(dev, "mapping%d", mapping->id);
+	if (rc) {
+		put_device(dev);
+		return rc;
+	}
+
 	rc = device_add(dev);
 	if (rc) {
 		put_device(dev);
@@ -1334,7 +1339,9 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
 	dev_dax->region = dax_region;
 	dev = &dev_dax->dev;
 	device_initialize(dev);
-	dev_set_name(dev, "dax%d.%d", dax_region->id, dev_dax->id);
+	rc = dev_set_name(dev, "dax%d.%d", dax_region->id, dev_dax->id);
+	if (rc)
+		goto err_range;
 
 	rc = alloc_dev_dax_range(dev_dax, dax_region->res.start, data->size);
 	if (rc)
-- 
2.27.0

