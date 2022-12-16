Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B49764E92C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 11:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiLPKKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 05:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiLPKJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 05:09:59 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0572186DD;
        Fri, 16 Dec 2022 02:09:57 -0800 (PST)
Received: from dggpemm500012.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NYPvb6FFnzJqT4;
        Fri, 16 Dec 2022 18:08:59 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 dggpemm500012.china.huawei.com (7.185.36.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 16 Dec 2022 18:09:55 +0800
From:   Xingui Yang <yangxingui@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <john.g.garry@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yangxingui@huawei.com>,
        <prime.zeng@hisilicon.com>, <kangfenglong@huawei.com>
Subject: [PATCH V2] scsi: libsas: Directly kick-off EH when ATA device fell off
Date:   Fri, 16 Dec 2022 10:03:27 +0000
Message-ID: <20221216100327.7386-1-yangxingui@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500012.china.huawei.com (7.185.36.89)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the ATA device fell off, call sas_ata_device_link_abort() directly and
mark all outstanding QCs as failed and kick-off EH Immediately. This avoids
having to wait for block layer timeouts.

Signed-off-by: Xingui Yang <yangxingui@huawei.com>
---
Changes to v1:
- Use dev_is_sata() to check ATA device type 
 drivers/scsi/libsas/sas_discover.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/libsas/sas_discover.c b/drivers/scsi/libsas/sas_discover.c
index d5bc1314c341..a12b65eb4a2a 100644
--- a/drivers/scsi/libsas/sas_discover.c
+++ b/drivers/scsi/libsas/sas_discover.c
@@ -362,6 +362,9 @@ static void sas_destruct_ports(struct asd_sas_port *port)
 
 void sas_unregister_dev(struct asd_sas_port *port, struct domain_device *dev)
 {
+	if (test_bit(SAS_DEV_GONE, &dev->state) && dev_is_sata(dev))
+		sas_ata_device_link_abort(dev, false);
+
 	if (!test_bit(SAS_DEV_DESTROY, &dev->state) &&
 	    !list_empty(&dev->disco_list_node)) {
 		/* this rphy never saw sas_rphy_add */
-- 
2.17.1

