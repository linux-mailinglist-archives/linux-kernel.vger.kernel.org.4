Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47473748285
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 12:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjGEKtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 06:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjGEKto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 06:49:44 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE52C1719
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 03:49:42 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 4FB6510007C;
        Wed,  5 Jul 2023 13:49:41 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 4FB6510007C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1688554181;
        bh=hwuIkah7tdQ/ux/daGas/Or4t38i1CesFllcRMgtpB4=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=LCrgUoQkNEiOr6e6O1dwXK1JjmVaO0lqpozfIRWVjYdzZjuDFjwINjJOW7U4tSTxr
         5achdhqLr7WTN53PaZaRGSrURCLG+azXunoyo8/Ipjnqf0ijKu2/hV4vAU/VyRtS/Y
         n3ltxFK5DGvoyr8rr7tOK+gjsW7gIVUEbrBWnzyobUCNcO6N3lGrEfPdZm3I1kfzEr
         /RZ0yHEQmvcb8+1ogLDukXiniiR849nckVw48Aq9thifA5oV4K8jrNlhlTb3QZMvpo
         DAUNy0xZEq51KS97dyvKR0T3570mwlVs2GWoZlJN0ln5N6Y1rMMVjS7UVUjpsdjWVO
         VZwrJfRdovaAw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Wed,  5 Jul 2023 13:49:41 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 5 Jul 2023 13:49:38 +0300
From:   Arseniy Krasnov <AVKrasnov@sberdevices.ru>
To:     Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        JaimeLiao <jaimeliao.tw@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <kernel@kempniu.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        ChenXiaoSong <chenxiaosong2@huawei.com>,
        Adam Borowski <kilobyte@angband.pl>
CC:     <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/2] mtd: rawnand: export 'nand_exit_status_op()'
Date:   Wed, 5 Jul 2023 13:43:57 +0300
Message-ID: <20230705104403.696680-2-AVKrasnov@sberdevices.ru>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20230705104403.696680-1-AVKrasnov@sberdevices.ru>
References: <20230705104403.696680-1-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178443 [Jul 05 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: AVKrasnov@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 520 520 ccb018a655251011855942a2571029252d3d69a2, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/07/05 05:28:00 #21565829
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export this function to work in pair with 'nand_status_op()' which is
already exported.

Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
---
 drivers/mtd/nand/raw/nand_base.c | 1 +
 include/linux/mtd/rawnand.h      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index a6af521832aa..d4b55155aeae 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -1885,6 +1885,7 @@ int nand_exit_status_op(struct nand_chip *chip)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(nand_exit_status_op);
 
 /**
  * nand_erase_op - Do an erase operation
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 5159d692f9ce..90a141ba2a5a 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1540,6 +1540,7 @@ int nand_reset_op(struct nand_chip *chip);
 int nand_readid_op(struct nand_chip *chip, u8 addr, void *buf,
 		   unsigned int len);
 int nand_status_op(struct nand_chip *chip, u8 *status);
+int nand_exit_status_op(struct nand_chip *chip);
 int nand_erase_op(struct nand_chip *chip, unsigned int eraseblock);
 int nand_read_page_op(struct nand_chip *chip, unsigned int page,
 		      unsigned int offset_in_page, void *buf, unsigned int len);
-- 
2.35.0

