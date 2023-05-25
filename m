Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47CD7115F9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242951AbjEYStY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242889AbjEYSpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:45:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C440710D8;
        Thu, 25 May 2023 11:41:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53D6A60C15;
        Thu, 25 May 2023 18:41:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10CB9C4339E;
        Thu, 25 May 2023 18:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685040091;
        bh=afNQWkfyRZLHDDYKpCIb8B5aaZ7xvXdiYgMDf9I1M2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FpPCRNJitwMCBpzVrPn+2wIWHj2UQJTpcrFKKkfeUcFFJfh13fI1Wv9LOlVR/wgvp
         YIfbdyKwOh4RFqQ25I34g5H4Y6sqy1Yjml7PH9PJBpQ351ZAy7SWiTXW81KG6/XVpU
         wx+qoQGejV4F5t2n8RpzmJgPUpmDIbXnlqkPAVrDhJt5/31z83oaiiZOMl/E6z1/lB
         AARhyF6KXr5rhZaiLz9YgkRPd/7+jJTMsQgF/Sb0L30F59vu+jPfjlaX3D7ShJSrtQ
         Zts5aV+oPBii+DJ/Dk4b7LegmJ9jfFvdPJuqO7ClIT0CaceN7GL7ApfyN46c0Rw9B9
         Igc9Esq6Jv2zA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhang Shurong <zhang_shurong@foxmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>, crope@iki.fi,
        linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 10/31] media: dvb-usb-v2: rtl28xxu: fix null-ptr-deref in rtl28xxu_i2c_xfer
Date:   Thu, 25 May 2023 14:40:41 -0400
Message-Id: <20230525184105.1909399-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525184105.1909399-1-sashal@kernel.org>
References: <20230525184105.1909399-1-sashal@kernel.org>
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

From: Zhang Shurong <zhang_shurong@foxmail.com>

[ Upstream commit aa4a447b81b84f69c1a89ad899df157f386d7636 ]

In rtl28xxu_i2c_xfer, msg is controlled by user. When msg[i].buf
is null and msg[i].len is zero, former checks on msg[i].buf would be
passed. Malicious data finally reach rtl28xxu_i2c_xfer. If accessing
msg[i].buf[0] without sanity check, null ptr deref would happen.
We add check on msg[i].len to prevent crash.

Similar commit:
commit 0ed554fd769a
("media: dvb-usb: az6027: fix null-ptr-deref in az6027_i2c_xfer()")

Link: https://lore.kernel.org/linux-media/tencent_3623572106754AC2F266B316798B0F6CCA05@qq.com
Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/dvb-usb-v2/rtl28xxu.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/media/usb/dvb-usb-v2/rtl28xxu.c b/drivers/media/usb/dvb-usb-v2/rtl28xxu.c
index c278b9b0f1024..70a2f04942164 100644
--- a/drivers/media/usb/dvb-usb-v2/rtl28xxu.c
+++ b/drivers/media/usb/dvb-usb-v2/rtl28xxu.c
@@ -176,6 +176,10 @@ static int rtl28xxu_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 			ret = -EOPNOTSUPP;
 			goto err_mutex_unlock;
 		} else if (msg[0].addr == 0x10) {
+			if (msg[0].len < 1 || msg[1].len < 1) {
+				ret = -EOPNOTSUPP;
+				goto err_mutex_unlock;
+			}
 			/* method 1 - integrated demod */
 			if (msg[0].buf[0] == 0x00) {
 				/* return demod page from driver cache */
@@ -189,6 +193,10 @@ static int rtl28xxu_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 				ret = rtl28xxu_ctrl_msg(d, &req);
 			}
 		} else if (msg[0].len < 2) {
+			if (msg[0].len < 1) {
+				ret = -EOPNOTSUPP;
+				goto err_mutex_unlock;
+			}
 			/* method 2 - old I2C */
 			req.value = (msg[0].buf[0] << 8) | (msg[0].addr << 1);
 			req.index = CMD_I2C_RD;
@@ -217,8 +225,16 @@ static int rtl28xxu_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 			ret = -EOPNOTSUPP;
 			goto err_mutex_unlock;
 		} else if (msg[0].addr == 0x10) {
+			if (msg[0].len < 1) {
+				ret = -EOPNOTSUPP;
+				goto err_mutex_unlock;
+			}
 			/* method 1 - integrated demod */
 			if (msg[0].buf[0] == 0x00) {
+				if (msg[0].len < 2) {
+					ret = -EOPNOTSUPP;
+					goto err_mutex_unlock;
+				}
 				/* save demod page for later demod access */
 				dev->page = msg[0].buf[1];
 				ret = 0;
@@ -231,6 +247,10 @@ static int rtl28xxu_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 				ret = rtl28xxu_ctrl_msg(d, &req);
 			}
 		} else if ((msg[0].len < 23) && (!dev->new_i2c_write)) {
+			if (msg[0].len < 1) {
+				ret = -EOPNOTSUPP;
+				goto err_mutex_unlock;
+			}
 			/* method 2 - old I2C */
 			req.value = (msg[0].buf[0] << 8) | (msg[0].addr << 1);
 			req.index = CMD_I2C_WR;
-- 
2.39.2

