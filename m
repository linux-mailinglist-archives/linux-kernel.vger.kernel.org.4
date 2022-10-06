Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A917A5F7190
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 01:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbiJFXPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 19:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJFXPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 19:15:03 -0400
X-Greylist: delayed 351 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 06 Oct 2022 16:15:02 PDT
Received: from mailout-pe-b.jellyfish.systems (mailout-pe-b.jellyfish.systems [198.54.127.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374392A424
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 16:15:00 -0700 (PDT)
Received: from output-router-58994b6955-749vc (unknown [10.35.5.64])
        by mailout-pe-b.jellyfish.systems (Postfix) with ESMTPA id 4Mk6ZS6FQHzDqGn;
        Thu,  6 Oct 2022 23:09:04 +0000 (UTC)
Received: from MTA-07.privateemail.com (unknown [10.50.14.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by NEW-01.privateemail.com (Postfix) with ESMTPS id 9F35818000D0;
        Thu,  6 Oct 2022 19:09:04 -0400 (EDT)
Received: from mta-07.privateemail.com (localhost [127.0.0.1])
        by mta-07.privateemail.com (Postfix) with ESMTP id 7DCF318000A3;
        Thu,  6 Oct 2022 19:09:04 -0400 (EDT)
Received: from bpappas-XPS-13-9310.lan (050-088-217-251.res.spectrum.com [50.88.217.251])
        by mta-07.privateemail.com (Postfix) with ESMTPA id E17AE18000A1;
        Thu,  6 Oct 2022 19:08:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pappasbrent.com;
        s=default; t=1665097744;
        bh=IVLwuGDOCuSv54DN8iklpx3g2m+wYF3VGkjLroLokTw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JNAYHy+6e/+WRzMyobhTT6r2577sR1DeG9piUvsQ09UQn23v0bgZKNsVEYHQq4elP
         nMtXJGXR+7zdGJ2zzVnnyqSRjD/jKEALhUQ9yI4Tra4jjqVGVWc0ylgbDi+DtZ+7cC
         ypKt2jnDPmdukmgoaOUMqHTrSKIAmjcl+YNYx03m29tntTQOdSKkNdXkma+tgBsGrE
         sn0g67wKp8mlFdlIMi8dBkcZtHK1ctBAga0iQ2tiF4rKKKquA4avLyfOh/OZRZglDP
         6tg/B7ui34MM/P8TfoLc7SRFFcNkfWypopacDLv0DJbE7KcMZxxemS8Luy6mL3m7dJ
         lzRhaWEdBXmTw==
From:   Brent Pappas <bpappas@pappasbrent.com>
To:     namcaov@gmail.com
Cc:     cai.huoqing@linux.dev, gregkh@linuxfoundation.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        pappasbrent@knights.ucf.edu, Brent Pappas <bpappas@pappasbrent.com>
Subject: [PATCH v3] Replace macros HB and LB with static inline functions
Date:   Thu,  6 Oct 2022 19:07:57 -0400
Message-Id: <20221006230757.33369-1-bpappas@pappasbrent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221006174436.GA8933@nam-dell>
References: <20221006174436.GA8933@nam-dell>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace function-like macros "HB" and "LB" with static inline functions
to comply with preferred Linux coding style standards.

Signed-off-by: Brent Pappas <bpappas@pappasbrent.com>
---
Changelog:
V1 -> V2: Resent diff from a mail client that would not replace tabs
          with spaces so that patch can be successfully applied.
V2 -> V3: Created patch using git format-patch.
		  Tested downloading and applying patch.
          Sent patch using git send-email.

 drivers/staging/most/net/net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/most/net/net.c b/drivers/staging/most/net/net.c
index 1d1fe8bff7ee..8a8fbc274b73 100644
--- a/drivers/staging/most/net/net.c
+++ b/drivers/staging/most/net/net.c
@@ -36,8 +36,8 @@
 #define PMS_TELID_MASK		0x0F
 #define PMS_TELID_SHIFT		4
 
-#define HB(value)		((u8)((u16)(value) >> 8))
-#define LB(value)		((u8)(value))
+static inline u8 HB(unsigned int value)		{ return ((u8)((u16)(value) >> 8)); }
+static inline u8 LB(unsigned int value)		{ return ((u8)(value)); }
 
 #define EXTRACT_BIT_SET(bitset_name, value) \
 	(((value) >> bitset_name##_SHIFT) & bitset_name##_MASK)
-- 
2.34.1

