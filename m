Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D849D607A08
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 16:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiJUO7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 10:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJUO7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 10:59:09 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2A95F5C;
        Fri, 21 Oct 2022 07:59:08 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29LELHUn005222;
        Fri, 21 Oct 2022 14:59:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=HwTKiXCYYiWue8m4cdSl19l/YvBjk+Ld7zKbzBxK7xQ=;
 b=EhnmG7wWZvgHdpsJR4hpRe3www84gqtmidoa9qC36xYFKPYMYYU73F/r9giT23mrLGst
 O+CvyjFHH46q6idJH8zRBGhMVSwKi2Zi8/dWWtZN4Lcc7UcuTB58hGH+wcel20YXx8wF
 fy8DAMSi/LbhCJQZT72RMgNjEymVUW5DonsFts9ZGSiWi7JatDP6eyNOUKYDqZ/fPK5L
 DmhWsOoMxCxxW/l+QqRcJ1MJIQ7xFkoKEFd3u/TWaRNta80PeRZdDSUfZSKuL9CqxcLR
 zzQQRhFuHFktJYMKJNYUyrYaX0o+qx30IKGf6Y9jS3ZQ08sjXYlkulA4SafjEbVuP9Eb KQ== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kbw4214x8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 14:59:08 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29LEpUEY020627;
        Fri, 21 Oct 2022 14:59:07 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma03dal.us.ibm.com with ESMTP id 3kapd5jw4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 14:59:07 +0000
Received: from smtpav06.dal12v.mail.ibm.com ([9.208.128.130])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29LEx5GB4522534
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 14:59:05 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2625058055;
        Fri, 21 Oct 2022 14:59:06 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C1C1758043;
        Fri, 21 Oct 2022 14:59:05 +0000 (GMT)
Received: from jason-laptop.endicott.ibm.com (unknown [9.60.75.234])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 21 Oct 2022 14:59:05 +0000 (GMT)
From:   "Jason J. Herne" <jjherne@linux.ibm.com>
To:     linux-s390@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] s390/vfio-ap: Fix memory allocation for mdev_types array
Date:   Fri, 21 Oct 2022 10:59:05 -0400
Message-Id: <20221021145905.15100-1-jjherne@linux.ibm.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: H-t_GqBm10l6j5aljCXiB7vV5SNLRZ4p
X-Proofpoint-ORIG-GUID: H-t_GqBm10l6j5aljCXiB7vV5SNLRZ4p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 malwarescore=0 impostorscore=0 clxscore=1011 phishscore=0
 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=937 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210210088
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vfio-ap crypto driver fails to allocate memory for an array of
pointers used to pass supported mdev types to mdev_register_parent().

Since we only support a single mdev type, the fix is to allocate a
single entry in the ap_matrix_dev->mdev_types array.

Fixes: 63e685747784 ("s390: vfio-ap: base implementation of VFIO AP device driver")
Cc: stable@vger.kernel.org
Cc: Tony Krowiak <akrowiak@linux.ibm.com>
Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_private.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 2eddd5f34ed3..976a65f32e7d 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -52,7 +52,7 @@ struct ap_matrix_dev {
 	struct mutex guests_lock; /* serializes access to each KVM guest */
 	struct mdev_parent parent;
 	struct mdev_type mdev_type;
-	struct mdev_type *mdev_types[];
+	struct mdev_type *mdev_types[1];
 };
 
 extern struct ap_matrix_dev *matrix_dev;
-- 
2.37.3

