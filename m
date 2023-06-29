Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2B2742FA9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 23:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjF2Vqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 17:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjF2Vqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 17:46:35 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8FD2D7F;
        Thu, 29 Jun 2023 14:46:34 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fbc0981757so9332045e9.3;
        Thu, 29 Jun 2023 14:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688075193; x=1690667193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mlwouPfcUKeU2liu8ipQl7VYxOU9K6yP4hsdhfdrrEo=;
        b=TWOt1SITfaWW4ov3/HUejB6kVlbGQdPexTvpswa+QBw1O2N250zeu88DaBGkdB3oyX
         /c/pV96gaBHbPQUgQTkfRdAeG0+HWV+GRnCeH+RWqgToGTjUyFWBNx3swddAkudoK8v0
         XLE2dVNpf4kyOTX2wgybvnPv7/zkQBZSJaOYm09wuwZ7CUiJr531A3xs123zayPLuQ8f
         vLuupWwJv4+NfOdtTOvsbLPI3KqbG/k1wOVpAaWhi8+YW8K33jlTe8BXUdbo3hXJ3s2s
         BzUBzP+KjtCoPAjFweqH7cQTbzRxT0BYDlp2J9wEO4CuM8uLeJAB1dmga5zgSJTI8jZ+
         QK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688075193; x=1690667193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mlwouPfcUKeU2liu8ipQl7VYxOU9K6yP4hsdhfdrrEo=;
        b=fOt591cKHQV+ymY55qmrq1ZvVYgs3vr2DuGSHk3da0ZXLMpZibnvWuRLwRmwa6jCli
         uLK+F5fMPYBS2cgTxbEfHHmv0k45QHlsGsIov7do4JpTTzut0uGGIKc1FXTL4olStOmt
         fasX9CfoSxd8fpCgye9boGKA5OqEJZP7SAPNKjqCnE/S39ufHXIuhiA7L8ppM3n7ThBK
         a27MUBx6oMFdtDCwXyits3i0VJdwEPe0VvrahrkRRqGRR/f6ogQzW2PE2vNToLhfJj4a
         d1Yw2wY9F1CkfPgnuM6ZjnKlk3weNzvQ+nQHyZ35e/9lfcCImMz3+EKCYx2+BvgrwvR5
         hImw==
X-Gm-Message-State: AC+VfDwLDAVvCXOPcrIfDMRsHp1JAzdwGtN8z4CrSAwznoMQNywXuM/s
        LxOHrBYuaGbWN6RWr9p/LOM=
X-Google-Smtp-Source: ACHHUZ6CamCENH70lMpK+j6IW681aDT2jBhH2nyYAniB9hDjli5y7psGG/yQFu4NS+dMclotEV7YqQ==
X-Received: by 2002:a05:600c:218f:b0:3fa:a6ce:54ad with SMTP id e15-20020a05600c218f00b003faa6ce54admr512722wme.6.1688075193114;
        Thu, 29 Jun 2023 14:46:33 -0700 (PDT)
Received: from localhost.localdomain (cpc157791-rdng31-2-0-cust585.15-3.cable.virginm.net. [86.24.214.74])
        by smtp.gmail.com with ESMTPSA id y23-20020a7bcd97000000b003fbb2c0fce5sm4922034wmj.25.2023.06.29.14.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 14:46:32 -0700 (PDT)
From:   Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
Cc:     Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>
Subject: [PATCH v2] HID: logitech-hidpp: Add wired USB id for Logitech G502 Lightspeed
Date:   Thu, 29 Jun 2023 22:46:03 +0100
Message-ID: <20230629214602.987600-1-stuart.a.hayhurst@gmail.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8
In-Reply-To: <20230629192422.980071-1-stuart.a.hayhurst@gmail.com>
References: <20230629192422.980071-1-stuart.a.hayhurst@gmail.com>
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

Previously, support for the G502 had been attempted in commit 27fc32f.
This caused some issues and was reverted by addf338.
Since then, a new version of this mouse has been released (Lightpseed Wireless), and works correctly.

This device has support for battery reporting with the driver

Signed-off-by: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
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

