Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBBEE5E9E10
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234408AbiIZJlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234407AbiIZJkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:40:41 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC55F474E8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:38:02 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mbczm18gtzpVcm;
        Mon, 26 Sep 2022 17:35:00 +0800 (CST)
Received: from kwepemm600005.china.huawei.com (7.193.23.191) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 17:37:54 +0800
Received: from huawei.com (10.69.192.56) by kwepemm600005.china.huawei.com
 (7.193.23.191) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 26 Sep
 2022 17:37:53 +0800
From:   Longfang Liu <liulongfang@huawei.com>
To:     <alex.williamson@redhat.com>, <jgg@nvidia.com>,
        <shameerali.kolothum.thodi@huawei.com>
CC:     <cohuck@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>, <liulongfang@huawei.com>
Subject: [PATCH v3 3/5] hisi_acc_vfio_pci: Remove useless function parameter
Date:   Mon, 26 Sep 2022 17:33:30 +0800
Message-ID: <20220926093332.28824-4-liulongfang@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220926093332.28824-1-liulongfang@huawei.com>
References: <20220926093332.28824-1-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused function parameters for vf_qm_fun_reset() and
ensure the device is enabled before the reset operation
is performed.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
index fbe72ce173de..c07ed7b0ccf1 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
@@ -337,8 +337,7 @@ static int vf_qm_cache_wb(struct hisi_qm *qm)
 	return 0;
 }
 
-static void vf_qm_fun_reset(struct hisi_acc_vf_core_device *hisi_acc_vdev,
-			    struct hisi_qm *qm)
+static void vf_qm_fun_reset(struct hisi_qm *qm)
 {
 	int i;
 
@@ -662,7 +661,10 @@ static void hisi_acc_vf_start_device(struct hisi_acc_vf_core_device *hisi_acc_vd
 	if (hisi_acc_vdev->vf_qm_state != QM_READY)
 		return;
 
-	vf_qm_fun_reset(hisi_acc_vdev, vf_qm);
+	/* Make sure the device is enabled */
+	qm_dev_cmd_init(vf_qm);
+
+	vf_qm_fun_reset(vf_qm);
 }
 
 static int hisi_acc_vf_load_state(struct hisi_acc_vf_core_device *hisi_acc_vdev)
-- 
2.33.0

