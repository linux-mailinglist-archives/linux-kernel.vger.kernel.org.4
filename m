Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1AE67E26B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 11:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjA0K7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 05:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjA0K7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:59:06 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD592703
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:59:05 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1C7D9218ED;
        Fri, 27 Jan 2023 10:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1674817144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=cBp1CMIM/DzCTcHwo/4LUyddjNj/UP/oSP/tqheJiAE=;
        b=crF5eUs/jtoLzvQmU1z3aUx/2GFAoHE8/l47K/C5R+8kWITOO3869Ou1z0DRjSRwWf4B8j
        RTmB9DYQnVZVcDqgvEdMPgzIzsUyNfCApMxVVnh+5qW50q6gTSrP7PIcPhJDBGc4N0ceNd
        oOe5Nq7ZpM+i+TuMADRmcteJ+ytj0P4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1674817144;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=cBp1CMIM/DzCTcHwo/4LUyddjNj/UP/oSP/tqheJiAE=;
        b=ELWRvUTAMdCCw0SmXVBc3Y3n6Ug7gtUUPGzhy7WlirX2F8mypBNgR/4j8DqzlXaMc24v1S
        qR6a3bzuCjjvfQBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D7E791336F;
        Fri, 27 Jan 2023 10:59:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uW0NM3eu02MFTQAAMHmgww
        (envelope-from <jdelvare@suse.de>); Fri, 27 Jan 2023 10:59:03 +0000
Date:   Fri, 27 Jan 2023 11:59:02 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     dri-devel@lists.freedesktop.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH RESEND] drm/display: Drop obsolete dependency on
 COMPILE_TEST
Message-ID: <20230127115902.276de20d@endymion.delvare>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.34; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
is possible to test-build any driver which depends on OF on any
architecture by explicitly selecting OF. Therefore depending on
COMPILE_TEST as an alternative is no longer needed.

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
