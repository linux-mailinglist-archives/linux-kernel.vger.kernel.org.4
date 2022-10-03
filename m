Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1A55F3055
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 14:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiJCMbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 08:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJCMbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 08:31:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480D227CEF
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 05:31:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E40FA21A1B;
        Mon,  3 Oct 2022 12:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1664800271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=GWSawxCsFiashJDvcVnYgeWFBL5mzgy/lRXQqOImSs0=;
        b=A97Y3gbAu3lHSqUcn46V7+8nfvVq1fvsniTI6ffZWkeqj7DtXwy4MMZaOZ9tDB6BMbR+aV
        dVZAZMtSEJ6SPFbm0CObfRMvZoihU32yS/GNXWt1hV7/Y4kUKgbHGk2c2lPPCbndFUPgXx
        wRv5EGZWmxUC1d08HwwWkC6W0DNjl9I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1664800271;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=GWSawxCsFiashJDvcVnYgeWFBL5mzgy/lRXQqOImSs0=;
        b=uCGislrKB3CW7XSAYOpHpoFs7SifjxV0JCro2lSsEpcFGBhDZuHC0DJ+F1ON5AfI7rIcnC
        L5c0uieYB4w03ACg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B3BEC1332F;
        Mon,  3 Oct 2022 12:31:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 919SKg/WOmMxPQAAMHmgww
        (envelope-from <jdelvare@suse.de>); Mon, 03 Oct 2022 12:31:11 +0000
Date:   Mon, 3 Oct 2022 14:31:10 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/display: Drop obsolete dependency on COMPILE_TEST
Message-ID: <20221003143110.1f8c5307@endymion.delvare>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
is possible to test-build any driver which depends on OF on any
architecture by explicitly selecting OF. Therefore depending on
COMPILE_TEST as an alternative is no longer needed.

It is actually better to always build such drivers with OF enabled,
so that the test builds are closer to how each driver will actually be
built on its intended target. Building them without OF may not test
much as the compiler will optimize out potentially large parts of the
code. In the worst case, this could even pop false positive warnings.
Dropping COMPILE_TEST here improves the quality of our testing and
avoids wasting time on non-existent issues.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 drivers/gpu/drm/display/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-5.19.orig/drivers/gpu/drm/display/Kconfig
+++ linux-5.19/drivers/gpu/drm/display/Kconfig
@@ -3,7 +3,7 @@
 config DRM_DP_AUX_BUS
 	tristate
 	depends on DRM
-	depends on OF || COMPILE_TEST
+	depends on OF
 
 config DRM_DISPLAY_HELPER
 	tristate


-- 
Jean Delvare
SUSE L3 Support
