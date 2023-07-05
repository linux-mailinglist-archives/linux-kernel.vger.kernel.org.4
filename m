Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B52F748284
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 12:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjGEKto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 06:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbjGEKtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 06:49:41 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50DA1728
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 03:49:38 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id B484A120061;
        Wed,  5 Jul 2023 13:49:35 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru B484A120061
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1688554175;
        bh=R99U9ZeCFnUhxosYR742hW48fCGlup+4oiuVH5a34TU=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=f/Kt7s0MLJ8wm5jz5SIu+fq0XAOa9AjzSUvxVJkht5Z+rPZCp1fsLoj11FH6+dAlI
         L3Y42u90dUGCW25q33urS2EmnaXe64mpMaBnoBaSx/AXbUDJB0KHunpXl47ScVaR0h
         Op2JbzSVIZs570B7Di5kkwhcM5iA2CXxPv/hCye7c78p6Ck+034u3JjalWocY3F6cD
         l/F7GN9Y4evyoW5Lq3Dlrm8YuwdzqstnBK+FV7WMN1QjC2I8LlIGXcPAxuMzf07JU5
         rCvC7i7DG/suhGZi1XbZHo4ffhrxtAikTJ9GGkvxbaVc8Xtpb1LWJqmXbkqIyT9jHx
         vk0AvTNFSOR9Q==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Wed,  5 Jul 2023 13:49:35 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 5 Jul 2023 13:49:32 +0300
From:   Arseniy Krasnov <AVKrasnov@sberdevices.ru>
To:     Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <kernel@kempniu.pl>,
        Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        Adam Borowski <kilobyte@angband.pl>,
        JaimeLiao <jaimeliao.tw@gmail.com>,
        ChenXiaoSong <chenxiaosong2@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 0/2] use NAND core API for Meson controller
Date:   Wed, 5 Jul 2023 13:43:56 +0300
Message-ID: <20230705104403.696680-1-AVKrasnov@sberdevices.ru>
X-Mailer: git-send-email 2.35.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178444 [Jul 05 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: AVKrasnov@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 520 520 ccb018a655251011855942a2571029252d3d69a2, {Tracking_from_domain_doesnt_match_to}, p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2;sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
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

During waiting for command completion this driver sends NAND_CMD_STATUS
and then NAND_CMD_READ0 to leave status checking mode. Instead of direct
accesses to the registers of the controller to send these commands, this
patchset uses currently implemented and exported NAND API for the same
purposes. First patch is preparation: we need to export function 
'nand_exit_status_op()' for modules. Second patch uses these functions
in the Meson driver.

Arseniy Krasnov (2):
  mtd: rawnand: export 'nand_exit_status_op()'
  mtd: rawnand: meson: use NAND core API to check status

 drivers/mtd/nand/raw/meson_nand.c | 26 ++++++++++++--------------
 drivers/mtd/nand/raw/nand_base.c  |  1 +
 include/linux/mtd/rawnand.h       |  1 +
 3 files changed, 14 insertions(+), 14 deletions(-)

-- 
2.35.0

