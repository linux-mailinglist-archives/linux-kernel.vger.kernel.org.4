Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1206B4DB2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbjCJQ4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjCJQzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 11:55:42 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062F8AD04;
        Fri, 10 Mar 2023 08:53:07 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id fm20-20020a05600c0c1400b003ead37e6588so6499940wmb.5;
        Fri, 10 Mar 2023 08:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678467181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SIZHiPYmUfwEfRLCvC1wnxERX0JIKAMAqH6shcSzDMI=;
        b=BFj0Hy4pAIILDu7BSbXbKqKVPhHUu21fdl+t7FBJOjPA3rbO0cjblN3I9hjshRbXEv
         JI/xBhRs+t74TleLVPWQFXUlpUZA2OJxCj1fFbqwmUEG4xK4udUYeMkjYxUHGd3Rj+H8
         jYnKozKktz9EHubsIaveekcGqXYXmmAwwe7VLKv+RMDvuHB6trfFEEkEmcgAgcmxlDwS
         iwOxTpj/5dbdyxa0Ffx/xoz/HPFuNU0Mlv/jwnRqVfmb/+ucag2w6cN9pPdbjfdVPJjr
         bYKTdpqSrXghfm0eUTTX1ZTYQtSQglIiRXh9IWKkKLLXvo/MbcpDDxNaVoIlA8RtXwJB
         dbLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678467181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SIZHiPYmUfwEfRLCvC1wnxERX0JIKAMAqH6shcSzDMI=;
        b=lxXhLZNlsu+7nRyfANjNdWaFJ7znb7oct+jY+G7hn0VF6TXJ6o/9Qi2xEc0/CNbgrl
         aPb4fH6j+0Op1amYHCUpeKFsOqk4exL51uq8FtZJSPko+LbvKkszlWriyLpDJiGrCpWn
         djy/O600CZoaNvGQWTXQcI+BwL/TPkoorvEcMpCPq5EN5x4FsP88xitJivWssWl7s70h
         VAU/cXL/PeoCY/68Qhk7YrEGIPWuhgfdYlP+hMV8EUox3c+BjIJlNCnmgGHZnhb/Ivh9
         NgQELhQGdttBw6S+sNHie4sOa/60npsdGY8JvbMBclj1zmgqUNVaNfCNEGwuuEQU/eWA
         mPdg==
X-Gm-Message-State: AO0yUKUEv+ApPtkqRC1owyhMgf/ht7hiaDGL/51AZJoc/L7jzFe1j3Lz
        1Y7LnxFt5v+QdE2gABvr9M0=
X-Google-Smtp-Source: AK7set85HIRyC5u9XoICbRzTKjn+zmMax77FYMqrehPFpeCxCW/pYg+YZiyJvITud1PNPoYUIQc8OA==
X-Received: by 2002:a05:600c:4f02:b0:3eb:39c3:8844 with SMTP id l2-20020a05600c4f0200b003eb39c38844mr3481192wmq.12.1678467181167;
        Fri, 10 Mar 2023 08:53:01 -0800 (PST)
Received: from alessandro-pc.localdomain (host-80-116-19-80.pool80116.interbusiness.it. [80.116.19.80])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c211100b003e20fa01a86sm408427wml.13.2023.03.10.08.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 08:53:00 -0800 (PST)
From:   Alessandro Manca <crizan.git@gmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alessandro Manca <crizan.git@gmail.com>
Subject: [PATCH] HID: topre: Add support for 87 keys Realforce R2
Date:   Fri, 10 Mar 2023 17:49:33 +0100
Message-Id: <20230310164933.4798-1-crizan.git@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tenkeyless version of the Realforce R2 has the same issue of the
full size one, the report fixup is needed to make n-key rollover
work instead of 6 key rollover

Signed-off-by: Alessandro Manca <crizan.git@gmail.com>
---
 drivers/hid/Kconfig     | 2 +-
 drivers/hid/hid-ids.h   | 1 +
 drivers/hid/hid-topre.c | 2 ++
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 82f64fb31fda..4ce012f83253 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -1122,7 +1122,7 @@ config HID_TOPRE
 	tristate "Topre REALFORCE keyboards"
 	depends on HID
 	help
-	  Say Y for N-key rollover support on Topre REALFORCE R2 108 key keyboards.
+	  Say Y for N-key rollover support on Topre REALFORCE R2 108/87 key keyboards.
 
 config HID_THINGM
 	tristate "ThingM blink(1) USB RGB LED"
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 63545cd307e5..50728e0a5067 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1249,6 +1249,7 @@
 
 #define USB_VENDOR_ID_TOPRE			0x0853
 #define USB_DEVICE_ID_TOPRE_REALFORCE_R2_108			0x0148
+#define USB_DEVICE_ID_TOPRE_REALFORCE_R2_87			0x0146
 
 #define USB_VENDOR_ID_TOPSEED		0x0766
 #define USB_DEVICE_ID_TOPSEED_CYBERLINK	0x0204
diff --git a/drivers/hid/hid-topre.c b/drivers/hid/hid-topre.c
index 88a91cdad5f8..d1d5ca310ead 100644
--- a/drivers/hid/hid-topre.c
+++ b/drivers/hid/hid-topre.c
@@ -36,6 +36,8 @@ static __u8 *topre_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 static const struct hid_device_id topre_id_table[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_TOPRE,
 			 USB_DEVICE_ID_TOPRE_REALFORCE_R2_108) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_TOPRE,
+			 USB_DEVICE_ID_TOPRE_REALFORCE_R2_87) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, topre_id_table);
-- 
2.39.2

