Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6FA62CF5C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 01:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbiKQANV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 19:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiKQANS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 19:13:18 -0500
Received: from mail.yuka.dev (mail.yuka.dev [IPv6:2a0f:4ac0:0:1::ec3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3300A3F06A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 16:13:15 -0800 (PST)
From:   Yureka Lilian <yuka@yuka.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yuka.dev; s=mail;
        t=1668643988; bh=5dNFdDc+2RQBqpffdw6jAU+GeuN6ZTrFWaqRxNYft14=;
        h=From:To:Cc:Subject:Date;
        b=t97Dkl9W4dd4Bh4pTwE/4nEKtDAciVisTI26WKUTT4+h1gEny1mX4pIgv4hr9zRiQ
         cziF5kRIqjl6VDUPHFnjkrVVPO9Aj+7ory9B4LSJA35EROPZWW0lgxbSi1U1YLUF5W
         +6X7gE5wC3rdP8KjKucOuBDIu6QRlerpBJhWpphA=
To:     samuel.thibault@ens-lyon.org
Cc:     gregkh@linuxfoundation.org, chris@the-brannons.com,
        linux-kernel@vger.kernel.org, speakup@linux-speakup.org,
        w.d.hubbs@gmail.com, Yureka Lilian <yuka@yuka.dev>
Subject: [PATCH v2] speakup: remove usage of non-standard u_char
Date:   Thu, 17 Nov 2022 01:12:44 +0100
Message-Id: <20221117001244.212047-1-yuka@yuka.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code is included in the build tools makemapdata and genmap, and it
expects that libc exposes a definition of u_char. But u_char is not
defined in either C or POSIX standards, and some systems don't have it.
Namely this breaks the build on hosts using musl libc, because musl only
exposes u_char if _GNU_SOURCE is defined.

Signed-off-by: Yureka Lilian <yuka@yuka.dev>
Cc: stable@vger.kernel.org
---
Content is unchanged compared to v1, but hopefully the patch is not
corrupted this time and I added a cc: stable
---
 drivers/accessibility/speakup/utils.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accessibility/speakup/utils.h b/drivers/accessibility/speakup/utils.h
index 4bf2ee8ac246..4ce9a12f7664 100644
--- a/drivers/accessibility/speakup/utils.h
+++ b/drivers/accessibility/speakup/utils.h
@@ -54,7 +54,7 @@ static inline int oops(const char *msg, const char *info)
 
 static inline struct st_key *hash_name(char *name)
 {
-	u_char *pn = (u_char *)name;
+	unsigned char *pn = (unsigned char *)name;
 	int hash = 0;
 
 	while (*pn) {
-- 
2.38.1

