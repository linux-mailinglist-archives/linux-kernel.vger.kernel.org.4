Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CA47018AD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 19:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbjEMR5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 13:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjEMR5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 13:57:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA94171E;
        Sat, 13 May 2023 10:57:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6BC261B63;
        Sat, 13 May 2023 17:57:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB52C433D2;
        Sat, 13 May 2023 17:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684000666;
        bh=4ClBQusFX5qbjQJdkZxV7kXoxd/BNCXo2EIL6LRfVUs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XsaTnx9umsYFitFXysEcek55CQeQ2z0EWmkTpKI+7Kjfwyn7ni62AfUOOXA2uKnkU
         V5gprOVVqyi4wMTkdpLCOvgmF4cHu4RSl2yguauMUYiGSUqk8FsODiUb+jgWKfrEXT
         RYLhE/n4wFQcfIfsIN4nGX2gfbiuKO3SbxhLHv3+sjIc/+FhkOZ+h3ynIXg+drkhQw
         Mpnsgfuculsd6HgDPMRSp7Zq+PEsI9ykyLk8BFk1UoAqhI0PsjzEPu9Qvm1bbI3xG6
         8TFHEEcgert5XqJodMeEPvFl4LZIZC2nEWZZIbZBnShKeKGiVHmP5PtYiQ5gJadZzp
         Rc4Ue6Oo/TH9Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.96)
        (envelope-from <mchehab@kernel.org>)
        id 1pxtV1-001txq-1J;
        Sat, 13 May 2023 18:57:43 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Wei Chen <harperchen1110@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 09/24] media: dvb-usb: dw2102: fix uninit-value in su3000_read_mac_address
Date:   Sat, 13 May 2023 18:57:26 +0100
Message-Id: <949b355d0b9233a30bfaf94f43437a14cba495ae.1684000646.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <53558de2b5c4f4ee6bfcfbe34e27071c2d0073d5.1684000646.git.mchehab@kernel.org>
References: <53558de2b5c4f4ee6bfcfbe34e27071c2d0073d5.1684000646.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Chen <harperchen1110@gmail.com>

In su3000_read_mac_address, if i2c_transfer fails to execute two
messages, array mac address will not be initialized. Without handling
such error, later in function dvb_usb_adapter_dvb_init, proposed_mac
is accessed before initialization.

Fix this error by returning a negative value if message execution fails.

Link: https://lore.kernel.org/linux-media/20230328124416.560889-1-harperchen1110@gmail.com
Signed-off-by: Wei Chen <harperchen1110@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 drivers/media/usb/dvb-usb/dw2102.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/dvb-usb/dw2102.c b/drivers/media/usb/dvb-usb/dw2102.c
index 0ca764282c76..8747960e6146 100644
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
2.40.1

