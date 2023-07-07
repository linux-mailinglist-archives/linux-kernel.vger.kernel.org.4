Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBDF74AF33
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 12:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbjGGK4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 06:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232853AbjGGK4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 06:56:37 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34001FEA;
        Fri,  7 Jul 2023 03:56:31 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 367AiQDC009098;
        Fri, 7 Jul 2023 10:56:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=jXhueTSPOHMzlueqvymp8seQ1H++N+GTe725CM9biwY=;
 b=gycLR1ya41kA/wDSyfdQ3X401hBRX/IRT+Wa0heCbNoB6UBcjvHvhH8T/5OQ+F+jP58A
 2Xy0TAuvYA0aWH8uMIxg6faqKFUeyuZw50mDw4CM5hk4hZYC0KBq9LyoUByq2UA08Y0p
 ZGNdhinTnWpO0v9mPTSA7HxebGDbujHmWtKQgp1dIsv7QoYMxMwpvjn+t5YSGy2Aixvy
 acmj1/DurWxP596pWw+HGnjtWb18oRJJq0ZV2CW7qCjQATFPSMsLQvEK32xmOb01VdIt
 yMryd5+y+WkzU0OXzp0OXwLPjgtxKckJpaYeRemu0OzIL4BOqGbY525HL/DQyZPwyzM6 Vg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rph768840-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 10:56:31 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 367AjHWb011549;
        Fri, 7 Jul 2023 10:56:30 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rph76882y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 10:56:30 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3674pEjd002638;
        Fri, 7 Jul 2023 10:56:28 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3rjbde3xvy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 10:56:28 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 367AuOGf9765432
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Jul 2023 10:56:25 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1F4020040;
        Fri,  7 Jul 2023 10:56:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 797902004E;
        Fri,  7 Jul 2023 10:56:24 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  7 Jul 2023 10:56:24 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Paolo Abeni <pabeni@redhat.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        Stefan Raspl <raspl@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net v2 3/3] s390/ism: Do not unregister clients with registered DMBs
Date:   Fri,  7 Jul 2023 12:56:22 +0200
Message-Id: <20230707105622.3332261-4-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230707105622.3332261-1-schnelle@linux.ibm.com>
References: <20230707105622.3332261-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eF6GmWa2em_q6HOwZDmSWChiC5_9b-Dt
X-Proofpoint-GUID: -xqR_-d9SHz2JVE0DnHrpavlIJTqY8uC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_06,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307070097
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When ism_unregister_client() is called but the client still has DMBs
registered it returns -EBUSY and prints an error. This only happens
after the client has already been unregistered however. This is
unexpected as the unregister claims to have failed. Furthermore as this
implies a client bug a WARN() is more appropriate. Thus move the
deregistration after the check and use WARN().

Fixes: 89e7d2ba61b7 ("net/ism: Add new API for client registration")
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/s390/net/ism_drv.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index 54091b7aea16..6df7f377d2f9 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -96,29 +96,32 @@ int ism_unregister_client(struct ism_client *client)
 	int rc = 0;
 
 	mutex_lock(&ism_dev_list.mutex);
-	mutex_lock(&clients_lock);
-	clients[client->id] = NULL;
-	if (client->id + 1 == max_client)
-		max_client--;
-	mutex_unlock(&clients_lock);
 	list_for_each_entry(ism, &ism_dev_list.list, list) {
 		spin_lock_irqsave(&ism->lock, flags);
 		/* Stop forwarding IRQs and events */
 		ism->subs[client->id] = NULL;
 		for (int i = 0; i < ISM_NR_DMBS; ++i) {
 			if (ism->sba_client_arr[i] == client->id) {
-				pr_err("%s: attempt to unregister client '%s'"
-				       "with registered dmb(s)\n", __func__,
-				       client->name);
+				WARN(1, "%s: attempt to unregister '%s' with registered dmb(s)\n",
+				     __func__, client->name);
 				rc = -EBUSY;
-				goto out;
+				goto err_reg_dmb;
 			}
 		}
 		spin_unlock_irqrestore(&ism->lock, flags);
 	}
-out:
 	mutex_unlock(&ism_dev_list.mutex);
 
+	mutex_lock(&clients_lock);
+	clients[client->id] = NULL;
+	if (client->id + 1 == max_client)
+		max_client--;
+	mutex_unlock(&clients_lock);
+	return rc;
+
+err_reg_dmb:
+	spin_unlock_irqrestore(&ism->lock, flags);
+	mutex_unlock(&ism_dev_list.mutex);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(ism_unregister_client);
-- 
2.39.2

