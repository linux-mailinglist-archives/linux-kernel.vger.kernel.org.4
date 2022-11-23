Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C307634E38
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 04:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235422AbiKWDQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 22:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbiKWDQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 22:16:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3288CBA5;
        Tue, 22 Nov 2022 19:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=XplI+geP46DYtWKfitoXrwKXFvO9E8ewRJGSG7yitzM=; b=GZ2/OsZp+Fy3h9ep3ygIVEgC88
        fW9vkQjgEXLFIxHH92x5HX4AEvdufiaxtG+ylyJFXqyHpHKuBKz+HOjEy+H/B3WDXvJ3PSmS20AWk
        Ezefu5K4MHaRICK6ZOVkuHcqVw6mm6jgNygD+Ks47tlreyn7EwQ+0gVBDY/0g+ZufZr0+MOavYXL3
        uvEE28zbcgtKOnkr5eTCSlwgjEiH7cOz6t8q1CijBSLXuTHu5w+4PoXQF/WDm0fww4JJv8JZzvN7U
        tm8jP0Tc3v5s/2LziH178aNzWl09w4LTr/LbzHkE0QDaeIMfx1Q5ZDHXzkDQEEqmB9wZydflEbJ0J
        Gx6gsAsg==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oxgFF-0073HC-FQ; Wed, 23 Nov 2022 03:16:17 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
        linuxppc-dev@lists.ozlabs.org, Daniel Vetter <daniel@ffwll.ch>,
        Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH -next] fbdev: offb: allow build when DRM_OFDRM=m
Date:   Tue, 22 Nov 2022 19:16:05 -0800
Message-Id: <20221123031605.16680-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix build when CONFIG_FB_OF=y and CONFIG_DRM_OFDRM=m.
When the latter symbol is =m, kconfig downgrades (limits) the 'select's
under FB_OF to modular (=m). This causes undefined symbol references:

powerpc64-linux-ld: drivers/video/fbdev/offb.o:(.data.rel.ro+0x58): undefined reference to `cfb_fillrect'
powerpc64-linux-ld: drivers/video/fbdev/offb.o:(.data.rel.ro+0x60): undefined reference to `cfb_copyarea'
powerpc64-linux-ld: drivers/video/fbdev/offb.o:(.data.rel.ro+0x68): undefined reference to `cfb_imageblit'

Fix this by allowing FB_OF any time that DRM_OFDRM != y so that the
selected FB_CFB_* symbols will become =y instead of =m.

In tristate logic (for DRM_OFDRM), this changes the dependency from
    !DRM_OFDRM	== 2 - 1 == 1 => modular only (or disabled)
to (boolean)
    DRM_OFDRM != y == y, allowing the 'select's to cause the
FB_CFB_* symbols to =y instead of =m.

Fixes: c8a17756c425 ("drm/ofdrm: Add ofdrm for Open Firmware framebuffers")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Michal Suchánek <msuchanek@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
---
 drivers/video/fbdev/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -455,7 +455,7 @@ config FB_ATARI
 config FB_OF
 	bool "Open Firmware frame buffer device support"
 	depends on (FB = y) && PPC && (!PPC_PSERIES || PCI)
-	depends on !DRM_OFDRM
+	depends on DRM_OFDRM != y
 	select APERTURE_HELPERS
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
