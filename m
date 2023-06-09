Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F61729BE0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 15:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241347AbjFINo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 09:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239848AbjFINoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 09:44:46 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BB735A9
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 06:44:43 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:a1e2:1b31:cba3:390d])
        by michel.telenet-ops.be with bizsmtp
        id 71kZ2A00512zQ4r061kZpM; Fri, 09 Jun 2023 15:44:42 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1q7cPS-008La3-2T;
        Fri, 09 Jun 2023 15:44:33 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1q7cPp-00GCTQ-3L;
        Fri, 09 Jun 2023 15:44:33 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Corbet <corbet@lwn.net>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Tomi Valkeinen <tomba@kernel.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v2 1/4] drm/todo: Add atomic modesetting references
Date:   Fri,  9 Jun 2023 15:44:27 +0200
Message-Id: <e1ee05ea2a13aa3942b8e3d085ef7e98c1f34983.1686318012.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1686318012.git.geert+renesas@glider.be>
References: <cover.1686318012.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The section about converting existing KMS drivers to atomic modesetting
mentions the existence of a conversion guide, but does not reference it.
While the guide is old and rusty, it still contains useful information,
so add a link to it.  Also link to the LWN.net articles that give an
overview about the atomic mode setting design.

While at it, remove the reference to unconverted virtual HW drivers, as
they've been converted.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
v2:
  - Add Reviewed-by,
  - Drop double space after full stop,
  - Use footnotes for references,
  - Remore reference to unconverted virtual HW drivers.
---
 Documentation/gpu/todo.rst | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index 68bdafa0284f55f6..6c328613c049fc1d 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -49,14 +49,18 @@ converted over. Modern compositors like Wayland or Surfaceflinger on Android
 really want an atomic modeset interface, so this is all about the bright
 future.
 
-There is a conversion guide for atomic and all you need is a GPU for a
-non-converted driver (again virtual HW drivers for KVM are still all
-suitable).
+There is a conversion guide for atomic [1]_ and all you need is a GPU for a
+non-converted driver.  The "Atomic mode setting design overview" series [2]_
+[3]_ at LWN.net can also be helpful.
 
 As part of this drivers also need to convert to universal plane (which means
 exposing primary & cursor as proper plane objects). But that's much easier to
 do by directly using the new atomic helper driver callbacks.
 
+  .. [1] https://blog.ffwll.ch/2014/11/atomic-modeset-support-for-kms-drivers.html
+  .. [2] https://lwn.net/Articles/653071/
+  .. [3] https://lwn.net/Articles/653466/
+
 Contact: Daniel Vetter, respective driver maintainers
 
 Level: Advanced
-- 
2.34.1

