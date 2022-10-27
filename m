Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C9660ECDF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 02:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbiJ0AMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 20:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234000AbiJ0AL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 20:11:57 -0400
X-Greylist: delayed 335 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 26 Oct 2022 17:11:55 PDT
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1267DF6D;
        Wed, 26 Oct 2022 17:11:55 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4MyQvF1097zBJ;
        Thu, 27 Oct 2022 02:06:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1666829178; bh=RSJxyVz8Wp0ZC04fPiuQJGAr4G/ZnkUAptmDTf6i+zM=;
        h=Date:Subject:From:To:Cc:From;
        b=KuY1fW0OZvy3E8gkGpnLiHBpnPo2EtFy/+OpEqI3h01ek23eIKT5uD7GsZPLkvnWa
         Bu7CBlDNBdNPyuWgnmYNLIYrxLjy9i0zJ8+1qKr6C2y3T3JAzcTNB6fyuAZG+RTGzi
         a/Z2o+e9UqwlV4nXK3rpT6vUP44HzIXj4MZWVqtcT/oCNWvreJQJnaatdYNoPGxgBb
         GMjcyoMigAvsL1ZO5Kd52FycQ2p4Pfbgj5qyLeHZ2WL3bgkmdcsb0uv1yG4GKI1iPa
         PDescXJrfWwmg3Kbyoi36KpXERRDUN60YtXPEk9I9kXTMGAKj0nRwdhQ7qK1pLbz/F
         N0scZAP9lQ4lw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.7 at mail
Date:   Thu, 27 Oct 2022 02:06:16 +0200
Message-Id: <e75323732bedc46d613d72ecb40f97e3bc75eea8.1666829073.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH] fbdev/core: Avoid uninitialized read in aperture_remove_conflicting_pci_device()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return on error directly from the BAR-iterating loop instead of
break+return.

This is actually a cosmetic fix, since it would be highly unusual to
have this called for a PCI device without any memory BARs.

Fixes: 9d69ef183815 ("fbdev/core: Remove remove_conflicting_pci_framebuffers()")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/video/aperture.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/video/aperture.c b/drivers/video/aperture.c
index 9e6bcc03a1a4..41e77de1ea82 100644
--- a/drivers/video/aperture.c
+++ b/drivers/video/aperture.c
@@ -340,12 +340,9 @@ int aperture_remove_conflicting_pci_devices(struct pci_dev *pdev, const char *na
 		size = pci_resource_len(pdev, bar);
 		ret = aperture_remove_conflicting_devices(base, size, primary, name);
 		if (ret)
-			break;
+			return ret;
 	}
 
-	if (ret)
-		return ret;
-
 	/*
 	 * WARNING: Apparently we must kick fbdev drivers before vgacon,
 	 * otherwise the vga fbdev driver falls over.
-- 
2.30.2

