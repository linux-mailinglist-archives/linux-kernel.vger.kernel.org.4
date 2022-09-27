Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFA35EC257
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 14:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbiI0MSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 08:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbiI0MRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 08:17:33 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B53377E8E;
        Tue, 27 Sep 2022 05:17:32 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4McJRH3DlDzHtgy;
        Tue, 27 Sep 2022 20:12:43 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500004.china.huawei.com
 (7.192.104.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 27 Sep
 2022 20:17:29 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <martin.petersen@oracle.com>, <jejb@linux.ibm.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hare@suse.com>, <hch@lst.de>, <bvanassche@acm.org>,
        <john.garry@huawei.com>, <jinpu.wang@cloud.ionos.com>,
        <damien.lemoal@opensource.wdc.com>, Jason Yan <yanaijie@huawei.com>
Subject: [PATCH v5 8/8] scsi: libsas: use sas_phy_match_port_addr() instead of open coded
Date:   Tue, 27 Sep 2022 20:39:26 +0800
Message-ID: <20220927123926.953297-9-yanaijie@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220927123926.953297-1-yanaijie@huawei.com>
References: <20220927123926.953297-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sas address comparison of asd_sas_port and expander phy is open
coded. Now we can replace it with sas_phy_match_port_addr().

Signed-off-by: Jason Yan <yanaijie@huawei.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/scsi/libsas/sas_expander.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index 38ed42b14fa0..b358a1cd9a68 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -1005,8 +1005,7 @@ static int sas_ex_discover_dev(struct domain_device *dev, int phy_id)
 	}
 
 	/* Parent and domain coherency */
-	if (!dev->parent && (SAS_ADDR(ex_phy->attached_sas_addr) ==
-			     SAS_ADDR(dev->port->sas_addr))) {
+	if (!dev->parent && sas_phy_match_port_addr(dev->port, ex_phy)) {
 		sas_add_parent_port(dev, phy_id);
 		return 0;
 	}
-- 
2.31.1

