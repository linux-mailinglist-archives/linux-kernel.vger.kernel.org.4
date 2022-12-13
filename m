Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA7B64B312
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 11:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235145AbiLMKTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 05:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235130AbiLMKTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 05:19:16 -0500
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024471C427;
        Tue, 13 Dec 2022 02:19:13 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jiapeng.chong@linux.alibaba.com;NM=0;PH=DS;RN=5;SR=0;TI=SMTPD_---0VXDunYh_1670926746;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VXDunYh_1670926746)
          by smtp.aliyun-inc.com;
          Tue, 13 Dec 2022 18:19:11 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] power: supply: rk817: Fix unsigned comparison with less than zero
Date:   Tue, 13 Dec 2022 18:19:04 +0800
Message-Id: <20221213101904.42260-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tmp is defined as u32 type, which results in invalid processing of
tmp<0 in function rk817_read_or_set_full_charge_on_boot(). Therefore,
change the tmp type to int.

drivers/power/supply/rk817_charger.c:828 rk817_read_or_set_full_charge_on_boot() warn: unsigned 'tmp' is never less than zero.
drivers/power/supply/rk817_charger.c:788 rk817_read_or_set_full_charge_on_boot() warn: unsigned 'tmp' is never less than zero.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3444
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/power/supply/rk817_charger.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/rk817_charger.c b/drivers/power/supply/rk817_charger.c
index 4f9c1c417916..7eefbcc0a4e9 100644
--- a/drivers/power/supply/rk817_charger.c
+++ b/drivers/power/supply/rk817_charger.c
@@ -731,8 +731,8 @@ rk817_read_or_set_full_charge_on_boot(struct rk817_charger *charger,
 {
 	struct rk808 *rk808 = charger->rk808;
 	u8 bulk_reg[4];
-	u32 boot_voltage, boot_charge_mah, tmp;
-	int ret, reg, off_time;
+	u32 boot_voltage, boot_charge_mah;
+	int ret, reg, off_time, tmp;
 	bool first_boot;
 
 	/*
-- 
2.20.1.7.g153144c

