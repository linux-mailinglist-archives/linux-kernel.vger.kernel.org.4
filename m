Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F73665751C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 11:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbiL1KGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 05:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbiL1KFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 05:05:40 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589E510063;
        Wed, 28 Dec 2022 02:05:39 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id o8-20020a17090a9f8800b00223de0364beso19634461pjp.4;
        Wed, 28 Dec 2022 02:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxRBm2XU4XIQi7X1v3Ft+eONrO9UoVmTZcrD/eMtUhA=;
        b=Hv0yLKSAHoWZ2/9bzhG3A+tIIUGjScb43m92UrfPWc6xCgpHp9lR4WGbUASMXI05BH
         S7CE7WBmVOapa2gkkdkYpjA314eulSNrRRTF+ctmtR0JjqChdWJLPYZ9Y2Ln6+WbW7Zy
         RoWu+Va2xQ3MEdAQ5QfyMXIqUtOIvz0umLKxfWGz7xtBln24SJLjoc/6xs0x/TLofVSX
         Q28A31YRPB4CVkoWaN/XaqrsOFI/Td1tkcqmOllJkd+PED6716ZbO31Lpbtge4/SgzNU
         gA4KNDoiTnnlCvPwHpRpdR6A/37deTAe+Rr+dJnyqfgMU1dBUkNk3/Ux0vHLp1iUyIs3
         /LoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mxRBm2XU4XIQi7X1v3Ft+eONrO9UoVmTZcrD/eMtUhA=;
        b=AfCS05AWppxeEO7Q6Is8HyQNhTHEeNJPx47ww/eqJT/9m6uafyOxA1YStAXfslvVNy
         XYXX3kw7O/eLvLqNpZxo93YVNngGSZXdj3mmYrgmo6p6gbDPkSYKxrjrd2oBLLraoOMt
         cU6WPEBtzp8LAthvOK+cRbq1iNiIgteZCyXJ8O8k2Z7k+0mUGY6xVFm4SPfxoK/Bja9t
         APftP2vn9mdZ2VNERfUNnV+rTErQePdDQV5dop3YQJcgUt3YWyouzKMMyBkaG5Vm3YDM
         JvR3VfZBPWU+YnXXEIRqoUe77IRyXZYsGb6eWiMN4IOUMbPAhd5vLCvkNlOkQaylfrZl
         HjQA==
X-Gm-Message-State: AFqh2kqcaK5DeCP5VJIwj0lCbU/DpI/7kApARSJC8XQVyuIsqxXtnGTD
        CI+bZ2kj4/r7tnPJZ/F5vDZrLIkMh7N1AQ==
X-Google-Smtp-Source: AMrXdXtRNwZT3qCdQbi16HHYR45qm7jdb3TcssmNhTmKUcumlM4A5zcxGE+hkQEO2/YbQo/zhgCyrQ==
X-Received: by 2002:a05:6a20:94c6:b0:ad:aaac:d40b with SMTP id ht6-20020a056a2094c600b000adaaacd40bmr30232618pzb.45.1672221938899;
        Wed, 28 Dec 2022 02:05:38 -0800 (PST)
Received: from localhost.localdomain ([45.112.3.26])
        by smtp.gmail.com with ESMTPSA id t6-20020a1709027fc600b0019277df45a6sm5794915plb.53.2022.12.28.02.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 02:05:38 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 06/11] usb: misc: onboard_usb_hub: add Genesys Logic GL3523-QFN76 hub support
Date:   Wed, 28 Dec 2022 10:03:15 +0000
Message-Id: <20221228100321.15949-7-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221228100321.15949-1-linux.amoon@gmail.com>
References: <20221228100321.15949-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Genesys Logic GL3523-QFN76 is a 4-port USB 3.1 hub that has a reset pin to
toggle and a 5.0V core supply exported though an integrated LDO is
available for powering it.

Add the support for this hub, for controlling the reset pin and the core
power supply.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/usb/misc/onboard_usb_hub.c | 1 +
 drivers/usb/misc/onboard_usb_hub.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onboard_usb_hub.c
index c0e8e6f4ec0a..699050eb3f17 100644
--- a/drivers/usb/misc/onboard_usb_hub.c
+++ b/drivers/usb/misc/onboard_usb_hub.c
@@ -410,6 +410,7 @@ static void onboard_hub_usbdev_disconnect(struct usb_device *udev)
 static const struct usb_device_id onboard_hub_id_table[] = {
 	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0608) }, /* Genesys Logic GL850G USB 2.0 */
 	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0610) }, /* Genesys Logic GL852G-OHG USB 2.0 */
+	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0620) }, /* Genesys Logic GL3523-QFN76 USB 3.1 */
 	{ USB_DEVICE(VENDOR_ID_MICROCHIP, 0x2514) }, /* USB2514B USB 2.0 */
 	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x0411) }, /* RTS5411 USB 3.1 */
 	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x5411) }, /* RTS5411 USB 2.1 */
diff --git a/drivers/usb/misc/onboard_usb_hub.h b/drivers/usb/misc/onboard_usb_hub.h
index 2ee1b0032d23..b32fad3a70f9 100644
--- a/drivers/usb/misc/onboard_usb_hub.h
+++ b/drivers/usb/misc/onboard_usb_hub.h
@@ -32,6 +32,7 @@ static const struct of_device_id onboard_hub_match[] = {
 	{ .compatible = "usb451,8142", .data = &ti_tusb8041_data, },
 	{ .compatible = "usb5e3,608", .data = &genesys_gl850g_data, },
 	{ .compatible = "genesys,usb5e3,610", .data = &genesys_gl850g_data, },
+	{ .compatible = "genesys,usb5e3,620", .data = &genesys_gl850g_data, },
 	{ .compatible = "usbbda,411", .data = &realtek_rts5411_data, },
 	{ .compatible = "usbbda,5411", .data = &realtek_rts5411_data, },
 	{ .compatible = "usbbda,414", .data = &realtek_rts5411_data, },
-- 
2.38.1

