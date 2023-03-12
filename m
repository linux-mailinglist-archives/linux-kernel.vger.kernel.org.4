Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B416B6724
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 15:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjCLOYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 10:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCLOYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 10:24:36 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C031D46170;
        Sun, 12 Mar 2023 07:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=4Zscu
        iQPwnHKfbAbpvcHFmQ/w/W3FQBM8Le/KlBVmX8=; b=YQklslgIvM7mi1Co4Qh5c
        3etl9t3wkCXV3MV5Sw1sG0m35C4r7TC8TPu9ytBAePYuB2hYV8nda1AcjVzlmhV1
        MyXmzggw5wRXI/ZsglyTyx6AGK8l6JSqwnJDmLNUmFfRQRdZZwXbsYcTpAOQ+BH2
        eiEZxIfCTe/8Iu0+Egtp3U=
Received: from leanderwang-LC2.localdomain (unknown [111.206.145.21])
        by zwqz-smtp-mta-g4-2 (Coremail) with SMTP id _____wC3g3x84A1kSDt1DA--.34606S2;
        Sun, 12 Mar 2023 22:23:56 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     sathya.prakash@broadcom.com
Cc:     sreekanth.reddy@broadcom.com,
        suganath-prabu.subramani@broadcom.com,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, hackerzheng666@gmail.com,
        1395428693sheep@gmail.com, alex000young@gmail.com,
        Zheng Wang <zyytlz.wz@163.com>
Subject: [PATCH] scsi: message: mptlan: Fix use after free bug in mptlan_remove due to race condition
Date:   Sun, 12 Mar 2023 22:23:54 +0800
Message-Id: <20230312142354.1857371-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wC3g3x84A1kSDt1DA--.34606S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrurykGF4Dur1fWry5Wr13CFg_yoW8Jry7pr
        ZFka48CrZ5Jw1Iy3WDtFy8AFyrC3WIgrWkKrWSg342vr1FkFyYq340kFy2kw1xXFs5Ga13
        Zr4DJFs7GayDKFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zi-eOJUUUUU=
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/xtbBzg0wU2I0Xm+hTwABso
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mptlan_probe, it called mpt_register_lan_device and bound 
&priv->post_buckets_task with mpt_lan_post_receive_buckets_work.
When it calls lan_reply, it will finally call 
mpt_lan_wake_post_buckets_task to start the work.

When we call mptlan_remove to remove the driver, there
may be a sequence as follows:

Fix it by finishing the work before cleanup in mptlan_remove

CPU0                  CPU1

                    |mpt_lan_post_receive_buckets_work
mptlan_remove       |
  free_netdev       |
    kfree(dev);     |
                    |
                    | dev->mtu
                    |   //use

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
---
 drivers/message/fusion/mptlan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/message/fusion/mptlan.c b/drivers/message/fusion/mptlan.c
index 142eb5d5d9df..de2e7bcf4784 100644
--- a/drivers/message/fusion/mptlan.c
+++ b/drivers/message/fusion/mptlan.c
@@ -1433,7 +1433,9 @@ mptlan_remove(struct pci_dev *pdev)
 {
 	MPT_ADAPTER 		*ioc = pci_get_drvdata(pdev);
 	struct net_device	*dev = ioc->netdev;
+	struct mpt_lan_priv *priv = netdev_priv(dev);
 
+	cancel_delayed_work_sync(&priv->post_buckets_task);
 	if(dev != NULL) {
 		unregister_netdev(dev);
 		free_netdev(dev);
-- 
2.25.1

