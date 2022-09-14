Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40A65B8A41
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiINOXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiINOXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:23:10 -0400
Received: from mail.sf-mail.de (mail.sf-mail.de [IPv6:2a01:4f8:1c17:6fae:616d:6c69:616d:6c69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486F9481C1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 07:23:05 -0700 (PDT)
Received: (qmail 29917 invoked from network); 14 Sep 2022 14:23:22 -0000
Received: from p200300cf07104d0076d435fffeb7be92.dip0.t-ipconnect.de ([2003:cf:710:4d00:76d4:35ff:feb7:be92]:42614 HELO eto.sf-tec.de) (auth=eike@sf-mail.de)
        by mail.sf-mail.de (Qsmtpd 0.38dev) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPSA
        for <linux-parisc@vger.kernel.org>; Wed, 14 Sep 2022 16:23:22 +0200
From:   Rolf Eike Beer <eike-kernel@sf-tec.de>
To:     linux-parisc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] parisc: remove obsolete manual allocation aligning
Date:   Wed, 14 Sep 2022 16:23:02 +0200
Message-ID: <2442384.MTfJ8ztCV8@eto.sf-tec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmalloc() returns memory with __assume_kmalloc_alignment, which is
__alignof__(unsigned long long) for parisc.

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>
---
 drivers/parisc/iosapic.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

I must confirm it's entirely untested.

diff --git a/drivers/parisc/iosapic.c b/drivers/parisc/iosapic.c
index 3a8c98615634..bdef7a8d6ab8 100644
--- a/drivers/parisc/iosapic.c
+++ b/drivers/parisc/iosapic.c
@@ -221,16 +221,7 @@ static size_t irt_num_entry;
 
 static struct irt_entry *iosapic_alloc_irt(int num_entries)
 {
-	unsigned long a;
-
-	/* The IRT needs to be 8-byte aligned for the PDC call. 
-	 * Normally kmalloc would guarantee larger alignment, but
-	 * if CONFIG_DEBUG_SLAB is enabled, then we can get only
-	 * 4-byte alignment on 32-bit kernels
-	 */
-	a = (unsigned long)kmalloc(sizeof(struct irt_entry) * num_entries + 8, GFP_KERNEL);
-	a = (a + 7UL) & ~7UL;
-	return (struct irt_entry *)a;
+	return kcalloc(num_entries, sizeof(struct irt_entry), GFP_KERNEL);
 }
 
 /**
-- 
2.35.3




