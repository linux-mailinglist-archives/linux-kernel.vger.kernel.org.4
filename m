Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968C5708B3C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 00:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjERWD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 18:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjERWDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 18:03:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52700E7;
        Thu, 18 May 2023 15:03:17 -0700 (PDT)
Date:   Thu, 18 May 2023 22:03:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684447393;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=9YXCgzPfesW8kVzbeuSgiq5SZvZkyR4MZFm52hZyS50=;
        b=H2IKOO5ivZ3oYApvJO9DDn8H1H7B42pbMMlKZ+WbEYA3GSCUW/5/U/PVsKIJ5Gix0AxWX7
        fI225vXqiJeFjy69jqEZQykAtVTpr7DrXXKUN/2EH83we4lDMhjbrL4+PVE3NbH9AfX2Ca
        wL/iRXKonDHwgpnqYU1IIBMMF/BH5iHkhlnbtjSvCdYIqxcCshLAsQKKa2iUp/aHoljMdj
        ZaVWSXq6IRJv7ik+1kAdCtHcGqr7wB1fKE9cIpUJ0qRNfPtRMO0JBvjqdv7zL1eWf42E4d
        KJ2xBEFrKe6v0USk+3NihM7BPHDDA9Q9IkjY+YZyHwbbzT5IleB8tIGTpoaNZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684447393;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=9YXCgzPfesW8kVzbeuSgiq5SZvZkyR4MZFm52hZyS50=;
        b=VwyqYk8AaOgsbSSe4aSvkos3m6Kdr5THYnPem6RPwjAM3WivQ85+QTMGEwDOBFrQgR5hCX
        ScXBKVcqdIB2iUCg==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/fbdev: Include asm/fb.h as needed
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168444739322.404.13800373768683363970.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     29bf464cb8ee1b119d23aec88cbf17f9941610ad
Gitweb:        https://git.kernel.org/tip/29bf464cb8ee1b119d23aec88cbf17f9941610ad
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Tue, 16 May 2023 21:35:43 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 18 May 2023 11:56:18 -07:00

x86/fbdev: Include asm/fb.h as needed

fb_is_primary_device() is defined as a global function on x86, unlike
the others that have an inline version. The file that defines is
however needs to include the declaration to avoid a warning:

arch/x86/video/fbdev.c:14:5: error: no previous prototype for 'fb_is_primary_device' [-Werror=missing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Link: https://lore.kernel.org/all/20230516193549.544673-15-arnd%40kernel.org
---
 arch/x86/video/fbdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/video/fbdev.c b/arch/x86/video/fbdev.c
index 9fd2484..9e91430 100644
--- a/arch/x86/video/fbdev.c
+++ b/arch/x86/video/fbdev.c
@@ -10,6 +10,7 @@
 #include <linux/pci.h>
 #include <linux/module.h>
 #include <linux/vgaarb.h>
+#include <asm/fb.h>
 
 int fb_is_primary_device(struct fb_info *info)
 {
