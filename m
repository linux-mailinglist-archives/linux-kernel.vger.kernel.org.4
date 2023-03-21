Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6FA16C3562
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjCUPRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjCUPRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:17:17 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F433BDBB;
        Tue, 21 Mar 2023 08:17:15 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32LEh3JZ016684;
        Tue, 21 Mar 2023 15:16:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=vbLhpg+PI2Rym4W/kWQG3RHITMxtpIWM1agvPvo6g0A=;
 b=B6d5SdVzpiGIxzuKxR/wWjNXk8Uor5NdEtqSOyox6/6H1I3DZS75T4WfjEvAC/t/K+5w
 OElCcjleJsDhZmBi8pPjXcD7KmkdY4ZOsEWN8cxcU26BDOcRy5/bRgzTTivxvfqkU+Bk
 UhTGok+I50jhyNsRwvXn4onEOlZPRZFPZHhC2eNT5ASuj1kkUS+F6Fl7ZUTYX63TEqpG
 T+1XwukgqnuEgIcU+KUkU156BwbQXNNg7+ERHDpxfN+Ail0+V4cTiswdzQqserB3/eRZ
 46DG9sZv1v/1UU6JoG5s4X8iLxI6O2e5lFRJF8oQAW9t5VTggzpxaIB/NAyoR5Ze/c9e EQ== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pf92421s3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Mar 2023 15:16:58 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32LF2HbD032441;
        Tue, 21 Mar 2023 15:16:57 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([9.208.130.100])
        by ppma05wdc.us.ibm.com (PPS) with ESMTPS id 3pd4x736jn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Mar 2023 15:16:57 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32LFGuhc6160974
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 15:16:56 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E52658066;
        Tue, 21 Mar 2023 15:16:56 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ABF5D58065;
        Tue, 21 Mar 2023 15:16:54 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.160.111.39])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 21 Mar 2023 15:16:54 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
        andrew@aj.id.au, joel@jms.id.au, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v2 3/4] eeprom: ee1004: Add devicetree binding
Date:   Tue, 21 Mar 2023 10:16:41 -0500
Message-Id: <20230321151642.461618-4-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230321151642.461618-1-eajames@linux.ibm.com>
References: <20230321151642.461618-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 79e012hUrlu-aSBvM21uiScPTC0ymbzc
X-Proofpoint-ORIG-GUID: 79e012hUrlu-aSBvM21uiScPTC0ymbzc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_11,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303210118
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an OF match table for devicetree instantiation of EE1004
devices.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/misc/eeprom/ee1004.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/misc/eeprom/ee1004.c b/drivers/misc/eeprom/ee1004.c
index 950813821087..72068bb72621 100644
--- a/drivers/misc/eeprom/ee1004.c
+++ b/drivers/misc/eeprom/ee1004.c
@@ -59,6 +59,12 @@ static const struct i2c_device_id ee1004_ids[] = {
 };
 MODULE_DEVICE_TABLE(i2c, ee1004_ids);
 
+static const struct of_device_id ee1004_of_match[] = {
+	{ .compatible = "atmel,at30tse" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, ee1004_of_match);
+
 /*-------------------------------------------------------------------------*/
 
 static int ee1004_get_current_page(struct ee1004_bus *bus)
@@ -270,6 +276,7 @@ static struct i2c_driver ee1004_driver = {
 	.driver = {
 		.name = "ee1004",
 		.dev_groups = ee1004_groups,
+		.of_match_table = ee1004_of_match,
 	},
 	.probe_new = ee1004_probe,
 	.remove = ee1004_remove,
-- 
2.31.1

