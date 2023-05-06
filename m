Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E7B6F8DB3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 03:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbjEFBnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 21:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjEFBnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 21:43:07 -0400
Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 32B6349E2;
        Fri,  5 May 2023 18:43:03 -0700 (PDT)
Received: from jleng.ambarella.net (unknown [116.246.37.178])
        by mail-app3 (Coremail) with SMTP id cC_KCgD3_w+ZsFVkOBEAAg--.23024S2;
        Sat, 06 May 2023 09:43:00 +0800 (CST)
From:   Jing Leng <3090101217@zju.edu.cn>
To:     pawell@cadence.com, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Jing Leng <3090101217@zju.edu.cn>
Subject: [PATCH] usb: cdnsp: fix kernel crash when usb_ep_dequeue
Date:   Sat,  6 May 2023 09:42:42 +0800
Message-Id: <20230506014242.21912-1-3090101217@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cC_KCgD3_w+ZsFVkOBEAAg--.23024S2
X-Coremail-Antispam: 1UD129KBjvJXoWxur4kAr1rAr4xZFW3Kw45Jrb_yoW5Ar18pF
        48GFWakr48Z390qrs7Kr4UZr4rJan2yasrKrZ7Ka4fZFZ3J3yku3W8GFyYqF47Gry8Zr47
        t3WIgw40gr4agaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
        JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
        rcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
        MIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUb0PfJUUUU
        U==
X-CM-SenderInfo: qtqziiyqrsilo62m3hxhgxhubq/1tbiAwIHBWRVG1wHPAAAsO
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The crash appears in the following situations:
1. Call usb_ep_dequeue without calling usb_ep_queue first
2. Repeated call usb_ep_dequeue

Below is the log of kernel crash when stopping USB FFS device:
[ 1044.732419] Unable to handle kernel NULL pointer dereference
               at virtual address 0000000000000000
...
[ 1044.946689] Call trace:
[ 1044.949133]  cdnsp_trb_in_td.constprop.0+0x4/0xd0 [cdns3]
[ 1044.954545]  cdnsp_gadget_ep_dequeue+0x88/0xf0 [cdns3]
[ 1044.959695]  usb_ep_dequeue+0x18/0x24
[ 1044.963366]  functionfs_unbind+0x2c/0xb4 [usb_f_fs]
[ 1044.968256]  ffs_func_unbind+0x110/0x124 [usb_f_fs]
[ 1044.973144]  purge_configs_funcs+0x9c/0x124 [libcomposite]
[ 1044.978646]  configfs_composite_unbind+0x5c/0xbc [libcomposite]
[ 1044.984581]  usb_gadget_remove_driver+0x60/0xf4
[ 1044.989120]  usb_gadget_unregister_driver+0x70/0xe4
[ 1044.994008]  unregister_gadget_item+0x30/0x58 [libcomposite]
[ 1044.999682]  ffs_data_clear+0x144/0x158 [usb_f_fs]
[ 1045.004483]  ffs_data_closed+0xdc/0x174 [usb_f_fs]
[ 1045.009283]  ffs_ep0_release+0x14/0x24 [usb_f_fs]

Signed-off-by: Jing Leng <3090101217@zju.edu.cn>
---
 drivers/usb/cdns3/cdnsp-gadget.c | 11 +++++++++--
 drivers/usb/cdns3/cdnsp-ring.c   |  5 +++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gadget.c
index fff9ec9c391f..160680a56e1d 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.c
+++ b/drivers/usb/cdns3/cdnsp-gadget.c
@@ -1072,6 +1072,7 @@ static struct usb_request *cdnsp_gadget_ep_alloc_request(struct usb_ep *ep,
 
 	preq->epnum = pep->number;
 	preq->pep = pep;
+	INIT_LIST_HEAD(&preq->td.td_list);
 
 	trace_cdnsp_alloc_request(preq);
 
@@ -1120,11 +1121,17 @@ static int cdnsp_gadget_ep_queue(struct usb_ep *ep,
 static int cdnsp_gadget_ep_dequeue(struct usb_ep *ep,
 				   struct usb_request *request)
 {
-	struct cdnsp_ep *pep = to_cdnsp_ep(ep);
-	struct cdnsp_device *pdev = pep->pdev;
+	struct cdnsp_ep *pep;
+	struct cdnsp_device *pdev;
 	unsigned long flags;
 	int ret;
 
+	if (!request || !ep)
+		return -EINVAL;
+
+	pep = to_cdnsp_ep(ep);
+	pdev = pep->pdev;
+
 	if (!pep->endpoint.desc) {
 		dev_err(pdev->dev,
 			"%s: can't dequeue to disabled endpoint\n",
diff --git a/drivers/usb/cdns3/cdnsp-ring.c b/drivers/usb/cdns3/cdnsp-ring.c
index 07f6068342d4..12dc3fb100e9 100644
--- a/drivers/usb/cdns3/cdnsp-ring.c
+++ b/drivers/usb/cdns3/cdnsp-ring.c
@@ -705,6 +705,11 @@ int cdnsp_remove_request(struct cdnsp_device *pdev,
 	trace_cdnsp_remove_request_td(preq);
 
 	cur_td = &preq->td;
+
+	/* Prevent kernel crash caused by re-running usb_ep_dequeue */
+	if (list_empty(&cur_td->td_list))
+		return ret;
+
 	ep_ring = cdnsp_request_to_transfer_ring(pdev, preq);
 
 	/*
-- 
2.17.1

