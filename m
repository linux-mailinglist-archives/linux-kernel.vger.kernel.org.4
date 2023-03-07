Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CBD6AF7CB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 22:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjCGVlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 16:41:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjCGVlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 16:41:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274469CFCF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 13:41:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5BEF61538
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 21:40:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2924C433EF;
        Tue,  7 Mar 2023 21:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678225259;
        bh=/AJxUHLBNkIXMqqlDW3RXr9CiYtLgIGonmvd3qOFEvI=;
        h=From:To:Cc:Subject:Date:From;
        b=QZMN8Yj+yCOMk33J+lBwsYw6nmd0dy416jCkWsOsdaHGSmGr72EZ4Mg2yQ6N5vVMd
         ScO2mKZpgip3EdbqazAL8G2FX2KbLVpbsN7XaZwomaiF7+kxvAuVL7FnNu8sYsDut0
         zdPKVG12O+831cXhCdqNFZ0miEkc+0bPVDyu17uRCeNB7WMgzmAoYNxQMcpQuiMrv6
         39WbAjit7hf5ia1+9OPJGbtelnreyOxj6N7v4wZw7g+FMIG/lZw1c5q2xTYCzzBz9p
         pNdfMV9x2OsO2Rk8nMxW+EI1R8nSLtQzmivetrGZ6XsU6sWr10R2I8GGZHpvWvNhg0
         HAcN9JgLd1Hig==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] ALSA: hda: Match only Intel devices with CONTROLLER_IN_GPU()
Date:   Tue,  7 Mar 2023 15:40:54 -0600
Message-Id: <20230307214054.886721-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

CONTROLLER_IN_GPU() is clearly intended to match only Intel devices, but
previously it checked only the PCI Device ID, not the Vendor ID, so it
could match devices from other vendors that happened to use the same Device
ID.

Update CONTROLLER_IN_GPU() so it matches only Intel devices.

Fixes: 535115b5ff51 ("ALSA: hda - Abort the probe without i915 binding for HSW/B")
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 sound/pci/hda/hda_intel.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 81c4a45254ff..77a592f21947 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -328,14 +328,15 @@ enum {
 #define needs_eld_notify_link(chip)	false
 #endif
 
-#define CONTROLLER_IN_GPU(pci) (((pci)->device == 0x0a0c) || \
+#define CONTROLLER_IN_GPU(pci) (((pci)->vendor == 0x8086) &&         \
+				       (((pci)->device == 0x0a0c) || \
 					((pci)->device == 0x0c0c) || \
 					((pci)->device == 0x0d0c) || \
 					((pci)->device == 0x160c) || \
 					((pci)->device == 0x490d) || \
 					((pci)->device == 0x4f90) || \
 					((pci)->device == 0x4f91) || \
-					((pci)->device == 0x4f92))
+					((pci)->device == 0x4f92)))
 
 #define IS_BXT(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0x5a98)
 
-- 
2.25.1

