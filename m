Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB14B5F3CDB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 08:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiJDGpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 02:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiJDGpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 02:45:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57ADB252B9;
        Mon,  3 Oct 2022 23:45:31 -0700 (PDT)
Received: from lenovo.Home (unknown [39.45.148.204])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BC0A0660225F;
        Tue,  4 Oct 2022 07:45:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664865930;
        bh=22jFsalhNwXYUDUi3MSy6myd6rIR0j2CZtZOcnwFfos=;
        h=From:To:Cc:Subject:Date:From;
        b=jeQDHB4eBbeeKdzLx87y71kw8Bm35Rj69kZ7eNtMEGiZvaDRhufRyclqWgkP5tZ2Z
         m2ewGZ9ljOy4DQfs8Bdt8y+l9Qv/+m28HloUNVCYVPmc+M1lWK4gijtazAUsDdHq3N
         YgG7/ASfh5H2KfvrszV1Hu4C7sD+UTZbRUSktSGiiwRnp5eGurMid+2H58RF9obNQJ
         CbGaGilsfqcnWxsURpdc36EJU4E2rS9S6IMgjA+895E0bO0mCWoGrZ3jo+wc4yXGfw
         ehZV/BQCS807ngkwDqaiuNs6yUtlOjAsqlw3aOe1tYBgXdGaZ0Smea8wZuDixjwc/o
         Zyf5azNIoMMrQ==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, kernel-janitors@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: remove less-than-zero comparison of unsigned variables
Date:   Tue,  4 Oct 2022 11:45:21 +0500
Message-Id: <20221004064521.498510-1-usama.anjum@collabora.com>
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

max_chg_vol_reg and max_chg_cur_reg are unsigned variables. The
less-than-zero comparison of an unsigned value is never true. Remove
these checks.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 drivers/power/supply/rk817_charger.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/rk817_charger.c b/drivers/power/supply/rk817_charger.c
index 635f051b0821..aa4b33f1bb83 100644
--- a/drivers/power/supply/rk817_charger.c
+++ b/drivers/power/supply/rk817_charger.c
@@ -951,12 +951,12 @@ static int rk817_battery_init(struct rk817_charger *charger,
 
 	max_chg_cur_reg = rk817_chg_cur_to_reg(max_chg_cur_ma);
 
-	if (max_chg_vol_reg < 0 || max_chg_vol_reg > 7) {
+	if (max_chg_vol_reg > 7) {
 		return dev_err_probe(charger->dev, -EINVAL,
 		       "invalid max charger voltage, value %u unsupported\n",
 		       max_chg_vol_mv * 1000);
 	}
-	if (max_chg_cur_reg < 0 || max_chg_cur_reg > 7) {
+	if (max_chg_cur_reg > 7) {
 		return dev_err_probe(charger->dev, -EINVAL,
 		       "invalid max charger current, value %u unsupported\n",
 		       max_chg_cur_ma * 1000);
-- 
2.30.2

