Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF8E6390AF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 21:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiKYUb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 15:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiKYUbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 15:31:19 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A322E9CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 12:31:18 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:d898:271f:7512:e47f])
        by albert.telenet-ops.be with bizsmtp
        id okXG280024su47u06kXGQc; Fri, 25 Nov 2022 21:31:18 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oyfLv-001aQu-KL; Fri, 25 Nov 2022 21:31:15 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oyfLv-003Kyr-Ar; Fri, 25 Nov 2022 21:31:15 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Helge Deller <deller@gmx.de>,
        Michael Schmitz <schmitzmic@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH/RFC 1/3] video: fbdev: c2p: Add transp2() and transp2x()
Date:   Fri, 25 Nov 2022 21:31:08 +0100
Message-Id: <7161013a238b616d18c79a1c9aa57655135ded04.1669406382.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1669406380.git.geert@linux-m68k.org>
References: <cover.1669406380.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add transpose operations on two 32-bit words, using normal or reverse
order.

To be used by the Atari DRM driver.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/video/fbdev/c2p_core.h | 38 ++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/video/fbdev/c2p_core.h b/drivers/video/fbdev/c2p_core.h
index cf5f1ebce65e6afd..480bd80fb31b57c0 100644
--- a/drivers/video/fbdev/c2p_core.h
+++ b/drivers/video/fbdev/c2p_core.h
@@ -142,6 +142,44 @@ static __always_inline void transp4x(u32 d[], unsigned int n, unsigned int m)
 }
 
 
+    /*
+     *  Transpose operations on 2 32-bit words
+     */
+
+static __always_inline void transp2(u32 d[], unsigned int n, unsigned int m)
+{
+	u32 mask = get_mask(n);
+
+	switch (m) {
+	case 1:
+		/* Single n x 1 block */
+		_transp(d, 0, 1, n, mask);
+		return;
+	}
+
+	BUILD_BUG();
+}
+
+
+    /*
+     *  Transpose operations on 2 32-bit words (reverse order)
+     */
+
+static __always_inline void transp2x(u32 d[], unsigned int n, unsigned int m)
+{
+	u32 mask = get_mask(n);
+
+	switch (m) {
+	case 1:
+		/* Single n x 1 block */
+		_transp(d, 1, 0, n, mask);
+		return;
+	}
+
+	BUILD_BUG();
+}
+
+
     /*
      *  Compose two values, using a bitmask as decision value
      *  This is equivalent to (a & mask) | (b & ~mask)
-- 
2.25.1

