Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621FC6143FE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 05:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiKAExG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 00:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKAExE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 00:53:04 -0400
X-Greylist: delayed 473 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 31 Oct 2022 21:53:00 PDT
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [20.232.28.96])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id B54C217425;
        Mon, 31 Oct 2022 21:53:00 -0700 (PDT)
Received: from jleng.ambarella.net (unknown [116.246.37.178])
        by mail-app2 (Coremail) with SMTP id by_KCgCnrSE3pGBjEghXBw--.5587S2;
        Tue, 01 Nov 2022 12:44:58 +0800 (CST)
From:   Jing Leng <3090101217@zju.edu.cn>
To:     3090101217@zju.edu.cn
Cc:     gregkh@linuxfoundation.org, jleng@ambarella.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        pawell@cadence.com
Subject: [PATCH v2] usb: cdnsp: Fix wrong transmission direction of EP0
Date:   Tue,  1 Nov 2022 12:44:33 +0800
Message-Id: <20221101044433.5627-1-3090101217@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220926075902.7390-1-3090101217@zju.edu.cn>
References: <20220926075902.7390-1-3090101217@zju.edu.cn>
X-CM-TRANSID: by_KCgCnrSE3pGBjEghXBw--.5587S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar1fGFy5XFWUZr1kAFW5Jrb_yoW8tryrpr
        4UCFZIkrs5Xr45ArnFgF4DZa13CFs7AFy7Jr92k3ZxZrn3W3yvyFn8KFyjgF47uFZ5Ar4j
        ga1DGFs7XF4jvFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: qtqziiyqrsilo62m3hxhgxhubq/1tbiAwQRBVNG3IY6XAAKsw
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EP0 transfer is bi-directional, but in the cdnsp gadget, the
transmission direction of EP0 is not changed after it is
initialized to IN, so the OUT data from EP0 received by the host
is invalid.

The value of ep0_expect_in will change according to the value of
bRequestType in the SETUP transaction of control transfer, so we
can use it as the transmission direction of EP0.

Signed-off-by: Jing Leng <3090101217@zju.edu.cn>
Signed-off-by: Jing Leng <jleng@ambarella.com>
---
ChangeLog v1->v2:
- Rebase the patch.
- Make email addresses ('From' and 'Signed-off-by') consistent.
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
2.17.1

