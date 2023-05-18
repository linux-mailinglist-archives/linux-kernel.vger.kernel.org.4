Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99857708619
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 18:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjERQdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 12:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjERQdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 12:33:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EF1D1;
        Thu, 18 May 2023 09:33:45 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34IFDQwg026231;
        Thu, 18 May 2023 16:33:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=VDaXGAZUppzRptwgxVznBwUvMYyzYubsE/Ej04ItnkY=;
 b=0EC29YQdaXRNxxVTz8UrtyG/K/ddfDBT5dxg0aPH9/SL+jbc5aF7sAjtXb526b81JVE5
 I18eujTTbh/4JmOcXdwmfNkjZ5d2UF0FbVUwy5ie1wtFaZdjiBOiZUPI7l/ECPY5qla4
 /T7TxxGfCTegxtXgCmL2snxUqUrWj3zc84+NEBDgyc+Jv7jk+RFVBTqXTVQLqeTiYtql
 4jiJ2GJk5PCnlB8oFQhomDwFRuxsizHvtYHEdLKkZGXfvjZYahaiICUhy9MmjNNwFdoX
 B1dZs5lAx4j9ZchLD2pxZOT73KRr4EoerO3N/jPEHG7iSIiI8heQy03otpDtyRk3cwy/ UQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmxfc33gm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 16:33:38 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34IGW5x6040011;
        Thu, 18 May 2023 16:33:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj106rh79-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 16:33:37 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34IGXbdQ025859;
        Thu, 18 May 2023 16:33:37 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3qj106rh6u-1;
        Thu, 18 May 2023 16:33:37 +0000
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     harshit.m.mogalapalli@oracle.com, error27@gmail.com,
        dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] misc: microchip: pci1xxxx: Fix error handling in gp_aux_bus_probe()
Date:   Thu, 18 May 2023 09:33:33 -0700
Message-Id: <20230518163333.1355445-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_13,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305180135
X-Proofpoint-GUID: _cQ6oceAgydok2lo27Ycn39_bzj4Q1jK
X-Proofpoint-ORIG-GUID: _cQ6oceAgydok2lo27Ycn39_bzj4Q1jK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch warns:
	drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c:73
	gp_aux_bus_probe() warn: missing unwind goto?

Apart from above warning that smatch warns, we have other issues with
this function.

1. The call to auxiliary_device_add() needs a matching call to
   auxiliary_device_delete(). When memory allocation for
   "aux_bus->aux_device_wrapper[1]" fails we should also delete
   auxiliary device for "aux_device_wrapper[0]".
2. In the error path when auxiliary_device_uninit() is called, it
   does trigger the release function --> gp_auxiliary_device_release(),
   this release function has the following:

	ida_free(&gp_client_ida, aux_device_wrapper->aux_dev.id);
	kfree(aux_device_wrapper);

   so few error paths have double frees. Eg: The goto label
   "err_aux_dev_add_0" first calls auxiliary_device_uninit() which also
   does an ida_free(), so when the control reaches "err_aux_dev_init_0"
   it will be a double free there.

Re-write the error handling code. Clean up manually before the
auxiliary_device_init() calls succeed and use gotos to clean up after
they succeed. Also change the goto label names to follow freeing the
last thing to make it more readable.

Fixes: 393fc2f5948f ("misc: microchip: pci1xxxx: load auxiliary bus driver for the PIO function in the multi-function endpoint of pci1xxxx device.")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
Only compile tested, from static analysis.
---
 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c | 71 ++++++++++---------
 1 file changed, 38 insertions(+), 33 deletions(-)

diff --git a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c
index 32af2b14ff34..f76ef6fd7bfc 100644
--- a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c
+++ b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c
@@ -48,8 +48,10 @@ static int gp_aux_bus_probe(struct pci_dev *pdev, const struct pci_device_id *id
 		return -ENOMEM;
 
 	retval = ida_alloc(&gp_client_ida, GFP_KERNEL);
-	if (retval < 0)
-		goto err_ida_alloc_0;
+	if (retval < 0) {
+		kfree(aux_bus->aux_device_wrapper[0]);
+		return retval;
+	}
 
 	aux_bus->aux_device_wrapper[0]->aux_dev.name = aux_dev_otp_e2p_name;
 	aux_bus->aux_device_wrapper[0]->aux_dev.dev.parent = &pdev->dev;
@@ -60,21 +62,28 @@ static int gp_aux_bus_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	aux_bus->aux_device_wrapper[0]->gp_aux_data.region_length = pci_resource_end(pdev, 0);
 
 	retval = auxiliary_device_init(&aux_bus->aux_device_wrapper[0]->aux_dev);
-	if (retval < 0)
-		goto err_aux_dev_init_0;
+	if (retval < 0) {
+		ida_free(&gp_client_ida, aux_bus->aux_device_wrapper[0]->aux_dev.id);
+		kfree(aux_bus->aux_device_wrapper[0]);
+		return retval;
+	}
 
 	retval = auxiliary_device_add(&aux_bus->aux_device_wrapper[0]->aux_dev);
 	if (retval)
-		goto err_aux_dev_add_0;
+		goto uninit_device_wrapper_0;
 
 	aux_bus->aux_device_wrapper[1] = kzalloc(sizeof(*aux_bus->aux_device_wrapper[1]),
 						 GFP_KERNEL);
-	if (!aux_bus->aux_device_wrapper[1])
-		return -ENOMEM;
+	if (!aux_bus->aux_device_wrapper[1]) {
+		retval = -ENOMEM;
+		goto delete_device_wrapper_0;
+	}
 
 	retval = ida_alloc(&gp_client_ida, GFP_KERNEL);
-	if (retval < 0)
-		goto err_ida_alloc_1;
+	if (retval < 0) {
+		kfree(aux_bus->aux_device_wrapper[1]);
+		goto delete_device_wrapper_0;
+	}
 
 	aux_bus->aux_device_wrapper[1]->aux_dev.name = aux_dev_gpio_name;
 	aux_bus->aux_device_wrapper[1]->aux_dev.dev.parent = &pdev->dev;
@@ -85,48 +94,44 @@ static int gp_aux_bus_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	aux_bus->aux_device_wrapper[1]->gp_aux_data.region_length = pci_resource_end(pdev, 0);
 
 	retval = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
-
-	if (retval < 0)
-		goto err_aux_dev_init_1;
+	if (retval < 0) {
+		ida_free(&gp_client_ida, aux_bus->aux_device_wrapper[1]->aux_dev.id);
+		kfree(aux_bus->aux_device_wrapper[1]);
+		goto delete_device_wrapper_0;
+	}
 
 	retval = pci_irq_vector(pdev, 0);
-	if (retval < 0)
-		goto err_aux_dev_init_1;
+	if (retval < 0) {
+		ida_free(&gp_client_ida, aux_bus->aux_device_wrapper[1]->aux_dev.id);
+		kfree(aux_bus->aux_device_wrapper[1]);
+		goto delete_device_wrapper_0;
+	}
 
 	pdev->irq = retval;
 	aux_bus->aux_device_wrapper[1]->gp_aux_data.irq_num = pdev->irq;
 
 	retval = auxiliary_device_init(&aux_bus->aux_device_wrapper[1]->aux_dev);
-	if (retval < 0)
-		goto err_aux_dev_init_1;
+	if (retval < 0) {
+		ida_free(&gp_client_ida, aux_bus->aux_device_wrapper[1]->aux_dev.id);
+		kfree(aux_bus->aux_device_wrapper[1]);
+		goto delete_device_wrapper_0;
+	}
 
 	retval = auxiliary_device_add(&aux_bus->aux_device_wrapper[1]->aux_dev);
 	if (retval)
-		goto err_aux_dev_add_1;
+		goto uninit_device_wrapper_1;
 
 	pci_set_drvdata(pdev, aux_bus);
 	pci_set_master(pdev);
 
 	return 0;
 
-err_aux_dev_add_1:
+uninit_device_wrapper_1:
 	auxiliary_device_uninit(&aux_bus->aux_device_wrapper[1]->aux_dev);
-
-err_aux_dev_init_1:
-	ida_free(&gp_client_ida, aux_bus->aux_device_wrapper[1]->aux_dev.id);
-
-err_ida_alloc_1:
-	kfree(aux_bus->aux_device_wrapper[1]);
-
-err_aux_dev_add_0:
+delete_device_wrapper_0:
+	auxiliary_device_delete(&aux_bus->aux_device_wrapper[0]->aux_dev);
+uninit_device_wrapper_0:
 	auxiliary_device_uninit(&aux_bus->aux_device_wrapper[0]->aux_dev);
-
-err_aux_dev_init_0:
-	ida_free(&gp_client_ida, aux_bus->aux_device_wrapper[0]->aux_dev.id);
-
-err_ida_alloc_0:
-	kfree(aux_bus->aux_device_wrapper[0]);
-
 	return retval;
 }
 
-- 
2.31.1

