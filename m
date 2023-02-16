Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919C1698EED
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 09:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjBPIoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 03:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjBPIoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 03:44:24 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040C638B5B;
        Thu, 16 Feb 2023 00:44:23 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id d2so1185323pjd.5;
        Thu, 16 Feb 2023 00:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0PtgDof4o89Oj6A3Ym6AmzeoxKb7pyQvIta7sDdx1Kc=;
        b=J+MKpiifRVUnm1+rLNu9lutRUWUwMrgb+ru/PRTql8ocS7mAfpP8rUy8BdyB+fwVhm
         A5wqxnQS0vPTP2SWIW4XagYZ5MkOcMLqEKT+i9bqlvFI6R7yhmUD+Wtyomnfspq2p6M1
         uaOgqIIdOP4fEbPy/oraMdEAT2gQLEhxEgVt6mpKZh+laHik1K0SOgHGviblEHXpTyOi
         14KitB+9908gqu46oMnagBNnFr1/NHJLUzFe4z+zN4o1TZ+yEDc3ZPHEWyzU5bQ+fvRt
         joTKQ2lBinzqlBxanJNZxERXo8RFbmBOx7wuhj6xasYSY6VVAkTv2UdY3grcDeLw4HrE
         F7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0PtgDof4o89Oj6A3Ym6AmzeoxKb7pyQvIta7sDdx1Kc=;
        b=X0NvSlZSpjF5SUx4DtXa60k90CsdfNlWkwciW8kITDFuY17EZpM3XFCDG4iJ2SYwHG
         aeFehmecehELXfOuhFpUGwOm/7grJ3rgBcr3RKNNUYDhOoUp9q9XTM4sdDQXRTnZUtI3
         nr/1t/+6TXskTWVuExv86gxE5S4Or9KAA52wmngHUE7mRbEciE5Kt7tTb1HH2zCTP6F/
         ngyyVcFu+qxtjOAiRvJybTM3sIX/Z0Pg/Z5XsWrDDSFEBfFv7wH6dWMz6+nMG79jAT8i
         /sKs16WZ2y2CDmHTcTGbdzNOttjtzCpHpx0K/T84cWe4ot4jta10sakD4iudTw6mw05t
         dPMw==
X-Gm-Message-State: AO0yUKXJGj8C9XlN07Hw+6hBWxD1ocsip6Mv5LL3m708DpI62R0DRISJ
        7aTVXbZs8j+IWAr0j17Xpe8=
X-Google-Smtp-Source: AK7set+CYHsq8ek78oGS0PSxmlxN6YIS+FR4k59YmGQj/GbbjdFrVr80YpCTN5sCIBT8b8p5vlhonA==
X-Received: by 2002:a17:90a:5314:b0:233:ee50:d291 with SMTP id x20-20020a17090a531400b00233ee50d291mr6428759pjh.22.1676537062532;
        Thu, 16 Feb 2023 00:44:22 -0800 (PST)
Received: from mi-OptiPlex-7080.mioffice.cn ([2408:8607:1b00:8:b27b:25ff:fe2c:5c4])
        by smtp.gmail.com with ESMTPSA id bt14-20020a17090af00e00b002341ae23ad7sm5355002pjb.1.2023.02.16.00.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 00:44:22 -0800 (PST)
From:   Qi Feng <fengqi706@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, fengqi <fengqi@xiaomi.com>
Subject: [PATCH v3] Our HID device need KEY_CAMERA_FOCUS event to control camera,
Date:   Thu, 16 Feb 2023 16:44:14 +0800
Message-Id: <9a85b268c7636ef2e4e3bbbe318561ba2842a591.1676536357.git.fengqi@xiaomi.com>
X-Mailer: git-send-email 2.39.0
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

From: fengqi <fengqi@xiaomi.com>

but this event is non-existent in current HID driver.

So we add this event in hid-input.c

Signed-off-by: fengqi <fengqi@xiaomi.com>

---

changes in v3:

-add HID_UP_CAMERA in HID usage tables , Then add the mapping under HID_UP_CAMERA

-modify the commit log of patch

-Link to v2:https://lore.kernel.org/linux-input/CACOZ=ZU0zgRmoRu8X5bMUzUrXA9x-qoDJqrQroUs=+qKR58MQA@mail.gmail.com/T/#t
-Link to v1:https://lore.kernel.org/linux-input/CACOZ=ZWB3grJKn7wAZEZ0BDyN7KJF4VWUTNs-mPxeoW_oiR7=g@mail.gmail.com/T/#t

---
---
 drivers/hid/hid-input.c | 10 ++++++++++
 include/linux/hid.h     |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 77c8c49852b5..c6098ae2fac7 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1225,6 +1225,16 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 			return;
 		}
 		goto unknown;
+	case HID_UP_CAMERA:
+		switch (usage->hid & HID_USAGE) {
+		case 0x020:
+			map_key_clear(KEY_CAMERA_FOCUS);	break;
+		case 0x021:
+			map_key_clear(KEY_CAMERA);		break;
+		default:
+			goto ignore;
+		}
+		break;
 
 	case HID_UP_HPVENDOR:	/* Reported on a Dutch layout HP5308 */
 		set_bit(EV_REP, input->evbit);
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 8677ae38599e..88793b77bd63 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -155,6 +155,7 @@ struct hid_item {
 #define HID_UP_DIGITIZER	0x000d0000
 #define HID_UP_PID		0x000f0000
 #define HID_UP_BATTERY		0x00850000
+#define HID_UP_CAMERA		0x00900000
 #define HID_UP_HPVENDOR         0xff7f0000
 #define HID_UP_HPVENDOR2        0xff010000
 #define HID_UP_MSVENDOR		0xff000000
-- 
2.39.0

