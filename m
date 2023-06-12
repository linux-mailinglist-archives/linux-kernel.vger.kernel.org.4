Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5920F72C7EA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237954AbjFLOQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237450AbjFLOOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:14:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C6F171D;
        Mon, 12 Jun 2023 07:14:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9040E2048E;
        Mon, 12 Jun 2023 14:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686579244; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g3wCKV7kkk87zubrz9MEzYCCAV0sKbpNFal72zite58=;
        b=I1ahMZf/iz09dQaLm2xUbouAtlZQq2mNHcmfvUNkB/sP64j7gYrK2kjM7GO2GrvGOo3XQs
        C0rVYq/BLUKjnc6gxqJkSvS6StqjQumxwNeOsmtR2Il7OgnVWzfgCAzC0kWo6V3enjcKf7
        sgf3gV+RFcYgUES04BIAmpugIC7Kx6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686579244;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g3wCKV7kkk87zubrz9MEzYCCAV0sKbpNFal72zite58=;
        b=ltbTpBSRPHpJOGUZRcjwDOrm+r8bj0fD3CCYA5M3SnyL4F8Td+rvB2X5eiO65PhKS6mhPH
        FjXBiKwc2+MajLBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 417241357F;
        Mon, 12 Jun 2023 14:14:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8CcBDywoh2RwGQAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 12 Jun 2023 14:14:04 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     daniel@ffwll.ch, javierm@redhat.com, sam@ravnborg.org,
        deller@gmx.de, geert+renesas@glider.be, lee@kernel.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com,
        dan.carpenter@linaro.org, michael.j.ruhl@intel.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 28/38] fbdev/sh7760fb: Use hardware device with dev_() output during probe
Date:   Mon, 12 Jun 2023 16:08:06 +0200
Message-ID: <20230612141352.29939-29-tzimmermann@suse.de>
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

Call output helpers in the probe function with the hardware device.
The virtual fbdev device has not been initialized at that point. Also
prepares fbdev for making struct fb_info.dev optional.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/sh7760fb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/sh7760fb.c b/drivers/video/fbdev/sh7760fb.c
index 74543a1e30314..8566bcd664076 100644
--- a/drivers/video/fbdev/sh7760fb.c
+++ b/drivers/video/fbdev/sh7760fb.c
@@ -450,7 +450,7 @@ static int sh7760fb_probe(struct platform_device *pdev)
 
 	par->pd = pdev->dev.platform_data;
 	if (!par->pd) {
-		dev_dbg(info->dev, "no display setup data!\n");
+		dev_dbg(&pdev->dev, "no display setup data!\n");
 		ret = -ENODEV;
 		goto out_fb;
 	}
@@ -519,13 +519,13 @@ static int sh7760fb_probe(struct platform_device *pdev)
 
 	ret = fb_alloc_cmap(&info->cmap, 256, 0);
 	if (ret) {
-		dev_dbg(info->dev, "Unable to allocate cmap memory\n");
+		dev_dbg(&pdev->dev, "Unable to allocate cmap memory\n");
 		goto out_mem;
 	}
 
 	ret = register_framebuffer(info);
 	if (ret < 0) {
-		dev_dbg(info->dev, "cannot register fb!\n");
+		dev_dbg(&pdev->dev, "cannot register fb!\n");
 		goto out_cmap;
 	}
 	platform_set_drvdata(pdev, info);
-- 
2.41.0

