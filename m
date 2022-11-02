Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538B36165B0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 16:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbiKBPCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 11:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbiKBPCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 11:02:35 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CEC2B257;
        Wed,  2 Nov 2022 08:02:26 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A2E05XA008819;
        Wed, 2 Nov 2022 15:02:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=zK5N0tUMxkW0ERF/PsC0Igelzma3i9op+QdHG5dSdqg=;
 b=W3+P5y0YhNGeVHMAbW2LbpuHNQwrUwj28fuirG8P5i2KjTKBzGUSyJVgBa2r6sAUYjeN
 E9tU1RqZH21fsUPgcZJk8JUmL1XZVQFezQRh+Qkq1eQWR+C+SqsOV44OgoKPtEk6VDuq
 qVa3x6E3doFHQ+enXTKBtcQugwFS/Bfp/IXUcoclkEe6a4TBCfQ053eVM0eUT2WOpXIO
 K3zQ9pD9G/NmdYzMATP9M5XqJIwdYzVWYGj4MPO7vlhHWlkDaAlLzSplnAm09PPAQf9N
 hk7qzg+hQDCBWf7CdeUtedk6smbIjoNNyYc6BV8c5JbnrqXh9g0t6VoRqvo6aWmXu5WA vA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kkqqn02y9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 15:02:00 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A2ETdAC020112;
        Wed, 2 Nov 2022 15:01:59 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kkqqn02wx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 15:01:59 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A2EobSw017362;
        Wed, 2 Nov 2022 15:01:57 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3kgut9706d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 15:01:57 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A2F1shQ35259048
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Nov 2022 15:01:54 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E16F52050;
        Wed,  2 Nov 2022 15:01:54 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 4370A5205F;
        Wed,  2 Nov 2022 15:01:54 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
        id E9ECDE2110; Wed,  2 Nov 2022 16:01:53 +0100 (CET)
From:   Eric Farman <farman@linux.ibm.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>
Cc:     Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Halil Pasic <pasic@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        Eric Auger <eric.auger@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Abhishek Sahu <abhsahu@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v2 4/7] vfio/ccw: move private to mdev lifecycle
Date:   Wed,  2 Nov 2022 16:01:49 +0100
Message-Id: <20221102150152.2521475-5-farman@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221102150152.2521475-1-farman@linux.ibm.com>
References: <20221102150152.2521475-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: h65DhNnbobOubvUrmpquKQGZJN5N56sw
X-Proofpoint-ORIG-GUID: m_i_rIgX4nYbYEfj6UHhMG-Gd70LQkRA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_11,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211020093
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the mdev parent data is split out into its own struct,
it is safe to move the remaining private data to follow the
mdev probe/remove lifecycle. The mdev parent data will remain
where it is, and follow the subchannel and the css driver
interfaces.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_drv.c     | 15 +--------------
 drivers/s390/cio/vfio_ccw_ops.c     | 26 +++++++++++++-------------
 drivers/s390/cio/vfio_ccw_private.h |  2 ++
 3 files changed, 16 insertions(+), 27 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index fd5720cbf005..041cc0860f0e 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -151,7 +151,7 @@ static void vfio_ccw_sch_irq(struct subchannel *sch)
 	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_INTERRUPT);
 }
 
-static void vfio_ccw_free_private(struct vfio_ccw_private *private)
+void vfio_ccw_free_private(struct vfio_ccw_private *private)
 {
 	struct vfio_ccw_crw *crw, *temp;
 
@@ -179,7 +179,6 @@ static void vfio_ccw_free_parent(struct device *dev)
 static int vfio_ccw_sch_probe(struct subchannel *sch)
 {
 	struct pmcw *pmcw = &sch->schib.pmcw;
-	struct vfio_ccw_private *private;
 	struct vfio_ccw_parent *parent;
 	int ret = -ENOMEM;
 
@@ -200,14 +199,7 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
 	if (ret)
 		goto out_free;
 
-	private = kzalloc(sizeof(*private), GFP_KERNEL);
-	if (IS_ERR(private)) {
-		put_device(&parent->dev);
-		return PTR_ERR(private);
-	}
-
 	dev_set_drvdata(&sch->dev, parent);
-	dev_set_drvdata(&parent->dev, private);
 
 	parent->mdev_type.sysfs_name = "io";
 	parent->mdev_type.pretty_name = "I/O subchannel (Non-QDIO)";
@@ -226,9 +218,7 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
 out_unreg:
 	device_unregister(&parent->dev);
 out_free:
-	dev_set_drvdata(&parent->dev, NULL);
 	dev_set_drvdata(&sch->dev, NULL);
-	vfio_ccw_free_private(private);
 	put_device(&parent->dev);
 	return ret;
 }
@@ -236,14 +226,11 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
 static void vfio_ccw_sch_remove(struct subchannel *sch)
 {
 	struct vfio_ccw_parent *parent = dev_get_drvdata(&sch->dev);
-	struct vfio_ccw_private *private = dev_get_drvdata(&parent->dev);
 
 	mdev_unregister_parent(&parent->parent);
 
 	device_unregister(&parent->dev);
 	dev_set_drvdata(&sch->dev, NULL);
-
-	vfio_ccw_free_private(private);
 	put_device(&parent->dev);
 
 	VFIO_CCW_MSG_EVENT(4, "unbound from subchannel %x.%x.%04x\n",
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index eb0b8cc210bb..e45d4acb109b 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -100,15 +100,20 @@ static int vfio_ccw_mdev_probe(struct mdev_device *mdev)
 {
 	struct subchannel *sch = to_subchannel(mdev->dev.parent);
 	struct vfio_ccw_parent *parent = dev_get_drvdata(&sch->dev);
-	struct vfio_ccw_private *private = dev_get_drvdata(&parent->dev);
+	struct vfio_ccw_private *private;
 	int ret;
 
-	if (private->state == VFIO_CCW_STATE_NOT_OPER)
-		return -ENODEV;
+	private = kzalloc(sizeof(*private), GFP_KERNEL);
+	if (!private)
+		return -ENOMEM;
 
 	ret = vfio_init_device(&private->vdev, &mdev->dev, &vfio_ccw_dev_ops);
-	if (ret)
+	if (ret) {
+		kfree(private);
 		return ret;
+	}
+
+	dev_set_drvdata(&parent->dev, private);
 
 	VFIO_CCW_MSG_EVENT(2, "sch %x.%x.%04x: create\n",
 			   sch->schid.cssid,
@@ -122,6 +127,7 @@ static int vfio_ccw_mdev_probe(struct mdev_device *mdev)
 	return 0;
 
 err_put_vdev:
+	dev_set_drvdata(&parent->dev, NULL);
 	vfio_put_device(&private->vdev);
 	return ret;
 }
@@ -131,15 +137,6 @@ static void vfio_ccw_mdev_release_dev(struct vfio_device *vdev)
 	struct vfio_ccw_private *private =
 		container_of(vdev, struct vfio_ccw_private, vdev);
 
-	/*
-	 * We cannot free vfio_ccw_private here because it includes
-	 * parent info which must be free'ed by css driver.
-	 *
-	 * Use a workaround by memset'ing the core device part and
-	 * then notifying the remove path that all active references
-	 * to this device have been released.
-	 */
-	memset(vdev, 0, sizeof(*vdev));
 	complete(&private->release_comp);
 }
 
@@ -156,6 +153,7 @@ static void vfio_ccw_mdev_remove(struct mdev_device *mdev)
 
 	vfio_unregister_group_dev(&private->vdev);
 
+	dev_set_drvdata(&parent->dev, NULL);
 	vfio_put_device(&private->vdev);
 	/*
 	 * Wait for all active references on mdev are released so it
@@ -166,6 +164,8 @@ static void vfio_ccw_mdev_remove(struct mdev_device *mdev)
 	 * cycle.
 	 */
 	wait_for_completion(&private->release_comp);
+
+	vfio_ccw_free_private(private);
 }
 
 static int vfio_ccw_mdev_open_device(struct vfio_device *vdev)
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
index 55d636225cff..747aba5f5272 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -134,6 +134,8 @@ int vfio_ccw_sch_quiesce(struct subchannel *sch);
 void vfio_ccw_sch_io_todo(struct work_struct *work);
 void vfio_ccw_crw_todo(struct work_struct *work);
 
+void vfio_ccw_free_private(struct vfio_ccw_private *private);
+
 extern struct mdev_driver vfio_ccw_mdev_driver;
 
 /*
-- 
2.34.1

