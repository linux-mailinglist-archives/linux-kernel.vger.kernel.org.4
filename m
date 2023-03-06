Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11AD6AC625
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 17:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjCFQAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 11:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjCFQA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 11:00:28 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A872410D;
        Mon,  6 Mar 2023 08:00:25 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7F5FD1FDE7;
        Mon,  6 Mar 2023 16:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678118424; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=R9E343hTmVMkaYF9j4EIzcOLH/Va29Qgqy6eESAuotI=;
        b=OUREKcInXmanxs2PAF8o4DAvPOX/O4raO5rAwJJOzNY834dqRLTJdZkwoSocpXmLDyN0E+
        vCtmK3HZy6nW2phvDJIpSiuO56Ukf6DC1tbq8xz7QD6LQu0nfSD4sfaTG7kRrcGh81906l
        fLlv4i/qanJ2BY1ierWbbrjzbMIYf90=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678118424;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=R9E343hTmVMkaYF9j4EIzcOLH/Va29Qgqy6eESAuotI=;
        b=s1Yu90c+fAavjp6B0NjVSLZz3hTMwwHUkdiskHSPi9V+dY/D9ZOdaKMUxGnqrVbvkMGJmo
        2KkYxhrJeAZiKnAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2AF5F13513;
        Mon,  6 Mar 2023 16:00:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZiizCRgOBmQ/PwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 06 Mar 2023 16:00:24 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     deller@gmx.de, paulus@samba.org, benh@kernel.crashing.org,
        linux@armlinux.org.uk, pjones@redhat.com, timur@kernel.org,
        adaplas@gmail.com, s.hauer@pengutronix.de, shawnguo@kernel.org,
        mbroemme@libmpq.org, thomas@winischhofer.net,
        James.Bottomley@HansenPartnership.com, spock@gentoo.org,
        sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        geert+renesas@glider.be, corbet@lwn.net
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 00/99] fbdev: Fix memory leak in option parsing
Date:   Mon,  6 Mar 2023 16:58:37 +0100
Message-Id: <20230306160016.4459-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce struct option_iter and helpers to parse command-line
options with comma-separated key-value pairs. Then convert fbdev
drivers to the new interface. Fixes a memory leak in the parsing of
the video= option.

Before commit 73ce73c30ba9 ("fbdev: Transfer video= option strings to
caller; clarify ownership"), a call to fb_get_options() either
returned an internal string or a duplicated string; hence ownership of
the string's memory buffer was not well defined, but depended on how
users specified the video= option on the kernel command line. For
global settings, the caller owned the returned memory and for per-driver
settings, fb_get_options() owned the memory. As calling drivers were
unable to detect the case, the memory was leaked.

Commit 73ce73c30ba9 ("fbdev: Transfer video= option strings to caller;
clarify ownership") changed sematics to caller-owned strings. Drivers
still leaked the memory, but at least ownership was clear.

This patchset fixes the memory leak and changes string ownership back
to fb_get_options(). Patch 1 introduces struct option_iter and a few
helpers. The interface takes an option string, such as video=, in the
common form value1,key2:value2,value3 etc and returns the individial
comma-separated pairs. Various modules use this pattern, so the code
is located under lib/.

Patches 2 to 98 go through fbdev drivers and convert them to the new
interface. This often requires a number of cleanups. A driver would
typically refer to the option string's video mode. Such strings are now
copied to driver-allocated memory so that drivers don't refer directly
to the option string's memory. The option iterator then replaces manual
parsing loops based on strsep(",").

Patch 99 finally changes the ownership of the option string to be
internal to fb_get_option(); thereby fixing the memory leak. The option
iterator holds its own copy of the string and is not affected by the
change.

Most fbdev drivers only support to parse option strings if they are
built-in. I assume that's because of the original fuzzy semantics of
fb_get_options(). A later patchset could change the driver to respect
video= settings in any configuration.

Thomas Zimmermann (99):
  lib: Add option iterator
  fbdev/68328fb: Remove trailing whitespaces
  fbdev/68328fb: Remove unused option string
  fbdev/acornfb: Only init fb_info once
  fbdev/acornfb: Parse option string with struct option_iter
  fbdev/amifb: Duplicate video-mode option string
  fbdev/amifb: Parse option string with struct option_iter
  fbdev/arkfb: Duplicate video-mode option string
  fbdev/atafb: Duplicate video-mode option string
  fbdev/atafb: Parse option string with struct option_iter
  fbdev/aty: Duplicate video-mode option string
  fbdev/aty: Parse option string with struct option_iter
  fbdev/au1100fb: Parse option string with struct option_iter
  fbdev/au1200fb: Parse option string with struct option_iter
  fbdev/cirrusfb: Duplicate video-mode option string
  fbdev/cirrusfb: Parse option string with struct option_iter
  fbdev/controlfb: Remove trailing whitespaces
  fbdev/controlfb: Parse option string with struct option_iter
  fbdev/cyber2000fb: Parse option string with struct option_iter
  fbdev/efifb: Parse option string with struct option_iter
  fbdev/fm2fb: Parse option string with struct option_iter
  fbdev/fsl-diu-fb: Duplicate video-mode option string
  fbdev/fsl-diu-fb: Parse option string with struct option_iter
  fbdev/gbefb: Duplicate video-mode option string
  fbdev/gbefb: Parse option string with struct option_iter
  fbdev/geode: Duplicate video-mode option string
  fbdev/geode: Parse option string with struct option_iter
  fbdev/grvga: Duplicate video-mode option string
  fbdev/grvga: Parse option string with struct option_iter
  fbdev/gxt4500: Duplicate video-mode option string
  fbdev/hyperv_fb: Duplicate video-mode option string
  fbdev/i740fb: Duplicate video-mode option string
  fbdev/i740fb: Parse option string with struct option_iter
  fbdev/i810: Duplicate video-mode option string
  fbdev/i810: Parse option string with struct option_iter
  fbdev/imsttfb: Parse option string with struct option_iter
  fbdev/intelfb: Duplicate video-mode option string
  fbdev/intelfb: Parse option string with struct option_iter
  fbdev/imxfb: Duplicate video-mode option string
  fbdev/imxfb: Parse option string with struct option_iter
  fbdev/kyrofb: Duplicate video-mode option string
  fbdev/kyrofb: Parse option string with struct option_iter
  fbdev/macfb: Remove trailing whitespaces
  fbdev/macfb: Parse option string with struct option_iter
  fbdev/matroxfb: Parse option string with struct option_iter
  fbdev/mx3fb: Duplicate video-mode option string
  fbdev/mx3fb: Parse option string with struct option_iter
  fbdev/neofb: Duplicate video-mode option string
  fbdev/neofb: Parse option string with struct option_iter
  fbdev/nvidiafb: Duplicate video-mode option string
  fbdev/nvidiafb: Parse option string with struct option_iter
  fbdev/ocfb: Duplicate video-mode option string
  fbdev/ocfb: Parse option string with struct option_iter
  fbdev/omapfb: Parse option string with struct option_iter
  fbdev/platinumfb: Remove trailing whitespaces
  fbdev/platinumfb: Parse option string with struct option_iter
  fbdev/pm2fb: Duplicate video-mode option string
  fbdev/pm2fb: Parse option string with struct option_iter
  fbdev/pm3fb: Duplicate video-mode option string
  fbdev/pm3fb: Parse option string with struct option_iter
  fbdev/ps3fb: Duplicate video-mode option string
  fbdev/ps3fb: Parse option string with struct option_iter
  fbdev/pvr2fb: Duplicate video-mode option string
  fbdev/pvr2fb: Parse option string with struct option_iter
  fbdev/pxafb: Parse option string with struct option_iter
  fbdev/rivafb: Duplicate video-mode option string
  fbdev/rivafb: Parse option string with struct option_iter
  fbdev/s3fb: Duplicate video-mode option string
  fbdev/s3fb: Parse option string with struct option_iter
  fbdev/savagefb: Duplicate video-mode option string
  fbdev/savagefb: Parse option string with struct option_iter
  fbdev/sisfb: Constify mode string
  fbdev/sisfb: Parse option string with struct option_iter
  fbdev/skeletonfb: Parse option string with struct option_iter
  fbdev/sm712fb: Duplicate video-mode option string
  fbdev/sstfb: Duplicate video-mode option string
  fbdev/sstfb: Parse option string with struct option_iter
  fbdev/stifb: Remove trailing whitespaces
  fbdev/sti: Constify option string
  fbdev/tdfxfb: Duplicate video-mode option string
  fbdev/tdfxfb: Parse option string with struct option_iter
  fbdev/tgafb: Duplicate video-mode option string
  fbdev/tgafb: Parse option string with struct option_iter
  fbdev/tmiofb: Remove unused option string
  fbdev/tridentfb: Duplicate video-mode option string
  fbdev/tridentfb: Parse option string with struct option_iter
  fbdev/uvesafb: Duplicate video-mode option string
  fbdev/uvesafb: Parse option string with struct option_iter
  fbdev/valkyriefb: Remove trailing whitespaces
  fbdev/valkyriefb: Parse option string with struct option_iter
  fbdev/vermilion: Remove unused option string
  fbdev/vesafb: Parse option string with struct option_iter
  fbdev/vfb: Remove trailing whitespaces
  fbdev/vfb: Duplicate video-mode option string
  fbdev/vfb: Parse option string with struct option_iter
  fbdev/viafb: Parse option string with struct option_iter
  fbdev/vt8623fb: Duplicate video-mode option string
  staging/sm750fb: Parse option string with struct option_iter
  fbdev: Constify option strings

 Documentation/core-api/kernel-api.rst        |   9 ++
 drivers/staging/sm750fb/sm750.c              |  45 +++---
 drivers/video/fbdev/68328fb.c                |  24 +--
 drivers/video/fbdev/acornfb.c                |  25 ++-
 drivers/video/fbdev/amifb.c                  |  30 ++--
 drivers/video/fbdev/arkfb.c                  |  15 +-
 drivers/video/fbdev/atafb.c                  |  25 ++-
 drivers/video/fbdev/aty/aty128fb.c           |  28 +++-
 drivers/video/fbdev/aty/atyfb_base.c         |  29 +++-
 drivers/video/fbdev/aty/radeon_base.c        |  32 ++--
 drivers/video/fbdev/au1100fb.c               |  13 +-
 drivers/video/fbdev/au1200fb.c               |  15 +-
 drivers/video/fbdev/cirrusfb.c               |  37 +++--
 drivers/video/fbdev/controlfb.c              |  49 +++---
 drivers/video/fbdev/core/fb_cmdline.c        |  13 +-
 drivers/video/fbdev/core/modedb.c            |   8 +-
 drivers/video/fbdev/cyber2000fb.c            |  19 +--
 drivers/video/fbdev/efifb.c                  |  48 +++---
 drivers/video/fbdev/ep93xx-fb.c              |   2 +-
 drivers/video/fbdev/fm2fb.c                  |  16 +-
 drivers/video/fbdev/fsl-diu-fb.c             |  30 ++--
 drivers/video/fbdev/gbefb.c                  |  25 +--
 drivers/video/fbdev/geode/gx1fb_core.c       |  18 +--
 drivers/video/fbdev/geode/gxfb_core.c        |  25 +--
 drivers/video/fbdev/geode/lxfb_core.c        |  29 ++--
 drivers/video/fbdev/grvga.c                  |  32 +++-
 drivers/video/fbdev/gxt4500.c                |  18 ++-
 drivers/video/fbdev/hyperv_fb.c              |  18 ++-
 drivers/video/fbdev/i740fb.c                 |  32 ++--
 drivers/video/fbdev/i810/i810_main.c         |  30 +++-
 drivers/video/fbdev/imsttfb.c                |  18 ++-
 drivers/video/fbdev/imxfb.c                  |  23 ++-
 drivers/video/fbdev/intelfb/intelfbdrv.c     |  29 +++-
 drivers/video/fbdev/kyro/fbdev.c             |  27 ++--
 drivers/video/fbdev/macfb.c                  |  28 ++--
 drivers/video/fbdev/matrox/matroxfb_base.c   |  21 +--
 drivers/video/fbdev/mx3fb.c                  |  27 +++-
 drivers/video/fbdev/neofb.c                  |  32 ++--
 drivers/video/fbdev/nvidia/nvidia.c          |  32 ++--
 drivers/video/fbdev/ocfb.c                   |  25 ++-
 drivers/video/fbdev/omap/omapfb_main.c       |  15 +-
 drivers/video/fbdev/platinumfb.c             |  46 +++---
 drivers/video/fbdev/pm2fb.c                  |  31 ++--
 drivers/video/fbdev/pm3fb.c                  |  33 ++--
 drivers/video/fbdev/ps3fb.c                  |  32 ++--
 drivers/video/fbdev/pvr2fb.c                 |  29 ++--
 drivers/video/fbdev/pxafb.c                  |  20 ++-
 drivers/video/fbdev/riva/fbdev.c             |  32 ++--
 drivers/video/fbdev/s3fb.c                   |  33 ++--
 drivers/video/fbdev/savage/savagefb_driver.c |  26 ++-
 drivers/video/fbdev/sis/sis_main.c           |  26 +--
 drivers/video/fbdev/skeletonfb.c             |  17 +-
 drivers/video/fbdev/sm712fb.c                |  19 ++-
 drivers/video/fbdev/sstfb.c                  |  31 ++--
 drivers/video/fbdev/stifb.c                  | 162 +++++++++----------
 drivers/video/fbdev/tdfxfb.c                 |  27 ++--
 drivers/video/fbdev/tgafb.c                  |  35 ++--
 drivers/video/fbdev/tmiofb.c                 |  24 +--
 drivers/video/fbdev/tridentfb.c              |  33 ++--
 drivers/video/fbdev/uvesafb.c                |  27 ++--
 drivers/video/fbdev/valkyriefb.c             |  32 ++--
 drivers/video/fbdev/vermilion/vermilion.c    |   7 +-
 drivers/video/fbdev/vesafb.c                 |  18 ++-
 drivers/video/fbdev/vfb.c                    |  41 +++--
 drivers/video/fbdev/via/viafbdev.c           |  17 +-
 drivers/video/fbdev/vt8623fb.c               |  16 +-
 include/linux/cmdline.h                      |  29 ++++
 include/linux/fb.h                           |   2 +-
 lib/Makefile                                 |   2 +-
 lib/cmdline_iter.c                           |  97 +++++++++++
 70 files changed, 1252 insertions(+), 708 deletions(-)
 create mode 100644 include/linux/cmdline.h
 create mode 100644 lib/cmdline_iter.c

-- 
2.39.2

