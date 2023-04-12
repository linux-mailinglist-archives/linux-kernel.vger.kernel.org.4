Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B786DFC89
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 19:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjDLRRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 13:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjDLRRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 13:17:04 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4548B2D54;
        Wed, 12 Apr 2023 10:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Ndk4F
        AvmShVgKPq5Bqqn4zjD3nCFuFesf1eKwaUQ9VQ=; b=CDdTCeuiVAiAlf0/ajVoc
        yPEHs/vnUPmKhUfANerzxZqvstN3/UqRTqxvH+pSzGKHt9nYr6JoyL7CDPmfdlHj
        2B1GnrAaOcPdCAxjZZtldxeh+5k19N74Pm3B8njlBwJJZ2oyBTBMc13wvmpG+xL2
        iVpSUNgq8mkcyz9jYukUuc=
Received: from leanderwang-LC2.localdomain (unknown [111.206.145.21])
        by zwqz-smtp-mta-g3-0 (Coremail) with SMTP id _____wAnh08C5zZkPAgtBQ--.24056S2;
        Thu, 13 Apr 2023 01:14:42 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     srinivas.pandruvada@linux.intel.com
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com, rafael@kernel.org,
        hdegoede@redhat.com, gregkh@linuxfoundation.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        hackerzheng666@gmail.com, 1395428693sheep@gmail.com,
        alex000young@gmail.com, Zheng Wang <zyytlz.wz@163.com>
Subject: [PATCH] HID: intel-ish-hid: pci-ish:  Fix use after free bug in  ish_remove due to race condition
Date:   Thu, 13 Apr 2023 01:14:41 +0800
Message-Id: <20230412171441.18958-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAnh08C5zZkPAgtBQ--.24056S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFW3uw45CF1fXF4kAry5urg_yoW8Gr1kpF
        4aqFy5Cr95XryIkw4kCay5CFyrZ340g3yYgrZ7Gw17XF13uF1DtFy8KFy8WryxXFs5X3yY
        9r1xt3yUCFyUZF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziIzuAUUUUU=
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/1tbiXQxOU1WBpNItegABs4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ish_probe, it calls ish_dev_init to init the device. In this function,
ishtp_device_init is called and &dev->bh_hbm_work is bound with 
bh_hbm_work_fn. recv_hbm may be called to start the timer work.

If we remove the module which will call ish_remove to make cleanup,
there may be an unfinished work. The possible sequence is as follows:

Fix it by canceling the work before cleanup in ishtp_bus_remove_all_clients

CPU0                  CPUc1

                    |bh_hbm_work_fn
ish_remove      |
ishtp_bus_remove_all_clients  |
kfree(ishtp_dev->fw_clients); |
                    |
                    |&dev->fw_clients[...]
                    |   //use

Fixes: 3703f53b99e4 ("HID: intel_ish-hid: ISH Transport layer")
Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
---
 drivers/hid/intel-ish-hid/ishtp/bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/intel-ish-hid/ishtp/bus.c b/drivers/hid/intel-ish-hid/ishtp/bus.c
index 81385ab37fa9..ada7cd08dbeb 100644
--- a/drivers/hid/intel-ish-hid/ishtp/bus.c
+++ b/drivers/hid/intel-ish-hid/ishtp/bus.c
@@ -744,6 +744,7 @@ void ishtp_bus_remove_all_clients(struct ishtp_device *ishtp_dev,
 		 */
 	}
 	spin_unlock_irqrestore(&ishtp_dev->cl_list_lock, flags);
+	cancel_work_sync(&ishtp_dev->bh_hbm_work);
 
 	/* Release DMA buffers for client messages */
 	ishtp_cl_free_dma_buf(ishtp_dev);
-- 
2.25.1

