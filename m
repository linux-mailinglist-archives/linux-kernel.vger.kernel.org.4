Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B364675FFE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 23:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjATWNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 17:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjATWM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 17:12:58 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F40BF5DB;
        Fri, 20 Jan 2023 14:12:45 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d3so6501702plr.10;
        Fri, 20 Jan 2023 14:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/BLx/kBvpw86ToAVtcXNE5Xz+7HViCTk2DMghDTHwhY=;
        b=C5YnR9WsRnY6mJENGiO5RCQWH8CMb+20BAZpcKt0iX+4NXcCEmWdQRF1BJEwu4U+8E
         QQEFyoZNwHDu8HvF3N5loRanY5euTKANIG0mA0l/lUt1s9OuhHNhv+QnzPEe340xQ1os
         vAXeeNAsdwSwVYK22lNhgllwMpPV+7D5AQhDiVGDaYUYke5mOapwfilb9s72L5bQLv8Z
         YmTJVjeUEgxA2dT0R8w1gFjvdw5PApx8xvyAtahmdfrQ/BpG67A86CmNaUgD69fMkwKc
         SwyV3LXOVZytWnnN45NWcdyBvkPZ7Q8cLzKsiVoBp1qiNle6H87NANQwEI+a3YeIyqbl
         61+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/BLx/kBvpw86ToAVtcXNE5Xz+7HViCTk2DMghDTHwhY=;
        b=29X0skF1yDRSxjOTsZPN8qxR+W1wc0DklRpnri2WGV4Xws/UwGEPayjiMt4Cye8HKD
         K53gPvHzo9m+9KD/cZtpN3hO6MO/srUaWnBRlyqHLvRhafs/XIBJj9tXgWEf26OXFIAS
         IxihedrSTnz1R3fIVH1xU9cQf65B1bLy60Q9vG0IU61AUU5oPGTBfWzEvYAIBikuQpBd
         Dv3BfG8YNuhWiBBfvMWqHx/bqmIaC7KT2pnR115jxEySZmXJHLbsq3DYHxCOBXM9DGk6
         BpRsKG0tKtu8cKLpxdGTqsUcfPYakK7joOQM6DrgRchp7zJITHIFLvkIYLcmcUQh+gXN
         FXcA==
X-Gm-Message-State: AFqh2kqQ8HDU92U3pHYx3cgdF/swuMcSqUX+JtJonxualPUvxOSepO98
        LvyZ2VXEeCXTGXVcfn8ih04=
X-Google-Smtp-Source: AMrXdXuc9iwnf7M8bmW7c4GcJqL6ToFHY3K4xMDpJCVJM4CjPjEFyGGj3Q5UlUCS65jU1P9SVrjVGg==
X-Received: by 2002:a17:90a:fe0c:b0:227:1b37:50c9 with SMTP id ck12-20020a17090afe0c00b002271b3750c9mr16487534pjb.5.1674252764404;
        Fri, 20 Jan 2023 14:12:44 -0800 (PST)
Received: from rishit-OMEN-Laptop-15-en0xxx ([171.76.81.196])
        by smtp.gmail.com with ESMTPSA id y13-20020a63e24d000000b00478eb777d18sm23237202pgj.72.2023.01.20.14.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 14:12:43 -0800 (PST)
From:   Rishit Bansal <rishitbansal0@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rishit Bansal <rishitbansal0@gmail.com>
Subject: [PATCH v2] platform/x86: hp-wmi: Handle Omen Key event
Date:   Sat, 21 Jan 2023 03:42:14 +0530
Message-Id: <20230120221214.24426-1-rishitbansal0@gmail.com>
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

Add support to map the "HP Omen Key" to KEY_PROG2. Laptops in the HP
Omen Series open the HP Omen Command Center application on windows. But,
on linux it fails with the following message from the hp-wmi driver:

[ 5143.415714] hp_wmi: Unknown event_id - 29 - 0x21a5

Also adds support to map Fn+Esc to KEY_FN_ESC. This currently throws the
following message on the hp-wmi driver:

[ 6082.143785] hp_wmi: Unknown key code - 0x21a7

There is also a "Win-Lock" key on HP Omen Laptops which supports
Enabling and Disabling the Windows key, which trigger commands 0x21a4
and 0x121a4 respectively, but I wasn't able to find any KEY in input.h
to map this to.

Signed-off-by: Rishit Bansal <rishitbansal0@gmail.com>
---
Changes since v1:
 - Add support for FN+Esc Key
---
 drivers/platform/x86/hp/hp-wmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 0a99058be813..ab858db551fb 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -91,6 +91,7 @@ enum hp_wmi_event_ids {
 	HPWMI_BATTERY_CHARGE_PERIOD	= 0x10,
 	HPWMI_SANITIZATION_MODE		= 0x17,
 	HPWMI_SMART_EXPERIENCE_APP	= 0x21,
+	HPWMI_OMEN_KEY				= 0x1D,
 };
 
 /*
@@ -219,6 +220,8 @@ static const struct key_entry hp_wmi_keymap[] = {
 	{ KE_KEY, 0x21a9,  { KEY_TOUCHPAD_OFF } },
 	{ KE_KEY, 0x121a9, { KEY_TOUCHPAD_ON } },
 	{ KE_KEY, 0x231b,  { KEY_HELP } },
+	{ KE_KEY, 0x21a5,  { KEY_PROG2 }}, /* HP Omen Key */
+	{ KE_KEY, 0x21a7, { KEY_FN_ESC }},
 	{ KE_END, 0 }
 };
 
@@ -810,6 +813,7 @@ static void hp_wmi_notify(u32 value, void *context)
 	case HPWMI_SMART_ADAPTER:
 		break;
 	case HPWMI_BEZEL_BUTTON:
+	case HPWMI_OMEN_KEY:
 		key_code = hp_wmi_read_int(HPWMI_HOTKEY_QUERY);
 		if (key_code < 0)
 			break;
-- 
2.37.2

