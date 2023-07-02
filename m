Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F28C745049
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 21:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjGBTQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 15:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjGBTQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 15:16:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB049C2
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 12:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688325346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JDcEAV6QwSsPTLZL87iLrwMThHt45oSghNV/E5+yNmU=;
        b=bt93jACT9sz4hZfiEOe+oBmltfKCjExU0UW9xoHTBEai2BP6/92jdlX8DKC1bksUUflJW0
        UlN5uBffHJ4NpVlL3G4CfptRZwbiZ8KxuRBcKgmaL5MDnw6KX8O+IfszBOEVk7h7Wb4Kte
        CJd6YrspfUw2Iaf382mWXW0gjZpdMbE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-HmTHNCLPOImiiRU9P5r4iQ-1; Sun, 02 Jul 2023 15:15:44 -0400
X-MC-Unique: HmTHNCLPOImiiRU9P5r4iQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-313f2430134so1703983f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 12:15:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688325343; x=1690917343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JDcEAV6QwSsPTLZL87iLrwMThHt45oSghNV/E5+yNmU=;
        b=d+U8nbV1O9DZPSs2Zmpny0eQuVe6IhuP/nzynURg2h1xHHsQfEKeL+vAqXraqo55aL
         Uqdpm39LMG8rvuxiyMXwsRWfLRQtvJ56zZ/6kv0Hx8y7GiPYhVXaLTNraE0SrUE52EMw
         SNVqHfGZYayJTLdHVRouGHw8CVlD3KAWFytpsvq041SVkOJPR8L4jdwWJgiIlu3W0mSe
         5RW9uJ1oBY1VWI0S84akQSDXKTdMnsJMiKwQwWWNsS5Y9izaZkdA/xWLAWM8AQHI9uEt
         de2B0keMDfigyeqooFGYi0+n9WmmfN9JWd0Z/CzO3YAF8cuqD3z3Sz8qokqsPvsaeb76
         2MgQ==
X-Gm-Message-State: ABy/qLa+m8avV4Hkfd6XBLkNQ9sOEDzxllsQLivVn3gZSNwSyh46bQKJ
        lZnBQ641unI3lYxbrz/mzPg8g7PUAqFMm2oAZVNLB781roelHm5+aIkCor8UD1asOQthy4oh1wu
        zPlWCQwElV5ovYhHloKAFCR3ABdkYTiMHZEJlZfM5cSsE7Et1+46lq5Sn+ejcfZqxNTy0oVFk0s
        cOeFfIxrY=
X-Received: by 2002:adf:dd0a:0:b0:314:1a98:ebc0 with SMTP id a10-20020adfdd0a000000b003141a98ebc0mr6619312wrm.26.1688325343477;
        Sun, 02 Jul 2023 12:15:43 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEDpCbRzZteK5K4atZLapgedVl0F/kvFEX2HZm5FHmLp8U7TVJXppcUN0K6Sz/ypkNYMZhM6Q==
X-Received: by 2002:adf:dd0a:0:b0:314:1a98:ebc0 with SMTP id a10-20020adfdd0a000000b003141a98ebc0mr6619298wrm.26.1688325343187;
        Sun, 02 Jul 2023 12:15:43 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id g11-20020a7bc4cb000000b003fbab76165asm14144231wmk.48.2023.07.02.12.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 12:15:42 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v3 1/3] drm: Improve Kconfig symbol prompt and help texts
Date:   Sun,  2 Jul 2023 21:15:18 +0200
Message-ID: <20230702191529.768248-2-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230702191529.768248-1-javierm@redhat.com>
References: <20230702191529.768248-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current text were not changed since the original Linux-2.6.12-rc2 git
import. Let's improve it and make that more aligned with the DRM/KMS docs.

Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v1)

 drivers/gpu/drm/Kconfig | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index afb3b2f5f425..373f85e174c2 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -3,10 +3,11 @@
 # Drm device configuration
 #
 # This driver provides support for the
-# Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
+# Direct Rendering Infrastructure (DRI) that is composed of the Direct
+# Rendering Manager (DRM) and Kernel Mode Settings (KMS) subsystems.
 #
 menuconfig DRM
-	tristate "Direct Rendering Manager (XFree86 4.1.0 and higher DRI support)"
+	tristate "Direct Rendering Manager (DRM) and Kernel Mode Settings (KMS)"
 	depends on (AGP || AGP=n) && !EMULATED_CMPXCHG && HAS_DMA
 	select DRM_PANEL_ORIENTATION_QUIRKS
 	select HDMI
@@ -19,13 +20,16 @@ menuconfig DRM
 	select VIDEO_CMDLINE
 	select VIDEO_NOMODESET
 	help
-	  Kernel-level support for the Direct Rendering Infrastructure (DRI)
-	  introduced in XFree86 4.0. If you say Y here, you need to select
-	  the module that's right for your graphics card from the list below.
-	  These modules provide support for synchronization, security, and
-	  DMA transfers. Please see <http://dri.sourceforge.net/> for more
-	  details.  You should also select and configure AGP
-	  (/dev/agpgart) support if it is available for your platform.
+	  Kernel-level support for the Direct Rendering Infrastructure (DRI),
+	  that is composed of the Direct Rendering Manager (DRM) and Kernel
+	  Mode Settings (KMS) subsystems.
+
+	  If you say Y here, you need to select the module that's right for
+	  your graphics card from the list below. These modules provide support
+	  for synchronization, security, and DMA transfers.
+
+	  Please see <https://www.kernel.org/doc/html/latest/gpu/index.html>
+	  for more details about the Linux DRM and KMS subsystems.
 
 config DRM_MIPI_DBI
 	tristate
-- 
2.41.0

