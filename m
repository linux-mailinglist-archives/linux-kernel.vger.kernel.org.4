Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F80B6D56C0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 04:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbjDDC1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 22:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjDDC1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 22:27:53 -0400
Received: from mail-m11878.qiye.163.com (mail-m11878.qiye.163.com [115.236.118.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300061BFA;
        Mon,  3 Apr 2023 19:27:51 -0700 (PDT)
Received: from localhost.localdomain (unknown [103.29.142.67])
        by mail-m11878.qiye.163.com (Hmail) with ESMTPA id 98317740458;
        Tue,  4 Apr 2023 10:27:47 +0800 (CST)
From:   Qiqi Zhang <eddy.zhang@rock-chips.com>
To:     eddy.zhang@rock-chips.com
Cc:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org
Subject: [PATCH v2] Bluetooth: hci_h5: Complements reliable packet processing logic
Date:   Tue,  4 Apr 2023 10:27:11 +0800
Message-Id: <20230404022711.86515-1-eddy.zhang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230403162928.118172-1-eddy.zhang@rock-chips.com>
References: <20230403162928.118172-1-eddy.zhang@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCS0pPVk4aHUhKSBkYGkwdSlUTARMWGhIXJBQOD1
        lXWRgSC1lBWUpLSFVJQlVKT0lVTUxZV1kWGg8SFR0UWUFZT0tIVUpKS0hKQ1VKS0tVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PCI6Ihw5ET0cNDgoMQ01QxEy
        KzEaFE9VSlVKTUNLTkxOSU1DTUpDVTMWGhIXVR4fHwJVARMaFRw7CRQYEFYYExILCFUYFBZFWVdZ
        EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUlNQko3Bg++
X-HM-Tid: 0a874a17847d2eb4kusn98317740458
X-HM-MType: 1
X-Spam-Status: No, score=-0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As shown in the schematic diagram below.There may be a critical
scenario in the current code. If the device does not receive an
pure ack sent by the host due to insufficient receive buffer or
other reasons and triggers a retransmission, the host will always
be in an 'out-of-order' state.The state machine will get stuck.

       host                 device
     SEQ3,ACK4 --------->
               <--------- SEQ4,ACK4
     pure ACK  ---------> (not received)
(out-of-order) <--------- SEQ4,ACK4(retransmission)
                ........
(out-of-order) <--------- SEQ4,ACK4(retransmission)

According to the description in the core specification: "whenever
a reliable packet is received, an acknowledgment shall be generated."
So set H5_TX_ACK_REQ bit to trigger retransmission of pure ack packet
when "out-of-order" occurs.

Signed-off-by: Qiqi Zhang <eddy.zhang@rock-chips.com>
---
Changes in v2:
- Fixed build bot warning.
---
---
 drivers/bluetooth/hci_h5.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 6455bc4fb5bb..d05eaeaa4516 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -463,6 +463,8 @@ static int h5_rx_3wire_hdr(struct hci_uart *hu, unsigned char c)
 	if (H5_HDR_RELIABLE(hdr) && H5_HDR_SEQ(hdr) != h5->tx_ack) {
 		bt_dev_err(hu->hdev, "Out-of-order packet arrived (%u != %u)",
 			   H5_HDR_SEQ(hdr), h5->tx_ack);
+		set_bit(H5_TX_ACK_REQ, &h5->flags);
+		hci_uart_tx_wakeup(hu);
 		h5_reset_rx(h5);
 		return 0;
 	}
-- 
2.25.1

