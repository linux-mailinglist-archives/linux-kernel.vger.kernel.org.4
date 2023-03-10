Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88376B5578
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 00:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbjCJXSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 18:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbjCJXRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 18:17:44 -0500
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C1AFF31
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 15:17:43 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id BD7E5604ED;
        Sat, 11 Mar 2023 00:17:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1678490261; bh=5I+WvBSzoM2mlJPk0nTQr8Oi3xePeOSo4Gorb+Mc1uY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JktBqM7mrXFW7qOe94eXOvome05S27eBUgDKRO89O+QeZgZD3aaL5l/mOtyiIoOSr
         NvyNTgoT/v67X3qgCvI0Wm9QFlKtyC2W9vs1qrjp6G60Cpd4WHVOt/r4NAcx3oeHGc
         F4NAnWC+UEP0kDmjCS/rMHnzW98ruQGBZQP3KLFIFwAWJ+nVRZvaay6sYuV3rqNvcp
         kUnOa3jLfRsG//Uu+eS3rKLQ4zabUg4jcd6Ksaw/CG2TdEJjzxvEf4v1bkifrs5low
         XYgCmnFqSG7AH7ZHCpPXykpSaTcMaCv2Z+OzWa70DiwKRAsDui0pV3KaOdPmrmWMup
         eUT1mFysgw9yg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4HtJHmUCYQqj; Sat, 11 Mar 2023 00:17:39 +0100 (CET)
Received: by domac.alu.hr (Postfix, from userid 1014)
        id 96161604EF; Sat, 11 Mar 2023 00:17:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1678490259; bh=5I+WvBSzoM2mlJPk0nTQr8Oi3xePeOSo4Gorb+Mc1uY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ajKfVE80Mc+oBKQN7UKhTFCrez7FjkNjFx/fm08z4P6I01WMSUfhlN4DnoUWsV2Fa
         0q5girtd+ubwIaXhCkCuFNmBWNJCrDwyk+s6DJkAtKsk+EYXuI95f5Qt7YCMWGhKIL
         VVWBiD2N+aeJKq6sZX2knItZ2aBZ3Vl3O62U9uhkyTM7OOTFiZ1DeZ8MieqIKnoDRz
         lnpdEr2gDYpzWCuSBNaL91gmgyUG5v7yyswT0MEo7fPt2IFBg+vCa5+EjBUTabTWSa
         uHFHkBlcATdkMgwTTZBtP7XtR16FUGbky6FXs4oNoAG2CUkKThzMK2Jls85goyp8wE
         6yKLCWAzb4l0g==
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     Paul Moore <paul@paul-moore.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        linux-kernel@vger.kernel.org
Cc:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Frederick Lawler <fred@cloudflare.com>
Subject: [PATCH v1 2/2] integrity: Add the release() hook to the integrity LSM module
Date:   Sat, 11 Mar 2023 00:11:10 +0100
Message-Id: <20230310231107.10954-2-mirsad.todorovac@alu.unizg.hr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230310231107.10954-1-mirsad.todorovac@alu.unizg.hr>
References: <20230310231107.10954-1-mirsad.todorovac@alu.unizg.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        PP_MIME_FAKE_ASCII_TEXT,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kmem_cache_create() callback in the init() hook of the integrity LSM
module doesn't have a corresponding kmem_cache_destroy() function call.

The allocated cache is destroyed on kernel shutdown in an undefined manner.

This patch should define a proper destructor to deallocate resource in a
well-behaved, defined order.

Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Thomas Weißschuh <linux@weissschuh.net>
Cc: Casey Schaufler <casey@schaufler-ca.com>
Cc: Christian Göttsche <cgzones@googlemail.com>
Cc: Mickaël Salaün <mic@digikod.net>
Cc: Frederick Lawler <fred@cloudflare.com>

---
 security/integrity/iint.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 8638976f7990..3f69eb702b2e 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -179,9 +179,16 @@ static int __init integrity_iintcache_init(void)
 			      0, SLAB_PANIC, init_once);
 	return 0;
 }
+
+static int __exit integrity_iintcache_release(void)
+{
+	kmem_cache_destroy(iint_cache);
+}
+
 DEFINE_LSM(integrity) = {
 	.name = "integrity",
 	.init = integrity_iintcache_init,
+	.release = integrity_iintcache_release,
 };
 
 
-- 
2.30.2

