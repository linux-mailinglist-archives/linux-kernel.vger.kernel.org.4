Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B5172CFF9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 21:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbjFLT54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 15:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234400AbjFLT5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 15:57:19 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12CAE77;
        Mon, 12 Jun 2023 12:57:18 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CJokTh021189;
        Mon, 12 Jun 2023 19:57:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=6fYsGoqmdKHTOzWXutB3JtgK6QmYKKedH3x7L/igIf4=;
 b=h/ffu0Krm9yQNL99rAcKMBGfK/U0FhUusCxHZ/GTiHh9KPNN2L8TTWCrh+dwRB4G2FlY
 04DeRU9RndwvtzKZC06j2B4NeRZN9EB0/FiiVofA9w5YUmL48ky0MeyrthddkJDH/RtN
 EsFizATMmSk3tOAuMk9IrQm78AsGaLuhaKdyiYfhGAXCcjUBXuk1n7OIAMr+CGUfc1aL
 pAj8fq46IooxEAJpVjgL6W8nwh0ErfewNmvMilWSClzFLkI9U8T5tOe9tUSp/ppbrr9T
 aqy4vRQq5z3YaDwUIc8eDrySZMwXKtBuu4XNZcxBhQlzZphdQSGvQ/a3kPWdrMCxF2vH 4A== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r69vjg2wn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 19:57:03 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35CJSw0k011868;
        Mon, 12 Jun 2023 19:57:02 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([9.208.130.98])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3r4gt5krsh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 19:57:02 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35CJv1FH3277398
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 19:57:01 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6359858043;
        Mon, 12 Jun 2023 19:57:01 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1BBC85805D;
        Mon, 12 Jun 2023 19:57:01 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.148.226])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 12 Jun 2023 19:57:01 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, jk@ozlabs.org, joel@jms.id.au,
        alistair@popple.id.au, andrew@aj.id.au, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 10/14] fsi: core: Switch to ida_alloc/free
Date:   Mon, 12 Jun 2023 14:56:53 -0500
Message-Id: <20230612195657.245125-11-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230612195657.245125-1-eajames@linux.ibm.com>
References: <20230612195657.245125-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: R6gZ3YMJcpz_B0JAp8hBCMVtv35a_7y6
X-Proofpoint-GUID: R6gZ3YMJcpz_B0JAp8hBCMVtv35a_7y6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_14,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 clxscore=1015 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306120169
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ida_simple_get/remove are deprecated, so switch to ida_alloc/free.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index ea280f149b3f..ec4d02264391 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -940,7 +940,7 @@ static int __fsi_get_new_minor(struct fsi_slave *slave, enum fsi_dev_type type,
 		 * bits, so construct the id with the below two bit shift.
 		 */
 		id = (cid << 2) | type;
-		id = ida_simple_get(&fsi_minor_ida, id, id + 1, GFP_KERNEL);
+		id = ida_alloc_range(&fsi_minor_ida, id, id, GFP_KERNEL);
 		if (id >= 0) {
 			*out_index = fsi_adjust_index(cid);
 			*out_dev = fsi_base_dev + id;
@@ -951,8 +951,8 @@ static int __fsi_get_new_minor(struct fsi_slave *slave, enum fsi_dev_type type,
 			return id;
 		/* Fallback to non-legacy allocation */
 	}
-	id = ida_simple_get(&fsi_minor_ida, FSI_CHAR_LEGACY_TOP,
-			    FSI_CHAR_MAX_DEVICES, GFP_KERNEL);
+	id = ida_alloc_range(&fsi_minor_ida, FSI_CHAR_LEGACY_TOP,
+			     FSI_CHAR_MAX_DEVICES - 1, GFP_KERNEL);
 	if (id < 0)
 		return id;
 	*out_index = fsi_adjust_index(id);
@@ -977,7 +977,7 @@ int fsi_get_new_minor(struct fsi_device *fdev, enum fsi_dev_type type,
 			/* Use the same scheme as the legacy numbers. */
 			int id = (aid << 2) | type;
 
-			id = ida_simple_get(&fsi_minor_ida, id, id + 1, GFP_KERNEL);
+			id = ida_alloc_range(&fsi_minor_ida, id, id, GFP_KERNEL);
 			if (id >= 0) {
 				*out_index = aid;
 				*out_dev = fsi_base_dev + id;
@@ -995,7 +995,7 @@ EXPORT_SYMBOL_GPL(fsi_get_new_minor);
 
 void fsi_free_minor(dev_t dev)
 {
-	ida_simple_remove(&fsi_minor_ida, MINOR(dev));
+	ida_free(&fsi_minor_ida, MINOR(dev));
 }
 EXPORT_SYMBOL_GPL(fsi_free_minor);
 
@@ -1330,7 +1330,7 @@ int fsi_master_register(struct fsi_master *master)
 	struct device_node *np;
 
 	mutex_init(&master->scan_lock);
-	master->idx = ida_simple_get(&master_ida, 0, INT_MAX, GFP_KERNEL);
+	master->idx = ida_alloc(&master_ida, GFP_KERNEL);
 	if (master->idx < 0)
 		return master->idx;
 
@@ -1339,7 +1339,7 @@ int fsi_master_register(struct fsi_master *master)
 
 	rc = device_register(&master->dev);
 	if (rc) {
-		ida_simple_remove(&master_ida, master->idx);
+		ida_free(&master_ida, master->idx);
 		return rc;
 	}
 
@@ -1359,7 +1359,7 @@ void fsi_master_unregister(struct fsi_master *master)
 	trace_fsi_master_unregister(master);
 
 	if (master->idx >= 0) {
-		ida_simple_remove(&master_ida, master->idx);
+		ida_free(&master_ida, master->idx);
 		master->idx = -1;
 	}
 
-- 
2.31.1

