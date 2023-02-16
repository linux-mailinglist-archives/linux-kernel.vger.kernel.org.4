Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064FF698EC9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 09:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjBPIf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 03:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjBPIfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 03:35:54 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA7D474D5;
        Thu, 16 Feb 2023 00:35:49 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id n20-20020a17090aab9400b00229ca6a4636so5131503pjq.0;
        Thu, 16 Feb 2023 00:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0PtgDof4o89Oj6A3Ym6AmzeoxKb7pyQvIta7sDdx1Kc=;
        b=cOMlWq5SF8rn+lCTy6O/YQ+hq0vp9PxMhJ6LEvktqqOBwZnkduQlJVCXO7WqWQPd3Y
         6FxZfrA50DZvcsTm1ylivJ3Q7/OrgNWGtpIMWUeo8Wdfj/Y36e7J2bYD4GaLqHJnrA0N
         7OfAKv1NEjFO3ebVfWDREzR2DWvDOLjriaOfOcXGrkjTmAAAMezqI5PuQwjw/ryNp2B/
         YQhR7FA/aQFvZMSRXuyhQvYQYVr+jK+UxJPNcqOOT5x+xdAcqgDbz14twswkbzlm+ysS
         eP/0Y0dC11N/U386J+nElfS4BcBKpYr6M0qFI4y2fgu8fQgmFVdTDeI+E3frtXu8V6d+
         onBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0PtgDof4o89Oj6A3Ym6AmzeoxKb7pyQvIta7sDdx1Kc=;
        b=NpGXiXQA8aaJPWZynluaNCEdDBPVBOeEmAs9X4Atgz97Vohi9Uwwqkbkf4tlCCcmMI
         hgjWyYAKZ+dOfNltOec1sQxrqtmrzKBB+Z2nVpf41grHLNfwKhWLnIQIZPaU6zPKG8mY
         INCNmKz3GUMUUNFQhUbaLOAk/qSC+cfcFQkLP0JmccoCItyIqMgekPnM/VKBcOWfw564
         3q7bdav7BdvMmQAQESD9DJFVnIx00DEuzqsycxyfkONyXcGFqDs8WPRNLm9+c8kv20xL
         ozAM0FU2b4VZkycyn3rB892gwG/UrWZnkK4yCMLL+6wDqPxsgaLF1k1+t7Vn1XO7jg5J
         vlYw==
X-Gm-Message-State: AO0yUKU0ZDD38Zk1GnQgv8q1ot8SDflMV43dCPfiRr5WYTlCeO4VvQCk
        NJhZ7/VyNtew24KMoXrt2ZA=
X-Google-Smtp-Source: AK7set/etVBvnBIWcJVDW++R+tZHALqTI8Mes+M+jWwma5VxWSqUle65Ez2eOmO3r7X4gGrK/651Eg==
X-Received: by 2002:a17:903:22d0:b0:192:4f85:b91d with SMTP id y16-20020a17090322d000b001924f85b91dmr6454674plg.46.1676536548796;
        Thu, 16 Feb 2023 00:35:48 -0800 (PST)
Received: from mi-OptiPlex-7080.mioffice.cn ([2408:8607:1b00:8:b27b:25ff:fe2c:5c4])
        by smtp.gmail.com with ESMTPSA id iw11-20020a170903044b00b0019aa7d89f06sm735091plb.30.2023.02.16.00.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 00:35:48 -0800 (PST)
From:   Qi Feng <fengqi706@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, fengqi <fengqi@xiaomi.com>
Subject: [PATCH v3] Our HID device need KEY_CAMERA_FOCUS event to control camera,
Date:   Thu, 16 Feb 2023 16:35:42 +0800
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

