Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424DD711495
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242085AbjEYSk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242113AbjEYSjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:39:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA73B2126;
        Thu, 25 May 2023 11:37:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A873464920;
        Thu, 25 May 2023 18:37:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A74C433EF;
        Thu, 25 May 2023 18:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685039830;
        bh=+rJDVAF0qjyQHon6lKunfXjuigwSuH4DDTuVuCC0ipw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KM73HYEESkCh0YOaam25UQQOzIN1KJaYsqKFXBoTF6ilp56IMmu28RsXlgeOEfSjZ
         RmaAoXco2kr4WegpqH3AooMP/LJPyyoNYWWA1v1+oUu+kMqWr9rJEvMq/E2khWVF5D
         YtVZeYTEFh4LCYChlweuxFm6PXP0hDuhwY9ucSX8p69LVNqx9PBKEWmNVHKWofnDOJ
         5dU0pzGWqsN7REBqyTezoWOatLzmmc8VMP7EqRbaDBwC+IQvFJk0h24eh3orcNFkzf
         x7ukbp+eeIP8IjH86e1s5E5HgzClOuj1bK0IbyC6a10bafrp/nsMF0IF2eIw835J0v
         cnAntnUvONZVw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wei Chen <harperchen1110@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 16/57] media: dvb-usb: digitv: fix null-ptr-deref in digitv_i2c_xfer()
Date:   Thu, 25 May 2023 14:35:26 -0400
Message-Id: <20230525183607.1793983-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525183607.1793983-1-sashal@kernel.org>
References: <20230525183607.1793983-1-sashal@kernel.org>
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

[ Upstream commit 9ded5bd2a49ce3015b7c936743eec0a0e6e11f0c ]

In digitv_i2c_xfer, msg is controlled by user. When msg[i].buf
is null and msg[i].len is zero, former checks on msg[i].buf would be
passed. Malicious data finally reach digitv_i2c_xfer. If accessing
msg[i].buf[0] without sanity check, null ptr deref would happen. We add
check on msg[i].len to prevent crash.

Similar commit:
commit 0ed554fd769a ("media: dvb-usb: az6027: fix null-ptr-deref in az6027_i2c_xfer()")

Link: https://lore.kernel.org/linux-media/20230313095008.1039689-1-harperchen1110@gmail.com
Signed-off-by: Wei Chen <harperchen1110@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/dvb-usb/digitv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/usb/dvb-usb/digitv.c b/drivers/media/usb/dvb-usb/digitv.c
index 2756815a780bc..32134be169148 100644
--- a/drivers/media/usb/dvb-usb/digitv.c
+++ b/drivers/media/usb/dvb-usb/digitv.c
@@ -63,6 +63,10 @@ static int digitv_i2c_xfer(struct i2c_adapter *adap,struct i2c_msg msg[],int num
 		warn("more than 2 i2c messages at a time is not handled yet. TODO.");
 
 	for (i = 0; i < num; i++) {
+		if (msg[i].len < 1) {
+			i = -EOPNOTSUPP;
+			break;
+		}
 		/* write/read request */
 		if (i+1 < num && (msg[i+1].flags & I2C_M_RD)) {
 			if (digitv_ctrl_msg(d, USB_READ_COFDM, msg[i].buf[0], NULL, 0,
-- 
2.39.2

