Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448565B4F58
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 16:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbiIKODj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 10:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbiIKODN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 10:03:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EC433A23;
        Sun, 11 Sep 2022 07:03:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5202B80B57;
        Sun, 11 Sep 2022 14:03:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50897C4347C;
        Sun, 11 Sep 2022 14:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662904989;
        bh=PEHzzoH9IF5H8guB1gj3gMHXET+ye+3uJaMUPxbg1us=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kIdFj89bb+WtZNYc1l8Ki70QoDiqYBv1ldKR5Tj9ljvCrSfWpCMa1d07wM4byN/aZ
         leM8U+iZO8t/DYh7HZR4GZ7aFPr2z8k1FgK8IRi4ZK6b10X8gky6bB3NitYcybHP3m
         2DmYtHrYXsex6NbqltKRYPqE/vzkTF8RFgKA0wO/1F7oVKnW8haiH6ffoJlxP+1EDy
         cjOFUzIGH1WQXbtK2Pj9kds99NBTnBd5T5kHho79Y3QV4/DpEwbt4BtBHHtBDfpnSz
         NufXRoC0dZg5Y67EMFChMZbtR57I5R8ja9GWLWEPsNqnjTr9Z4L03ED5jq8fm4xgtC
         9fdYLaC57gAEQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oXNYL-0007wY-HQ; Sun, 11 Sep 2022 16:03:17 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Amireddy mallikarjuna reddy <mallikarjuna.reddy@ftdichip.com>,
        arun.pappan@ftdichip.com, sowjanya.reddy@ftdichip.com,
        malliamireddy009@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/12] USB: serial: ftdi_sio: clean up chip type enum
Date:   Sun, 11 Sep 2022 16:02:05 +0200
Message-Id: <20220911140216.30481-2-johan@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220911140216.30481-1-johan@kernel.org>
References: <20220911140216.30481-1-johan@kernel.org>
MIME-Version: 1.0
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

Clean up the chip type enum by dropping the explicit values and moving
the definition to the implementation to make it easier to add further
types.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/ftdi_sio.c | 11 +++++++++++
 drivers/usb/serial/ftdi_sio.h | 12 ------------
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 52d59be92034..3757931284cb 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -47,6 +47,17 @@
 #define DRIVER_AUTHOR "Greg Kroah-Hartman <greg@kroah.com>, Bill Ryder <bryder@sgi.com>, Kuba Ober <kuba@mareimbrium.org>, Andreas Mohr, Johan Hovold <jhovold@gmail.com>"
 #define DRIVER_DESC "USB FTDI Serial Converters Driver"
 
+enum ftdi_chip_type {
+	SIO,
+	FT8U232AM,
+	FT232BM,
+	FT2232C,
+	FT232RL,
+	FT2232H,
+	FT4232H,
+	FT232H,
+	FTX,
+};
 
 struct ftdi_private {
 	enum ftdi_chip_type chip_type;
diff --git a/drivers/usb/serial/ftdi_sio.h b/drivers/usb/serial/ftdi_sio.h
index be1641e0408b..12bc3a82ac2c 100644
--- a/drivers/usb/serial/ftdi_sio.h
+++ b/drivers/usb/serial/ftdi_sio.h
@@ -153,18 +153,6 @@
  * not supported by the FT8U232AM).
  */
 
-enum ftdi_chip_type {
-	SIO = 1,
-	FT8U232AM = 2,
-	FT232BM = 3,
-	FT2232C = 4,
-	FT232RL = 5,
-	FT2232H = 6,
-	FT4232H = 7,
-	FT232H  = 8,
-	FTX     = 9,
-};
-
 enum ftdi_sio_baudrate {
 	ftdi_sio_b300 = 0,
 	ftdi_sio_b600 = 1,
-- 
2.35.1

