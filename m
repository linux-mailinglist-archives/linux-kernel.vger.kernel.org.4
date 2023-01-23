Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F876789D0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 22:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbjAWVmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 16:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjAWVmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 16:42:43 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6F610429;
        Mon, 23 Jan 2023 13:42:42 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id z9-20020a17090a468900b00226b6e7aeeaso12244615pjf.1;
        Mon, 23 Jan 2023 13:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FDD135jW/NyYj2u2IXG8tYJYPCEObqA6m9pB/saDvpQ=;
        b=h8PZTgkFjfM/+itkxqzflz2j/csRwrYZs15LZXlAf7S3MFY1Dpf3pqxTtPr11x3mKk
         ipO5imVlWqmtemuf3Bzb8gukFpMF6Z3/hHV1xFpQGdi33mYVYPchDlzh++ovQkAY7s8w
         5PomO59Db2Vnv9C6oMRj36uPUZG14J2JZnbf1B5MTfBhjOATos6kZv+O0VAbtDhJ/gdu
         iX+hVLULXGIW0prqblDWT97b7+K3PSK5GQrqDVw5bJghl/OucQ7xqH3YF6yo9Ia94ync
         EIhCOGGVQhP5K8PurZ/rkPMGxVxGl7z0Sisc+ci0qzvfZz4IV+n81f52ueoXD3JWDnh5
         335w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FDD135jW/NyYj2u2IXG8tYJYPCEObqA6m9pB/saDvpQ=;
        b=vZpUIDc7EolHW8yq5pkBdIh1IA/hDOMVqTnI3m4Vm/48M5csMuSSPlSGbRPC6Gdj72
         1ZeNSV/i3JGaBN8F7GCYp4erM/umypRkdR5D1HmJxJEisZ+GyBdDiG49x3AlMm5UHUb0
         gPAZQKOZzpjtYbVwv2LPCkNU6jzexkhPgjVWY2o52Cd4nJBjam/UUv96GNKtYeEcEsZm
         Q7TLcJNPM60rjKXIrvV71DbpYIgRrA7LTdSWvEt2s71IpLugnUicheHTmrtkIurF4B6s
         VsTcv42cPpZq5hk7WMBKoFF8hwcME/xwzdrnhH4DcBF9Xc3XUkcX+4w9eiBgFVnye0zQ
         ml+g==
X-Gm-Message-State: AFqh2kpNQhHAaDH6kfVUIyLKESBqUr6uoEL8Epuu2YhyA0L1BzzqqjCS
        FWN6RM8NZ1QfsAssiG6HLi0=
X-Google-Smtp-Source: AMrXdXs6R9T9aXKiTKwaa8gr76eWk3lG3Wi81m7YS3XqJInGMqZJLxglThM2t/EbLDK4zherRNsD3g==
X-Received: by 2002:a17:90b:2347:b0:226:d727:4045 with SMTP id ms7-20020a17090b234700b00226d7274045mr27326599pjb.24.1674510161818;
        Mon, 23 Jan 2023 13:42:41 -0800 (PST)
Received: from rishit-OMEN-Laptop-15-en0xxx ([171.76.81.196])
        by smtp.gmail.com with ESMTPSA id 12-20020a17090a08cc00b0020dc318a43esm110190pjn.25.2023.01.23.13.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 13:42:41 -0800 (PST)
From:   Rishit Bansal <rishitbansal0@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rishit Bansal <rishitbansal0@gmail.com>
Subject: [PATCH] platform/x86: hp-wmi: Ignore Win-Lock key events
Date:   Tue, 24 Jan 2023 03:11:50 +0530
Message-Id: <20230123214150.62597-1-rishitbansal0@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow up from https://lore.kernel.org/all/20230120221214.24426-1-rishitbansal0@gmail.com/

There is a "Win-Lock" key on HP Omen Laptops which supports
enabling and disabling the Windows key, which trigger commands 0x21a4
and 0x121a4 respectively. Currently the hp-wmi driver throws warnings
for this event. These can be ignored using KE_IGNORE as the
functionality is handled by the keyboard firmware itself.

Signed-off-by: Rishit Bansal <rishitbansal0@gmail.com>
---
 drivers/platform/x86/hp/hp-wmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 0a99058be813..009cf0bda756 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -216,6 +216,8 @@ static const struct key_entry hp_wmi_keymap[] = {
 	{ KE_KEY, 0x213b,  { KEY_INFO } },
 	{ KE_KEY, 0x2169,  { KEY_ROTATE_DISPLAY } },
 	{ KE_KEY, 0x216a,  { KEY_SETUP } },
+	{ KE_IGNORE, 0x21a4, }, /* Win Lock On */
+	{ KE_IGNORE, 0x121a4, }, /* Win Lock Off */
 	{ KE_KEY, 0x21a9,  { KEY_TOUCHPAD_OFF } },
 	{ KE_KEY, 0x121a9, { KEY_TOUCHPAD_ON } },
 	{ KE_KEY, 0x231b,  { KEY_HELP } },
-- 
2.37.2

