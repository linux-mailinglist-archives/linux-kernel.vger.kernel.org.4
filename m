Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7C86C16F7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 16:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbjCTPKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 11:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbjCTPKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 11:10:10 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D662A17C;
        Mon, 20 Mar 2023 08:05:29 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32KEbRli006686;
        Mon, 20 Mar 2023 15:04:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=sbcm4J2uGMccHXFiI4jv/CBAQt7jKBKzS5MR4N3bNUE=;
 b=S+Va+QTt697D5tJVvi6JTQ13iPw7K751usCwDFJ2zxJWuIdYM9boODQ8Hc4rxLD74Hue
 pkt4VveZ9qvsOrBli9M82fSmjuq5iW3YOttYkZ2Lxpn6qSNJw1a9Xn91HP7ixhkC2+6X
 AcisqWVDAELAl6iL5l1i/TY17o/NrA0kIjRtjoOs3UgID8BaXTej0Pq0BamsEshyXo9N
 xwkIWRpHzXG0BA7TfLhpY2JSTt+p9eheD0J50DP5eIstj48YQ9xiiW2kzJNepDFRelZP
 YyuRx1QA2v6F/jk+N89ZAfnzz7gsh01C3gTPebo6lZ85WCxCMZ8S2p8qqxurxu3yYp7e 3w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3peqvuv28b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 15:04:53 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32KEgALP017620;
        Mon, 20 Mar 2023 15:04:53 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3peqvuv27w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 15:04:53 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32KEtmv2021467;
        Mon, 20 Mar 2023 15:04:52 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([9.208.130.100])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3pd4x70qws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 15:04:52 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32KF4n3H1049232
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Mar 2023 15:04:49 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F71B5805E;
        Mon, 20 Mar 2023 15:04:49 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 66FA75805F;
        Mon, 20 Mar 2023 15:04:48 +0000 (GMT)
Received: from li-2c1e724c-2c76-11b2-a85c-ae42eaf3cb3d.ibm.com.com (unknown [9.65.246.37])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 20 Mar 2023 15:04:48 +0000 (GMT)
From:   Tony Krowiak <akrowiak@linux.ibm.com>
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com,
        jjherne@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com,
        imbrenda@linux.ibm.com, hca@linux.ibm.com
Subject: [PATCH v2] s390/vfio_ap: fix memory leak in vfio_ap device driver
Date:   Mon, 20 Mar 2023 11:04:47 -0400
Message-Id: <20230320150447.34557-1-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZGv7e11yR1FhRlWYheeuhKBHyxIvhDDJ
X-Proofpoint-ORIG-GUID: C4lwPTqHf4vg_XTOvIjzPvev6rbdan7d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_10,2023-03-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 impostorscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303200128
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device release callback function invoked to release the matrix device
uses the dev_get_drvdata(device *dev) function to retrieve the
pointer to the vfio_matrix_dev object in order to free its storage. The
problem is, this object is not stored as drvdata with the device; since the
kfree function will accept a NULL pointer, the memory for the
vfio_matrix_dev object is never freed.

Since the device being released is contained within the vfio_matrix_dev
object, the container_of macro will be used to retrieve its pointer.

Fixes: 1fde573413b5 ("s390: vfio-ap: base implementation of VFIO AP device driver")
Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
index 997b524bdd2b..a48c6938ae68 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -54,8 +54,9 @@ static struct ap_driver vfio_ap_drv = {
 
 static void vfio_ap_matrix_dev_release(struct device *dev)
 {
-	struct ap_matrix_dev *matrix_dev = dev_get_drvdata(dev);
+	struct ap_matrix_dev *matrix_dev;
 
+	matrix_dev = container_of(dev, struct ap_matrix_dev, device);
 	kfree(matrix_dev);
 }
 
-- 
2.31.1

