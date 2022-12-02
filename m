Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1044640FD1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 22:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiLBVNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 16:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234097AbiLBVNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 16:13:43 -0500
Received: from smtp.smtpout.orange.fr (smtp-12.smtpout.orange.fr [80.12.242.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD34DB1E9
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 13:13:41 -0800 (PST)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id 1DLlpPcSnM75k1DLlp2pVY; Fri, 02 Dec 2022 22:13:39 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 02 Dec 2022 22:13:39 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Jason@zx2c4.com, kuba@kernel.org, tytso@mit.edu, elver@google.com,
        yury.norov@gmail.com, linux@dominikbrodowski.net,
        gregkh@linuxfoundation.org, pmladek@suse.com, keescook@chromium.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] random: Include <linux/once.h> in the right header
Date:   Fri,  2 Dec 2022 22:13:36 +0100
Message-Id: <212adb212cb0234a7d395daf31b2578b9409d492.1670015476.git.christophe.jaillet@wanadoo.fr>
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

<linux/prandom.h> uses DO_ONCE(). So it should include <linux/once.h>
directly.

On the contrary, <linux/random.h> doesn't use functionalities from
<linux/once.h>, so it should be removed.

All this is true since commit c0842fbc1b18 ("random32: move the
pseudo-random 32-bit definitions to prandom.h")

Move the #include <linux/once.h> in the right file.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Let see if build-bots agree with me!
---
 include/linux/prandom.h | 1 +
 include/linux/random.h  | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/prandom.h b/include/linux/prandom.h
index 1f4a0de7b019..c94c02ba065c 100644
--- a/include/linux/prandom.h
+++ b/include/linux/prandom.h
@@ -9,6 +9,7 @@
 #define _LINUX_PRANDOM_H
 
 #include <linux/types.h>
+#include <linux/once.h>
 #include <linux/percpu.h>
 #include <linux/random.h>
 
diff --git a/include/linux/random.h b/include/linux/random.h
index b1a34181eed6..4a2a1de423cd 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -6,7 +6,6 @@
 #include <linux/bug.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
-#include <linux/once.h>
 
 #include <uapi/linux/random.h>
 
-- 
2.34.1

