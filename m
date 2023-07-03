Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCB87463A4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 22:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjGCUES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 16:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjGCUEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 16:04:15 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE32DE47;
        Mon,  3 Jul 2023 13:04:13 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 72F97120029;
        Mon,  3 Jul 2023 23:04:12 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 72F97120029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1688414652;
        bh=3glFyjcepOK8/Kxd5LbRvbqIMFcThbI+slfTdN39SXQ=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=WjMN6ZhzyZADuzwnFwMQ3gUPW2zr7aMn5XdG790qvsjykfMk5YSLaehgLDmfmroLQ
         pUIV8KPbgJYcmvuXXXBLEsot0h7mr0rjc87cMhlyPYZZKln2gbvxie1oWDiLgL6MeZ
         1i4gzY9FTHTd+impmjhyACUY2p67fekGBp8+bnVfPxoF2U6YLQK0F9gK9TWoRC8Ur+
         sc9DrgR5qFEdzPBR1SkC0KODwWIU/WjSjmZLxA32+0cHNteYLymxa08/tmVHRt1wxY
         gbucrOtXG3RhW7mV+AiQglXYWhARQlEkr/ZUiALCbw9upJs9UXj9bFkokJmxdcjqtO
         Vry38FB6holOg==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Mon,  3 Jul 2023 23:04:12 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 3 Jul 2023 23:04:08 +0300
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
Subject: [PATCH v1] clk: meson: change usleep_range() to udelay() for atomic context
Date:   Mon, 3 Jul 2023 23:04:04 +0300
Message-ID: <20230703200404.20361-1-ddrokosov@sberdevices.ru>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178409 [Jul 03 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: DDRokosov@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 517 517 b0056c19d8e10afbb16cb7aad7258dedb0179a79, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;sberdevices.ru:7.1.1,5.0.1;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/07/03 16:02:00 #21557037
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function meson_clk_pll_enable() can be invoked under the enable_lock
spinlock from the clk core logic (please refer to
drivers/clk/clk.c:clk_core_enable_lock()), which risks a kernel panic
during the usleep_range() call:

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

Considering that this code is expected to be used in an atomic context,
it is required to use the udelay() function instead of usleep_range()
for the atomic context safety.

Fixes: b6ec400aa153 ("clk: meson: introduce new pll power-on sequence for A1 SoC family")
Reported-by: Jan Dakinevich <yvdakinevich@sberdevices.ru>
Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
Signed-off-by: Jan Dakinevich <yvdakinevich@sberdevices.ru>
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

