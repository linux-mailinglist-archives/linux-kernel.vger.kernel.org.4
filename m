Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE23A5F3D5C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 09:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiJDHhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 03:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiJDHhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 03:37:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB2726122;
        Tue,  4 Oct 2022 00:37:05 -0700 (PDT)
Received: from lenovo.Home (unknown [39.45.148.204])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 35BD86602294;
        Tue,  4 Oct 2022 08:37:03 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664869024;
        bh=Ow0BfW79bfpNtlYiCN2hlVpzCFIfLUidy8OnfpB1IZs=;
        h=From:To:Cc:Subject:Date:From;
        b=hGB5On3HW21LEikg0ZG0iqbpKg+UAdl0V3K6IeTSbBKEnj1PZG/02yhPjaClt3BOW
         evZoILYqvR1zDPdRaLuv86Gbww1bwj7Bll3E1V4p8wD/mFb7Iy4DmtUCfw5YGHl4+u
         m+cLArG9GRftOiAxXpf1PEenMT2pC/f+nwCu+VPbsuo98ispMGNBnwNLAukido+U+5
         Tcf68kSjaq7xFMDifj9S+xNxXKkv4Evc6H0ZmlR8shQtvQgfJLL3YlbYYrKzyHTjkA
         W8YZFo+xo5SuzyN4JQnJaFrJSwwmHRrJ9AgClX7c2LzX4B8ycT6XFPjwFgrIxRVvez
         ocA6tIhzDp7Jg==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, kernel-janitors@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: remove dead code
Date:   Tue,  4 Oct 2022 12:36:51 +0500
Message-Id: <20221004073652.568681-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tmp is an unsigned variable. It can never be less than zero. Remove the
dead code.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 drivers/power/supply/rk817_charger.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/power/supply/rk817_charger.c b/drivers/power/supply/rk817_charger.c
index aa4b33f1bb83..ba3f5ccaeacd 100644
--- a/drivers/power/supply/rk817_charger.c
+++ b/drivers/power/supply/rk817_charger.c
@@ -785,8 +785,6 @@ rk817_read_or_set_full_charge_on_boot(struct rk817_charger *charger,
 		regmap_bulk_read(rk808->regmap, RK817_GAS_GAUGE_Q_PRES_H3,
 				 bulk_reg, 4);
 		tmp = get_unaligned_be32(bulk_reg);
-		if (tmp < 0)
-			tmp = 0;
 		boot_charge_mah = ADC_TO_CHARGE_UAH(tmp,
 						    charger->res_div) / 1000;
 		/*
@@ -825,8 +823,6 @@ rk817_read_or_set_full_charge_on_boot(struct rk817_charger *charger,
 	regmap_bulk_read(rk808->regmap, RK817_GAS_GAUGE_Q_PRES_H3,
 			 bulk_reg, 4);
 	tmp = get_unaligned_be32(bulk_reg);
-	if (tmp < 0)
-		tmp = 0;
 	boot_charge_mah = ADC_TO_CHARGE_UAH(tmp, charger->res_div) / 1000;
 	regmap_bulk_read(rk808->regmap, RK817_GAS_GAUGE_OCV_VOL_H,
 			 bulk_reg, 2);
-- 
2.30.2

