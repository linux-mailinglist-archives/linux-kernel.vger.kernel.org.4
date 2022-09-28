Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803C55ED94C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 11:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbiI1Jk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 05:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233299AbiI1Jjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 05:39:42 -0400
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB142661
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 02:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1664357967;
        bh=3PAIiBxy0R6ZHl7Muf1mC94HPv5MJphBBSwkAzfvJiY=;
        h=From:To:Cc:Subject:Date:From;
        b=GcG7mjvawlKMxdLIpN17QOWMCe5ewhQj98CJGvOySPm5bfEsyIbt5EU9rF65dfUM2
         LwG3cobkGZjxj0Tt7kYBNVca1vYTdTYKhwEYJwPB3uClzFpC/yjiSst9YRLOKTXOud
         aOlhJ8ySoftPReLjyUYO2LnS9lkEjl0BqOBMmdLk=
Received: from xry111-x57s1.. (unknown [124.115.222.149])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id D7374667F1;
        Wed, 28 Sep 2022 05:39:24 -0400 (EDT)
From:   Xi Ruoyao <xry111@xry111.site>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Ning Wang <ningwang35@outlook.com>,
        Xi Ruoyao <xry111@xry111.site>, Chang Feng <flukehn@gmail.com>
Subject: [PATCH] nvme-pci: avoid the deepest sleep state on ZHITAI TiPro5000 SSDs
Date:   Wed, 28 Sep 2022 17:39:13 +0800
Message-Id: <20220928093913.45905-1-xry111@xry111.site>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        FROM_SUSPICIOUS_NTLD_FP,SPF_HELO_PASS,SPF_PASS,T_PDS_OTHER_BAD_TLD
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ZHITAI TiPro5000 SSDs has the same APST sleep problem as its cousin,
TiPro7000.  The quirk for TiPro7000 has been added in
commit 6b961bce50e4 ("nvme-pci: avoid the deepest sleep state on
ZHITAI TiPro7000 SSDs"), use the same quirk for TiPro5000.

The ASPT data from "nvme id-ctrl /dev/nvme1":

vid       : 0x1e49
ssvid     : 0x1e49
sn        : ZTA21T0KA2227304LM
mn        : ZHITAI TiPlus5000 1TB
fr        : ZTA09139
[...]
ps    0 : mp:6.50W operational enlat:0 exlat:0 rrt:0 rrl:0
         rwt:0 rwl:0 idle_power:- active_power:-
ps    1 : mp:5.80W operational enlat:0 exlat:0 rrt:1 rrl:1
         rwt:1 rwl:1 idle_power:- active_power:-
ps    2 : mp:3.60W operational enlat:0 exlat:0 rrt:2 rrl:2
         rwt:2 rwl:2 idle_power:- active_power:-
ps    3 : mp:0.0500W non-operational enlat:5000 exlat:10000 rrt:3 rrl:3
         rwt:3 rwl:3 idle_power:- active_power:-
ps    4 : mp:0.0025W non-operational enlat:8000 exlat:45000 rrt:4 rrl:4
         rwt:4 rwl:4 idle_power:- active_power:-

Reported-and-tested-by: Chang Feng <flukehn@gmail.com>
Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 98864b853eef..65481d1975cc 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3513,6 +3513,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1dbe, 0x5236),   /* ADATA XPG GAMMIX S70 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x1e49, 0x0021),   /* ZHITAI TiPro5000 NVMe SSD */
+		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
 	{ PCI_DEVICE(0x1e49, 0x0041),   /* ZHITAI TiPro7000 NVMe SSD */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
 	{ PCI_DEVICE(0xc0a9, 0x540a),   /* Crucial P2 */
-- 
2.37.3

