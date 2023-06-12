Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99FE72CFF1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 21:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238316AbjFLT5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 15:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbjFLT5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 15:57:19 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3807FE71;
        Mon, 12 Jun 2023 12:57:18 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CJk1vO006928;
        Mon, 12 Jun 2023 19:57:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Z50hVAq6eoFMEtoYlp7dlPzK8gihaJtCWPqn2TSso1g=;
 b=b8q/HiE0SM4P8FKcDNxFT92HObAhtyDo8MgVi37gux7CQ20j2e8unby3ImDtOnB+C/d6
 9ZlEAYfYsgMvj1StGE5isI92UI0Hfuq9it/MO3u//lRFzCj0xEQQhnOFecGUmlxXMbU5
 2keLL12EMZQIkRoTOPNCSqnSDmuk/BMjEX7VAd/YGehcId2AmWH5C1x5162oR9doOIZa
 0dEolXbUkQmmCQMcUrSmF5ozbaFW0iolZQBxO5PsxsKZ32WGzq/mcmk1r7OUQEL7Ow70
 wTzU7m1UEe0UvuKrO0eLcvZvtFcbtqknzGx/XoL/6ACI1gRxb5QcTm5LcT0HfTDu/b1e qg== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r69t5885e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 19:57:03 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35CHnIxt002906;
        Mon, 12 Jun 2023 19:57:01 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([9.208.130.98])
        by ppma03wdc.us.ibm.com (PPS) with ESMTPS id 3r4gt5cm98-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 19:57:01 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35CJv1dh3277396
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 19:57:01 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1232B58055;
        Mon, 12 Jun 2023 19:57:01 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C101F58043;
        Mon, 12 Jun 2023 19:57:00 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.148.226])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 12 Jun 2023 19:57:00 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, jk@ozlabs.org, joel@jms.id.au,
        alistair@popple.id.au, andrew@aj.id.au, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 09/14] fsi: core: Fix legacy minor numbering
Date:   Mon, 12 Jun 2023 14:56:52 -0500
Message-Id: <20230612195657.245125-10-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230612195657.245125-1-eajames@linux.ibm.com>
References: <20230612195657.245125-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -2mpnwjYVlo9eDPKlyQGdtdP1Wrh-hd0
X-Proofpoint-ORIG-GUID: -2mpnwjYVlo9eDPKlyQGdtdP1Wrh-hd0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_14,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 suspectscore=0 mlxscore=0 malwarescore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

From: Eddie James <eajames@us.ibm.com>

The legacy minor numbering shifts the chip id too much,
resulting in ids that overlap with regular ids. Since there
are only 2 bits for 4 types, only shift the chip id by 2
to fit the legacy ids in their reserved space.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-core.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 47e47c16d5ed..ea280f149b3f 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -934,8 +934,12 @@ static int __fsi_get_new_minor(struct fsi_slave *slave, enum fsi_dev_type type,
 
 	/* Check if we qualify for legacy numbering */
 	if (cid >= 0 && cid < 16 && type < 4) {
-		/* Try reserving the legacy number */
-		id = (cid << 4) | type;
+		/*
+		 * Try reserving the legacy number, which has 0 - 0x3f reserved
+		 * in the ida range. cid goes up to 0xf and type contains two
+		 * bits, so construct the id with the below two bit shift.
+		 */
+		id = (cid << 2) | type;
 		id = ida_simple_get(&fsi_minor_ida, id, id + 1, GFP_KERNEL);
 		if (id >= 0) {
 			*out_index = fsi_adjust_index(cid);
@@ -970,7 +974,8 @@ int fsi_get_new_minor(struct fsi_device *fdev, enum fsi_dev_type type,
 		int aid = of_alias_get_id(fdev->dev.of_node, fsi_dev_type_names[type]);
 
 		if (aid >= 0) {
-			int id = (aid << 4) | type;
+			/* Use the same scheme as the legacy numbers. */
+			int id = (aid << 2) | type;
 
 			id = ida_simple_get(&fsi_minor_ida, id, id + 1, GFP_KERNEL);
 			if (id >= 0) {
-- 
2.31.1

