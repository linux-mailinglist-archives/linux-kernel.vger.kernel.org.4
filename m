Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8DB6454F6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 08:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiLGHzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 02:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiLGHzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 02:55:36 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CCF25EAC;
        Tue,  6 Dec 2022 23:55:35 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NRqMp0yZcz4y0v1;
        Wed,  7 Dec 2022 15:55:34 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl1.zte.com.cn with SMTP id 2B77tJJv078722;
        Wed, 7 Dec 2022 15:55:19 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 7 Dec 2022 15:55:22 +0800 (CST)
Date:   Wed, 7 Dec 2022 15:55:22 +0800 (CST)
X-Zmail-TransId: 2af9639046eaffffffffb86a0852
X-Mailer: Zmail v1.0
Message-ID: <202212071555220843038@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <andriy.shevchenko@linux.intel.com>
Cc:     <jic23@kernel.org>, <lars@metafoo.de>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@foss.st.com>, <fabrice.gasnier@foss.st.com>,
        <paul@crapouillou.net>, <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBpaW86IHRyaWdnZXI6IHN0bTMyLXRpbWVyOiBDb252ZXJ0IHRvIHVzZSBzeXNmc19lbWl0X2F0KCkgQVBJ?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2B77tJJv078722
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.13.novalocal with ID 639046F6.000 by FangMail milter!
X-FangMail-Envelope: 1670399734/4NRqMp0yZcz4y0v1/639046F6.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 639046F6.000/4NRqMp0yZcz4y0v1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Follow the advice of the Documentation/filesystems/sysfs.rst and show()
should only use sysfs_emit() or sysfs_emit_at() when formatting the
value to be returned to user space.

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/iio/trigger/stm32-timer-trigger.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
index 3643c4afae67..eadfb255f7b7 100644
--- a/drivers/iio/trigger/stm32-timer-trigger.c
+++ b/drivers/iio/trigger/stm32-timer-trigger.c
@@ -352,8 +352,7 @@ static ssize_t stm32_tt_show_master_mode_avail(struct device *dev,
 		master_mode_max = MASTER_MODE_MAX;

 	for (i = 0; i <= master_mode_max; i++)
-		len += scnprintf(buf + len, PAGE_SIZE - len,
-			"%s ", master_mode_table[i]);
+		len += sysfs_emit_at(buf, len, "%s ", master_mode_table[i]);

 	/* replace trailing space by newline */
 	buf[len - 1] = '\n';
-- 
2.25.1
