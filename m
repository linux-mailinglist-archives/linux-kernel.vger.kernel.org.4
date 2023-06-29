Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7691742DAB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 21:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjF2Tan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 15:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbjF2T3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 15:29:50 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7A14ECD;
        Thu, 29 Jun 2023 12:26:59 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fbc0981755so8258265e9.1;
        Thu, 29 Jun 2023 12:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688066818; x=1690658818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7N5ZmY2KWkRajsAf9XhKN7sozrITx4iUqfiGyFTIrtM=;
        b=pn5mJC3LX13PWjP5BQG0rVHHheD/uC57/FYIvnpWXl+nOn3zJ4zU+rPiBklBj41S7/
         7smMibiUI8VqTiUgSeyVEku4/Hx61E/I66tw079LprtcXk46ufEenh0Di2xq0kHrghDl
         p/arOEK7WgI6nVGXxWsG/Zr7sQtDuskJvyy+R9ay2SimyEn7/jR9bbh5logKmaSwMbtI
         fOkqKzSJ4qEf4L02G2XZMEGR8SVcu43PvCxA4uXhEJjhs5TSMaWtwfDY905QNeL8ZF6t
         56ydjvpO+HlChCNACMIwmBSP1ITrlc0qQEzFqwMBigANZ1XS+pdaiVn8mPr4XJFHynzE
         XNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688066818; x=1690658818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7N5ZmY2KWkRajsAf9XhKN7sozrITx4iUqfiGyFTIrtM=;
        b=FYW4mE6Z9V06Pg/OfklsNfH5rKiu3WKEMfjms+GXNLe5snmP9UoFf0DVM5xNSejTAb
         WW6zwpjyJKDe1YZkGHHKW9Jba6iHgqIll7ZObKb5pDMWzrxD0mYMSvXamdHmSuvSp2Jj
         jShFgIUHpB/68KQpPh9a7WCm9+JCWp1KKiwbv5yAjC/H6ADTFaOpXo+UY0l6cLQQqf7L
         9qQAOdNKmXjdaztPsMF2pkmBpxVicoYTi3meMcHKt5neVT41rpE0mS0SfDaXrVp9OKOq
         nsGeEkePUKjtKCu5xyiLabrXTmnLH4Iej4Mw5fMuG+qqXmZh4Xv/SlH6WORnlrVE+bPt
         AFcw==
X-Gm-Message-State: AC+VfDzJDa5VMXSt1I+WHU170I+HrtgiS0OZ0lEXNLR8k1s5iLd6XYmj
        79uN4aAho4AkyF40vNsfLlw=
X-Google-Smtp-Source: ACHHUZ6fs7BvV10RnyZejEahZQFzg9KSCff3eoy+1EJu4azlNVoW9RvNuqjHRhLk1DDk4kb32xF6RQ==
X-Received: by 2002:a7b:cc15:0:b0:3f9:8c3:6805 with SMTP id f21-20020a7bcc15000000b003f908c36805mr265160wmh.7.1688066817749;
        Thu, 29 Jun 2023 12:26:57 -0700 (PDT)
Received: from localhost.localdomain (cpc157791-rdng31-2-0-cust585.15-3.cable.virginm.net. [86.24.214.74])
        by smtp.gmail.com with ESMTPSA id c1-20020a05600c0ac100b003fba6a0c881sm7972683wmr.43.2023.06.29.12.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 12:26:57 -0700 (PDT)
From:   Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
Cc:     Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>
Subject: [PATCH] HID: logitech-hidpp: Add wired USB id for Logitech G502 Lightspeed
Date:   Thu, 29 Jun 2023 20:24:26 +0100
Message-ID: <20230629192422.980071-1-stuart.a.hayhurst@gmail.com>
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

Previously, support for the G502 had been attempted and reverted within this driver.
Since then, a new version of this mouse has been released, and seems to work fine.

Signed-off-by: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 5e1a412fd28f..050bad0f9aca 100644
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

