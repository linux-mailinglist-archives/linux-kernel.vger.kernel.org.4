Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF25C74AF35
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 12:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbjGGK4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 06:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbjGGK4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 06:56:40 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809B01FEE;
        Fri,  7 Jul 2023 03:56:34 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 367Afnuc023390;
        Fri, 7 Jul 2023 10:56:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=FiXmI2k/9244Z9oQXE/8cOVrPyhmB3N3R1TpxJXn6ew=;
 b=Hl/Cxt7waDeyv70A3aFVLnw6tInznX0TmBi7Wq3Fd34+imVOr0nL746dXkXwl8Bu0cCp
 5jfjvEZktx5A5FxiIRQT+1nZbCSAzLwSr0a6IZDp8SeDSBrF13S1c3p9HPWX4CHQDtXx
 sfDYlqzYAV/JHnxvuPgXQvzp/TRjBen+/f2NGX7Kxp1W5yrozEKbQ7tVGtA7ESQZVlUm
 ao+Xge6f7QpBhkGb+qkVQd5GQIjBH9tMT1cJaKXI+aLquHC6aYUSKVzWhgF2irDdEJ6K
 bhttDS7kp/J6KUq/uWE0lXLKgGT7XNMNjcysQNZFRR0ykXNk3V9aVRy805FEZDL0W8nz 6Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rpgu3rnxm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 10:56:32 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 367AhYaj027323;
        Fri, 7 Jul 2023 10:56:32 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rpgu3rnwy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 10:56:31 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3677mesc016768;
        Fri, 7 Jul 2023 10:56:30 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3rjbs4uy96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 10:56:30 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 367AuQkI14484052
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Jul 2023 10:56:26 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF44F20043;
        Fri,  7 Jul 2023 10:56:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 96B182004F;
        Fri,  7 Jul 2023 10:56:23 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  7 Jul 2023 10:56:23 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Paolo Abeni <pabeni@redhat.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        Stefan Raspl <raspl@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net v2 1/3] s390/ism: Fix locking for forwarding of IRQs and events to clients
Date:   Fri,  7 Jul 2023 12:56:20 +0200
Message-Id: <20230707105622.3332261-2-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230707105622.3332261-1-schnelle@linux.ibm.com>
References: <20230707105622.3332261-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zRO7XdwlnkxnintcFzE1pv6pUOdan_Ie
X-Proofpoint-GUID: A-WEsBEOUu7_IeT7D3sk8696nU1M5dAs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_06,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0 adultscore=0
 spamscore=0 impostorscore=0 mlxlogscore=869 mlxscore=0 bulkscore=0
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

The clients array references all registered clients and is protected by
the clients_lock. Besides its use as general list of clients the clients
array is accessed in ism_handle_irq() to forward ISM device events to
clients.

While the clients_lock is taken in the IRQ handler when calling
handle_event() it is however incorrectly not held during the
client->handle_irq() call and for the preceding clients[] access leaving
it unprotected against concurrent client (un-)registration.

Furthermore the accesses to ism->sba_client_arr[] in ism_register_dmb()
and ism_unregister_dmb() are not protected by any lock. This is
especially problematic as the client ID from the ism->sba_client_arr[]
is not checked against NO_CLIENT and neither is the client pointer
checked.

Instead of expanding the use of the clients_lock further add a separate
array in struct ism_dev which references clients subscribed to the
device's events and IRQs. This array is protected by ism->lock which is
already taken in ism_handle_irq() and can be taken outside the IRQ
handler when adding/removing subscribers or the accessing
ism->sba_client_arr[]. This also means that the clients_lock is no
longer taken in IRQ context.

Fixes: 89e7d2ba61b7 ("net/ism: Add new API for client registration")
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/s390/net/ism_drv.c | 44 +++++++++++++++++++++++++++++++-------
 include/linux/ism.h        |  1 +
 2 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index 9b5fccdbc7d6..b664e4a08645 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -47,6 +47,15 @@ static struct ism_dev_list ism_dev_list = {
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
@@ -71,6 +80,7 @@ int ism_register_client(struct ism_client *client)
 		list_for_each_entry(ism, &ism_dev_list.list, list) {
 			ism->priv[i] = NULL;
 			client->add(ism);
+			ism_setup_forwarding(client, ism);
 		}
 	}
 	mutex_unlock(&ism_dev_list.mutex);
@@ -92,6 +102,9 @@ int ism_unregister_client(struct ism_client *client)
 		max_client--;
 	spin_unlock_irqrestore(&clients_lock, flags);
 	list_for_each_entry(ism, &ism_dev_list.list, list) {
+		spin_lock_irqsave(&ism->lock, flags);
+		/* Stop forwarding IRQs and events */
+		ism->subs[client->id] = NULL;
 		for (int i = 0; i < ISM_NR_DMBS; ++i) {
 			if (ism->sba_client_arr[i] == client->id) {
 				pr_err("%s: attempt to unregister client '%s'"
@@ -101,6 +114,7 @@ int ism_unregister_client(struct ism_client *client)
 				goto out;
 			}
 		}
+		spin_unlock_irqrestore(&ism->lock, flags);
 	}
 out:
 	mutex_unlock(&ism_dev_list.mutex);
@@ -328,6 +342,7 @@ int ism_register_dmb(struct ism_dev *ism, struct ism_dmb *dmb,
 		     struct ism_client *client)
 {
 	union ism_reg_dmb cmd;
+	unsigned long flags;
 	int ret;
 
 	ret = ism_alloc_dmb(ism, dmb);
@@ -351,7 +366,9 @@ int ism_register_dmb(struct ism_dev *ism, struct ism_dmb *dmb,
 		goto out;
 	}
 	dmb->dmb_tok = cmd.response.dmb_tok;
+	spin_lock_irqsave(&ism->lock, flags);
 	ism->sba_client_arr[dmb->sba_idx - ISM_DMB_BIT_OFFSET] = client->id;
+	spin_unlock_irqrestore(&ism->lock, flags);
 out:
 	return ret;
 }
@@ -360,6 +377,7 @@ EXPORT_SYMBOL_GPL(ism_register_dmb);
 int ism_unregister_dmb(struct ism_dev *ism, struct ism_dmb *dmb)
 {
 	union ism_unreg_dmb cmd;
+	unsigned long flags;
 	int ret;
 
 	memset(&cmd, 0, sizeof(cmd));
@@ -368,7 +386,9 @@ int ism_unregister_dmb(struct ism_dev *ism, struct ism_dmb *dmb)
 
 	cmd.request.dmb_tok = dmb->dmb_tok;
 
+	spin_lock_irqsave(&ism->lock, flags);
 	ism->sba_client_arr[dmb->sba_idx - ISM_DMB_BIT_OFFSET] = NO_CLIENT;
+	spin_unlock_irqrestore(&ism->lock, flags);
 
 	ret = ism_cmd(ism, &cmd);
 	if (ret && ret != ISM_ERROR)
@@ -491,6 +511,7 @@ static u16 ism_get_chid(struct ism_dev *ism)
 static void ism_handle_event(struct ism_dev *ism)
 {
 	struct ism_event *entry;
+	struct ism_client *clt;
 	int i;
 
 	while ((ism->ieq_idx + 1) != READ_ONCE(ism->ieq->header.idx)) {
@@ -499,21 +520,21 @@ static void ism_handle_event(struct ism_dev *ism)
 
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
@@ -530,8 +551,10 @@ static irqreturn_t ism_handle_irq(int irq, void *data)
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
@@ -554,6 +577,7 @@ static void ism_dev_add_work_func(struct work_struct *work)
 						 add_work);
 
 	client->add(client->tgt_ism);
+	ism_setup_forwarding(client, client->tgt_ism);
 	atomic_dec(&client->tgt_ism->add_dev_cnt);
 	wake_up(&client->tgt_ism->waitq);
 }
@@ -691,7 +715,11 @@ static void ism_dev_remove_work_func(struct work_struct *work)
 {
 	struct ism_client *client = container_of(work, struct ism_client,
 						 remove_work);
+	unsigned long flags;
 
+	spin_lock_irqsave(&client->tgt_ism->lock, flags);
+	client->tgt_ism->subs[client->id] = NULL;
+	spin_unlock_irqrestore(&client->tgt_ism->lock, flags);
 	client->remove(client->tgt_ism);
 	atomic_dec(&client->tgt_ism->free_clients_cnt);
 	wake_up(&client->tgt_ism->waitq);
diff --git a/include/linux/ism.h b/include/linux/ism.h
index ea2bcdae7401..5160d47e5ea9 100644
--- a/include/linux/ism.h
+++ b/include/linux/ism.h
@@ -44,6 +44,7 @@ struct ism_dev {
 	u64 local_gid;
 	int ieq_idx;
 
+	struct ism_client *subs[MAX_CLIENTS];
 	atomic_t free_clients_cnt;
 	atomic_t add_dev_cnt;
 	wait_queue_head_t waitq;
-- 
2.39.2

