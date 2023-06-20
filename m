Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDC7737355
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 19:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjFTR4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 13:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjFTR4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 13:56:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FD41728
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 10:56:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67E6B61348
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 17:56:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7049FC433CC;
        Tue, 20 Jun 2023 17:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687283799;
        bh=LEAe0NsxUirzrz1/vb7i4AnyoOYRet9FQaA6901ajn0=;
        h=From:To:Cc:Subject:Date:From;
        b=YIRZ/eYWd+fOtXdsGARBHdShsNOAhtDClS5GCF3QOhXmq3zYHqvR6bRLS5oMTGbY/
         g5r1Xq/8squEOcLnwH2mdVIudEjsRTTwIbSO/0XC0epo+/6/FCLptoxsDT9mWg99m7
         DI5ts+0H2ESi+keQ7H9Vvkus61ejCdGW76DCc7Jg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geoff Levand <geoff@infradead.org>,
        Thierry Reding <treding@nvidia.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH] sound: make all 'class' structures const
Date:   Tue, 20 Jun 2023 19:56:34 +0200
Message-ID: <20230620175633.641141-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4811; i=gregkh@linuxfoundation.org; h=from:subject; bh=1cb14i/gwAIZV/k9GgRzsiloc4sYqdiaG2JT6hlz55Q=; b=owGbwMvMwCRo6H6F97bub03G02pJDCkTXwRKPnlQtZJ9S+He/186Pqt+XnTrxfOIDYHX+7wlO 76ma3RIdMSyMAgyMciKKbJ82cZzdH/FIUUvQ9vTMHNYmUCGMHBxCsBENDYyLFj88XGRTZ0p69lD e/aVeqt35QbdFmVYcLLR+uaX3+5HWn2sM/69zfrGuIIhBwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ivan Orlov <ivan.orlov0322@gmail.com>

Now that the driver core allows for struct class to be in read-only
memory, making all 'class' structures to be declared at build time
placing them into read-only memory, instead of having to be dynamically
allocated at load time.

Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Geoff Levand <geoff@infradead.org>
Cc: Thierry Reding <treding@nvidia.com>
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: alsa-devel@alsa-project.org
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/sound/core.h     |  2 +-
 sound/core/control_led.c |  2 +-
 sound/core/init.c        |  4 ++--
 sound/sound_core.c       | 23 ++++++++++++-----------
 4 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/include/sound/core.h b/include/sound/core.h
index 3edc4ab08774..bbcecfff723d 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -232,7 +232,7 @@ static inline struct device *snd_card_get_device_link(struct snd_card *card)
 
 extern int snd_major;
 extern int snd_ecards_limit;
-extern struct class *sound_class;
+extern const struct class sound_class;
 #ifdef CONFIG_SND_DEBUG
 extern struct dentry *sound_debugfs_root;
 #endif
diff --git a/sound/core/control_led.c b/sound/core/control_led.c
index 3cadd40100f3..ee77547bf8dc 100644
--- a/sound/core/control_led.c
+++ b/sound/core/control_led.c
@@ -737,7 +737,7 @@ static int __init snd_ctl_led_init(void)
 	unsigned int group;
 
 	device_initialize(&snd_ctl_led_dev);
-	snd_ctl_led_dev.class = sound_class;
+	snd_ctl_led_dev.class = &sound_class;
 	snd_ctl_led_dev.release = snd_ctl_led_dev_release;
 	dev_set_name(&snd_ctl_led_dev, "ctl-led");
 	if (device_add(&snd_ctl_led_dev)) {
diff --git a/sound/core/init.c b/sound/core/init.c
index df0c22480375..baef2688d0cf 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -129,7 +129,7 @@ void snd_device_initialize(struct device *dev, struct snd_card *card)
 	device_initialize(dev);
 	if (card)
 		dev->parent = &card->card_dev;
-	dev->class = sound_class;
+	dev->class = &sound_class;
 	dev->release = default_release;
 }
 EXPORT_SYMBOL_GPL(snd_device_initialize);
@@ -331,7 +331,7 @@ static int snd_card_init(struct snd_card *card, struct device *parent,
 
 	device_initialize(&card->card_dev);
 	card->card_dev.parent = parent;
-	card->card_dev.class = sound_class;
+	card->card_dev.class = &sound_class;
 	card->card_dev.release = release_card_device;
 	card->card_dev.groups = card->dev_groups;
 	card->dev_groups[0] = &card_dev_attr_group;
diff --git a/sound/sound_core.c b/sound/sound_core.c
index 4f6911274d56..d81fed1c1226 100644
--- a/sound/sound_core.c
+++ b/sound/sound_core.c
@@ -23,9 +23,6 @@ static inline int init_oss_soundcore(void)	{ return 0; }
 static inline void cleanup_oss_soundcore(void)	{ }
 #endif
 
-struct class *sound_class;
-EXPORT_SYMBOL(sound_class);
-
 MODULE_DESCRIPTION("Core sound module");
 MODULE_AUTHOR("Alan Cox");
 MODULE_LICENSE("GPL");
@@ -37,6 +34,12 @@ static char *sound_devnode(const struct device *dev, umode_t *mode)
 	return kasprintf(GFP_KERNEL, "snd/%s", dev_name(dev));
 }
 
+const struct class sound_class = {
+	.name = "sound",
+	.devnode = sound_devnode,
+};
+EXPORT_SYMBOL(sound_class);
+
 static int __init init_soundcore(void)
 {
 	int rc;
@@ -45,21 +48,19 @@ static int __init init_soundcore(void)
 	if (rc)
 		return rc;
 
-	sound_class = class_create("sound");
-	if (IS_ERR(sound_class)) {
+	rc = class_register(&sound_class);
+	if (rc) {
 		cleanup_oss_soundcore();
-		return PTR_ERR(sound_class);
+		return rc;
 	}
 
-	sound_class->devnode = sound_devnode;
-
 	return 0;
 }
 
 static void __exit cleanup_soundcore(void)
 {
 	cleanup_oss_soundcore();
-	class_destroy(sound_class);
+	class_unregister(&sound_class);
 }
 
 subsys_initcall(init_soundcore);
@@ -276,7 +277,7 @@ static int sound_insert_unit(struct sound_unit **list, const struct file_operati
 		}
 	}
 
-	device_create(sound_class, dev, MKDEV(SOUND_MAJOR, s->unit_minor),
+	device_create(&sound_class, dev, MKDEV(SOUND_MAJOR, s->unit_minor),
 		      NULL, "%s", s->name+6);
 	return s->unit_minor;
 
@@ -302,7 +303,7 @@ static void sound_remove_unit(struct sound_unit **list, int unit)
 		if (!preclaim_oss)
 			__unregister_chrdev(SOUND_MAJOR, p->unit_minor, 1,
 					    p->name);
-		device_destroy(sound_class, MKDEV(SOUND_MAJOR, p->unit_minor));
+		device_destroy(&sound_class, MKDEV(SOUND_MAJOR, p->unit_minor));
 		kfree(p);
 	}
 }
-- 
2.41.0

