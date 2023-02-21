Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40E069E978
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 22:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjBUV1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 16:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjBUV0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 16:26:55 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D01F31E2E;
        Tue, 21 Feb 2023 13:26:52 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31LLHNOo021477;
        Tue, 21 Feb 2023 21:26:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=tlmEo/kVrmSoI+f5eQKxgmNkhnCo7i/A1GBB4psqyLY=;
 b=OBl7OMbKnNLv4HIVMcac0weSE79GaNK7Nh9Sz0ZxWNFD3kdTzhit0RhVj5DOEqFtOEdg
 h8TONH3PEKly282q5v9oEQFEGE+IuMRK5azooUB+KV0eh4WhEqk3hhTHv+9/OkyvqDcE
 cJGRzFZ5M370zF07F8G4y5UFTgPV1fTrPLed9jcCuyio3gLzDZ4G+m8qxx4NQQoMwtu4
 Z92h7DUSYNH01wjJ1Yi1iVFZD9XP33TrOHk21ws6vybkfWjM8EFZesc2E6+uuAwkwMx7
 juEMzy/0ZPQYQX9OfVGvXuVZa/f1927hwSYsYqI+nb/hiuj5vOBnIrPkr5/7KRsX9LpO Jg== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nw408anp9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 21:26:37 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31LHk5Fk016332;
        Tue, 21 Feb 2023 21:26:36 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([9.208.129.116])
        by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3ntpa7cve1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 21:26:36 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31LLQZR78913528
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Feb 2023 21:26:35 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A46858058;
        Tue, 21 Feb 2023 21:26:35 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53F3658059;
        Tue, 21 Feb 2023 21:26:33 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.65.223.120])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 21 Feb 2023 21:26:33 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, alistair@popple.id.au, joel@jms.id.au,
        jk@ozlabs.org, andrew@aj.id.au, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, eajames@linux.ibm.com
Subject: [PATCH v5 5/6] fsi: Add aliased device numbering
Date:   Tue, 21 Feb 2023 15:26:21 -0600
Message-Id: <20230221212622.3897097-6-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230221212622.3897097-1-eajames@linux.ibm.com>
References: <20230221212622.3897097-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HAWDVR9h4wuQ3VjHjodaFyZzJAigu9dU
X-Proofpoint-ORIG-GUID: HAWDVR9h4wuQ3VjHjodaFyZzJAigu9dU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_12,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302210182
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The I2C and SPI subsystems can use an aliased name to number the device.
Add similar support to the FSI subsystem for any device type.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-core.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index d591e68afd11..b77013b9d8a7 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -955,9 +955,34 @@ static int __fsi_get_new_minor(struct fsi_slave *slave, enum fsi_dev_type type,
 	return 0;
 }
 
+static const char *const fsi_dev_type_names[] = {
+	"cfam",
+	"sbefifo",
+	"scom",
+	"occ",
+};
+
 int fsi_get_new_minor(struct fsi_device *fdev, enum fsi_dev_type type,
 		      dev_t *out_dev, int *out_index)
 {
+	if (fdev->dev.of_node) {
+		int aid = of_alias_get_id(fdev->dev.of_node, fsi_dev_type_names[type]);
+
+		if (aid >= 0) {
+			int id = (aid << 4) | type;
+
+			id = ida_simple_get(&fsi_minor_ida, id, id + 1, GFP_KERNEL);
+			if (id >= 0) {
+				*out_index = aid;
+				*out_dev = fsi_base_dev + id;
+				return 0;
+			}
+
+			if (id != -ENOSPC)
+				return id;
+		}
+	}
+
 	return __fsi_get_new_minor(fdev->slave, type, out_dev, out_index);
 }
 EXPORT_SYMBOL_GPL(fsi_get_new_minor);
-- 
2.31.1

