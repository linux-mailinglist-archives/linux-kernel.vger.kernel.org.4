Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631036AC7EE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 17:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjCFQ3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 11:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjCFQ3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 11:29:03 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D5BA5F3;
        Mon,  6 Mar 2023 08:28:36 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326FrF7E017356;
        Mon, 6 Mar 2023 16:11:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=KJc0ydFTUgIwjCtrGuXVj0xPsA/uMLi0FjiGPI0kMbA=;
 b=hY8ZOxUv5biZkTPrq/BY7fVKfXFAIDujuM2L5SDJgcEqx3Ov8gYKJeeVTtDjXh1PrsH7
 M6bCX9ipx2O7io8MCeYLG+5aeIAXypHkLNxVVJtMg2m4CJUZ8n9XcaHP2xMaHF0ebspG
 kwRo1iqDvHmkj5BAhjnXA8HXDFbBx8BjvQ4i5tUohKIxrXY5zPAmJX0uhex5yT2N7kpH
 oz2yVfhG2DSS8OSb3MkR2suIVZtpFSo5Aner9yY6k8FMYRRsT8nMOMQ8zFRTXsPFkCNy
 C+9X/8Vy+yn2lqzwqLVi3o8qHwO6TH47oTvNX23Yy8FLgq4sClphrx+DWJCXk8UyljAM 0A== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p4vp23hw5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 16:11:18 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 326G5cJN010180;
        Mon, 6 Mar 2023 16:11:17 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([9.208.129.117])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3p419e632q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 16:11:17 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 326GBGCZ4260470
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Mar 2023 16:11:16 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 021EE58059;
        Mon,  6 Mar 2023 16:11:16 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 267C15805B;
        Mon,  6 Mar 2023 16:11:14 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.160.108.29])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Mar 2023 16:11:13 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, alistair@popple.id.au, joel@jms.id.au,
        jk@ozlabs.org, andrew@aj.id.au, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, eajames@linux.ibm.com
Subject: [PATCH v8 8/8] fsi: sbefifo: Don't check status during probe
Date:   Mon,  6 Mar 2023 10:10:56 -0600
Message-Id: <20230306161057.44017-9-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230306161057.44017-1-eajames@linux.ibm.com>
References: <20230306161057.44017-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _GRm8Kz4E-rhTUsgYYNUBbSH2FhkmY1_
X-Proofpoint-GUID: _GRm8Kz4E-rhTUsgYYNUBbSH2FhkmY1_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_08,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0
 mlxlogscore=999 mlxscore=0 priorityscore=1501 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303060142
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

