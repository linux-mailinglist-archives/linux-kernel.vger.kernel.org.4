Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8277D6F73C6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 21:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjEDTqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 15:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjEDTp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 15:45:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A71AD37;
        Thu,  4 May 2023 12:44:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B025E63758;
        Thu,  4 May 2023 19:44:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12467C433A4;
        Thu,  4 May 2023 19:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229443;
        bh=X40QQfdRaA3MHuarzlvmKZkdrjntoaNiRjpsI+0EnKU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YBKhIY6T+jlQXe1zaHM31cUnZhFE/kxbetiWHhyVKazwXbN4gZtOolIZiYtu4iOAc
         hOfbCLUnY947v/5aHbr0fLug3X8PsI/LTga2XU/hhiQzrM6+hRMhP/w61c1YLvyrqP
         dcIgoFcmE9vy0swmA1UVs8MXL4hHZR9HRqE8yrgyk1AbuIqtYPEU17Eo+UXlDQt9Uf
         JeMKkux3rIWJ4ZrnmVKi93z7Ivt1/1vCZslrHiIY+Minxvdu58YZoOLLBUI/ru06Ky
         J29bkqy28ah3enumRo5sJCSs17rsiIQ94HxCEYmNHHyS/pUcVMLaTigzrXQyZRo8Oh
         FA8FuDHZI2xqA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Raul Cheleguini <rcheleguini@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Sasha Levin <sashal@kernel.org>, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 53/59] Bluetooth: Improve support for Actions Semi ATS2851 based devices
Date:   Thu,  4 May 2023 15:41:36 -0400
Message-Id: <20230504194142.3805425-53-sashal@kernel.org>
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

From: Raul Cheleguini <rcheleguini@google.com>

[ Upstream commit 7c2b2d2d0cb658aa543e11e90ae95621d3cb5fe6 ]

Add two more quirks to resume the device initialization and basic
operation as the device seems not to support "Read Transmit Power"
and "Set Extended Scan Parameters".

< HCI Command: LE Read Transmit Power (0x08|0x004b) plen 0
> HCI Event: Command Status (0x0f) plen 4
      LE Read Transmit Power (0x08|0x004b) ncmd 1
        Status: Unknown HCI Command (0x01)

< HCI Command: LE Set Extended Scan Parameters (0x08|0x0041) plen 8
        Own address type: Random (0x01)
        Filter policy: Accept all advertisement (0x00)
        PHYs: 0x01
        Entry 0: LE 1M
          Type: Active (0x01)
          Interval: 11.250 msec (0x0012)
          Window: 11.250 msec (0x0012)
> HCI Event: Command Status (0x0f) plen 4
      LE Set Extended Scan Parameters (0x08|0x0041) ncmd 1
        Status: Unknown HCI Command (0x01)

Signed-off-by: Raul Cheleguini <rcheleguini@google.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 683556dcdc436..1ab5663b009d8 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4105,6 +4105,8 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_ACTIONS_SEMI) {
 		/* Support is advertised, but not implemented */
 		set_bit(HCI_QUIRK_BROKEN_ERR_DATA_REPORTING, &hdev->quirks);
+		set_bit(HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER, &hdev->quirks);
+		set_bit(HCI_QUIRK_BROKEN_EXT_SCAN, &hdev->quirks);
 	}
 
 	if (!reset)
-- 
2.39.2

