Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE5072E0CC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 13:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236588AbjFMLKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 07:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239833AbjFMLKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 07:10:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B970510DE;
        Tue, 13 Jun 2023 04:10:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 695741FD94;
        Tue, 13 Jun 2023 11:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686654599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2wf5UN+K9UcAVy1mCANrZvQ9x0IpdyWlrVw1Wkiccp8=;
        b=Nu/aaOrslrM66/21iVrUsUCTXmyWGejYdEvhVWbTTvejZLW0RsRzMAtIu6mGfqNZcsAXGI
        iAiAj7DCMQrNNHZuzZgD/XlwL1HuyoBnngarP8OoEqOIy64fGBuTm90nmmf7NOqyl/1Res
        MYcgZO01fxU02q7NWciFY3UvE/GGZxI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686654599;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2wf5UN+K9UcAVy1mCANrZvQ9x0IpdyWlrVw1Wkiccp8=;
        b=Awwnl0APnI49QzRWeWfRYyXqXzgxWh+3sTo9xLumKCBpYeAMn/D3FEgF3jDsENtzq83I7o
        +poLwx6OQms4x9DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 26C7013A47;
        Tue, 13 Jun 2023 11:09:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mGrCCIdOiGR8CQAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Tue, 13 Jun 2023 11:09:59 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     daniel@ffwll.ch, javierm@redhat.com, sam@ravnborg.org,
        deller@gmx.de, geert+renesas@glider.be, lee@kernel.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com,
        dan.carpenter@linaro.org, michael.j.ruhl@intel.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 09/38] fbdev/aty128fb: Reorder backlight and framebuffer init/cleanup
Date:   Tue, 13 Jun 2023 13:06:44 +0200
Message-ID: <20230613110953.24176-10-tzimmermann@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230613110953.24176-1-tzimmermann@suse.de>
References: <20230613110953.24176-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver's backlight code requires the framebuffer to be
registered. Therefore reorder the init and cleanup calls for
both data structures.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
---
 drivers/video/fbdev/aty/aty128fb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/aty/aty128fb.c b/drivers/video/fbdev/aty/aty128fb.c
index 36a9ac05a340f..b4a49068a522f 100644
--- a/drivers/video/fbdev/aty/aty128fb.c
+++ b/drivers/video/fbdev/aty/aty128fb.c
@@ -2028,14 +2028,14 @@ static int aty128_init(struct pci_dev *pdev, const struct pci_device_id *ent)
 	par->asleep = 0;
 	par->lock_blank = 0;
 
+	if (register_framebuffer(info) < 0)
+		return 0;
+
 #ifdef CONFIG_FB_ATY128_BACKLIGHT
 	if (backlight)
 		aty128_bl_init(par);
 #endif
 
-	if (register_framebuffer(info) < 0)
-		return 0;
-
 	fb_info(info, "%s frame buffer device on %s\n",
 		info->fix.id, video_card);
 
@@ -2167,12 +2167,12 @@ static void aty128_remove(struct pci_dev *pdev)
 
 	par = info->par;
 
-	unregister_framebuffer(info);
-
 #ifdef CONFIG_FB_ATY128_BACKLIGHT
 	aty128_bl_exit(info->bl_dev);
 #endif
 
+	unregister_framebuffer(info);
+
 	arch_phys_wc_del(par->wc_cookie);
 	iounmap(par->regbase);
 	iounmap(info->screen_base);
-- 
2.41.0

