Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1347774AEE5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 12:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbjGGKoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 06:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbjGGKoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 06:44:16 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB4010E2;
        Fri,  7 Jul 2023 03:44:14 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 367Adhqi000645;
        Fri, 7 Jul 2023 10:44:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=3kmISSrzganXOnjVP+9ZKmumyMf+Nbe/QCVQo+hbBhw=;
 b=VHrIfABnrtsYQ0CiZj0foiqLPyv5ei7h0JQKH1SzlHSTwCFRBK1W8XnsjVdqP0zalalL
 mSKA7xyi26h2jeOSnEDhTgw8A6QOpddoXS3gfwJQMSNwE52khep1kbI9Qbo0wEZTfLMg
 O3J9O/d70w4IN63ts9PGPstaDZPofC4aKZV2hvecA+dZGzKAobk0Fozisqmk1w5VIDsl
 y7GBzBAg8N43FCMlwsTSGAg4J0UZzbeZjX7ZRwRJ5e7GNMr0ocjQivkwlKFOIZ1cXRYu
 A9F5AdC9mHUpEcUHG01266fU3shUFKbUVQEWqNsPpcPHhNaD92gi4DSR9dDr6LhAFvaZ Sg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rpgw50apg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 10:44:12 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 367AhE86012287;
        Fri, 7 Jul 2023 10:44:12 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rpgw50ant-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 10:44:12 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3676w1qk014731;
        Fri, 7 Jul 2023 10:44:10 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3rjbde3xqu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 10:44:10 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 367Ai2jH19726954
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Jul 2023 10:44:02 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E82BB20063;
        Fri,  7 Jul 2023 10:44:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6375420040;
        Fri,  7 Jul 2023 10:44:01 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  7 Jul 2023 10:44:01 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Paolo Abeni <pabeni@redhat.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        Stefan Raspl <raspl@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net v2 2/3] s390/ism: Fix and simplify add()/remove() callback handling
Date:   Fri,  7 Jul 2023 12:43:58 +0200
Message-Id: <20230707104359.3324039-3-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230707104359.3324039-1-schnelle@linux.ibm.com>
References: <20230707104359.3324039-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wsfRGkosQvCZvc7aRIZ466DEzzNXLSvK
X-Proofpoint-ORIG-GUID: EyByd6bf-1JMg4NDGqyQNEs39WFTH0cP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_06,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2307070097
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously the clients_lock was protecting the clients array against
concurrent addition/removal of clients but was also accessed from IRQ
context. This meant that it had to be a spinlock and that the add() and
remove() callbacks in which clients need to do allocation and take
mutexes can't be called under the clients_lock. To work around this these
callbacks were moved to workqueues. This not only introduced significant
complexity but is also subtly broken in at least one way.

In ism_dev_init() and ism_dev_exit() clients[i]->tgt_ism is used to
communicate the added/removed ISM device to the work function. While
write access to client[i]->tgt_ism is protected by the clients_lock and
the code waits that there is no pending add/remove work before and after
setting clients[i]->tgt_ism this is not enough. The problem is that the
wait happens based on per ISM device counters. Thus a concurrent
ism_dev_init()/ism_dev_exit() for a different ISM device may overwrite
a clients[i]->tgt_ism between unlocking the clients_lock and the
subsequent wait for the work to finnish.

Thankfully with the clients_lock no longer held in IRQ context it can be
turned into a mutex which can be held during the calls to add()/remove()
completely removing the need for the workqueues and the associated
broken housekeeping including the per ISM device counters and the
clients[i]->tgt_ism.

Fixes: 89e7d2ba61b7 ("net/ism: Add new API for client registration")
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/s390/net/ism_drv.c | 90 +++++++++++---------------------------
 include/linux/ism.h        |  6 ---
 2 files changed, 26 insertions(+), 70 deletions(-)

diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index b664e4a08645..54091b7aea16 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -36,7 +36,7 @@ static const struct smcd_ops ism_ops;
 static struct ism_client *clients[MAX_CLIENTS];	/* use an array rather than */
 						/* a list for fast mapping  */
 static u8 max_client;
-static DEFINE_SPINLOCK(clients_lock);
+static DEFINE_MUTEX(clients_lock);
 struct ism_dev_list {
 	struct list_head list;
 	struct mutex mutex; /* protects ism device list */
@@ -59,11 +59,10 @@ static void ism_setup_forwarding(struct ism_client *client, struct ism_dev *ism)
 int ism_register_client(struct ism_client *client)
 {
 	struct ism_dev *ism;
-	unsigned long flags;
 	int i, rc = -ENOSPC;
 
 	mutex_lock(&ism_dev_list.mutex);
-	spin_lock_irqsave(&clients_lock, flags);
+	mutex_lock(&clients_lock);
 	for (i = 0; i < MAX_CLIENTS; ++i) {
 		if (!clients[i]) {
 			clients[i] = client;
@@ -74,7 +73,8 @@ int ism_register_client(struct ism_client *client)
 			break;
 		}
 	}
-	spin_unlock_irqrestore(&clients_lock, flags);
+	mutex_unlock(&clients_lock);
+
 	if (i < MAX_CLIENTS) {
 		/* initialize with all devices that we got so far */
 		list_for_each_entry(ism, &ism_dev_list.list, list) {
@@ -96,11 +96,11 @@ int ism_unregister_client(struct ism_client *client)
 	int rc = 0;
 
 	mutex_lock(&ism_dev_list.mutex);
-	spin_lock_irqsave(&clients_lock, flags);
+	mutex_lock(&clients_lock);
 	clients[client->id] = NULL;
 	if (client->id + 1 == max_client)
 		max_client--;
-	spin_unlock_irqrestore(&clients_lock, flags);
+	mutex_unlock(&clients_lock);
 	list_for_each_entry(ism, &ism_dev_list.list, list) {
 		spin_lock_irqsave(&ism->lock, flags);
 		/* Stop forwarding IRQs and events */
@@ -571,21 +571,9 @@ static u64 ism_get_local_gid(struct ism_dev *ism)
 	return ism->local_gid;
 }
 
-static void ism_dev_add_work_func(struct work_struct *work)
-{
-	struct ism_client *client = container_of(work, struct ism_client,
-						 add_work);
-
-	client->add(client->tgt_ism);
-	ism_setup_forwarding(client, client->tgt_ism);
-	atomic_dec(&client->tgt_ism->add_dev_cnt);
-	wake_up(&client->tgt_ism->waitq);
-}
-
 static int ism_dev_init(struct ism_dev *ism)
 {
 	struct pci_dev *pdev = ism->pdev;
-	unsigned long flags;
 	int i, ret;
 
 	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI);
@@ -618,25 +606,16 @@ static int ism_dev_init(struct ism_dev *ism)
 		/* hardware is V2 capable */
 		ism_create_system_eid();
 
-	init_waitqueue_head(&ism->waitq);
-	atomic_set(&ism->free_clients_cnt, 0);
-	atomic_set(&ism->add_dev_cnt, 0);
-
-	wait_event(ism->waitq, !atomic_read(&ism->add_dev_cnt));
-	spin_lock_irqsave(&clients_lock, flags);
-	for (i = 0; i < max_client; ++i)
-		if (clients[i]) {
-			INIT_WORK(&clients[i]->add_work,
-				  ism_dev_add_work_func);
-			clients[i]->tgt_ism = ism;
-			atomic_inc(&ism->add_dev_cnt);
-			schedule_work(&clients[i]->add_work);
-		}
-	spin_unlock_irqrestore(&clients_lock, flags);
-
-	wait_event(ism->waitq, !atomic_read(&ism->add_dev_cnt));
-
 	mutex_lock(&ism_dev_list.mutex);
+	mutex_lock(&clients_lock);
+	for (i = 0; i < max_client; ++i) {
+		if (clients[i]) {
+			clients[i]->add(ism);
+			ism_setup_forwarding(clients[i], ism);
+		}
+	}
+	mutex_unlock(&clients_lock);
+
 	list_add(&ism->list, &ism_dev_list.list);
 	mutex_unlock(&ism_dev_list.mutex);
 
@@ -711,40 +690,24 @@ static int ism_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return ret;
 }
 
-static void ism_dev_remove_work_func(struct work_struct *work)
-{
-	struct ism_client *client = container_of(work, struct ism_client,
-						 remove_work);
-	unsigned long flags;
-
-	spin_lock_irqsave(&client->tgt_ism->lock, flags);
-	client->tgt_ism->subs[client->id] = NULL;
-	spin_unlock_irqrestore(&client->tgt_ism->lock, flags);
-	client->remove(client->tgt_ism);
-	atomic_dec(&client->tgt_ism->free_clients_cnt);
-	wake_up(&client->tgt_ism->waitq);
-}
-
-/* Callers must hold ism_dev_list.mutex */
 static void ism_dev_exit(struct ism_dev *ism)
 {
 	struct pci_dev *pdev = ism->pdev;
 	unsigned long flags;
 	int i;
 
-	wait_event(ism->waitq, !atomic_read(&ism->free_clients_cnt));
-	spin_lock_irqsave(&clients_lock, flags);
+	spin_lock_irqsave(&ism->lock, flags);
 	for (i = 0; i < max_client; ++i)
-		if (clients[i]) {
-			INIT_WORK(&clients[i]->remove_work,
-				  ism_dev_remove_work_func);
-			clients[i]->tgt_ism = ism;
-			atomic_inc(&ism->free_clients_cnt);
-			schedule_work(&clients[i]->remove_work);
-		}
-	spin_unlock_irqrestore(&clients_lock, flags);
+		ism->subs[i] = NULL;
+	spin_unlock_irqrestore(&ism->lock, flags);
 
-	wait_event(ism->waitq, !atomic_read(&ism->free_clients_cnt));
+	mutex_lock(&ism_dev_list.mutex);
+	mutex_lock(&clients_lock);
+	for (i = 0; i < max_client; ++i) {
+		if (clients[i])
+			clients[i]->remove(ism);
+	}
+	mutex_unlock(&clients_lock);
 
 	if (SYSTEM_EID.serial_number[0] != '0' ||
 	    SYSTEM_EID.type[0] != '0')
@@ -755,15 +718,14 @@ static void ism_dev_exit(struct ism_dev *ism)
 	kfree(ism->sba_client_arr);
 	pci_free_irq_vectors(pdev);
 	list_del_init(&ism->list);
+	mutex_unlock(&ism_dev_list.mutex);
 }
 
 static void ism_remove(struct pci_dev *pdev)
 {
 	struct ism_dev *ism = dev_get_drvdata(&pdev->dev);
 
-	mutex_lock(&ism_dev_list.mutex);
 	ism_dev_exit(ism);
-	mutex_unlock(&ism_dev_list.mutex);
 
 	pci_release_mem_regions(pdev);
 	pci_disable_device(pdev);
diff --git a/include/linux/ism.h b/include/linux/ism.h
index 5160d47e5ea9..9a4c204df3da 100644
--- a/include/linux/ism.h
+++ b/include/linux/ism.h
@@ -45,9 +45,6 @@ struct ism_dev {
 	int ieq_idx;
 
 	struct ism_client *subs[MAX_CLIENTS];
-	atomic_t free_clients_cnt;
-	atomic_t add_dev_cnt;
-	wait_queue_head_t waitq;
 };
 
 struct ism_event {
@@ -69,9 +66,6 @@ struct ism_client {
 	 */
 	void (*handle_irq)(struct ism_dev *dev, unsigned int bit, u16 dmbemask);
 	/* Private area - don't touch! */
-	struct work_struct remove_work;
-	struct work_struct add_work;
-	struct ism_dev *tgt_ism;
 	u8 id;
 };
 
-- 
2.39.2

