Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9864672C7A1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237989AbjFLOOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237265AbjFLON7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:13:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4909210C4;
        Mon, 12 Jun 2023 07:13:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CBA9F2032C;
        Mon, 12 Jun 2023 14:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686579236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YweYg5QlxrvSMFXdEzvC/VBZz/0c3f7S0HZGS4SbqFk=;
        b=TSfozs5XHmzkm9M1JxPQxso7XdfoqSQtFyLEk7+i2mA4J4YwGdnwrW150DPOtM22bldOEl
        zYdMUfc9mbHaa/lVGRab3OzQMRxDMNy7ZX/zA85BuuMKUN3pJCgXlArvbxr5XJyzQ2jpJ8
        BKjzboD2scSmJyDG2+t0U0dyT6LSCy8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686579236;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YweYg5QlxrvSMFXdEzvC/VBZz/0c3f7S0HZGS4SbqFk=;
        b=LuHCGeZkQiXPdQKpizmFnPYmsvbUF60dQ07fBtTOoV2N4fpJp1sZlewIYsXJLxW+j/aRFN
        mRrCdWgIRc+a30Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 70A8913A67;
        Mon, 12 Jun 2023 14:13:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mDedGiQoh2RwGQAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 12 Jun 2023 14:13:56 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     daniel@ffwll.ch, javierm@redhat.com, sam@ravnborg.org,
        deller@gmx.de, geert+renesas@glider.be, lee@kernel.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com,
        dan.carpenter@linaro.org, michael.j.ruhl@intel.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: [PATCH v2 06/38] backlight/lv5207lp: Rename struct lv5207lp_platform_data.fbdev to 'dev'
Date:   Mon, 12 Jun 2023 16:07:44 +0200
Message-ID: <20230612141352.29939-7-tzimmermann@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612141352.29939-1-tzimmermann@suse.de>
References: <20230612141352.29939-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename struct lv5207lp_platform_data.fbdev to 'dev', as it stores a
pointer to the Linux platform device; not the fbdev device. Makes
the code easier to understand.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Lee Jones <lee@kernel.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: linux-sh@vger.kernel.org
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
 arch/sh/boards/mach-kfr2r09/setup.c    | 2 +-
 drivers/video/backlight/lv5207lp.c     | 2 +-
 include/linux/platform_data/lv5207lp.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sh/boards/mach-kfr2r09/setup.c b/arch/sh/boards/mach-kfr2r09/setup.c
index 20f4db778ed6a..a18e80394aedc 100644
--- a/arch/sh/boards/mach-kfr2r09/setup.c
+++ b/arch/sh/boards/mach-kfr2r09/setup.c
@@ -202,7 +202,7 @@ static struct platform_device kfr2r09_sh_lcdc_device = {
 };
 
 static struct lv5207lp_platform_data kfr2r09_backlight_data = {
-	.fbdev = &kfr2r09_sh_lcdc_device.dev,
+	.dev = &kfr2r09_sh_lcdc_device.dev,
 	.def_value = 13,
 	.max_value = 13,
 };
diff --git a/drivers/video/backlight/lv5207lp.c b/drivers/video/backlight/lv5207lp.c
index 99ba4bc0a500d..739f45cd2d381 100644
--- a/drivers/video/backlight/lv5207lp.c
+++ b/drivers/video/backlight/lv5207lp.c
@@ -67,7 +67,7 @@ static int lv5207lp_backlight_check_fb(struct backlight_device *backlight,
 {
 	struct lv5207lp *lv = bl_get_data(backlight);
 
-	return lv->pdata->fbdev == NULL || lv->pdata->fbdev == info->device;
+	return !lv->pdata->dev || lv->pdata->dev == info->device;
 }
 
 static const struct backlight_ops lv5207lp_backlight_ops = {
diff --git a/include/linux/platform_data/lv5207lp.h b/include/linux/platform_data/lv5207lp.h
index c9da8d4027504..95d85c1394bca 100644
--- a/include/linux/platform_data/lv5207lp.h
+++ b/include/linux/platform_data/lv5207lp.h
@@ -8,7 +8,7 @@
 struct device;
 
 struct lv5207lp_platform_data {
-	struct device *fbdev;
+	struct device *dev;
 	unsigned int max_value;
 	unsigned int def_value;
 };
-- 
2.41.0

