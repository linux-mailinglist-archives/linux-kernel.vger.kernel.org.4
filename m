Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79D45E9B80
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 10:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbiIZICz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 04:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiIZICI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 04:02:08 -0400
Received: from zg8tmtyylji0my4xnjqunzqa.icoremail.net (zg8tmtyylji0my4xnjqunzqa.icoremail.net [162.243.164.74])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 763FA15A17;
        Mon, 26 Sep 2022 00:59:29 -0700 (PDT)
Received: from jleng.ambarella.net (unknown [180.169.129.130])
        by mail-app3 (Coremail) with SMTP id cC_KCgBHv6rKWzFj7OYYBw--.61426S2;
        Mon, 26 Sep 2022 15:59:15 +0800 (CST)
From:   3090101217@zju.edu.cn
To:     pawell@cadence.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jing Leng <jleng@ambarella.com>
Subject: [PATCH] usb: cdnsp: Fix wrong transmission direction of EP0
Date:   Mon, 26 Sep 2022 15:59:02 +0800
Message-Id: <20220926075902.7390-1-3090101217@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cC_KCgBHv6rKWzFj7OYYBw--.61426S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uryrAFWfJw1DXr1xWFyUZFb_yoW8ury8pr
        4UCFZIkrs3Jr43Ar92gF4DZa1akFs7CF17Jr1vk3ZxZrs3uw4vyFn8KFyjgF47CFWrAr4j
        ga1DGFs7XF4jvFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBIb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWlnxkEFVCFx7IYxxCEVcI2
        5VAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lw4CEc2x0rVAKj4xxMxkIecxEwVAFwVW8CwCF04k20x
        vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
        3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIx
        AIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAI
        cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
        IEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8MrW5UUUUU==
X-CM-SenderInfo: qtqziiyqrsilo62m3hxhgxhubq/1tbiAwQPBVNG3GzSjQAJs+
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jing Leng <jleng@ambarella.com>

EP0 transfer is bi-directional, but in the cdnsp gadget, the
transmission direction of EP0 is not changed after it is
initialized to IN, so the OUT data from EP0 received by the host
is invalid.

The value of ep0_expect_in will change according to the value of
bRequestType in the SETUP transaction of control transfer, so we
can use it as the transmission direction of EP0.

Signed-off-by: Jing Leng <jleng@ambarella.com>
---
 drivers/usb/cdns3/cdnsp-gadget.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gadget.c
index c67715f6f756..526f80651d35 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.c
+++ b/drivers/usb/cdns3/cdnsp-gadget.c
@@ -345,6 +345,7 @@ int cdnsp_ep_enqueue(struct cdnsp_ep *pep, struct cdnsp_request *preq)
 {
 	struct cdnsp_device *pdev = pep->pdev;
 	struct usb_request *request;
+	u8 direction;
 	int ret;
 
 	if (preq->epnum == 0 && !list_empty(&pep->pending_list)) {
@@ -355,11 +356,14 @@ int cdnsp_ep_enqueue(struct cdnsp_ep *pep, struct cdnsp_request *preq)
 	request = &preq->request;
 	request->actual = 0;
 	request->status = -EINPROGRESS;
-	preq->direction = pep->direction;
+
+	direction = usb_endpoint_xfer_control(pep->endpoint.desc) ?
+		    pdev->ep0_expect_in : pep->direction;
+	preq->direction = direction;
 	preq->epnum = pep->number;
 	preq->td.drbl = 0;
 
-	ret = usb_gadget_map_request_by_dev(pdev->dev, request, pep->direction);
+	ret = usb_gadget_map_request_by_dev(pdev->dev, request, direction);
 	if (ret) {
 		trace_cdnsp_request_enqueue_error(preq);
 		return ret;
@@ -387,8 +391,7 @@ int cdnsp_ep_enqueue(struct cdnsp_ep *pep, struct cdnsp_request *preq)
 	return 0;
 
 unmap:
-	usb_gadget_unmap_request_by_dev(pdev->dev, &preq->request,
-					pep->direction);
+	usb_gadget_unmap_request_by_dev(pdev->dev, &preq->request, direction);
 	list_del(&preq->list);
 	trace_cdnsp_request_enqueue_error(preq);
 
-- 
2.34.1

