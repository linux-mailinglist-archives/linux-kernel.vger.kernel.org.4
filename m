Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0377069D0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 15:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbjEQN1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 09:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjEQN1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 09:27:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76E910E
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 06:27:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42D4F646F2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 13:27:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6634CC433D2;
        Wed, 17 May 2023 13:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684330050;
        bh=1/afHD7U/S45cs/oYFrBR7Ii02gyuBPABL/vb45N5Nc=;
        h=From:To:Cc:Subject:Date:From;
        b=YeD9h5PsYXEONk3b7UItwnBK0xRVjnRrxIrltPyI7vtnsKrmmgv7xv0BwrATVGzYI
         /nIIFirpVk5u47Pdc/ZDo9ckTlADlFeSdr/TT1gvD38iieRuoeTG6FjlzmZGY/h/NB
         7jYsk3FkKVT8F99OQZlKCA43N/JobGn6qz2A26iWEu3lI1cbe6yQcri8lWPjc4Zu+n
         CyZqZkEbZc+EDwavO91mBvBkiOjayAQ4FhdAmt0G/gbHLDLt2maAsdUlZ20lLdydV1
         9cXnBg5+Yinu9DI1VqfdsA0PeCQmT7ki8eOg50zgNfwfQzNQ9haKrPt6SXRxIzL6Jo
         Ng4tcWAyCuAdg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] jffs2: mark __jffs2_dbg_superblock_counts() static
Date:   Wed, 17 May 2023 15:27:14 +0200
Message-Id: <20230517132725.938292-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

This function is only called locally and does not need to be
global. Since there is no external prototype, gcc warns about
the non-static definition:

fs/jffs2/debug.c:160:6: error: no previous prototype for '__jffs2_dbg_superblock_counts' [-Werror=missing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/jffs2/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jffs2/debug.c b/fs/jffs2/debug.c
index 9d26b1b9fc01..0925caab23c4 100644
--- a/fs/jffs2/debug.c
+++ b/fs/jffs2/debug.c
@@ -157,7 +157,7 @@ __jffs2_dbg_prewrite_paranoia_check(struct jffs2_sb_info *c,
 	kfree(buf);
 }
 
-void __jffs2_dbg_superblock_counts(struct jffs2_sb_info *c)
+static void __jffs2_dbg_superblock_counts(struct jffs2_sb_info *c)
 {
 	struct jffs2_eraseblock *jeb;
 	uint32_t free = 0, dirty = 0, used = 0, wasted = 0,
-- 
2.39.2

