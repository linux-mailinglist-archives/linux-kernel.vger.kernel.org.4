Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDA0639E9C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 02:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiK1BKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 20:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiK1BKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 20:10:33 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6FCDE8E
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 17:10:31 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id s12so13490980edd.5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 17:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4rtPx/wHRBmLXkavVYA1NDTQhY5kq6GDYlUhH/xUxZE=;
        b=UzR8DcMQoFb5PzukzVAW8QM40EE80GdkFkg90endjIMDfCTyc7qzl5ISMWKRw/kQHN
         GC+JvePNfeK7QWSwGMHD3kh0n4L8NbR8nXSnf3eTJtW1igI1nf7GamgA1V1hzEQ+b487
         gQ/jzHz5pbKl1vhMF5FEZdSfdMfjgDKV3DrEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4rtPx/wHRBmLXkavVYA1NDTQhY5kq6GDYlUhH/xUxZE=;
        b=nxNbMfxDfAQ9Um6pieggz4YXWNP0Su6VM2rrwgoGceG0N6y9V8NwJ5WDLrHd1xG42Q
         GinrxaxMMhdojmbpWaa/hLWdg1f49Buw4crGT29bWZw0VqhsK3CkScSfdrPDONLogUvD
         oyw0dWJU1gzDVZJiDUM4dX436Ws2myYiBkQKm7vicIWDDbG9k6qsoiNg6KFV8Ugr844L
         jHn3kG3OfBjfznHiSzxO3N4xrN93C3VX5N3tKpINRCHkMEdvhDJwoooxcFoGspaAecsp
         5GNM5+5/PVyciA0rPivmPSAcvueblWyYSXsa9/U0ugxCdPIVi9vglUmMmFuupqOteoAF
         f8Pg==
X-Gm-Message-State: ANoB5pmEXNRwf6Qt2U2qNfh2FB1cKxXjpylmvNPWbE4RkxpBwatsHzWK
        Z0UplO3LABDPYEw03znFBRii3w==
X-Google-Smtp-Source: AA0mqf7vS5N9OhHs7DIepOllox7bl/JKHWyYuEoPKq1KHkrQhkmTIaI5jvdwYa7cTtunenn67/QVGw==
X-Received: by 2002:a05:6402:541a:b0:463:be84:5283 with SMTP id ev26-20020a056402541a00b00463be845283mr4173024edb.7.1669597830462;
        Sun, 27 Nov 2022 17:10:30 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id r9-20020a50aac9000000b00461c6e8453dsm4618920edc.23.2022.11.27.17.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 17:10:30 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Mon, 28 Nov 2022 02:10:22 +0100
Subject: [PATCH v2] ALSA: core: Fix deadlock when shutdown a frozen userspace
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221127-snd-freeze-v2-0-d8a425ea9663@chromium.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        alsa-devel@alsa-project.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=2836; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=bThzG3aRgB/sOrGMJQB5LC1dlBBXr23rW/xD9I0gXNQ=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjhAqAgz6GX+nVta5dYboWjnLx1ooIVZ4GxuPVK4GE
 sUiAjxqJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY4QKgAAKCRDRN9E+zzrEiKSnD/
 9AIHnQ5OfDU4aPlfzZKbTEIv1bKBvOi4LYh4P5qKmBroX6tBRqNdNmBWPOEzfKTzvOynP98c95o5kF
 0KNIFK4lLja8CWhPvaSxrtY2DA3kRSoQ4utnYTZ0mumkpDQnIY9FWiyCbgjFi5csOq66gKfNR8gnWl
 qYm68hnhTUc5L4ZlLwYO4U/yR05NY68CMaQWqTztlwBiizmP/5hhKpz0+Z1aFOVd0iW2QAGAMH56u6
 IAZx9UrWJIOpqsL2QphwPABwkTHP7GiFezPWEDZCbojXnD0Plhnupm52KPN5JTTBEWuLFewyIvkMl3
 NMdFI+5kBgmuTPRsuw9/0Oq4rJHTvKcCD/tPr0ZDGiM9HXzyq2rKgjaYYkNu/qLqHpPoSbQJf+wVlm
 liRLhc+6ajmFpjwE4hHmPtC2r36HMbY93awNIgDanHxOS+W1wImoQtnydqZOVVQdy1bs17lnTGsz5v
 XcoA/HkMl/vjHeX1+6eJrig+0YsuF1o1IELyRa7xLGxIYmuN6CNvafbRoCNUVysps02u7QZrbbSmQE
 gBZMcCM8mGpOuo2AQknJXQACmh+/jBU+IUjuWpUbOjlhzPdMQrfHhl83IloPSd+ToqlemWd01WnBfc
 jE8lWgP4Ut6Atz0aHs7iLHV0ypJUoGyCvuag1WgoPgUNH6YNBZpz+fKffrsQ==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the user space is frozen, we cannot wait for it to complete.

This fixes:

[   84.943749] Freezing user space processes ... (elapsed 0.111 seconds) done.
[  246.784446] INFO: task kexec-lite:5123 blocked for more than 122 seconds.
[  246.819035] Call Trace:
[  246.821782]  <TASK>
[  246.824186]  __schedule+0x5f9/0x1263
[  246.828231]  schedule+0x87/0xc5
[  246.831779]  snd_card_disconnect_sync+0xb5/0x127
...
[  246.889249]  snd_sof_device_shutdown+0xb4/0x150
[  246.899317]  pci_device_shutdown+0x37/0x61
[  246.903990]  device_shutdown+0x14c/0x1d6
[  246.908391]  kernel_kexec+0x45/0xb9

And

[  246.893222] INFO: task kexec-lite:4891 blocked for more than 122 seconds.
[  246.927709] Call Trace:
[  246.930461]  <TASK>
[  246.932819]  __schedule+0x5f9/0x1263
[  246.936855]  ? fsnotify_grab_connector+0x5c/0x70
[  246.942045]  schedule+0x87/0xc5
[  246.945567]  schedule_timeout+0x49/0xf3
[  246.949877]  wait_for_completion+0x86/0xe8
[  246.954463]  snd_card_free+0x68/0x89
...
[  247.001080]  platform_device_unregister+0x12/0x35

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
To: Jaroslav Kysela <perex@perex.cz>
To: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>
---
Changes in v2:
- Only use pm_freezing if CONFIG_FREEZER 
- Link to v1: https://lore.kernel.org/r/20221127-snd-freeze-v1-0-57461a366ec2@chromium.org
---
 sound/core/init.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/sound/core/init.c b/sound/core/init.c
index 5377f94eb211..35fb71177fea 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/file.h>
+#include <linux/freezer.h>
 #include <linux/slab.h>
 #include <linux/time.h>
 #include <linux/ctype.h>
@@ -573,6 +574,13 @@ void snd_card_disconnect_sync(struct snd_card *card)
 		return;
 	}
 
+#ifdef CONFIG_FREEZER
+	if (pm_freezing) {
+		dev_err(card->dev, "Userspace is frozen, skipping sync\n");
+		return;
+	}
+#endif
+
 	spin_lock_irq(&card->files_lock);
 	wait_event_lock_irq(card->remove_sleep,
 			    list_empty(&card->files_list),
@@ -658,6 +666,15 @@ int snd_card_free(struct snd_card *card)
 	ret = snd_card_free_when_closed(card);
 	if (ret)
 		return ret;
+
+#ifdef CONFIG_FREEZER
+	/*
+	 * If userspace is frozen the wait from completion will never end.
+	 */
+	if (pm_freezing)
+		return 0;
+#endif
+
 	/* wait, until all devices are ready for the free operation */
 	wait_for_completion(&released);
 

---
base-commit: 4312098baf37ee17a8350725e6e0d0e8590252d4
change-id: 20221127-snd-freeze-1ee143228326

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
