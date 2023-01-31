Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57439682D63
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbjAaNJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbjAaNJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:09:06 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA6C126D7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 05:09:03 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id ud5so41449296ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 05:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diag.uniroma1.it; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uOYadJvP8u49K2x2oSYl+EYqiXssZ4idBGq/e4Tz9NY=;
        b=KDEKy6z9clzZ/yt+Ugm+vcRRWzEj90+XlSFk9eYXi6IC5nH1Ekl2y3Hm9QX1/VOyg6
         KoU6Bt2QbVi12p9NEJGHVLQti9laMQw3q0XhRpn8RudSITu6ZnOGgKHs7nTwUuFy4XOk
         N1Lq/Rl18bZd0+9UEdChBzxmYVa5FEhjARYR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uOYadJvP8u49K2x2oSYl+EYqiXssZ4idBGq/e4Tz9NY=;
        b=2XqWLvwh/vGR4VzPu7fC7Wg+Qp7UGeqyYRktVuGBK2ynmQgp418TLhd/H5mvVT81O9
         j/NlXvoDU34ESipWPFwt4VA8xGX06LRzahRSvELaagQYWd4ccctbwOSJZo2hDVKe2Zyn
         +FEF1X4SY+p+5mZ2KjT6P3LPQ9qhmEt8ey1M+EtElJ7RO1yyINulXIVnDq2fREbnosRb
         0H3uSZp1GR4WtOO0jfSb9SutRVOEVPsZjI2GZlrUCzPoI9EMH5BtmbcyqjmAc91uCDQs
         OkjzEZCO4/cweLlSyzKazXjSTF7Xua3E/4QvDNyakvVJxkgzzAJ1QxECyfK1S5UORPlQ
         1sKA==
X-Gm-Message-State: AO0yUKUAxBsEJLglinOPC5ZlpIBo6YIE2YKgORM2/qmCdYVH8vR7X9h7
        OQ9RxfVtolZLGaoXjnDAP7Ofdg==
X-Google-Smtp-Source: AK7set+TLo90zN/rggXs78IMqKvdRPq3UMM97//YKxvo/gz4hPVpUrCvA/s+uzGixpW4LfOqI22Pzg==
X-Received: by 2002:a17:907:da1:b0:888:7ce4:1dc1 with SMTP id go33-20020a1709070da100b008887ce41dc1mr10015780ejc.26.1675170541590;
        Tue, 31 Jan 2023 05:09:01 -0800 (PST)
Received: from [192.168.17.2] (wolkje-127.labs.vu.nl. [130.37.198.127])
        by smtp.gmail.com with ESMTPSA id f19-20020a170906391300b0088452ca0666sm4898956eje.196.2023.01.31.05.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 05:09:01 -0800 (PST)
From:   Pietro Borrello <borrello@diag.uniroma1.it>
Date:   Tue, 31 Jan 2023 13:08:45 +0000
Subject: [PATCH v2 1/5] HID: bigben_remove: manually unregister leds
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230125-hid-unregister-leds-v2-1-689cc62fc878@diag.uniroma1.it>
References: <20230125-hid-unregister-leds-v2-0-689cc62fc878@diag.uniroma1.it>
In-Reply-To: <20230125-hid-unregister-leds-v2-0-689cc62fc878@diag.uniroma1.it>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Hanno Zulla <kontakt@hanno.de>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee@kernel.org>,
        Roderick Colenbrander <roderick.colenbrander@sony.com>,
        Sven Eckelmann <sven@narfation.org>
Cc:     linux-leds@vger.kernel.org,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jkl820.git@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Kosina <jkosina@suse.cz>,
        Roderick Colenbrander <roderick@gaikai.com>,
        Pietro Borrello <borrello@diag.uniroma1.it>
X-Mailer: b4 0.11.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675170540; l=1037;
 i=borrello@diag.uniroma1.it; s=20221223; h=from:subject:message-id;
 bh=wlU1zbXd7qFTSbVqYvqS9BOVrqglVS3eHD1ePCtISHc=;
 b=1S4dFJ6YtEJ88InQZSjBIJqgxbqXt+T9JIgkqoLWq0NtwsubGN/Fl9VW6G07oKHBAzx9ClO/JaNt
 v2JlPGwtCuiFqrHoLk9QBHzG1Seo6N4LHcIZ7c4vooOoJ+dx5t6/
X-Developer-Key: i=borrello@diag.uniroma1.it; a=ed25519;
 pk=4xRQbiJKehl7dFvrG33o2HpveMrwQiUPKtIlObzKmdY=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unregister the LED controllers before device removal, as
bigben_set_led() may schedule bigben->worker after the structure has
been freed, causing a use-after-free.

Fixes: 4eb1b01de5b9 ("HID: hid-bigbenff: fix race condition for scheduled work during removal")
Signed-off-by: Pietro Borrello <borrello@diag.uniroma1.it>
---
 drivers/hid/hid-bigbenff.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hid/hid-bigbenff.c b/drivers/hid/hid-bigbenff.c
index e8b16665860d..d3201b755595 100644
--- a/drivers/hid/hid-bigbenff.c
+++ b/drivers/hid/hid-bigbenff.c
@@ -306,9 +306,14 @@ static enum led_brightness bigben_get_led(struct led_classdev *led)
 
 static void bigben_remove(struct hid_device *hid)
 {
+	int n;
 	struct bigben_device *bigben = hid_get_drvdata(hid);
 
 	bigben->removed = true;
+	for (n = 0; n < NUM_LEDS; n++) {
+		if (bigben->leds[n])
+			devm_led_classdev_unregister(&hid->dev, bigben->leds[n]);
+	}
 	cancel_work_sync(&bigben->worker);
 	hid_hw_stop(hid);
 }

-- 
2.25.1
