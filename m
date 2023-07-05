Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0FA7483FF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 14:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjGEMRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 08:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjGEMRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 08:17:33 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A541705;
        Wed,  5 Jul 2023 05:17:31 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 365CGfVA028683;
        Wed, 5 Jul 2023 12:17:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=4Nuo+H/4A9ekSoMImnWEFF/e0Ai1sjlLHhrL+oJzZtQ=;
 b=pxCHf8s3UufZDyK61SLMVuI7TLg7qvyQgHNd5qlXeKYDuUeOdW8OGV2s0KyIVeHAaDXq
 Cxi4gbRxrsZZllT5Q6iVEeeoGQAIE+2wrUnUppzWFVYDlOgvNfJaLPlQHjffBPE+LDcz
 sh2qNjUkLQODNtE6XybvDwGWN+QQtUTrGHxnVwqINM3GCjN3vrThc3mO/KQwNYzijpsd
 1G/082QY8TD/Vt1FLJ6ymQGqbKO4LPX8XKpmlsHYs3XkNs4oOFANxOZFf7PMiUQ3sXv5
 L4Yo9sOQ55h0Noty5ERHCenhlVaTtPYo+b5DTiPmcnnslvHFOfpFkYwLgzawDetNrFE2 Rg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rn8cn0157-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 12:17:28 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3652OvpN026303;
        Wed, 5 Jul 2023 12:17:26 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3rjbde2j6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 12:17:26 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 365CHN2L5505668
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Jul 2023 12:17:23 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A85A2004F;
        Wed,  5 Jul 2023 12:17:23 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE62E20040;
        Wed,  5 Jul 2023 12:17:22 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  5 Jul 2023 12:17:22 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Alexandra Winter <wintera@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        Stefan Raspl <raspl@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Julian Ruess <julianr@linux.ibm.com>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net] s390/ism: Fix locking for forwarding of IRQs and events to clients
Date:   Wed,  5 Jul 2023 14:17:21 +0200
Message-Id: <20230705121722.2700998-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: V_EErmgM617ie-xrYwFs1X1gfsgM-Kzk
X-Proofpoint-ORIG-GUID: V_EErmgM617ie-xrYwFs1X1gfsgM-Kzk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_04,2023-07-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=778 spamscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307050107
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clients array references all registered clients and is protected by
the clients_lock. Besides its use as general list of clients the clients
array is accessed in ism_handle_irq() to forward IRQs and events to
clients. This use in an interrupt handler thus requires all code that
takes the clients_lock to be IRQ save.

This is problematic since the add() and remove() callbacks which are
called for all clients when an ISM device is added or removed cannot be
called directly while iterating over the clients array and holding the
clients_lock since clients need to allocate and/or take mutexes in these
callbacks. To deal with this the calls get pushed to workqueues with
additional housekeeping to be able to wait for the completion outside
the clients_lock.

Moreover while the clients_lock is taken in the IRQ handler when calling
handle_event() it is incorrectly not held during the
client->handle_irq() call and for the preceding clients[] access. This
leaves the clients array unprotected. Similarly the accesses to
ism->sba_client_arr[] in ism_register_dmb() and ism_unregister_dmb() are
also not protected by any lock. This is especially problematic as the
the client ID from the ism->sba_client_arr[] is not checked against
NO_CLIENT.

Instead of expanding the use of the clients_lock further add a separate
array in struct ism_dev which references clients subscribed to the
device's events and IRQs. This array is protected by ism->lock which is
already taken in ism_handle_irq() and can be taken outside the IRQ
handler when adding/removing subscribers or the accessing
ism->sba_client_arr[].

With the clients_lock no longer accessed from IRQ context it is turned
into a mutex and the add and remove workqueues plus their housekeeping
can be removed in favor of simple direct calls.

Fixes: 89e7d2ba61b7 ("net/ism: Add new API for client registration")
Tested-by: Julian Ruess <julianr@linux.ibm.com>
Reviewed-by: Julian Ruess <julianr@linux.ibm.com>
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
Note: I realize this is a rather large patch. So I'd understand if it's not
acceptable as is and needs to be broken up. That said it removes more lines
than it adds and the complexity of the resulting code is in my opinion reduced.

 drivers/s390/net/ism_drv.c | 138 ++++++++++++++++++-------------------
 include/linux/ism.h        |   7 +-
 2 files changed, 67 insertions(+), 78 deletions(-)

diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index 9b5fccdbc7d6..4887f53d0eff 100644
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
@@ -47,14 +47,22 @@ static struct ism_dev_list ism_dev_list = {
 	.mutex = __MUTEX_INITIALIZER(ism_dev_list.mutex),
 };
 
+static void ism_setup_forwarding(struct ism_client *client, struct ism_dev *ism)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ism->lock, flags);
+	ism->subs[client->id] = client;
+	spin_unlock_irqrestore(&ism->lock, flags);
+}
+
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
@@ -65,12 +73,14 @@ int ism_register_client(struct ism_client *client)
 			break;
 		}
 	}
-	spin_unlock_irqrestore(&clients_lock, flags);
+	mutex_unlock(&clients_lock);
+
 	if (i < MAX_CLIENTS) {
 		/* initialize with all devices that we got so far */
 		list_for_each_entry(ism, &ism_dev_list.list, list) {
 			ism->priv[i] = NULL;
 			client->add(ism);
+			ism_setup_forwarding(client, ism);
 		}
 	}
 	mutex_unlock(&ism_dev_list.mutex);
@@ -86,25 +96,33 @@ int ism_unregister_client(struct ism_client *client)
 	int rc = 0;
 
 	mutex_lock(&ism_dev_list.mutex);
-	spin_lock_irqsave(&clients_lock, flags);
-	clients[client->id] = NULL;
-	if (client->id + 1 == max_client)
-		max_client--;
-	spin_unlock_irqrestore(&clients_lock, flags);
 	list_for_each_entry(ism, &ism_dev_list.list, list) {
+		spin_lock_irqsave(&ism->lock, flags);
+		/* Stop forwarding IRQs and events */
+		ism->subs[client->id] = NULL;
 		for (int i = 0; i < ISM_NR_DMBS; ++i) {
 			if (ism->sba_client_arr[i] == client->id) {
 				pr_err("%s: attempt to unregister client '%s'"
 				       "with registered dmb(s)\n", __func__,
 				       client->name);
 				rc = -EBUSY;
-				goto out;
+				goto err_reg_dmb;
 			}
 		}
+		spin_unlock_irqrestore(&ism->lock, flags);
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
@@ -328,6 +346,7 @@ int ism_register_dmb(struct ism_dev *ism, struct ism_dmb *dmb,
 		     struct ism_client *client)
 {
 	union ism_reg_dmb cmd;
+	unsigned long flags;
 	int ret;
 
 	ret = ism_alloc_dmb(ism, dmb);
@@ -351,7 +370,9 @@ int ism_register_dmb(struct ism_dev *ism, struct ism_dmb *dmb,
 		goto out;
 	}
 	dmb->dmb_tok = cmd.response.dmb_tok;
+	spin_lock_irqsave(&ism->lock, flags);
 	ism->sba_client_arr[dmb->sba_idx - ISM_DMB_BIT_OFFSET] = client->id;
+	spin_unlock_irqrestore(&ism->lock, flags);
 out:
 	return ret;
 }
@@ -360,6 +381,7 @@ EXPORT_SYMBOL_GPL(ism_register_dmb);
 int ism_unregister_dmb(struct ism_dev *ism, struct ism_dmb *dmb)
 {
 	union ism_unreg_dmb cmd;
+	unsigned long flags;
 	int ret;
 
 	memset(&cmd, 0, sizeof(cmd));
@@ -368,7 +390,9 @@ int ism_unregister_dmb(struct ism_dev *ism, struct ism_dmb *dmb)
 
 	cmd.request.dmb_tok = dmb->dmb_tok;
 
+	spin_lock_irqsave(&ism->lock, flags);
 	ism->sba_client_arr[dmb->sba_idx - ISM_DMB_BIT_OFFSET] = NO_CLIENT;
+	spin_unlock_irqrestore(&ism->lock, flags);
 
 	ret = ism_cmd(ism, &cmd);
 	if (ret && ret != ISM_ERROR)
@@ -491,6 +515,7 @@ static u16 ism_get_chid(struct ism_dev *ism)
 static void ism_handle_event(struct ism_dev *ism)
 {
 	struct ism_event *entry;
+	struct ism_client *clt;
 	int i;
 
 	while ((ism->ieq_idx + 1) != READ_ONCE(ism->ieq->header.idx)) {
@@ -499,21 +524,21 @@ static void ism_handle_event(struct ism_dev *ism)
 
 		entry = &ism->ieq->entry[ism->ieq_idx];
 		debug_event(ism_debug_info, 2, entry, sizeof(*entry));
-		spin_lock(&clients_lock);
-		for (i = 0; i < max_client; ++i)
-			if (clients[i])
-				clients[i]->handle_event(ism, entry);
-		spin_unlock(&clients_lock);
+		for (i = 0; i < max_client; ++i) {
+			clt = ism->subs[i];
+			if (clt)
+				clt->handle_event(ism, entry);
+		}
 	}
 }
 
 static irqreturn_t ism_handle_irq(int irq, void *data)
 {
 	struct ism_dev *ism = data;
-	struct ism_client *clt;
 	unsigned long bit, end;
 	unsigned long *bv;
 	u16 dmbemask;
+	u8 client_id;
 
 	bv = (void *) &ism->sba->dmb_bits[ISM_DMB_WORD_OFFSET];
 	end = sizeof(ism->sba->dmb_bits) * BITS_PER_BYTE - ISM_DMB_BIT_OFFSET;
@@ -530,8 +555,10 @@ static irqreturn_t ism_handle_irq(int irq, void *data)
 		dmbemask = ism->sba->dmbe_mask[bit + ISM_DMB_BIT_OFFSET];
 		ism->sba->dmbe_mask[bit + ISM_DMB_BIT_OFFSET] = 0;
 		barrier();
-		clt = clients[ism->sba_client_arr[bit]];
-		clt->handle_irq(ism, bit + ISM_DMB_BIT_OFFSET, dmbemask);
+		client_id = ism->sba_client_arr[bit];
+		if (unlikely(client_id == NO_CLIENT || !ism->subs[client_id]))
+			continue;
+		ism->subs[client_id]->handle_irq(ism, bit + ISM_DMB_BIT_OFFSET, dmbemask);
 	}
 
 	if (ism->sba->e) {
@@ -548,20 +575,9 @@ static u64 ism_get_local_gid(struct ism_dev *ism)
 	return ism->local_gid;
 }
 
-static void ism_dev_add_work_func(struct work_struct *work)
-{
-	struct ism_client *client = container_of(work, struct ism_client,
-						 add_work);
-
-	client->add(client->tgt_ism);
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
@@ -594,25 +610,16 @@ static int ism_dev_init(struct ism_dev *ism)
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
 
@@ -687,36 +694,24 @@ static int ism_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return ret;
 }
 
-static void ism_dev_remove_work_func(struct work_struct *work)
-{
-	struct ism_client *client = container_of(work, struct ism_client,
-						 remove_work);
-
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
@@ -727,15 +722,14 @@ static void ism_dev_exit(struct ism_dev *ism)
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
index ea2bcdae7401..9a4c204df3da 100644
--- a/include/linux/ism.h
+++ b/include/linux/ism.h
@@ -44,9 +44,7 @@ struct ism_dev {
 	u64 local_gid;
 	int ieq_idx;
 
-	atomic_t free_clients_cnt;
-	atomic_t add_dev_cnt;
-	wait_queue_head_t waitq;
+	struct ism_client *subs[MAX_CLIENTS];
 };
 
 struct ism_event {
@@ -68,9 +66,6 @@ struct ism_client {
 	 */
 	void (*handle_irq)(struct ism_dev *dev, unsigned int bit, u16 dmbemask);
 	/* Private area - don't touch! */
-	struct work_struct remove_work;
-	struct work_struct add_work;
-	struct ism_dev *tgt_ism;
 	u8 id;
 };
 

base-commit: d528014517f2b0531862c02865b9d4c908019dc4
-- 
2.39.2

