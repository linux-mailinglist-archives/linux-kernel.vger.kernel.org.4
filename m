Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103E872C79D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237435AbjFLOOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237316AbjFLOOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:14:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9215810D9;
        Mon, 12 Jun 2023 07:13:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 31693203E7;
        Mon, 12 Jun 2023 14:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686579238; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6kaVCNj4tgN+z2DdqslCQwj9/KoTXQV8PSRO8egtdwg=;
        b=TUsdTAYgmS8pspPnsXIEh8X/Q6hFe1+kgCRCx0cJ6HUYwaxplYsxI7KxIcSv2gk1WzxUCM
        tkixYzDw8TI8VjyqX7mSHAcHknZ+W4XGL4Kb7X5C/W26lmJTdeuW/lu1OwzMfFvh60xGPu
        TU9c1g6qtcGNROkxe/o0SMuLIJDy9Vs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686579238;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6kaVCNj4tgN+z2DdqslCQwj9/KoTXQV8PSRO8egtdwg=;
        b=eB6RqgxueXzNYsaF1Y3a4zr0pkYjM/24cfOxXsOq8/07BOeFZ1+nrTHTM01B4IJuKY+Ls3
        9RGhQD0zMxMTIaBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D4BBE1357F;
        Mon, 12 Jun 2023 14:13:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mG3+MiUoh2RwGQAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 12 Jun 2023 14:13:57 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     daniel@ffwll.ch, javierm@redhat.com, sam@ravnborg.org,
        deller@gmx.de, geert+renesas@glider.be, lee@kernel.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com,
        dan.carpenter@linaro.org, michael.j.ruhl@intel.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 10/38] fbdev/aty128fb: Use hardware device as backlight parent
Date:   Mon, 12 Jun 2023 16:07:48 +0200
Message-ID: <20230612141352.29939-11-tzimmermann@suse.de>
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

Use the hardware device in struct fb_info.device as parent of the
backlight device. Aligns the driver with the rest of the codebase
and prepares fbdev for making struct fb_info.dev optional.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/video/fbdev/aty/aty128fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/aty/aty128fb.c b/drivers/video/fbdev/aty/aty128fb.c
index b4a49068a522f..2d9320a52e519 100644
--- a/drivers/video/fbdev/aty/aty128fb.c
+++ b/drivers/video/fbdev/aty/aty128fb.c
@@ -1846,7 +1846,7 @@ static void aty128_bl_init(struct aty128fb_par *par)
 	memset(&props, 0, sizeof(struct backlight_properties));
 	props.type = BACKLIGHT_RAW;
 	props.max_brightness = FB_BACKLIGHT_LEVELS - 1;
-	bd = backlight_device_register(name, info->dev, par, &aty128_bl_data,
+	bd = backlight_device_register(name, info->device, par, &aty128_bl_data,
 				       &props);
 	if (IS_ERR(bd)) {
 		info->bl_dev = NULL;
-- 
2.41.0

