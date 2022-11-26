Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCCF6393F7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 06:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbiKZFKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 00:10:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiKZFKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 00:10:30 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD68931239
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 21:10:29 -0800 (PST)
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1669439428;
        bh=EVRYLbXJT4r/tavtjYFvtvsmMIF+T3VXJ7DLMO3Mjvk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=paSSMypWqVVc32GQycN1h492cMml4NmI5izRh13kXBEGH0rcARgKWWqbWxS9t/GFi
         Y3JPOXI3Y2gJSAOicOpaqKoffFmR/u0ztBX4hdNwOJ13/bSxFNcTY45IxjTk5CK10L
         hFlS2jno+wK3Zvsm4cwRbo9gpl18+MQwYKAIJ6Bc=
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linuxppc-dev@lists.ozlabs.org
Cc:     =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 3/3] init/version.c: remove #include <generated/utsversion.h>
Date:   Sat, 26 Nov 2022 06:10:01 +0100
Message-Id: <20221126051002.123199-3-linux@weissschuh.net>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221126051002.123199-1-linux@weissschuh.net>
References: <20221126051002.123199-1-linux@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1669439380; l=867; i=linux@weissschuh.net; s=20211113; h=from:subject; bh=EVRYLbXJT4r/tavtjYFvtvsmMIF+T3VXJ7DLMO3Mjvk=; b=F1HxhTKHtpXu/BykxEW66XOAnX88KtYknMzBSigNB14Ozcd2B3B2rppXzAUGtYP2vqAnS1LWKQit 0PUndB9uBZRUnE2ncW+8Kkw6N2OVHHp2fLHhO7W+ChZnDKTkwUJI
X-Developer-Key: i=linux@weissschuh.net; a=ed25519; pk=9LP6KM4vD/8CwHW7nouRBhWLyQLcK1MkP6aTZbzUlj4=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2df8220cc511 ("kbuild: build init/built-in.a just once") moved
the usage of the define UTS_VERSION to the file version-timestamp.c.

version-timestamp.c in turn is included from version.c but already
includes utsversion.h itself properly.

The unneeded include of utsversion.h from version.c can be dropped.

Fixes: 2df8220cc511 ("kbuild: build init/built-in.a just once")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 init/version.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/init/version.c b/init/version.c
index 01d4ab05f0ba..f117921811b4 100644
--- a/init/version.c
+++ b/init/version.c
@@ -15,7 +15,6 @@
 #include <linux/printk.h>
 #include <linux/uts.h>
 #include <linux/utsname.h>
-#include <generated/utsrelease.h>
 #include <linux/proc_ns.h>
 
 static int __init early_hostname(char *arg)
-- 
2.38.1

