Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7EA7270A5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 23:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjFGVlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 17:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjFGVlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 17:41:09 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE04A1BF7;
        Wed,  7 Jun 2023 14:41:08 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-bacfa9fa329so5467276.0;
        Wed, 07 Jun 2023 14:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686174067; x=1688766067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nGrbqkR+iLzazRj/5Eznoucnd0w6CLsNLWJLkMCRjmE=;
        b=CJjLzbCxwiqomsb+jlDBuo4XtdzT0RRbk0bBi7sk+uwEbXCEV+5211UEpBoSeK7ddD
         DfCZlyTN+ZHpQqT5+kTW4u3LJgyysWmHA5vfXUH65OoTNmtJVHOpq1nfuwvMq5GAw63Z
         NkAE61S1L1WXzRmjR9vw1TfWJboQspQaDWdrVFu1AkEIL8+WjOAxl1FDWfktTheScczs
         1bhFwwc9qG1j8NWRI2OoebHdEGipSto8Fa4EuxAis629dECIUtxLFq+gy9kJMOr1o+TM
         sCwjQDJqtDl3VDSuSsBDI7XfY5QYGmM9fJpH/jQ6xfDB3sAi1DAaPeMQS922pCo7N7/t
         sIpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686174067; x=1688766067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nGrbqkR+iLzazRj/5Eznoucnd0w6CLsNLWJLkMCRjmE=;
        b=anpFJG1QiZj7MKRyu1E+xMEWN4VMFg7GZGoF4lJka2404GaFExr9qBxClydIvmg/YH
         m8b50yFCs1j9oFiydLjmaMsAkeMNgw0Zkw0UW0gFmzooVXVFXAbTN7BRzVyuv44q59KG
         PTbYceChy1p/maMsKsV9qCPQ1uUKoOYrIUFZUJgfR53cWYSxoBvX8vR30jb+TyfJcx+p
         ovEXdSFJjqkwbSWzrs/KxeR91d/OseRy7P58+sQrfjdTJp5zKZ53231so0sufxvKlS0z
         lfun2SFFXlBGXh0Bwrr1DES8ZRZYSr5EdZ8Yt4/mnhd+vok9D0BCsAXETKyV43JMc1+o
         k9rg==
X-Gm-Message-State: AC+VfDwg1XKaagQWLN5mdOjFO+7Cm8X7NLioXDH7xJKrZKTnecMqbUzh
        n375XO+NFqy22Q7i7TRj/LpaM+BdlsqFPg==
X-Google-Smtp-Source: ACHHUZ58QT/d69mv9JhOkCKiAQq7JxdtSdfrT3g9kxfF6x5JcDQ6rcAbB2vfoB33GiVxVU+lfkOzbw==
X-Received: by 2002:a25:fa09:0:b0:b9e:6d2c:ce2 with SMTP id b9-20020a25fa09000000b00b9e6d2c0ce2mr6629219ybe.46.1686174067588;
        Wed, 07 Jun 2023 14:41:07 -0700 (PDT)
Received: from horus.lan (75-164-186-145.ptld.qwest.net. [75.164.186.145])
        by smtp.gmail.com with ESMTPSA id e18-20020a258912000000b00ba7c2112650sm172714ybl.30.2023.06.07.14.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 14:41:07 -0700 (PDT)
From:   Jason Gerecke <killertofu@gmail.com>
X-Google-Original-From: Jason Gerecke <jason.gerecke@wacom.com>
To:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc:     Ping Cheng <pinglinux@gmail.com>,
        Aaron Armstrong Skomra <skomra@gmail.com>,
        Joshua Dickens <Joshua@Joshua-Dickens.com>,
        Jason Gerecke <jason.gerecke@wacom.com>
Subject: [PATCH] HID: wacom: Use ktime_t rather than int when dealing with timestamps
Date:   Wed,  7 Jun 2023 14:41:02 -0700
Message-ID: <20230607214102.2113-1-jason.gerecke@wacom.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code which interacts with timestamps needs to use the ktime_t type
returned by functions like ktime_get. The int type does not offer
enough space to store these values, and attempting to use it is a
recipe for problems. In this particular case, overflows would occur
when calculating/storing timestamps leading to incorrect values being
reported to userspace. In some cases these bad timestamps cause input
handling in userspace to appear hung.

Link: https://gitlab.freedesktop.org/libinput/libinput/-/issues/901
Fixes: 17d793f3ed53 ("HID: wacom: insert timestamp to packed Bluetooth (BT) events")
Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 4 ++--
 drivers/hid/wacom_wac.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 2ccf83837134..2f16e47e4b69 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1314,7 +1314,7 @@ static void wacom_intuos_pro2_bt_pen(struct wacom_wac *wacom)
 	struct input_dev *pen_input = wacom->pen_input;
 	unsigned char *data = wacom->data;
 	int number_of_valid_frames = 0;
-	int time_interval = 15000000;
+	ktime_t time_interval = 15000000;
 	ktime_t time_packet_received = ktime_get();
 	int i;
 
@@ -1359,7 +1359,7 @@ static void wacom_intuos_pro2_bt_pen(struct wacom_wac *wacom)
 		bool range = frame[0] & 0x20;
 		bool invert = frame[0] & 0x10;
 		int frames_number_reversed = number_of_valid_frames - i - 1;
-		int event_timestamp = time_packet_received - frames_number_reversed * time_interval;
+		ktime_t event_timestamp = time_packet_received - frames_number_reversed * time_interval;
 
 		if (!valid)
 			continue;
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 1a40bb8c5810..ee21bb260f22 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -324,7 +324,7 @@ struct hid_data {
 	int ps_connected;
 	bool pad_input_event_flag;
 	unsigned short sequence_number;
-	int time_delayed;
+	ktime_t time_delayed;
 };
 
 struct wacom_remote_data {
-- 
2.41.0

