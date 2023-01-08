Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC5266186B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 20:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjAHTE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 14:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjAHTE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 14:04:56 -0500
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439B3E00B
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 11:04:54 -0800 (PST)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id EayQpvONwvuBYEayQps48G; Sun, 08 Jan 2023 20:04:52 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 08 Jan 2023 20:04:52 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vineet Gupta <vgupta@kernel.org>,
        Dan Carpenter <error27@gmail.com>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] bit_spinlock: Include <asm/processor.h>
Date:   Sun,  8 Jan 2023 20:04:44 +0100
Message-Id: <8b81101d59a31f4927016c17e49be96754a23380.1673204461.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
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

It broke on arc.

Include <asm/processor.h> in <linux/bit_spinlock.h> to fix the issue.
This will help remove some un-needed includes from <include/dcache.h>.

[1]: https://lore.kernel.org/all/202301082130.LXMj5qkD-lkp@intel.com/

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Not sure who to send this to.
get_maintainer.pl is of no help, and the file is untouched from a too long
time.

Greg? Dan? Any pointer?
---
 include/linux/bit_spinlock.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/bit_spinlock.h b/include/linux/bit_spinlock.h
index bbc4730a6505..d0fd2a7afca2 100644
--- a/include/linux/bit_spinlock.h
+++ b/include/linux/bit_spinlock.h
@@ -2,6 +2,7 @@
 #ifndef __LINUX_BIT_SPINLOCK_H
 #define __LINUX_BIT_SPINLOCK_H
 
+#include <asm/processor.h>
 #include <linux/kernel.h>
 #include <linux/preempt.h>
 #include <linux/atomic.h>
-- 
2.34.1

