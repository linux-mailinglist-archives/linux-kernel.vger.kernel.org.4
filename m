Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574BA7479B7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 23:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjGDVyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 17:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjGDVyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 17:54:23 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6F0127;
        Tue,  4 Jul 2023 14:54:20 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id CCAC3100069;
        Wed,  5 Jul 2023 00:54:17 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru CCAC3100069
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1688507657;
        bh=sMHKeng6YabVu1I8dRw/uL0UU93WVerpkNgP4pxZLzY=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=rpmRKrpVDesQVijIsKp7PCvkhThX73sNXsYr9+Nsw4vfhGsBqh2cUebtGtW9+V/xh
         iZ/uoyS4Dn1Ks7wksuOg5KornPBRCCsUi5J7V9TxO+67KsBYWkxxRllRAI0Utm2vKm
         IpFEXviTHYWMtst4VlDJnlnc/w9y3ME+75l8kQgfHz3FgQHkNln6sUHjbJ3dueBAqc
         s+h+POjDs1vncnibrvJhxJVCSy9zB2kCClHPc4nhsZK5MmkGwnniQ03BQnvq4eS1XN
         FeqtCK5zZhlpPt9fJiYQr3KxnnihKgEIp/YF/U1Uoe8/ZotbjzsrYX+VAw/A2o0TOG
         JA1Y/S/s+7CZw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Wed,  5 Jul 2023 00:54:17 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 5 Jul 2023 00:54:04 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <khilman@baylibre.com>, <martin.blumenstingl@googlemail.com>
CC:     <jian.hu@amlogic.com>, <kernel@sberdevices.ru>,
        <rockosov@gmail.com>, <linux-amlogic@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        Jan Dakinevich <yvdakinevich@sberdevices.ru>
Subject: [PATCH v2] clk: meson: change usleep_range() to udelay() for atomic context
Date:   Wed, 5 Jul 2023 00:54:04 +0300
Message-ID: <20230704215404.11533-1-ddrokosov@sberdevices.ru>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178432 [Jul 04 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: DDRokosov@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 520 520 ccb018a655251011855942a2571029252d3d69a2, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;sberdevices.ru:7.1.1,5.0.1;lore.kernel.org:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2023/07/04 20:47:00
X-KSMG-LinksScanning: Clean, bases: 2023/07/04 20:47:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/07/04 15:36:00 #21561860
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

The function meson_clk_pll_enable() can be invoked under the enable_lock
spinlock from the clk core logic, which risks a kernel panic during the
usleep_range() call:

   BUG: scheduling while atomic: kworker/u4:2/36/0x00000002
   Modules linked in: g_ffs usb_f_fs libcomposite
   CPU: 1 PID: 36 Comm: kworker/u4:2 Not tainted 6.4.0-rc5 #273
   Workqueue: events_unbound async_run_entry_fn
   Call trace:
    dump_backtrace+0x9c/0x128
    show_stack+0x20/0x38
    dump_stack_lvl+0x48/0x60
    dump_stack+0x18/0x28
    __schedule_bug+0x58/0x78
    __schedule+0x828/0xa88
    schedule+0x64/0xd8
    schedule_hrtimeout_range_clock+0xd0/0x208
    schedule_hrtimeout_range+0x1c/0x30
    usleep_range_state+0x6c/0xa8
    meson_clk_pll_enable+0x1f4/0x310
    clk_core_enable+0x78/0x200
    clk_core_enable+0x58/0x200
    clk_core_enable+0x58/0x200
    clk_core_enable+0x58/0x200
    clk_enable+0x34/0x60

So it is required to use the udelay() function instead of usleep_range()
for the atomic context safety.

Fixes: b6ec400aa153 ("clk: meson: introduce new pll power-on sequence for A1 SoC family")
Reported-by: Jan Dakinevich <yvdakinevich@sberdevices.ru>
Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
---
Changes v2 since v1 at [1]:
    - remove redundant SoB from commit msg
    - drop unuseful reference to clk_core_enable() from commit msg 

Links:
    [1] https://lore.kernel.org/all/20230703200404.20361-1-ddrokosov@sberdevices.ru/
---
 drivers/clk/meson/clk-pll.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
index 56ec2210f1ad..eef6f37c8d8d 100644
--- a/drivers/clk/meson/clk-pll.c
+++ b/drivers/clk/meson/clk-pll.c
@@ -367,9 +367,9 @@ static int meson_clk_pll_enable(struct clk_hw *hw)
 	 * 3. enable the lock detect module
 	 */
 	if (MESON_PARM_APPLICABLE(&pll->current_en)) {
-		usleep_range(10, 20);
+		udelay(10);
 		meson_parm_write(clk->map, &pll->current_en, 1);
-		usleep_range(40, 50);
+		udelay(40);
 	};
 
 	if (MESON_PARM_APPLICABLE(&pll->l_detect)) {
-- 
2.36.0

