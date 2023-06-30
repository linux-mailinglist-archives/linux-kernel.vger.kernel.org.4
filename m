Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40269743B09
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 13:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbjF3Lky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 07:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbjF3Lku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 07:40:50 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFE41FE4;
        Fri, 30 Jun 2023 04:40:49 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fb9fd28025so2114692e87.2;
        Fri, 30 Jun 2023 04:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688125247; x=1690717247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VmfjX6Wn9m5YuvJvCWHimbJjifc79f2/rbARPNwTo4o=;
        b=TcMbVyWoTQvrN0J43t4brKxg/EgKZXWW7DfWGDZs8ZlLhxcwokidL6mCIrny6YeOpB
         4vb3e7/w2iOs47K0QbuZUYn1F77zUwfge0A+DVIwO9urXI75UrfSkg6z/lBbsPLCcJdK
         JDiW71/B0p9cE1I5dMFwDYuQY1jEASKd/KF3E9TAZlv+BFKhxSK2vUkOcVtSn8+1/T39
         hjDTJ/ZI0dImxQGF99PGbcKloQS5NNZjvzJ5okIeIvhaCacnj8PbpoY5x9VVibpMbbmT
         CE2hw7g0XHgAC98z+oOp8sBskLpBhhlR2qvBowisFxhAxl0hZifd/JsA41hoLpsdTZqT
         u0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688125247; x=1690717247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VmfjX6Wn9m5YuvJvCWHimbJjifc79f2/rbARPNwTo4o=;
        b=AQ8fXvcy+yCkfT0ZM9+YXgiUrAPcJ2dsL08oMRv4Uz1eDyPpv5D80h+0AO33gxsE1Y
         UMo2ZVAhnt0B21flRRXrQM5q7Tybg9p/bWOZXUifEJrS7D3oGQ8CQL1OwAyX9ZrIt92g
         xuqxuSssyjr0h/Up+Yh6Cp6TEpIYAVnA+c3oMITxi37gajUFhsSA4dGB3il08xaMFP6p
         9vtqyu8iPrXIZ+9KvAJfimpgZu58T9tzF+tNT2PLGTJZlEYTHpalVmZ4raqalXcJ/fTm
         g15R93hzxK5HquaFIkeOSfwWMOc1NF6FI760BXCulGbgWZl7kJRHX07WWuIgcmvH1820
         q4RA==
X-Gm-Message-State: ABy/qLayte/lbvyzF0O2+/pV7u8Y2lndiLbbGlzBmsDw7VBkgdtZzCTy
        h7lL9PimZXpyE8b4JmPdWYs=
X-Google-Smtp-Source: APBJJlEbamyWd9pJHWL99c5UMwWwaB7NdYtA840f17JULOnXq/r5bBnPfCoWnhAs0zRFsZCxszzQug==
X-Received: by 2002:ac2:4bc6:0:b0:4f8:6627:7983 with SMTP id o6-20020ac24bc6000000b004f866277983mr1946478lfq.5.1688125246974;
        Fri, 30 Jun 2023 04:40:46 -0700 (PDT)
Received: from localhost.localdomain (cpc157791-rdng31-2-0-cust585.15-3.cable.virginm.net. [86.24.214.74])
        by smtp.gmail.com with ESMTPSA id i7-20020adfdec7000000b00313dfe954ecsm17996863wrn.11.2023.06.30.04.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 04:40:46 -0700 (PDT)
From:   Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
Cc:     Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>
Subject: [PATCH v3] HID: logitech-hidpp: Add wired USB id for Logitech G502 Lightspeed
Date:   Fri, 30 Jun 2023 12:38:20 +0100
Message-ID: <20230630113818.13005-1-stuart.a.hayhurst@gmail.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, support for the G502 had been attempted in commit
'27fc32fd9417 ("HID: logitech-hidpp: add USB PID for a few more supported mice")'

This caused some issues and was reverted by
'addf3382c47c ("Revert "HID: logitech-hidpp: add USB PID for a few more
supported mice"")'.

Since then, a new version of this mouse has been released (Lightpseed Wireless), and works correctly.

This device has support for battery reporting with the driver

Signed-off-by: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
---

Changes:
v3:
 - Add git commit titles
v2:
 - Add commit references

---
 drivers/hid/hid-logitech-hidpp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 5e1a412fd28f..94a045ef8e50 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4598,6 +4598,8 @@ static const struct hid_device_id hidpp_devices[] = {
 
 	{ /* Logitech G403 Wireless Gaming Mouse over USB */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC082) },
+	{ /* Logitech G502 Lightspeed Wireless Gaming Mouse over USB */
+	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC08D) },
 	{ /* Logitech G703 Gaming Mouse over USB */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC087) },
 	{ /* Logitech G703 Hero Gaming Mouse over USB */
-- 
2.40.1.521.gf1e218fcd8

