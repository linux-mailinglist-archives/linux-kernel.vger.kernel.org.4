Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52C06F73D7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 21:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjEDTq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 15:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjEDTpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 15:45:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D451492E;
        Thu,  4 May 2023 12:44:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C474A6373E;
        Thu,  4 May 2023 19:43:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 118F5C4339B;
        Thu,  4 May 2023 19:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229416;
        bh=MJS4dzAVZY1D72hkrMes3j6B2EDrslbNlLubS/o/zaQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BLlQjG263BsbE6scllCxPBc+WPhqR6fw9OU5nUVmQH6+tSJLNj+Hnj34dkZjyy+Ag
         ZDuq2/OTKoFecYEIIuT9fiQjx1wzarJbT4e/FY0J3pUMzQvQseZutHcp/j8haNRkGu
         xhbH4v/9RhzFSgkf/oprxrZX2wldcDJUY7THDr5fglcicNDBoZ7gYjoB+j1fN1NuTZ
         WoZizABj6LFktxYIr9N+DvS7MgfBhANGzzBo3kjjkMId+EkJhS6hQVQfijWbXMYD62
         50hdYhPfHoRMhgsMEPkUsNs3P+F9P5DyQA04stEc3Ya+1TZhnl+VvsXpg6UIrzQbHR
         JOYW8SibsbRkg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Reese Russell <git@qrsnap.io>, Felix Fietkau <nbd@nbd.name>,
        Sasha Levin <sashal@kernel.org>, lorenzo@kernel.org,
        ryder.lee@mediatek.com, kvalo@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        matthias.bgg@gmail.com, sean.wang@mediatek.com,
        deren.wu@mediatek.com, sridhar.samudrala@intel.com,
        gch981213@gmail.com, greearb@candelatech.com,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.3 41/59] wifi: mt76: mt7921: add Netgear AXE3000 (A8000) support
Date:   Thu,  4 May 2023 15:41:24 -0400
Message-Id: <20230504194142.3805425-41-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504194142.3805425-1-sashal@kernel.org>
References: <20230504194142.3805425-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Reese Russell <git@qrsnap.io>

[ Upstream commit 03eb52dd78cab08f13925aeec8315fbdbcba3253 ]

Issue: Though the Netgear AXE3000 (A8000) is based on the mt7921
chipset because of the unique USB VID:PID combination this device
does not initialize/register. Thus making it not plug and play.

Fix: Adds support for the Netgear AXE3000 (A8000) based on the Mediatek
mt7921au chipset. The method of action is adding the USD VID/PID
pair to the mt7921u_device_table[] array.

Notes: A retail sample of the Netgear AXE3000 (A8000) yeilds the following
from lsusb D 0846:9060 NetGear, Inc. Wireless_Device. This pair
0846:9060 VID:PID has been reported by other users on Github.

Signed-off-by: Reese Russell <git@qrsnap.io>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/usb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
index 8fef09ed29c91..a95ec388653c5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
@@ -18,6 +18,9 @@ static const struct usb_device_id mt7921u_device_table[] = {
 	/* Comfast CF-952AX */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x3574, 0x6211, 0xff, 0xff, 0xff),
 		.driver_info = (kernel_ulong_t)MT7921_FIRMWARE_WM },
+	/* Netgear, Inc. [A8000,AXE3000] */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0846, 0x9060, 0xff, 0xff, 0xff),
+		.driver_info = (kernel_ulong_t)MT7921_FIRMWARE_WM },
 	{ },
 };
 
-- 
2.39.2

