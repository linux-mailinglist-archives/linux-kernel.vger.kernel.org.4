Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C716AC831
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 17:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjCFQgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 11:36:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjCFQfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 11:35:51 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A4939BA1;
        Mon,  6 Mar 2023 08:35:19 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326Er8gS017378;
        Mon, 6 Mar 2023 16:11:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=++FuhlHztEop4Uig5L1dBZosNZIyBfh5t9N+NcII+ow=;
 b=WYyQF+1ZnyfpnGUnRv0g8PHg/JVLXozfapFl20oDkdVXFSSunHcpaiaWJLYpt5hhlX+m
 KP8RjMAVFKxGToU6qvLIKySaOn9g0a0jibINxWWMnRVznbTzg2Cp38n/9adRYuMkNkpM
 bcr58CI5H4WD5kIkW9d7Iv167mM233DG8tWaRa+/xVVUjm6IJQEIFGWnW0RNYNXptpuu
 EfgFx6TcT/BMg+RYMl8L1dpXrIC1sp4RO6mrLJqy3ODjMDNVx/9UvTPLG1H+QsutUR/u
 6H/zldKTMbm5BWEZ1xaXDli/+5ysrnafY22LvbneXaB7JBttTzoWH2vzQXT8aiI4bhFE zQ== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p50vmgetr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 16:11:06 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 326G1TYH015321;
        Mon, 6 Mar 2023 16:11:05 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([9.208.129.117])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3p4199hk1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 16:11:05 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 326GB31l49021300
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Mar 2023 16:11:03 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D3F458058;
        Mon,  6 Mar 2023 16:11:03 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C38C458059;
        Mon,  6 Mar 2023 16:11:01 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.160.108.29])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Mar 2023 16:11:01 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, alistair@popple.id.au, joel@jms.id.au,
        jk@ozlabs.org, andrew@aj.id.au, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, eajames@linux.ibm.com
Subject: [PATCH v8 2/8] fsi: Make master device indexing and naming optional
Date:   Mon,  6 Mar 2023 10:10:50 -0600
Message-Id: <20230306161057.44017-3-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230306161057.44017-1-eajames@linux.ibm.com>
References: <20230306161057.44017-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wmkguqJmclJLF4rXpk8AUjMG1ui0b-cM
X-Proofpoint-ORIG-GUID: wmkguqJmclJLF4rXpk8AUjMG1ui0b-cM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_08,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 adultscore=0 mlxscore=0 phishscore=0 spamscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303060142
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some FSI masters need different device naming, so make the indexing and naming
an optional part of FSI master registration.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-core.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index d591e68afd11..3271e40702ec 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -1297,11 +1297,16 @@ int fsi_master_register(struct fsi_master *master)
 	struct device_node *np;
 
 	mutex_init(&master->scan_lock);
-	master->idx = ida_simple_get(&master_ida, 0, INT_MAX, GFP_KERNEL);
-	if (master->idx < 0)
-		return master->idx;
 
-	dev_set_name(&master->dev, "fsi%d", master->idx);
+	if (!master->idx) {
+		master->idx = ida_simple_get(&master_ida, 0, INT_MAX,
+					     GFP_KERNEL);
+		if (master->idx < 0)
+			return master->idx;
+
+		dev_set_name(&master->dev, "fsi%d", master->idx);
+	}
+
 	master->dev.class = &fsi_master_class;
 
 	rc = device_register(&master->dev);
-- 
2.31.1

