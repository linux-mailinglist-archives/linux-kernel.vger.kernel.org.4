Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D24C708B34
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 00:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjERWDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 18:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjERWDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 18:03:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFAE6E7;
        Thu, 18 May 2023 15:03:14 -0700 (PDT)
Date:   Thu, 18 May 2023 22:03:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684447392;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=CYAhi29Fuj5PqmurKfBSVbz5QmuhmN4r93D7MCVjtys=;
        b=NhpF13hxcQoVDPQpP8U6/7XldFinAbXregGUiM4iPy3JLQsjLaUhA0YsxYnghWjumOtBUj
        9KKdRul4UKTV2GzfqR6rtzpRQ3bN+EkMLJI+JORybpxZJy9cwy8EbBeXm2Kuh5Uo+yWT5h
        gOoK1hvAk3RUnJ2+ModwprXadK4/2DG21nktm7xjybIomky4fs7lCHCCGZJz7h0NtUxfxo
        6szF1/ER4kUqgq0l5cBAdo0I3SpwdnyABa275a2exUWBEIGaL0Jv0/ayYXfs6eJU13TEKL
        HYxXwrBBW2D8Md+Hd1f2Sg2TaY7Hp1YHhZBcolYirIwQVLYIcL25kyY9WLpt3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684447392;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=CYAhi29Fuj5PqmurKfBSVbz5QmuhmN4r93D7MCVjtys=;
        b=qkkaO31VPvA/XzaeGnkyR7LfPSoZevWZT5BVDuxYe67dKJkVCSQXmiExKoeIIz8zH/JO+i
        KaapD9qTDR2U9qBw==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/usercopy: Include arch_wb_cache_pmem() declaration
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168444739233.404.10638167784822197520.tip-bot2@tip-bot2>
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

Commit-ID:     3b939ba0c21115de99d8e2966eaa2c4e74733d00
Gitweb:        https://git.kernel.org/tip/3b939ba0c21115de99d8e2966eaa2c4e74733d00
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Tue, 16 May 2023 21:35:46 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 18 May 2023 11:56:18 -07:00

x86/usercopy: Include arch_wb_cache_pmem() declaration

arch_wb_cache_pmem() is declared in a global header but defined by
the architecture. On x86, the implementation needs to include the header
to avoid this warning:

arch/x86/lib/usercopy_64.c:39:6: error: no previous prototype for 'arch_wb_cache_pmem' [-Werror=missing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Link: https://lore.kernel.org/all/20230516193549.544673-18-arnd%40kernel.org
---
 arch/x86/lib/usercopy_64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/lib/usercopy_64.c b/arch/x86/lib/usercopy_64.c
index 003d901..e9251b8 100644
--- a/arch/x86/lib/usercopy_64.c
+++ b/arch/x86/lib/usercopy_64.c
@@ -9,6 +9,7 @@
 #include <linux/export.h>
 #include <linux/uaccess.h>
 #include <linux/highmem.h>
+#include <linux/libnvdimm.h>
 
 /*
  * Zero Userspace
