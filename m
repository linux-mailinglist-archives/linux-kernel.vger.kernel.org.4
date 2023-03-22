Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7556C4CD4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjCVOES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjCVOEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:04:13 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790A624733;
        Wed, 22 Mar 2023 07:04:12 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32MBsZHX010968;
        Wed, 22 Mar 2023 14:04:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=GrcH9OwGP0s3q2kLc5+IBzkO2QsYs64mhVYB9WCnCTo=;
 b=D0Rqq9WWsl37PwiQijrdYKNpEy5V4j9V4o0X8/1crceAWBbEPij3B5x1U7ibiqoNI+Hl
 qIeLYS7ldNwDOpPxMHEffs20qPW7cw8vgqb2x9aF1Hnpuk+bAmlhAnE0AFfOfOpYSjBx
 cOrY6hgLeC0O+WFxbLAIe4MlYOl2mgjDtkdBcaLcOBuH/PdIcZ6Jkit5UofoZN9H1T21
 F8gYB2jX/BAUm5shQiQ7qGUSC0U+tRTB+UYnwlvjNzW8hpGKkanJD5P8ZX4dLzoij/Na
 J+2uFmmwWHQNBtUfYv4vNIo8EHc+nqgO915FUwLlSx7Wp8L5mJjuqtZCBBOwqzU2c5lL 7w== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pg17dumh3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 14:03:59 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32MDkB2N001051;
        Wed, 22 Mar 2023 14:03:58 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([9.208.129.119])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3pd4x78m0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 14:03:58 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32ME3vnv29491896
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Mar 2023 14:03:57 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 493F15806F;
        Wed, 22 Mar 2023 14:03:57 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C3E9E5805A;
        Wed, 22 Mar 2023 14:03:55 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.77.129.242])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 22 Mar 2023 14:03:55 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
        andrew@aj.id.au, joel@jms.id.au, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v3 3/4] eeprom: ee1004: Add OF matching support
Date:   Wed, 22 Mar 2023 09:03:47 -0500
Message-Id: <20230322140348.569397-4-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230322140348.569397-1-eajames@linux.ibm.com>
References: <20230322140348.569397-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PwtGncKZ4mGumoWJR2aDyULX4TL5DaKm
X-Proofpoint-GUID: PwtGncKZ4mGumoWJR2aDyULX4TL5DaKm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_11,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303220103
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an OF match table for devicetree instantiation of the
AT30TSE004A EEPROM.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
Changes since v2:
 - Use full model number
 - Fix commit name

 drivers/misc/eeprom/ee1004.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/misc/eeprom/ee1004.c b/drivers/misc/eeprom/ee1004.c
index 0aed5760e370..b7566c1d6edd 100644
--- a/drivers/misc/eeprom/ee1004.c
+++ b/drivers/misc/eeprom/ee1004.c
@@ -58,6 +58,12 @@ static const struct i2c_device_id ee1004_ids[] = {
 };
 MODULE_DEVICE_TABLE(i2c, ee1004_ids);
 
+static const struct of_device_id ee1004_of_match[] = {
+	{ .compatible = "atmel,at30tse004a" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, ee1004_of_match);
+
 /*-------------------------------------------------------------------------*/
 
 static int ee1004_get_current_page(struct ee1004_bus *bus)
@@ -269,6 +275,7 @@ static struct i2c_driver ee1004_driver = {
 	.driver = {
 		.name = "ee1004",
 		.dev_groups = ee1004_groups,
+		.of_match_table = ee1004_of_match,
 	},
 	.probe_new = ee1004_probe,
 	.remove = ee1004_remove,
-- 
2.31.1

