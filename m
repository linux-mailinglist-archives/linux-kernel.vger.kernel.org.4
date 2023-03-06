Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1BA6AC868
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 17:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjCFQn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 11:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjCFQnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 11:43:17 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F0A3B651;
        Mon,  6 Mar 2023 08:42:52 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326FnAp2005336;
        Mon, 6 Mar 2023 16:11:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=FiAxevSZDlkHJ7YIX0Hkoj7todOUStrFv0NiEBwrdIw=;
 b=M60D2TuN0vxyGXSfQoM0RTZMdxjGDW7CivJhf/jG38JFeam8B9XEcTUmMmeUXxZ9/2NZ
 p7FK/6+/P0/YMZqgkKXYFNchpQlKZNUcVltEo9YvEJM84Q/3hcovRfSbUiIS+FlV/EV5
 k0k7jeQ+rO3SCZyNl8mSbZ8mT1rxo5GY5aILhpaDZPkG1YD9PIjEqTEolxYdb+NheIfn
 E35W6/xoFhUQjkPaIC+m3Pe6N1QtOoPIUKOKer2idzPy53VVCrH5si1QGL+YQFDLkQIV
 YcYntSRJ761t+4zq9HBJESRq5mB4Cwc+BPyYhPeP7Iphz1/F1/xv2nKIfuJMAhgERZd7 kw== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p50n48ags-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 16:11:13 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 326G1BLg020389;
        Mon, 6 Mar 2023 16:11:13 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([9.208.130.99])
        by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3p419k6348-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 16:11:12 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 326GBBDh33948342
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Mar 2023 16:11:12 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6D4458059;
        Mon,  6 Mar 2023 16:11:11 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 088B15805D;
        Mon,  6 Mar 2023 16:11:10 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.160.108.29])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Mar 2023 16:11:09 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, alistair@popple.id.au, joel@jms.id.au,
        jk@ozlabs.org, andrew@aj.id.au, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, eajames@linux.ibm.com
Subject: [PATCH v8 6/8] fsi: Add aliased device numbering
Date:   Mon,  6 Mar 2023 10:10:54 -0600
Message-Id: <20230306161057.44017-7-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230306161057.44017-1-eajames@linux.ibm.com>
References: <20230306161057.44017-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: APH9o7untAVnaJA7uNrQMju1xJluULqt
X-Proofpoint-GUID: APH9o7untAVnaJA7uNrQMju1xJluULqt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_08,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303060142
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
index 3271e40702ec..48f25dc0fad7 100644
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

