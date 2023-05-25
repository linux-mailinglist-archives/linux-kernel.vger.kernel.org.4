Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314C07116F5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 21:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243096AbjEYSxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243518AbjEYSuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:50:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FC52133;
        Thu, 25 May 2023 11:44:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C51F64948;
        Thu, 25 May 2023 18:42:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05180C433A0;
        Thu, 25 May 2023 18:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685040173;
        bh=Jv2BJFI0ZebNhG+1/BDF6i17mtpfugcBwkQ1hEvE0ZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jk8dPWAAMUuZRq0xzV0xKnd713WLafntniA6txn0xWzMDLl4UVOyx8SQ82/gW5dQn
         ZPJttXYOul8TSGEV86C+ACekZdEN7GWBCKlOY6vi0yTBB/H92D86UkxCLGkdTyovkS
         7m/ZxL1Pj8O8O7+CTs+VjJZsXq7aBON+m9I7yqU1MlgsnahgQVbKOE8eRu/8SxmkU/
         Ea8sPOdTwVBwsz6nUo2d4ZHhVY5/y1a7D4BLzqtoFkf800QhLXegl0jEa2MUm1FYpL
         Ev0rYVjFEGNirJnYJ83D7vkX0VKD52yy9+FH8U6bWejYpcr7w5JPV8zLmgi4JezIMG
         8CkwZ5H4ZzIPA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wei Chen <harperchen1110@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>, crope@iki.fi,
        linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 06/27] media: dvb-usb-v2: ec168: fix null-ptr-deref in ec168_i2c_xfer()
Date:   Thu, 25 May 2023 14:42:15 -0400
Message-Id: <20230525184238.1943072-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525184238.1943072-1-sashal@kernel.org>
References: <20230525184238.1943072-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Chen <harperchen1110@gmail.com>

[ Upstream commit a6dcefcc08eca1bf4e3d213c97c3cfb75f377935 ]

In ec168_i2c_xfer, msg is controlled by user. When msg[i].buf is null
and msg[i].len is zero, former checks on msg[i].buf would be passed.
If accessing msg[i].buf[0] without sanity check, null pointer deref
would happen. We add check on msg[i].len to prevent crash.

Similar commit:
commit 0ed554fd769a ("media: dvb-usb: az6027: fix null-ptr-deref in az6027_i2c_xfer()")

Link: https://lore.kernel.org/linux-media/20230313085853.3252349-1-harperchen1110@gmail.com
Signed-off-by: Wei Chen <harperchen1110@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/dvb-usb-v2/ec168.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/media/usb/dvb-usb-v2/ec168.c b/drivers/media/usb/dvb-usb-v2/ec168.c
index e30305876840f..1191e32407c77 100644
--- a/drivers/media/usb/dvb-usb-v2/ec168.c
+++ b/drivers/media/usb/dvb-usb-v2/ec168.c
@@ -115,6 +115,10 @@ static int ec168_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 	while (i < num) {
 		if (num > i + 1 && (msg[i+1].flags & I2C_M_RD)) {
 			if (msg[i].addr == ec168_ec100_config.demod_address) {
+				if (msg[i].len < 1) {
+					i = -EOPNOTSUPP;
+					break;
+				}
 				req.cmd = READ_DEMOD;
 				req.value = 0;
 				req.index = 0xff00 + msg[i].buf[0]; /* reg */
@@ -131,6 +135,10 @@ static int ec168_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 			}
 		} else {
 			if (msg[i].addr == ec168_ec100_config.demod_address) {
+				if (msg[i].len < 1) {
+					i = -EOPNOTSUPP;
+					break;
+				}
 				req.cmd = WRITE_DEMOD;
 				req.value = msg[i].buf[1]; /* val */
 				req.index = 0xff00 + msg[i].buf[0]; /* reg */
@@ -139,6 +147,10 @@ static int ec168_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 				ret = ec168_ctrl_msg(d, &req);
 				i += 1;
 			} else {
+				if (msg[i].len < 1) {
+					i = -EOPNOTSUPP;
+					break;
+				}
 				req.cmd = WRITE_I2C;
 				req.value = msg[i].buf[0]; /* val */
 				req.index = 0x0100 + msg[i].addr; /* I2C addr */
-- 
2.39.2

