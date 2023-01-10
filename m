Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C09664D2E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 21:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbjAJUVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 15:21:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjAJUVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 15:21:32 -0500
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59CC795BB
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 12:21:29 -0800 (PST)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id FL7cpSMgVPNsNFL7dpVOK1; Tue, 10 Jan 2023 21:21:27 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 10 Jan 2023 21:21:27 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Vineet Gupta <vgupta@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <error27@gmail.com>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2] bit_spinlock: Include <linux/processor.h>
Date:   Tue, 10 Jan 2023 21:21:13 +0100
Message-Id: <efd8783178f9d15e6d57f10e2e5090a14d5bc923.1673381735.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In an attempt to simplify some includes in <include/dcache.h>, it
appeared, when compiling fs/ecryptfs/dentry.c, that <linux/bit_spinlock.h>
was relying on other includes to get the definition of cpu_relax().
(see [1])

It broke on ARC.

Include <linux/processor.h> in <linux/bit_spinlock.h> to fix the issue.
This will help to remove some un-needed includes from <include/dcache.h>.

[1]: https://lore.kernel.org/all/202301082130.LXMj5qkD-lkp@intel.com/

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Change in v2:
  - include <linux/processor.h> instead of <asm/processor.h>   (Andrew Morton)
  
v1:
https://lore.kernel.org/all/8b81101d59a31f4927016c17e49be96754a23380.1673204461.git.christophe.jaillet@wanadoo.fr/
---
 include/linux/bit_spinlock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bit_spinlock.h b/include/linux/bit_spinlock.h
index bbc4730a6505..4e3b407963f6 100644
--- a/include/linux/bit_spinlock.h
+++ b/include/linux/bit_spinlock.h
@@ -4,9 +4,9 @@
 
 #include <linux/kernel.h>
 #include <linux/preempt.h>
+#include <linux/processor.h>
 #include <linux/atomic.h>
 #include <linux/bug.h>
-
 /*
  *  bit-based spin_lock()
  *
-- 
2.34.1

