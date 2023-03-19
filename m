Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48AF6C05A4
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 22:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjCSVfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 17:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjCSVfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 17:35:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2F11164B;
        Sun, 19 Mar 2023 14:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=o7Go1puxe90FGMktwOjmsLknRJd3vVFjG7iQj4FUx+M=; b=XqMEHnA1Jxvrrb245/gV9tQJgM
        CKTzB8jqsj/Mrc4jQJulJjjvW6eSvvhDRJQbLLthWWGxdgzs8e4f8/HMftBfDxSu3htw9yjyqzbdn
        MR52AsAZ+FOCvqmkf3us3iGzPp8CH+PEQK+DCAV8CtKbtMXpwUtFC3Q5RqOOhcf6fmJpRuP60BIwR
        ibr7FJGZ1bxgKq3OkApLjLhfFPS9w9R58snlxbcBxwgpL2XLyrlavSNCIGS39tMMMP4bvuhMAGk2D
        fCdcpy95A7nX+nt+i6POnJs0gt71a61x82dcm/xEwhub3LSs3OSQbCghkvUjXi9XJIEmxXQC8b/jA
        MjmDTuVg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pe0gp-007Vmz-1r;
        Sun, 19 Mar 2023 21:35:43 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, david@redhat.com, petr.pavlu@suse.com,
        prarit@redhat.com
Cc:     christophe.leroy@csgroup.eu, song@kernel.org, mcgrof@kernel.org
Subject: [PATCH 5/5] module: fold usermode helper kmod into modules directory
Date:   Sun, 19 Mar 2023 14:35:42 -0700
Message-Id: <20230319213542.1790479-6-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230319213542.1790479-1-mcgrof@kernel.org>
References: <20230319213542.1790479-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel/kmod.c is already only built if we enabled modules, so
just stuff it under kernel/module/kmod.c and unify the MAINTAINERS
file for it.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 MAINTAINERS                | 13 +++----------
 kernel/Makefile            |  1 -
 kernel/module/Makefile     |  4 +++-
 kernel/{ => module}/kmod.c |  0
 4 files changed, 6 insertions(+), 12 deletions(-)
 rename kernel/{ => module}/kmod.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d5bc223f305..1ca0e26aa9f8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11522,16 +11522,6 @@ F:	include/linux/kmemleak.h
 F:	mm/kmemleak.c
 F:	samples/kmemleak/kmemleak-test.c
 
-KMOD KERNEL MODULE LOADER - USERMODE HELPER
-M:	Luis Chamberlain <mcgrof@kernel.org>
-L:	linux-kernel@vger.kernel.org
-L:	linux-modules@vger.kernel.org
-S:	Maintained
-F:	include/linux/kmod.h
-F:	kernel/kmod.c
-F:	lib/test_kmod.c
-F:	tools/testing/selftests/kmod/
-
 KMSAN
 M:	Alexander Potapenko <glider@google.com>
 R:	Marco Elver <elver@google.com>
@@ -14083,8 +14073,11 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git modules-next
 F:	include/linux/module.h
+F:	include/linux/kmod.h
 F:	kernel/module/
 F:	scripts/module*
+F:	lib/test_kmod.c
+F:	tools/testing/selftests/kmod/
 
 MONOLITHIC POWER SYSTEM PMIC DRIVER
 M:	Saravanan Sekar <sravanhome@gmail.com>
diff --git a/kernel/Makefile b/kernel/Makefile
index 10ef068f598d..3dd4ea433ee9 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -13,7 +13,6 @@ obj-y     = fork.o exec_domain.o panic.o \
 	    async.o range.o smpboot.o ucount.o regset.o
 
 obj-$(CONFIG_USERMODE_DRIVER) += usermode_driver.o
-obj-$(CONFIG_MODULES) += kmod.o
 obj-$(CONFIG_MULTIUSER) += groups.o
 
 ifdef CONFIG_FUNCTION_TRACER
diff --git a/kernel/module/Makefile b/kernel/module/Makefile
index 948efea81e85..5b1d26b53b8d 100644
--- a/kernel/module/Makefile
+++ b/kernel/module/Makefile
@@ -7,7 +7,9 @@
 # and produce insane amounts of uninteresting coverage.
 KCOV_INSTRUMENT_module.o := n
 
-obj-y += main.o strict_rwx.o
+obj-y += main.o
+obj-y += strict_rwx.o
+obj-y += kmod.o
 obj-$(CONFIG_MODULE_DECOMPRESS) += decompress.o
 obj-$(CONFIG_MODULE_SIG) += signing.o
 obj-$(CONFIG_LIVEPATCH) += livepatch.o
diff --git a/kernel/kmod.c b/kernel/module/kmod.c
similarity index 100%
rename from kernel/kmod.c
rename to kernel/module/kmod.c
-- 
2.39.1

