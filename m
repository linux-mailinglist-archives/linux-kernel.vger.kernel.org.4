Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929395EB786
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 04:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiI0CTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 22:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbiI0CTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 22:19:14 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC7FA98CA;
        Mon, 26 Sep 2022 19:19:11 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mc3C25VtszpTgj;
        Tue, 27 Sep 2022 10:16:14 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500004.china.huawei.com
 (7.192.104.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 27 Sep
 2022 10:19:09 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <martin.petersen@oracle.com>, <jejb@linux.ibm.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hare@suse.com>, <hch@lst.de>, <bvanassche@acm.org>,
        <john.garry@huawei.com>, <jinpu.wang@cloud.ionos.com>,
        Jason Yan <yanaijie@huawei.com>
Subject: [PATCH v3 8/8] scsi: libsas: use sas_phy_match_port_addr() instead of open coded
Date:   Tue, 27 Sep 2022 10:29:41 +0800
Message-ID: <20220927022941.4029476-9-yanaijie@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220927022941.4029476-1-yanaijie@huawei.com>
References: <20220927022941.4029476-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sas address comparation of asd_sas_port and expander phy is open
coded. Now we can replace it with sas_phy_match_port_addr().

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/scsi/libsas/sas_expander.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index f268291b7584..eabc56966f36 100644
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

