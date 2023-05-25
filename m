Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB217115FA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242958AbjEYSt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242879AbjEYSph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:45:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E8610C9;
        Thu, 25 May 2023 11:41:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5BEF60B37;
        Thu, 25 May 2023 18:41:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70278C433D2;
        Thu, 25 May 2023 18:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685040088;
        bh=x/V/RBeJcyDiQDXAtSSZoqmN131WiEOgV7eiYgyexhk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PfG1yj8D61dvZCW7eoDTV+3+k2GpLYGczKp5UzViGfe0aTYZeM0g8qME8vq6TWJrb
         BA/ciYEvywyuyKzoHqKdkeGsoS1EcDmr2B1duvaScd9j/ySIcvKP4Xrt90qQDoLcE5
         n1zPgr3Ijc73+mDdzqkNuKgG/CQYMiI0tJNIu+A6LvklrX2YyFntf9r+NGpDr/abEW
         sbI/4TwHrbEt3Uux1wul04HBzgcDiXeh2GQH0glE28fJUFkEgueo3SayDLYWQNWEEi
         tAEvLp7sFJT6tHSVIKVU0k4CxcCtxFqrHaMyLz0IpGZHKSlgjeMqu3CHhgbYiqsLSU
         Bdwyl5yK8iDdg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wei Chen <harperchen1110@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>, zhongbaisong@huawei.com,
        linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 07/31] media: dvb-usb: az6027: fix three null-ptr-deref in az6027_i2c_xfer()
Date:   Thu, 25 May 2023 14:40:38 -0400
Message-Id: <20230525184105.1909399-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525184105.1909399-1-sashal@kernel.org>
References: <20230525184105.1909399-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Chen <harperchen1110@gmail.com>

[ Upstream commit 858e97d7956d17a2cb56a9413468704a4d5abfe1 ]

In az6027_i2c_xfer, msg is controlled by user. When msg[i].buf is null,
commit 0ed554fd769a ("media: dvb-usb: az6027: fix null-ptr-deref in
az6027_i2c_xfer()") fix the null-ptr-deref bug when msg[i].addr is 0x99.
However, null-ptr-deref also happens when msg[i].addr is 0xd0 and 0xc0.
We add check on msg[i].len to prevent null-ptr-deref.

Link: https://lore.kernel.org/linux-media/20230310165604.3093483-1-harperchen1110@gmail.com
Signed-off-by: Wei Chen <harperchen1110@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/dvb-usb/az6027.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/media/usb/dvb-usb/az6027.c b/drivers/media/usb/dvb-usb/az6027.c
index 32b4ee65c2802..991f4510aaebb 100644
--- a/drivers/media/usb/dvb-usb/az6027.c
+++ b/drivers/media/usb/dvb-usb/az6027.c
@@ -988,6 +988,10 @@ static int az6027_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[], int n
 			/* write/read request */
 			if (i + 1 < num && (msg[i + 1].flags & I2C_M_RD)) {
 				req = 0xB9;
+				if (msg[i].len < 1) {
+					i = -EOPNOTSUPP;
+					break;
+				}
 				index = (((msg[i].buf[0] << 8) & 0xff00) | (msg[i].buf[1] & 0x00ff));
 				value = msg[i].addr + (msg[i].len << 8);
 				length = msg[i + 1].len + 6;
@@ -1001,6 +1005,10 @@ static int az6027_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[], int n
 
 				/* demod 16bit addr */
 				req = 0xBD;
+				if (msg[i].len < 1) {
+					i = -EOPNOTSUPP;
+					break;
+				}
 				index = (((msg[i].buf[0] << 8) & 0xff00) | (msg[i].buf[1] & 0x00ff));
 				value = msg[i].addr + (2 << 8);
 				length = msg[i].len - 2;
@@ -1026,6 +1034,10 @@ static int az6027_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[], int n
 			} else {
 
 				req = 0xBD;
+				if (msg[i].len < 1) {
+					i = -EOPNOTSUPP;
+					break;
+				}
 				index = msg[i].buf[0] & 0x00FF;
 				value = msg[i].addr + (1 << 8);
 				length = msg[i].len - 1;
-- 
2.39.2

