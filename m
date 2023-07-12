Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31795750837
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbjGLM1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbjGLM1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:27:23 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8019B
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 05:27:21 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36CBdbTR003969;
        Wed, 12 Jul 2023 12:27:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=Z2g6bzyfpZCzCp33w3yLlCiXyUWfr6VgzHUl9tHSEqA=;
 b=VUMSJGnQRujwazoW5jbkfo4NkjZZysyhJHv+AOyN1qNfD1+Xd+iVJfhuRfFfp/WOBTVZ
 WxM1/ALDW540r4TJD49RkdrQraE9JdzKucV1kzebuBpsQl9HTggtNy8+QhHWyv0/xtWv
 ipBTx4UuZM1kErhUYNzd0/yE84u3WSAXF1xQkPCVm+T3VAWME1kJSmH0nuVctcaRDsJM
 jUCQtC/uJMFfVmtdciZYr0Oq0A7l0Z53nzNLa1RRKFW9LkzH3ANiTfgpBw8SKaXxWU6V
 qhUWJrJ96qBGJSnkYAhWiylGCAQWyMIrEFWhgpnmtEHg/H9h9jC9f4X1IQujA4k9oB7r jA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rsf87hfg5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 12:27:11 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36CCRA0h028683
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 12:27:10 GMT
Received: from hu-ajainp-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 12 Jul 2023 05:27:08 -0700
From:   Anvesh Jain P <quic_ajainp@quicinc.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <xuanzhuo@linux.alibaba.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <quic_vkakani@quicinc.com>,
        <quic_vagdhank@quicinc.com>,
        Anvesh Jain P <quic_ajainp@quicinc.com>
Subject: [PATCH] virtio_mmio: add suspend and resume calls for virtio_mmio devices
Date:   Wed, 12 Jul 2023 17:56:50 +0530
Message-ID: <20230712122650.19903-1-quic_ajainp@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8xDslTx7eWoNisR_9T_OAVSRY2LwFr_V
X-Proofpoint-ORIG-GUID: 8xDslTx7eWoNisR_9T_OAVSRY2LwFr_V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_08,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 adultscore=0 clxscore=1011 priorityscore=1501 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307120111
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle suspend and resume calls for virtio mmio devices from
PM core. Expose these notifications to virtio drivers that can quiesce and
resume vq operations. Update virtio pm ops to handle freeze& restore and
suspend & resume callbacks separately.

Signed-off-by: Anvesh Jain P <quic_ajainp@quicinc.com>
Signed-off-by: Venkata Rao Kakani <quic_vkakani@quicinc.com>
---
 drivers/virtio/virtio.c      | 112 +++++++++++++++++++++++++++++++++++
 drivers/virtio/virtio_mmio.c |  50 +++++++++++++++-
 include/linux/virtio.h       |  12 ++++
 3 files changed, 173 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 3893dc29eb26..c6f25a267600 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -551,6 +551,118 @@ int virtio_device_restore(struct virtio_device *dev)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(virtio_device_restore);
+
+int virtio_device_suspend(struct virtio_device *dev)
+{
+	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
+
+	virtio_config_disable(dev);
+
+	dev->failed = dev->config->get_status(dev) & VIRTIO_CONFIG_S_FAILED;
+
+	if (drv && drv->suspend)
+		return drv->suspend(dev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(virtio_device_suspend);
+
+int virtio_device_resume(struct virtio_device *dev)
+{
+	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
+	int ret;
+
+	if (drv && drv->resume) {
+		ret = drv->resume(dev);
+		if (ret)
+			goto err;
+
+		if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK))
+			virtio_device_ready(dev);
+
+		virtio_config_enable(dev);
+	}
+
+	return 0;
+err:
+	virtio_add_status(dev, VIRTIO_CONFIG_S_FAILED);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(virtio_device_resume);
+
+int virtio_device_suspend_late(struct virtio_device *dev)
+{
+	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
+
+	virtio_config_disable(dev);
+
+	dev->failed = dev->config->get_status(dev) & VIRTIO_CONFIG_S_FAILED;
+
+	if (drv && drv->suspend_late)
+		return drv->suspend_late(dev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(virtio_device_suspend_late);
+
+int virtio_device_resume_early(struct virtio_device *dev)
+{
+	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
+	int ret;
+
+	if (drv && drv->resume_early) {
+		ret = drv->resume_early(dev);
+		if (ret)
+			goto err;
+		if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK))
+			virtio_device_ready(dev);
+
+		virtio_config_enable(dev);
+	}
+
+	return 0;
+err:
+	virtio_add_status(dev, VIRTIO_CONFIG_S_FAILED);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(virtio_device_resume_early);
+
+int virtio_device_suspend_noirq(struct virtio_device *dev)
+{
+	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
+
+	virtio_config_disable(dev);
+
+	dev->failed = dev->config->get_status(dev) & VIRTIO_CONFIG_S_FAILED;
+
+	if (drv && drv->suspend_noirq)
+		return drv->suspend_noirq(dev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(virtio_device_suspend_noirq);
+
+int virtio_device_resume_noirq(struct virtio_device *dev)
+{
+	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
+	int ret;
+
+	if (drv && drv->resume_noirq) {
+		ret = drv->resume_noirq(dev);
+		if (ret)
+			goto err;
+		if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK))
+			virtio_device_ready(dev);
+
+		virtio_config_enable(dev);
+	}
+
+	return 0;
+err:
+	virtio_add_status(dev, VIRTIO_CONFIG_S_FAILED);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(virtio_device_resume_noirq);
 #endif
 
 static int virtio_init(void)
diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index a46a4a29e929..9385c7e65da9 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -596,9 +596,57 @@ static int virtio_mmio_restore(struct device *dev)
 
 	return virtio_device_restore(&vm_dev->vdev);
 }
+static int virtio_mmio_suspend(struct device *dev)
+{
+       struct virtio_mmio_device *vm_dev = dev_get_drvdata(dev);
+
+       return virtio_device_suspend(&vm_dev->vdev);
+}
+
+static int virtio_mmio_resume(struct device *dev)
+{
+       struct virtio_mmio_device *vm_dev = dev_get_drvdata(dev);
+
+       return virtio_device_resume(&vm_dev->vdev);
+}
+
+static int virtio_mmio_suspend_late(struct device *dev)
+{
+       struct virtio_mmio_device *vm_dev = dev_get_drvdata(dev);
+
+       return virtio_device_suspend_late(&vm_dev->vdev);
+}
+
+static int virtio_mmio_resume_early(struct device *dev)
+{
+       struct virtio_mmio_device *vm_dev = dev_get_drvdata(dev);
+
+       return virtio_device_resume_early(&vm_dev->vdev);
+}
+
+static int virtio_mmio_suspend_noirq(struct device *dev)
+{
+       struct virtio_mmio_device *vm_dev = dev_get_drvdata(dev);
+
+       return virtio_device_suspend_noirq(&vm_dev->vdev);
+}
+
+static int virtio_mmio_resume_noirq(struct device *dev)
+{
+       struct virtio_mmio_device *vm_dev = dev_get_drvdata(dev);
+
+       return virtio_device_resume_noirq(&vm_dev->vdev);
+}
 
 static const struct dev_pm_ops virtio_mmio_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(virtio_mmio_freeze, virtio_mmio_restore)
+       .freeze         = virtio_mmio_freeze,
+       .restore        = virtio_mmio_restore,
+       .suspend        = virtio_mmio_suspend,
+       .resume         = virtio_mmio_resume,
+       .suspend_late   = virtio_mmio_suspend_late,
+       .resume_early   = virtio_mmio_resume_early,
+       .suspend_noirq  = virtio_mmio_suspend_noirq,
+       .resume_noirq   = virtio_mmio_resume_noirq,
 };
 #endif
 
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index de6041deee37..e88b321408e9 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -145,6 +145,12 @@ void virtio_config_changed(struct virtio_device *dev);
 #ifdef CONFIG_PM_SLEEP
 int virtio_device_freeze(struct virtio_device *dev);
 int virtio_device_restore(struct virtio_device *dev);
+int virtio_device_suspend(struct virtio_device *dev);
+int virtio_device_resume(struct virtio_device *dev);
+int virtio_device_suspend_late(struct virtio_device *dev);
+int virtio_device_resume_early(struct virtio_device *dev);
+int virtio_device_suspend_noirq(struct virtio_device *dev);
+int virtio_device_resume_noirq(struct virtio_device *dev);
 #endif
 void virtio_reset_device(struct virtio_device *dev);
 
@@ -187,6 +193,12 @@ struct virtio_driver {
 #ifdef CONFIG_PM
 	int (*freeze)(struct virtio_device *dev);
 	int (*restore)(struct virtio_device *dev);
+	int (*suspend)(struct virtio_device *dev);
+	int (*resume)(struct virtio_device *dev);
+	int (*suspend_late)(struct virtio_device *dev);
+	int (*resume_early)(struct virtio_device *dev);
+	int (*suspend_noirq)(struct virtio_device *dev);
+	int (*resume_noirq)(struct virtio_device *dev);
 #endif
 };
 

base-commit: 3f01e9fed8454dcd89727016c3e5b2fbb8f8e50c
-- 
2.17.1

