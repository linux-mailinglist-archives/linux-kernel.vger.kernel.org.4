Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B0374D6B2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 15:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbjGJNBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 09:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbjGJNBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:01:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6369D114;
        Mon, 10 Jul 2023 06:01:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0DCCA221B7;
        Mon, 10 Jul 2023 13:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688994075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ynzR+asEmdddM2MtQxJUJQzhlQgoZE1NTlMZsErkt0w=;
        b=e7w/Xl3Hw9wwGd1e5xnBwZ+JxFUOmymNR5fKqsDftYESWMjt9tCqJU6zrTR1MLii6b3jWl
        Ab/erDdWMJKPJwB1cc0m1+8KkIA8r+llJxP22L1X8T64yKqz5NVHeGRj2TfRLZ4mvx6aSy
        VjvEnoCmfKOYfENXo96rp4DBlqFfEKY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688994075;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ynzR+asEmdddM2MtQxJUJQzhlQgoZE1NTlMZsErkt0w=;
        b=2YmsAJmF2VZHLPUdB7v5MUFt26z8vBYO2gdre0w9vPW7oE1H5RJV14vgBDQS8LQqAHgRXW
        rLO8r+62FjDS9ABg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9DBE013A05;
        Mon, 10 Jul 2023 13:01:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /BeDJRoBrGTTFAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 10 Jul 2023 13:01:14 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     deller@gmx.de, javierm@redhat.com
Cc:     linux-sh@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-input@vger.kernel.org, linux-media@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-geode@lists.infradead.org, linux-nvidia@lists.surfsouth.com,
        linux-hyperv@vger.kernel.org, linux-omap@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 00/17] fbdev: Remove FBINFO_DEFAULT and FBINFO_FLAG_DEFAULT flags
Date:   Mon, 10 Jul 2023 14:50:04 +0200
Message-ID: <20230710130113.14563-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unused flags FBINFO_DEFAULT and FBINFO_FLAG_DEFAULT from
fbdev and drivers, as briefly discussed at [1]. Both flags were maybe
useful when fbdev had special handling for driver modules. With
commit 376b3ff54c9a ("fbdev: Nuke FBINFO_MODULE"), they are both 0
and have no further effect.

Patches 1 to 7 remove FBINFO_DEFAULT from drivers. Patches 2 to 5
split this by the way the fb_info struct is being allocated. All flags
are cleared to zero during the allocation.

Patches 8 to 16 do the same for FBINFO_FLAG_DEFAULT. Patch 8 fixes
an actual bug in how arch/sh uses the tokne for struct fb_videomode,
which is unrelated.

Patch 17 removes both flag constants from <linux/fb.h>

[1] https://lore.kernel.org/dri-devel/877crer8fm.fsf@minerva.mail-host-address-is-not-set/

Thomas Zimmermann (17):
  drm: Remove flag FBINFO_DEFAULT from fbdev emulation
  fbdev: Remove flag FBINFO_DEFAULT from fbdev drivers
  fbdev: Remove flag FBINFO_DEFAULT from fbdev drivers
  fbdev: Remove flag FBINFO_DEFAULT from fbdev drivers
  fbdev: Remove flag FBINFO_DEFAULT from fbdev drivers
  fbdev/fsl-diu-fb: Remove flag FBINFO_DEFAULT
  vfio-mdev: Remove flag FBINFO_DEFAULT from fbdev sample driver
  arch/sh: Do not assign FBINFO_FLAG_DEFAULT to fb_videomode.flag
  auxdisplay: Remove flag FBINFO_FLAG_DEFAULT from fbdev drivers
  hid/picolcd: Remove flag FBINFO_FLAG_DEFAULT from fbdev driver
  media: Remove flag FBINFO_FLAG_DEFAULT from fbdev drivers
  staging: Remove flag FBINFO_FLAG_DEFAULT from fbdev drivers
  fbdev: Remove flag FBINFO_FLAG_DEFAULT from fbdev drivers
  fbdev: Remove flag FBINFO_FLAG_DEFAULT from fbdev drivers
  fbdev/atafb: Remove flag FBINFO_FLAG_DEFAULT
  fbdev/pxafb: Remove flag FBINFO_FLAG_DEFAULT
  fbdev: Remove FBINFO_DEFAULT and FBINFO_FLAG_DEFAULT

 arch/sh/boards/mach-sh7763rdp/setup.c          | 1 -
 drivers/auxdisplay/cfag12864bfb.c              | 1 -
 drivers/auxdisplay/ht16k33.c                   | 1 -
 drivers/gpu/drm/drm_fbdev_dma.c                | 1 -
 drivers/gpu/drm/drm_fbdev_generic.c            | 1 -
 drivers/gpu/drm/gma500/fbdev.c                 | 2 +-
 drivers/gpu/drm/radeon/radeon_fbdev.c          | 2 +-
 drivers/hid/hid-picolcd_fb.c                   | 1 -
 drivers/media/pci/ivtv/ivtvfb.c                | 1 -
 drivers/media/test-drivers/vivid/vivid-osd.c   | 1 -
 drivers/staging/fbtft/fbtft-core.c             | 2 +-
 drivers/staging/sm750fb/sm750.c                | 1 -
 drivers/video/fbdev/68328fb.c                  | 2 +-
 drivers/video/fbdev/acornfb.c                  | 2 +-
 drivers/video/fbdev/amba-clcd.c                | 1 -
 drivers/video/fbdev/amifb.c                    | 5 ++---
 drivers/video/fbdev/arcfb.c                    | 1 -
 drivers/video/fbdev/asiliantfb.c               | 1 -
 drivers/video/fbdev/atafb.c                    | 1 -
 drivers/video/fbdev/atmel_lcdfb.c              | 2 +-
 drivers/video/fbdev/aty/aty128fb.c             | 1 -
 drivers/video/fbdev/aty/atyfb_base.c           | 3 +--
 drivers/video/fbdev/aty/radeon_base.c          | 3 +--
 drivers/video/fbdev/broadsheetfb.c             | 2 +-
 drivers/video/fbdev/bw2.c                      | 1 -
 drivers/video/fbdev/carminefb.c                | 1 -
 drivers/video/fbdev/cg14.c                     | 2 +-
 drivers/video/fbdev/cg3.c                      | 1 -
 drivers/video/fbdev/cg6.c                      | 2 +-
 drivers/video/fbdev/chipsfb.c                  | 1 -
 drivers/video/fbdev/cirrusfb.c                 | 3 +--
 drivers/video/fbdev/clps711x-fb.c              | 1 -
 drivers/video/fbdev/cobalt_lcdfb.c             | 1 -
 drivers/video/fbdev/controlfb.c                | 2 +-
 drivers/video/fbdev/cyber2000fb.c              | 2 +-
 drivers/video/fbdev/da8xx-fb.c                 | 1 -
 drivers/video/fbdev/efifb.c                    | 1 -
 drivers/video/fbdev/ep93xx-fb.c                | 1 -
 drivers/video/fbdev/ffb.c                      | 3 +--
 drivers/video/fbdev/fm2fb.c                    | 1 -
 drivers/video/fbdev/fsl-diu-fb.c               | 2 +-
 drivers/video/fbdev/g364fb.c                   | 2 +-
 drivers/video/fbdev/gbefb.c                    | 1 -
 drivers/video/fbdev/geode/gx1fb_core.c         | 1 -
 drivers/video/fbdev/geode/gxfb_core.c          | 1 -
 drivers/video/fbdev/geode/lxfb_core.c          | 1 -
 drivers/video/fbdev/goldfishfb.c               | 1 -
 drivers/video/fbdev/grvga.c                    | 2 +-
 drivers/video/fbdev/gxt4500.c                  | 3 +--
 drivers/video/fbdev/hecubafb.c                 | 2 +-
 drivers/video/fbdev/hgafb.c                    | 2 +-
 drivers/video/fbdev/hitfb.c                    | 2 +-
 drivers/video/fbdev/hpfb.c                     | 1 -
 drivers/video/fbdev/hyperv_fb.c                | 2 --
 drivers/video/fbdev/i740fb.c                   | 2 +-
 drivers/video/fbdev/i810/i810_main.c           | 4 ++--
 drivers/video/fbdev/imsttfb.c                  | 3 +--
 drivers/video/fbdev/imxfb.c                    | 3 +--
 drivers/video/fbdev/intelfb/intelfbdrv.c       | 5 ++---
 drivers/video/fbdev/kyro/fbdev.c               | 1 -
 drivers/video/fbdev/leo.c                      | 1 -
 drivers/video/fbdev/macfb.c                    | 1 -
 drivers/video/fbdev/matrox/matroxfb_crtc2.c    | 5 ++---
 drivers/video/fbdev/maxinefb.c                 | 1 -
 drivers/video/fbdev/mb862xx/mb862xxfbdrv.c     | 2 +-
 drivers/video/fbdev/metronomefb.c              | 2 +-
 drivers/video/fbdev/mmp/fb/mmpfb.c             | 2 +-
 drivers/video/fbdev/mx3fb.c                    | 1 -
 drivers/video/fbdev/neofb.c                    | 2 +-
 drivers/video/fbdev/nvidia/nvidia.c            | 4 ++--
 drivers/video/fbdev/offb.c                     | 2 +-
 drivers/video/fbdev/omap/omapfb_main.c         | 1 -
 drivers/video/fbdev/omap2/omapfb/omapfb-main.c | 1 -
 drivers/video/fbdev/p9100.c                    | 1 -
 drivers/video/fbdev/platinumfb.c               | 1 -
 drivers/video/fbdev/pm2fb.c                    | 3 +--
 drivers/video/fbdev/pm3fb.c                    | 3 +--
 drivers/video/fbdev/pmag-aa-fb.c               | 1 -
 drivers/video/fbdev/pmag-ba-fb.c               | 1 -
 drivers/video/fbdev/pmagb-b-fb.c               | 1 -
 drivers/video/fbdev/ps3fb.c                    | 2 +-
 drivers/video/fbdev/pvr2fb.c                   | 2 +-
 drivers/video/fbdev/pxa168fb.c                 | 2 +-
 drivers/video/fbdev/pxafb.c                    | 2 --
 drivers/video/fbdev/q40fb.c                    | 1 -
 drivers/video/fbdev/riva/fbdev.c               | 3 +--
 drivers/video/fbdev/s1d13xxxfb.c               | 4 ++--
 drivers/video/fbdev/s3c-fb.c                   | 1 -
 drivers/video/fbdev/sa1100fb.c                 | 1 -
 drivers/video/fbdev/savage/savagefb_driver.c   | 3 +--
 drivers/video/fbdev/sh_mobile_lcdcfb.c         | 2 --
 drivers/video/fbdev/simplefb.c                 | 1 -
 drivers/video/fbdev/sis/sis_main.c             | 5 +----
 drivers/video/fbdev/skeletonfb.c               | 2 +-
 drivers/video/fbdev/sm501fb.c                  | 2 +-
 drivers/video/fbdev/sm712fb.c                  | 1 -
 drivers/video/fbdev/smscufx.c                  | 2 +-
 drivers/video/fbdev/sstfb.c                    | 1 -
 drivers/video/fbdev/sunxvr1000.c               | 1 -
 drivers/video/fbdev/sunxvr2500.c               | 1 -
 drivers/video/fbdev/sunxvr500.c                | 1 -
 drivers/video/fbdev/tcx.c                      | 1 -
 drivers/video/fbdev/tdfxfb.c                   | 2 +-
 drivers/video/fbdev/tgafb.c                    | 2 +-
 drivers/video/fbdev/tridentfb.c                | 2 +-
 drivers/video/fbdev/udlfb.c                    | 2 +-
 drivers/video/fbdev/uvesafb.c                  | 3 +--
 drivers/video/fbdev/valkyriefb.c               | 1 -
 drivers/video/fbdev/vermilion/vermilion.c      | 2 +-
 drivers/video/fbdev/vesafb.c                   | 2 +-
 drivers/video/fbdev/vfb.c                      | 1 -
 drivers/video/fbdev/vga16fb.c                  | 2 +-
 drivers/video/fbdev/via/viafbdev.c             | 2 +-
 drivers/video/fbdev/vt8500lcdfb.c              | 3 +--
 drivers/video/fbdev/wm8505fb.c                 | 3 +--
 drivers/video/fbdev/xen-fbfront.c              | 2 +-
 drivers/video/fbdev/xilinxfb.c                 | 1 -
 include/linux/fb.h                             | 3 ---
 samples/vfio-mdev/mdpy-fb.c                    | 1 -
 119 files changed, 65 insertions(+), 150 deletions(-)

-- 
2.41.0

