Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD0F728A54
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 23:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235973AbjFHVig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 17:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234340AbjFHVie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 17:38:34 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA24E2D76;
        Thu,  8 Jun 2023 14:38:33 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-ba829e17aacso1216609276.0;
        Thu, 08 Jun 2023 14:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686260312; x=1688852312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNSTXKmj7hUlHOCo/xW5hZUWoBrrqUdvHn7X8LT0uEo=;
        b=rZIcXZyCfGooVGGpLJeChBFLN7dybtTQQD+7IN5Ah2gDaJGh/7o5lF95DKFVrZsmau
         JcQ65/GsP+NRet2RK+xat+jPJeJldBX+ajWq3AXStMP+NjrkQCBwhWDUHBWLgTrvLiW9
         Zly30kTox+RY3fR2R+F6WxGyDP4RFLQgkC7lcsortV2U6N0eXXtJ1UW8HkAJH5Zbp61/
         nXeFFq7CyIBapVygOmu9XOVRXN9kaw1HPg6dgsts8kvtrpirYegNqztW50RQlW7bszQo
         /IRoSYsI2qP7dc3xmZAYjVl9OEaUtA+82pznAY7RWkkBEtUlLMh+xZIQ9YFcNu2DZI+N
         TrfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686260312; x=1688852312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mNSTXKmj7hUlHOCo/xW5hZUWoBrrqUdvHn7X8LT0uEo=;
        b=YnlziMDHh3v0mVoWXz2x4dLNgSUQmKBsL044ZMTN4ecqnrMW56/bsdftVjkpLSPDsM
         pzBrtpwbfCMKCp/Y2d4iJ1l54feO0bP1xfYCbvoiEVYYlb2mkxMy6fsw0T2X0MustoD/
         gCsJKvWGl70UCVOakBx0PQlay79nJphCrU8cxdMdZk7T8LL47ePE8OchDWogkod30Wsg
         7hDmdsv1zj1WV+8gbDVanHabPXYkI2A3tUQEzOnVvEa1IhPU8c7DJWuJowbyHwmKMDQz
         rxjYr+szVs8O308DSgFcF2MdIwBmGU4SdO1f2sZn6oBGTKDfjwDv5DRVVcXETQseyQaI
         wjWQ==
X-Gm-Message-State: AC+VfDxwjiV7+8dg3kGMMzH/1lBk10YJx7fS9nGUb1FvlvlL6/0ojKIR
        soS62SuTutqjy2B+tYwUWky3ItrQtbiEmg==
X-Google-Smtp-Source: ACHHUZ64nz/89TF4yOsANzK3DPKHXPY8azQ0YKED8rWPYKwjdTat0cV7rT7fhdPR0mnUoTDTSHU0fg==
X-Received: by 2002:a81:49c6:0:b0:561:e7bb:1b27 with SMTP id w189-20020a8149c6000000b00561e7bb1b27mr585571ywa.52.1686260312608;
        Thu, 08 Jun 2023 14:38:32 -0700 (PDT)
Received: from horus.lan (75-164-186-145.ptld.qwest.net. [75.164.186.145])
        by smtp.gmail.com with ESMTPSA id e130-20020a816988000000b00545b02d4af5sm189158ywc.48.2023.06.08.14.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 14:38:32 -0700 (PDT)
From:   Jason Gerecke <killertofu@gmail.com>
X-Google-Original-From: Jason Gerecke <jason.gerecke@wacom.com>
To:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc:     Ping Cheng <pinglinux@gmail.com>,
        Aaron Armstrong Skomra <skomra@gmail.com>,
        Joshua Dickens <Joshua@Joshua-Dickens.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        Jason Gerecke <jason.gerecke@wacom.com>, stable@vger.kernel.org
Subject: [PATCH v2] HID: wacom: Use ktime_t rather than int when dealing with timestamps
Date:   Thu,  8 Jun 2023 14:38:28 -0700
Message-ID: <20230608213828.2108-1-jason.gerecke@wacom.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607214102.2113-1-jason.gerecke@wacom.com>
References: <20230607214102.2113-1-jason.gerecke@wacom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
CC: stable@vger.kernel.org
Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
v2: Use div_u64 to perform division to deal with ARC and ARM architectures
    (as found by the kernel test robot)

 drivers/hid/wacom_wac.c | 6 +++---
 drivers/hid/wacom_wac.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 2ccf838371343..174bf03908d7c 100644
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
 
@@ -1348,7 +1348,7 @@ static void wacom_intuos_pro2_bt_pen(struct wacom_wac *wacom)
 	if (number_of_valid_frames) {
 		if (wacom->hid_data.time_delayed)
 			time_interval = ktime_get() - wacom->hid_data.time_delayed;
-		time_interval /= number_of_valid_frames;
+		time_interval = div_u64(time_interval, number_of_valid_frames);
 		wacom->hid_data.time_delayed = time_packet_received;
 	}
 
@@ -1359,7 +1359,7 @@ static void wacom_intuos_pro2_bt_pen(struct wacom_wac *wacom)
 		bool range = frame[0] & 0x20;
 		bool invert = frame[0] & 0x10;
 		int frames_number_reversed = number_of_valid_frames - i - 1;
-		int event_timestamp = time_packet_received - frames_number_reversed * time_interval;
+		ktime_t event_timestamp = time_packet_received - frames_number_reversed * time_interval;
 
 		if (!valid)
 			continue;
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 1a40bb8c5810c..ee21bb260f22f 100644
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

