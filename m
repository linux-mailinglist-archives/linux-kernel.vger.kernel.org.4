Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8536DFE16
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 20:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjDLS4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 14:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjDLS4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 14:56:18 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE6330EE
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:56:18 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33CIiXPc002905;
        Wed, 12 Apr 2023 18:56:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=lR3MrlronEpgXpGIZkzM44/5qUvZENCA31eOhQI2jc8=;
 b=bwLC9j/GRU9s8SFKrE3gEt1Kz8+UK60yP7gYKn67Ifw6aGpFUvDLbvZD5NqORtqLierf
 qEJnnleUjNs8mM8vlJ0UGoWr44whmagNAAZXKz0eCkRZKAjWt+zJdKTGLKBM2JCXDUZX
 ebqknFfGxbQg4Kc/0/FPQTA5NWstct00XVvNiXZTNUi/kzso3lVo2INnvfms657CZTNR
 1cJ+nSEhljFg4Hj4JK/gQdKN+kjWjLypLD92Uq2ktUIPhdctzIum3McoD/Z8dNh87z6P
 W9sSzAy5QUZXOofUXw2E6XGxEpaaPowN2T4uBT048WeKltLGKN5lMXkIst9OHfXApmUZ Aw== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3px0aamxb1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 18:56:11 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33CGwRXV013526;
        Wed, 12 Apr 2023 18:56:10 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([9.208.129.119])
        by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3pu0m6qnqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 18:56:10 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33CIu91d35521254
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 18:56:09 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E99BC5805F;
        Wed, 12 Apr 2023 18:56:08 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E077958065;
        Wed, 12 Apr 2023 18:56:07 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.160.16.129])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 12 Apr 2023 18:56:07 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, joel@jms.id.au, jk@ozlabs.org,
        alistair@popple.id.au, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH 1/2] fsi: core: Lock scan mutex for master index removal
Date:   Wed, 12 Apr 2023 13:56:01 -0500
Message-Id: <20230412185602.1592629-2-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230412185602.1592629-1-eajames@linux.ibm.com>
References: <20230412185602.1592629-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fwItIhmNL4A7cirOU_J2x14QFlvSWnSx
X-Proofpoint-ORIG-GUID: fwItIhmNL4A7cirOU_J2x14QFlvSWnSx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_08,2023-04-12_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304120160
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a master scan occurs while the master is being unregistered,
the devicecs may end up with incorrect and possibly duplicate names,
resulting in kernel warnings. Ensure the master index isn't changed
outside of the scan mutex.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index fcbf0469ce3f..18d4d68482d7 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -1354,12 +1354,12 @@ EXPORT_SYMBOL_GPL(fsi_master_register);
 
 void fsi_master_unregister(struct fsi_master *master)
 {
+	mutex_lock(&master->scan_lock);
 	if (master->idx >= 0) {
 		ida_simple_remove(&master_ida, master->idx);
 		master->idx = -1;
 	}
 
-	mutex_lock(&master->scan_lock);
 	fsi_master_unscan(master);
 	mutex_unlock(&master->scan_lock);
 	device_unregister(&master->dev);
-- 
2.31.1

