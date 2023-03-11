Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267416B57FC
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 04:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjCKDPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 22:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjCKDO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 22:14:59 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EEF133A4C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 19:14:57 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1678504495;
        bh=sOiskQrdfCnIJT4uxkWaPY9RlNau8EXPiu1P/We8tr0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=r/d9r6prZI3rN88Jp8LpvVV4Mclk1h/7E1U1QKzH2As+OnhYe1m3BJ3lpvCqdoDRR
         73Yyu6R8b0J3Vpa3t6yAjxvuHDG7lGPTT+KqdxAV8ZMFB1WhF6f9jVPMe/4aN48OqQ
         oXGNywQObYH9ARQEdw7bFa/nYQjggFazBV3pqFBo=
Date:   Sat, 11 Mar 2023 03:14:49 +0000
Subject: [PATCH 4/4] kobject: upgrade log of missing release func to warn
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230311-kobject-warning-v1-4-1ebba4f71fb5@weissschuh.net>
References: <20230311-kobject-warning-v1-0-1ebba4f71fb5@weissschuh.net>
In-Reply-To: <20230311-kobject-warning-v1-0-1ebba4f71fb5@weissschuh.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678504493; l=1778;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=sOiskQrdfCnIJT4uxkWaPY9RlNau8EXPiu1P/We8tr0=;
 b=1ar91zJaVsxFyRXTGIyF83f5ARIzmhFC06gDZVTbz4t54KvrLwhjwOawF3WfOLvvQEPg1PIEi
 02YIqkm5pAjC3TH5+EyWKZjVzcYuLfMLDj8RjMEHNFi76kqhIebznaV
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation is outspoken in its requirement for a release()
function. Documentation/core-api/kobject.rst:

  One important point cannot be overstated: every kobject must have a
  release() method, and the kobject must persist (in a consistent state)
  until that method is called. If these constraints are not met, the code is
  flawed. Note that the kernel will warn you if you forget to provide a
  release() method.  Do not try to get rid of this warning by providing an
  "empty" release function.

So adapt the logging to actually provide the promised warning.

At the moment there are still kobjects that do not have a release()
function, notably integrity_ktype and acpi_hotplug_profile_ktype.
Therefore leave it at pr_warn().

When the remaining cases are fixed the message could be upgraded to
pr_err() and/or an -EINVAL could be returned.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 lib/kobject.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/kobject.c b/lib/kobject.c
index 68ff8a48b784..8723f477095e 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -215,9 +215,11 @@ static int kobject_add_internal(struct kobject *kobj)
 		return -EINVAL;
 	}
 
-	if (kobj->ktype && !kobj->ktype->release)
-		pr_debug("'%s' (%p): does not have a release() function, it is broken and must be fixed. See Documentation/core-api/kobject.rst.\n",
-			 kobject_name(kobj), kobj);
+	if (kobj->ktype && !kobj->ktype->release) {
+		pr_warn("'%s' (%p): does not have a release() function, it is broken and must be fixed. See Documentation/core-api/kobject.rst.\n",
+			kobject_name(kobj), kobj);
+		dump_stack_lvl(KERN_WARNING);
+	}
 
 	parent = kobject_get(kobj->parent);
 

-- 
2.39.2

