Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7B372C7D7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237717AbjFLOPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237377AbjFLOOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:14:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A90010FC;
        Mon, 12 Jun 2023 07:14:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0419C2048C;
        Mon, 12 Jun 2023 14:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686579241; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4C46o8uYDdrEdTWuVBPChdiMr7SKVkGgLXmMwmSf+iU=;
        b=kzIVjaEqce3dAEaknrxPIJZ6lS6+Ya8hqQX3c1byB+YH0jLXNK64oQP4mxcjAaEe17tzMF
        /54DMlCe520D+fEa1qAjq5ZpYDiXizZMP+q9iTR+wrGBb3fxCyQoMkA6aV8KUqfVjN5sm3
        yQTK0xPgy5xeK2MxrsmKWGfCVRJDUjg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686579241;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4C46o8uYDdrEdTWuVBPChdiMr7SKVkGgLXmMwmSf+iU=;
        b=YbBVmDjgAzUdv7zuZTl3RcbhtJJDzUBE5FFcKWqKWE9Pvajj1QDa6s5B7Fj0S6k4nIsyW9
        BrCZqArWSVN0mNCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A20D21357F;
        Mon, 12 Jun 2023 14:14:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GIuQJigoh2RwGQAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 12 Jun 2023 14:14:00 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     daniel@ffwll.ch, javierm@redhat.com, sam@ravnborg.org,
        deller@gmx.de, geert+renesas@glider.be, lee@kernel.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com,
        dan.carpenter@linaro.org, michael.j.ruhl@intel.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Antonino Daplas <adaplas@gmail.com>
Subject: [PATCH v2 18/38] fbdev/nvidiafb: Reorder backlight and framebuffer init/cleanup
Date:   Mon, 12 Jun 2023 16:07:56 +0200
Message-ID: <20230612141352.29939-19-tzimmermann@suse.de>
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

The driver's backlight code requires the framebuffer to be
registered. Therefore reorder the init and cleanup calls for
both data structures.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Antonino Daplas <adaplas@gmail.com>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/video/fbdev/nvidia/nvidia.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/nvidia/nvidia.c b/drivers/video/fbdev/nvidia/nvidia.c
index ea4ba3dfb96bb..039e886346fa6 100644
--- a/drivers/video/fbdev/nvidia/nvidia.c
+++ b/drivers/video/fbdev/nvidia/nvidia.c
@@ -1400,14 +1400,14 @@ static int nvidiafb_probe(struct pci_dev *pd, const struct pci_device_id *ent)
 
 	pci_set_drvdata(pd, info);
 
-	if (backlight)
-		nvidia_bl_init(par);
-
 	if (register_framebuffer(info) < 0) {
 		printk(KERN_ERR PFX "error registering nVidia framebuffer\n");
 		goto err_out_iounmap_fb;
 	}
 
+	if (backlight)
+		nvidia_bl_init(par);
+
 	printk(KERN_INFO PFX
 	       "PCI nVidia %s framebuffer (%dMB @ 0x%lX)\n",
 	       info->fix.id,
@@ -1439,9 +1439,9 @@ static void nvidiafb_remove(struct pci_dev *pd)
 
 	NVTRACE_ENTER();
 
+	nvidia_bl_exit(par);
 	unregister_framebuffer(info);
 
-	nvidia_bl_exit(par);
 	arch_phys_wc_del(par->wc_cookie);
 	iounmap(info->screen_base);
 	fb_destroy_modedb(info->monspecs.modedb);
-- 
2.41.0

