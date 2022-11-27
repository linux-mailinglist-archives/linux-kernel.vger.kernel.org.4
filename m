Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF2A639BA0
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 17:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiK0QHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 11:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiK0QHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 11:07:45 -0500
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6276396
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 08:07:41 -0800 (PST)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id zKBuo3TEYgfI9zKBuokZLw; Sun, 27 Nov 2022 17:07:39 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 27 Nov 2022 17:07:39 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] io-mapping: Move some code within the include guarded section
Date:   Sun, 27 Nov 2022 17:07:32 +0100
Message-Id: <4dbaf427d4300edba6c6bbfaf4d57493b9bec6ee.1669565241.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is spurious to have some code out-side the include guard in a .h file.
Fix it.

Fixes: 1fbaf8fc12a0 ("mm: add a io_mapping_map_user helper")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 include/linux/io-mapping.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/io-mapping.h b/include/linux/io-mapping.h
index 66a774d2710e..09d4f17c8d3b 100644
--- a/include/linux/io-mapping.h
+++ b/include/linux/io-mapping.h
@@ -213,7 +213,7 @@ io_mapping_free(struct io_mapping *iomap)
 	kfree(iomap);
 }
 
-#endif /* _LINUX_IO_MAPPING_H */
-
 int io_mapping_map_user(struct io_mapping *iomap, struct vm_area_struct *vma,
 		unsigned long addr, unsigned long pfn, unsigned long size);
+
+#endif /* _LINUX_IO_MAPPING_H */
-- 
2.34.1

