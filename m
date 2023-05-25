Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA439711756
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 21:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243662AbjEYTXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 15:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243660AbjEYTW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 15:22:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510F02127;
        Thu, 25 May 2023 12:19:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8019A64965;
        Thu, 25 May 2023 18:42:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 344B6C433D2;
        Thu, 25 May 2023 18:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685040174;
        bh=kc8dK8eSTr3oTZLfhzc/3knnXlYIiv3+5tNUAtKPIFg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EFGhvqVrWDA/kUYbnyI99BIJ5rf6MI/SfXc+4O/o3fizjMYv4dGcF0FxhaPiXRxhI
         spXKMsQvwZUaQYFgsp5OZMiu+Q8oFEm0nwFndC9YGPawKe+fcrjFgFSy4kpkt+ryIa
         npHDa6PAkv5vG4q84DYlzs1kL7ce1zwtfBdxHSstI9aGm6v5XiiIwMA3CGZUQ03UMi
         6G04PV9tbN9PPWvi5Ysx0FitKyYCsD2r/Z2YixmaH62AsH5xIL097O6eg97WPORawu
         AOff6HR/1th871FE+Uu+kqJ6HykbNlilVsoP68agQ0U5ZufmMd0dEvORlm9sYEa5MP
         lSeOf4zjs9zeQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wei Chen <harperchen1110@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>, crope@iki.fi,
        linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 07/27] media: dvb-usb-v2: ce6230: fix null-ptr-deref in ce6230_i2c_master_xfer()
Date:   Thu, 25 May 2023 14:42:16 -0400
Message-Id: <20230525184238.1943072-7-sashal@kernel.org>
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

[ Upstream commit dff919090155fb22679869e8469168f270dcd97f ]

In ce6230_i2c_master_xfer, msg is controlled by user. When msg[i].buf
is null and msg[i].len is zero, former checks on msg[i].buf would be
passed. Malicious data finally reach ce6230_i2c_master_xfer. If accessing
msg[i].buf[0] without sanity check, null ptr deref would happen. We add
check on msg[i].len to prevent crash.

Similar commit:
commit 0ed554fd769a ("media: dvb-usb: az6027: fix null-ptr-deref in az6027_i2c_xfer()")

Link: https://lore.kernel.org/linux-media/20230313092751.209496-1-harperchen1110@gmail.com
Signed-off-by: Wei Chen <harperchen1110@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/dvb-usb-v2/ce6230.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/media/usb/dvb-usb-v2/ce6230.c b/drivers/media/usb/dvb-usb-v2/ce6230.c
index 44540de1a2066..d3b5cb4a24daf 100644
--- a/drivers/media/usb/dvb-usb-v2/ce6230.c
+++ b/drivers/media/usb/dvb-usb-v2/ce6230.c
@@ -101,6 +101,10 @@ static int ce6230_i2c_master_xfer(struct i2c_adapter *adap,
 		if (num > i + 1 && (msg[i+1].flags & I2C_M_RD)) {
 			if (msg[i].addr ==
 				ce6230_zl10353_config.demod_address) {
+				if (msg[i].len < 1) {
+					i = -EOPNOTSUPP;
+					break;
+				}
 				req.cmd = DEMOD_READ;
 				req.value = msg[i].addr >> 1;
 				req.index = msg[i].buf[0];
@@ -117,6 +121,10 @@ static int ce6230_i2c_master_xfer(struct i2c_adapter *adap,
 		} else {
 			if (msg[i].addr ==
 				ce6230_zl10353_config.demod_address) {
+				if (msg[i].len < 1) {
+					i = -EOPNOTSUPP;
+					break;
+				}
 				req.cmd = DEMOD_WRITE;
 				req.value = msg[i].addr >> 1;
 				req.index = msg[i].buf[0];
-- 
2.39.2

