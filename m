Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25BD6717AA7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbjEaIuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbjEaItf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:49:35 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B56113;
        Wed, 31 May 2023 01:49:10 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34V7awX5000761;
        Wed, 31 May 2023 08:49:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=UEan03QWYcnaZZlJX/zExSgnptFkk/YvcVmYOiJWI3Y=;
 b=irTK6z8jQsgfF8WrE2q0C5sRzFL82dNrqEHBvthzlV1vxw04TZUy2EoxA24R6Wmxzw7R
 I8l/n2pNjXYTkk6OimtUj1VcOOmZMRGsoyqo3iefGQaphW8PIB7h6ClRLa83cd6Frrh7
 dl4JDtlZQg59j64NZuG5P+dYayODn70CWzqd66b3Da7V6ZYS7MbVftwRGy7LrPJXif3J
 SdG7/Usg7osuhE3QI3gTLRrK9UEJt9EFPYjlWWBfa/T0DDmgaWuWfadTl9iyl7dN2K6J
 temFX14tITDHu8xrnqFsOcGPMqmSYrezv37lMeO6p/Jxjw+c8fWmWNeQ2grpRgEHMQGx Pw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qx1r5j2eb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 08:49:02 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34V8fdTM003518;
        Wed, 31 May 2023 08:49:01 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qx1r5j2ds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 08:49:01 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34V4otZm011798;
        Wed, 31 May 2023 08:48:59 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3qu94e1w21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 08:48:59 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34V8mun221889760
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 May 2023 08:48:57 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CAC962004B;
        Wed, 31 May 2023 08:48:56 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9181120043;
        Wed, 31 May 2023 08:48:56 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 31 May 2023 08:48:56 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Shay Drory <shayd@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
        Eli Cohen <elic@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Simon Horman <simon.horman@corigine.com>,
        linux-rdma@vger.kernel.org
Subject: [PATCH net v2] net/mlx5: Fix setting of irq->map.index for static IRQ case
Date:   Wed, 31 May 2023 10:48:56 +0200
Message-Id: <20230531084856.2091666-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IpaMixqhl_GstFLOiN4P1omx1hOk1inL
X-Proofpoint-GUID: P4cTm2aPsP84RRIVih7cyLmLqC5MIFVB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_04,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 lowpriorityscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305310074
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When dynamic IRQ allocation is not supported all IRQs are allocated up
front in mlx5_irq_table_create() instead of dynamically as part of
mlx5_irq_alloc(). In the latter dynamic case irq->map.index is set
via the mapping returned by pci_msix_alloc_irq_at(). In the static case
and prior to commit 1da438c0ae02 ("net/mlx5: Fix indexing of mlx5_irq")
irq->map.index was set in mlx5_irq_alloc() twice once initially to 0 and
then to the requested index before storing in the xarray. After this
commit it is only set to 0 which breaks all other IRQ mappings.

Fix this by setting irq->map.index to the requested index together with
irq->map.virq and improve the related comment to make it clearer which
cases it deals with.

Tested-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Reviewed-by: Eli Cohen <elic@nvidia.com>
Fixes: 1da438c0ae02 ("net/mlx5: Fix indexing of mlx5_irq")
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
v1 -> v2:
- Added R-bs/Acks
- Fixed typos in commit message

 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
index db5687d9fec9..fd5b43e8f3bb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
@@ -232,12 +232,13 @@ struct mlx5_irq *mlx5_irq_alloc(struct mlx5_irq_pool *pool, int i,
 	if (!irq)
 		return ERR_PTR(-ENOMEM);
 	if (!i || !pci_msix_can_alloc_dyn(dev->pdev)) {
-		/* The vector at index 0 was already allocated.
-		 * Just get the irq number. If dynamic irq is not supported
-		 * vectors have also been allocated.
+		/* The vector at index 0 is always statically allocated. If
+		 * dynamic irq is not supported all vectors are statically
+		 * allocated. In both cases just get the irq number and set
+		 * the index.
 		 */
 		irq->map.virq = pci_irq_vector(dev->pdev, i);
-		irq->map.index = 0;
+		irq->map.index = i;
 	} else {
 		irq->map = pci_msix_alloc_irq_at(dev->pdev, MSI_ANY_INDEX, af_desc);
 		if (!irq->map.virq) {
-- 
2.39.2

