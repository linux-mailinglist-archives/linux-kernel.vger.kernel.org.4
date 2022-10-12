Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011935FC170
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 09:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiJLHwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 03:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiJLHwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 03:52:14 -0400
X-Greylist: delayed 401 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 Oct 2022 00:52:12 PDT
Received: from giacobini.uberspace.de (giacobini.uberspace.de [185.26.156.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F664ACA17
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 00:52:12 -0700 (PDT)
Received: (qmail 18606 invoked by uid 990); 12 Oct 2022 07:45:29 -0000
Authentication-Results: giacobini.uberspace.de;
        auth=pass (plain)
From:   Soenke Huster <soenke.huster@eknoes.de>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Soenke Huster <soenke.huster@eknoes.de>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 RESEND] Bluetooth: virtio_bt: Use skb_put to set length
Date:   Wed, 12 Oct 2022 09:45:06 +0200
Message-Id: <20221012074507.8157-1-soenke.huster@eknoes.de>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20220727070541.6450-1-soenke.huster@eknoes.de>
References: <20220727070541.6450-1-soenke.huster@eknoes.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: /
X-Rspamd-Report: BAYES_HAM(-2.823088) R_MISSING_CHARSET(0.5) MIME_GOOD(-0.1) MID_CONTAINS_FROM(1) SUSPICIOUS_RECIPS(1.5)
X-Rspamd-Score: 0.076911
Received: from unknown (HELO unkown) (::1)
        by giacobini.uberspace.de (Haraka/2.8.28) with ESMTPSA; Wed, 12 Oct 2022 09:45:29 +0200
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By using skb_put we ensure that skb->tail is set
correctly. Currently, skb->tail is always zero, which
leads to errors, such as the following page fault in
rfcomm_recv_frame:

    BUG: unable to handle page fault for address: ffffed1021de29ff
    #PF: supervisor read access in kernel mode
    #PF: error_code(0x0000) - not-present page
    RIP: 0010:rfcomm_run+0x831/0x4040 (net/bluetooth/rfcomm/core.c:1751)

Fixes: afd2daa26c7a ("Bluetooth: Add support for virtio transport driver")
Signed-off-by: Soenke Huster <soenke.huster@eknoes.de>
---
v2: Add Fixes tag
 drivers/bluetooth/virtio_bt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
index 67c21263f9e0..fd281d439505 100644
--- a/drivers/bluetooth/virtio_bt.c
+++ b/drivers/bluetooth/virtio_bt.c
@@ -219,7 +219,7 @@ static void virtbt_rx_work(struct work_struct *work)
 	if (!skb)
 		return;
 
-	skb->len = len;
+	skb_put(skb, len);
 	virtbt_rx_handle(vbt, skb);
 
 	if (virtbt_add_inbuf(vbt) < 0)
-- 
2.36.1


