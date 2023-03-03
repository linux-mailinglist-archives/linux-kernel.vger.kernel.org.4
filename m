Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B356A9CB9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 18:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjCCRFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 12:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbjCCREx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 12:04:53 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C5622A17;
        Fri,  3 Mar 2023 09:04:49 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 323Fr1I5000925;
        Fri, 3 Mar 2023 17:04:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=KJc0ydFTUgIwjCtrGuXVj0xPsA/uMLi0FjiGPI0kMbA=;
 b=rYTCT0poTtn9RlOfJmZSP/A/EK9pX19lTc2MK9fRI5nemK4Mh5FbdUfCM0Tbv0VGW2OT
 yEjlP6hB2j6qwmavHaEleSg/yjao3T52seUS6Xt10wPg/z3aj70Z3PSVj6X79onlId+2
 Lqbu5TIZEx9xkqOdYqAIfnGWKEKbrw76XOgPvVrqgZY4H8MmqQ3AVJ+JZks4/ywYY2Df
 KjDS9BRQvsNEjnAUWxKTp0wOiYvI6bd+vF7+JYa9pCR6DR6pVTPVCRv+iLGq2VlzX1DM
 es6vjsdmhb8snX7itXCfL15YlbQBzTDm3EySR2Q4hxq9xpAXo5ybYMYNCwl7bilKoqXR Pg== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3p3kx4a1xj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Mar 2023 17:04:35 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 323EaCb4005832;
        Fri, 3 Mar 2023 17:04:34 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([9.208.130.101])
        by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3nybcgkypx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Mar 2023 17:04:34 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 323H4XFo5636794
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Mar 2023 17:04:34 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C181758043;
        Fri,  3 Mar 2023 17:04:33 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD1AC58061;
        Fri,  3 Mar 2023 17:04:31 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.77.137.234])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  3 Mar 2023 17:04:31 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, alistair@popple.id.au, joel@jms.id.au,
        jk@ozlabs.org, andrew@aj.id.au, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, eajames@linux.ibm.com
Subject: [PATCH v7 7/7] fsi: sbefifo: Don't check status during probe
Date:   Fri,  3 Mar 2023 11:04:16 -0600
Message-Id: <20230303170416.1347530-8-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230303170416.1347530-1-eajames@linux.ibm.com>
References: <20230303170416.1347530-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zeIb4CRhD_XWkIGW4WNIPqhufLQ1-vZe
X-Proofpoint-ORIG-GUID: zeIb4CRhD_XWkIGW4WNIPqhufLQ1-vZe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_03,2023-03-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303030143
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The status check during probe doesn't serve any purpose. Any attempt
to use the SBEFIFO will result in the same check and cleanup.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-sbefifo.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
index 9912b7a6a4b9..42d7c95528d1 100644
--- a/drivers/fsi/fsi-sbefifo.c
+++ b/drivers/fsi/fsi-sbefifo.c
@@ -1027,14 +1027,6 @@ static int sbefifo_probe(struct device *dev)
 	mutex_init(&sbefifo->lock);
 	sbefifo->timeout_start_rsp_ms = SBEFIFO_TIMEOUT_START_RSP;
 
-	/*
-	 * Try cleaning up the FIFO. If this fails, we still register the
-	 * driver and will try cleaning things up again on the next access.
-	 */
-	rc = sbefifo_cleanup_hw(sbefifo);
-	if (rc && rc != -ESHUTDOWN)
-		dev_err(dev, "Initial HW cleanup failed, will retry later\n");
-
 	/* Create chardev for userspace access */
 	sbefifo->dev.type = &fsi_cdev_type;
 	sbefifo->dev.parent = dev;
-- 
2.31.1

