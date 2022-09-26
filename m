Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876FD5E9E04
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234709AbiIZJkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235118AbiIZJiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:38:55 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E696B46204
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:37:24 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mbcz903c2zpTTv;
        Mon, 26 Sep 2022 17:34:29 +0800 (CST)
Received: from kwepemm600005.china.huawei.com (7.193.23.191) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 17:37:23 +0800
Received: from huawei.com (10.69.192.56) by kwepemm600005.china.huawei.com
 (7.193.23.191) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 26 Sep
 2022 17:37:22 +0800
From:   Longfang Liu <liulongfang@huawei.com>
To:     <alex.williamson@redhat.com>, <jgg@nvidia.com>,
        <shameerali.kolothum.thodi@huawei.com>
CC:     <cohuck@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>, <liulongfang@huawei.com>
Subject: [PATCH v3 2/5] hisi_acc_vfio_pci: Fix device data address combination problem
Date:   Mon, 26 Sep 2022 17:33:29 +0800
Message-ID: <20220926093332.28824-3-liulongfang@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220926093332.28824-1-liulongfang@huawei.com>
References: <20220926093332.28824-1-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The queue address of the accelerator device should be combined into
a dma address in a way of combining the low and high bits.
The previous combination is wrong and needs to be modified.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
index 4ef9761ef467..fbe72ce173de 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
@@ -520,12 +520,12 @@ static int vf_qm_state_save(struct hisi_acc_vf_core_device *hisi_acc_vdev,
 		return -EINVAL;
 
 	/* Every reg is 32 bit, the dma address is 64 bit. */
-	vf_data->eqe_dma = vf_data->qm_eqc_dw[2];
+	vf_data->eqe_dma = vf_data->qm_eqc_dw[1];
 	vf_data->eqe_dma <<= QM_XQC_ADDR_OFFSET;
-	vf_data->eqe_dma |= vf_data->qm_eqc_dw[1];
-	vf_data->aeqe_dma = vf_data->qm_aeqc_dw[2];
+	vf_data->eqe_dma |= vf_data->qm_eqc_dw[0];
+	vf_data->aeqe_dma = vf_data->qm_aeqc_dw[1];
 	vf_data->aeqe_dma <<= QM_XQC_ADDR_OFFSET;
-	vf_data->aeqe_dma |= vf_data->qm_aeqc_dw[1];
+	vf_data->aeqe_dma |= vf_data->qm_aeqc_dw[0];
 
 	/* Through SQC_BT/CQC_BT to get sqc and cqc address */
 	ret = qm_get_sqc(vf_qm, &vf_data->sqc_dma);
-- 
2.33.0

