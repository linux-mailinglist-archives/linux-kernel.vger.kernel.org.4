Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F81D711595
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242769AbjEYSq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242537AbjEYSoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:44:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F152698;
        Thu, 25 May 2023 11:40:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADF8F609AD;
        Thu, 25 May 2023 18:39:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E72C433EF;
        Thu, 25 May 2023 18:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685039988;
        bh=6oEfyY97q+QA+6vM8N0IC3MT3ZTwummQY1+kbjQmf0Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VzfahcpO2XnMTnON1pynQkHA7SrUriHV9Rhf0nNBo2hlW5hW2nCHz8lDj57v4rxtm
         GPZ/nq7YDuX4nsA6KdrbQbBjABF2c4XD6QBsTnS1HF5TLu9gr9eQm0+r4bldBacPgt
         moxNkXiuVv3tn1wVx5V8yCOeWZcegXFddDzDB+cim0t211SZOFWYO5dOBYOOPczRkt
         Hofj2REsO2DBqZC/52/DOYhGhmDJZuTzuoW/RTf0FTVhQBHi5sRo/mDp7pQ2J8o3rY
         iIWc6DNca34hszDrOvAFslNDnlXUebSPh6ETNxjzkFBRJyrpq1Yolg0PP92KGQI2vW
         uLZo/wMgaDyRA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wei Chen <harperchen1110@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 15/43] media: dvb-usb: dw2102: fix uninit-value in su3000_read_mac_address
Date:   Thu, 25 May 2023 14:38:26 -0400
Message-Id: <20230525183854.1855431-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525183854.1855431-1-sashal@kernel.org>
References: <20230525183854.1855431-1-sashal@kernel.org>
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

[ Upstream commit a3fd1ef27aa686d871cefe207bd6168c4b0cd29e ]

In su3000_read_mac_address, if i2c_transfer fails to execute two
messages, array mac address will not be initialized. Without handling
such error, later in function dvb_usb_adapter_dvb_init, proposed_mac
is accessed before initialization.

Fix this error by returning a negative value if message execution fails.

Link: https://lore.kernel.org/linux-media/20230328124416.560889-1-harperchen1110@gmail.com
Signed-off-by: Wei Chen <harperchen1110@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/dvb-usb/dw2102.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/dvb-usb/dw2102.c b/drivers/media/usb/dvb-usb/dw2102.c
index ca75ebdc10b37..1ed62a80067c6 100644
--- a/drivers/media/usb/dvb-usb/dw2102.c
+++ b/drivers/media/usb/dvb-usb/dw2102.c
@@ -946,7 +946,7 @@ static int su3000_read_mac_address(struct dvb_usb_device *d, u8 mac[6])
 	for (i = 0; i < 6; i++) {
 		obuf[1] = 0xf0 + i;
 		if (i2c_transfer(&d->i2c_adap, msg, 2) != 2)
-			break;
+			return -1;
 		else
 			mac[i] = ibuf[0];
 	}
-- 
2.39.2

