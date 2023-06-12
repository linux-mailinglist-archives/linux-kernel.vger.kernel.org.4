Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE9872C742
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237392AbjFLOOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237240AbjFLON5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:13:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A210E10D9;
        Mon, 12 Jun 2023 07:13:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3DCDE20303;
        Mon, 12 Jun 2023 14:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686579235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BdOpqd8riEVy6A6ndCU3FeJdbnI01l1n5vgXheBRNPM=;
        b=AX0PqU26N96lUG8W5y7ONitKYXtqFi+jo9/EH6RW6PPDtdArtp+VmLtBpjjaGPUUstQA4n
        6D99kkMFBjs1NA43aDerFxT22vaZ5/yd61oWOicl3JupuPpYgetNnxWYKo8xzqtVr1XhPM
        dJkNcERrnE8H9dRs2zd06EwhYSAghIU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686579235;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BdOpqd8riEVy6A6ndCU3FeJdbnI01l1n5vgXheBRNPM=;
        b=s/HWL2JP2+LDna9JvfXlutTSDq6MopUeTKYUZ+Lse0DhdZBKpPNV4NbCdJKeW14gszKv7T
        lmM07QWInHF3TWAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EC8541357F;
        Mon, 12 Jun 2023 14:13:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OEz3OCIoh2RwGQAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 12 Jun 2023 14:13:54 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     daniel@ffwll.ch, javierm@redhat.com, sam@ravnborg.org,
        deller@gmx.de, geert+renesas@glider.be, lee@kernel.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com,
        dan.carpenter@linaro.org, michael.j.ruhl@intel.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 02/38] backlight/bd6107: Rename struct bd6107_platform_data.fbdev to 'dev'
Date:   Mon, 12 Jun 2023 16:07:40 +0200
Message-ID: <20230612141352.29939-3-tzimmermann@suse.de>
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

Rename struct bd6107_platform_data.fbdev to 'dev', as it stores a
pointer to the Linux platform device; not the fbdev device. Makes
the code easier to understand.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Lee Jones <lee@kernel.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/video/backlight/bd6107.c     | 2 +-
 include/linux/platform_data/bd6107.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/backlight/bd6107.c b/drivers/video/backlight/bd6107.c
index e3410444ea235..fa3dd45c8f9d1 100644
--- a/drivers/video/backlight/bd6107.c
+++ b/drivers/video/backlight/bd6107.c
@@ -104,7 +104,7 @@ static int bd6107_backlight_check_fb(struct backlight_device *backlight,
 {
 	struct bd6107 *bd = bl_get_data(backlight);
 
-	return bd->pdata->fbdev == NULL || bd->pdata->fbdev == info->device;
+	return !bd->pdata->dev || bd->pdata->dev == info->device;
 }
 
 static const struct backlight_ops bd6107_backlight_ops = {
diff --git a/include/linux/platform_data/bd6107.h b/include/linux/platform_data/bd6107.h
index 54a06a4d26186..596ca4f95cfa4 100644
--- a/include/linux/platform_data/bd6107.h
+++ b/include/linux/platform_data/bd6107.h
@@ -8,7 +8,7 @@
 struct device;
 
 struct bd6107_platform_data {
-	struct device *fbdev;
+	struct device *dev;
 	unsigned int def_value;
 };
 
-- 
2.41.0

