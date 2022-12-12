Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC1564A99E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 22:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbiLLVjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 16:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiLLVjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 16:39:06 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61677252
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 13:39:05 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id j16so10231014qtv.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 13:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ffELf9QCePpNkmA9SAPHTlpHz3ybgd2eAH/oKDo0+I8=;
        b=LZ8PtqosW7Y7QlUmY6zM4LbmRdcyMNnyEyUDRpekxerbBKbTJH3J/Tq6Jjtb6cHVWI
         Lbjo38u457Pe9c1bzWk+tvJ5igO2XSUx7ECzVWEUwRAaR6S61InfS0RRDE2Z1sjX2nCq
         HlBviIJ27b6+LHt0ew2p+dok4F3Uq3pkzLB78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ffELf9QCePpNkmA9SAPHTlpHz3ybgd2eAH/oKDo0+I8=;
        b=P7wg7YdORVDwetcqj0jJC2sZnaX0GSbxyAiOD6gtpfxI6N9RBG9FCzc5lVYC8aEWB+
         tPjY1lKsIJpHWaYbRYfsejzPgHwSr79w0qZtYVCiS0DCQyrQ2cA+ymzaGi/b5nQfAWNx
         tUHa4xIhGw73AIF38TJnqPZoe9JiB3jNdrbkZPyUZjw7lcz6rlTHSt+TELRJ56oxqxLY
         jhOoWlIYy387HToHNTn7Ugj515Xs6E9La3dwkqrmvZVsUFa97HGOg6q5ziMJZ4wn+6vk
         oeKsJC+eH2sOM30//HDiyibZdKMFEVgJjYJzijgp1rSebZ3+HjtJSo14CToESMmeh+mC
         2Nlg==
X-Gm-Message-State: ANoB5pm0a1Gfu2areiBiCyyShkXPxaUx9v3DBrYHAbDpi3p9YeIMIYRk
        lRqemF9buCTiICAC2aY4VflP2RhFYlDLDakY
X-Google-Smtp-Source: AA0mqf6/OESp8CG9m1MQzlFOnwK5AuQJ7XG9xPfLuM3qwWg+A7OsNzi3Fm+vPu458zhET97D7lqOdA==
X-Received: by 2002:ac8:4e31:0:b0:3a5:1caf:6886 with SMTP id d17-20020ac84e31000000b003a51caf6886mr21189906qtw.57.1670881144513;
        Mon, 12 Dec 2022 13:39:04 -0800 (PST)
Received: from grundler-glapstation.lan ([70.134.62.80])
        by smtp.gmail.com with ESMTPSA id s5-20020a05620a254500b006ec62032d3dsm6599107qko.30.2022.12.12.13.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 13:39:03 -0800 (PST)
From:   Grant Grundler <grundler@chromium.org>
To:     Benson Leung <bleung@chromium.org>
Cc:     Guenter Roeck <groeck@chromium.org>,
        Sebastian Reichel <sre@kernel.org>,
        chrome-platform@lists.linux.dev, linux-pm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Grant Grundler <grundler@chromium.org>
Subject: [PATCH] power: supply: cros_usbpd: reclassify "default case!" as debug
Date:   Mon, 12 Dec 2022 13:38:57 -0800
Message-Id: <20221212213857.3636830-1-grundler@chromium.org>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This doesn't need to be printed every second as an error:
...
<3>[17438.628385] cros-usbpd-charger cros-usbpd-charger.3.auto: Port 1: default case!
<3>[17439.634176] cros-usbpd-charger cros-usbpd-charger.3.auto: Port 1: default case!
<3>[17440.640298] cros-usbpd-charger cros-usbpd-charger.3.auto: Port 1: default case!
...

Reduce priority from ERROR to DEBUG.

Signed-off-by: Grant Grundler <grundler@chromium.org>
---
 drivers/power/supply/cros_usbpd-charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/supply/cros_usbpd-charger.c
index cadb6a0c2cc7..b6c96376776a 100644
--- a/drivers/power/supply/cros_usbpd-charger.c
+++ b/drivers/power/supply/cros_usbpd-charger.c
@@ -276,7 +276,7 @@ static int cros_usbpd_charger_get_power_info(struct port_data *port)
 		port->psy_current_max = 0;
 		break;
 	default:
-		dev_err(dev, "Port %d: default case!\n", port->port_number);
+		dev_dbg(dev, "Port %d: default case!\n", port->port_number);
 		port->psy_usb_type = POWER_SUPPLY_USB_TYPE_SDP;
 	}
 
-- 
2.39.0.rc1.256.g54fd8350bd-goog

