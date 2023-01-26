Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7A167C182
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 01:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235863AbjAZAZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 19:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjAZAZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 19:25:21 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9B764694
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 16:25:18 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id az20so1184205ejc.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 16:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diag.uniroma1.it; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OtVGZ8lsHwJ47yfcKnn1bRe6oeChLHMzfzZSc6Gf3Bk=;
        b=FhM1PUIfGfe6DUD16IChGWJaU6LERUdgiPksp6xjaJUAOtm0035y/Tsd6cq+yHu7tt
         qT76ljpv39GRfaDNSrayfQdofiyBe9lV9P1CGOhrpAy8XokyeAoyQUTp43e+ebGlnlCR
         rUGXnHKg3PpjJ7CS0MsENo5zvI78JnrV1gRFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OtVGZ8lsHwJ47yfcKnn1bRe6oeChLHMzfzZSc6Gf3Bk=;
        b=ISlKJF5xkxnnwwqC7u280JOO0g0czmPjEwyUWw+Rec36nhu8o1htygbo1mwD1ZVVhh
         jJDL1mbpNGVFWQ7qTd2bOIfqvCTn4pZUNPkPLke5Ys5uNuDkUfMu3OHCWl8UmbwUEbB+
         uy3++UEVqkU0xHepjw8BMd5elsBaWw9OaEop8Hxvo2jkORiU6v5R7SdzRPu4AhV6Hib9
         gKJPoBnDO5Pei3LRhK8XgNC/heCdPF+99BNpY07Hm3vuKIn6ZcMYiRN2n56uNd+FK7TQ
         S8vMUlHLQkpbWpJBYzsAYm5zu0ykHRNSd3MJvRsyrOwuGNRt8N1AhqO2S/JW15U/2yUO
         td8A==
X-Gm-Message-State: AFqh2krh4CSQAsLwXNvfXgVQFUOIU3ZY1J3giQU+YSigd55Pl7QjoqZi
        WulJBkwWgs5WjsVBPXZ5EQArQw==
X-Google-Smtp-Source: AMrXdXtDF/mhpij5N8QZ7WduZ2JyEuoRZqc/BP6mFLcsVZ5G65OUA8CUxVO1bcXYcAWmtKisdo+Lpw==
X-Received: by 2002:a17:906:774f:b0:870:94e:13f9 with SMTP id o15-20020a170906774f00b00870094e13f9mr36103029ejn.0.1674692717095;
        Wed, 25 Jan 2023 16:25:17 -0800 (PST)
Received: from [192.168.17.2] (wolkje-127.labs.vu.nl. [130.37.198.127])
        by smtp.gmail.com with ESMTPSA id jy12-20020a170907762c00b008784e808553sm555707ejc.6.2023.01.25.16.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 16:25:16 -0800 (PST)
From:   Pietro Borrello <borrello@diag.uniroma1.it>
Date:   Thu, 26 Jan 2023 00:24:54 +0000
Subject: [PATCH 2/5] HID: asus_remove: manually unregister led
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230125-hid-unregister-leds-v1-2-9a5192dcef16@diag.uniroma1.it>
References: <20230125-hid-unregister-leds-v1-0-9a5192dcef16@diag.uniroma1.it>
In-Reply-To: <20230125-hid-unregister-leds-v1-0-9a5192dcef16@diag.uniroma1.it>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Hanno Zulla <kontakt@hanno.de>,
        Carlo Caione <carlo@endlessm.com>, Pavel Machek <pavel@ucw.cz>,
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1674692715; l=841;
 i=borrello@diag.uniroma1.it; s=20221223; h=from:subject:message-id;
 bh=6oFA70DnzD6hxYzPyFU4oYw2osDEjulwpyTezPO1v4g=;
 b=LanraiZGbk3yNg4MlXZkhk/27dt0SorHwntfu9nVSjCCqJi6acwSDXB4OPEZrVMyTlOv0T7cuAF5
 Y31n2QKECy5DcyMwxWkrtks5NJOh29fDMmZpo8w47onA6s9bTu0/
X-Developer-Key: i=borrello@diag.uniroma1.it; a=ed25519;
 pk=4xRQbiJKehl7dFvrG33o2HpveMrwQiUPKtIlObzKmdY=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unregister the LED controller before device removal, as
asus_kbd_backlight_set() may schedule led->work after the structure
has been freed, causing a use-after-free.

Fixes: af22a610bc38 ("HID: asus: support backlight on USB keyboards")
Signed-off-by: Pietro Borrello <borrello@diag.uniroma1.it>
---
 drivers/hid/hid-asus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index f99752b998f3..0f274c8d1bef 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1122,6 +1122,7 @@ static void asus_remove(struct hid_device *hdev)
 
 	if (drvdata->kbd_backlight) {
 		drvdata->kbd_backlight->removed = true;
+		devm_led_classdev_unregister(&hdev->dev, &drvdata->kbd_backlight->cdev);
 		cancel_work_sync(&drvdata->kbd_backlight->work);
 	}
 

-- 
2.25.1
