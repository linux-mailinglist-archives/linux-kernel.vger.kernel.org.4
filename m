Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621F36D1C80
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjCaJed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjCaJeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:34:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67F51EA23
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:33:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2476B82D7C
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 09:33:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A2EEC433D2;
        Fri, 31 Mar 2023 09:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680255212;
        bh=cG2nXhJrWKrDIwvw+gSEk9fxnRVDM8TBTZRetku5/tE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bRO3vsYsc5CcSBOAQcpEnD60o0CZkMqi9Rd+btz2vALjxImFFaafm8DFBdU1LLaKq
         96+Yd7JusWfOT+5J8R8Ef1UcStaZ9g8E6CmIqce8hlToVkiW7+rTuQVjvByZsnfN5O
         j4/yUtcX63dOLEod2oH91gnBsVtehFwTWlhf54I0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 3/7] driver core: class: remove subsystem private pointer from struct class
Date:   Fri, 31 Mar 2023 11:33:14 +0200
Message-Id: <20230331093318.82288-3-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230331093318.82288-1-gregkh@linuxfoundation.org>
References: <20230331093318.82288-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1634; i=gregkh@linuxfoundation.org; h=from:subject; bh=cG2nXhJrWKrDIwvw+gSEk9fxnRVDM8TBTZRetku5/tE=; b=owGbwMvMwCRo6H6F97bub03G02pJDClqK+5myDzteeM6I6R0XoU8c92GquySFl4eoZr5aaqHV nH/kUvviGVhEGRikBVTZPmyjefo/opDil6Gtqdh5rAygQxh4OIUgIlYBjIs6FudsDxL9fZ90R/u XY/MA1Uinrf1MczPMnG/FZaWdaWcN5f1UrPQZZ+tXbUA
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the last users of the subsystem private pointer in struct class
are gone, the pointer can be removed, as no one is using it.  One step
closer to allowing struct class to be const and moved into read-only
memory.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/class.c         | 4 ----
 include/linux/device/class.h | 2 --
 2 files changed, 6 deletions(-)

diff --git a/drivers/base/class.c b/drivers/base/class.c
index a8a1bf976290..fcfb295363cc 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -97,8 +97,6 @@ static void class_release(struct kobject *kobj)
 
 	pr_debug("class '%s': release.\n", class->name);
 
-	class->p = NULL;
-
 	if (class->class_release)
 		class->class_release(class);
 	else
@@ -206,7 +204,6 @@ int class_register(struct class *cls)
 	cp->subsys.kobj.kset = class_kset;
 	cp->subsys.kobj.ktype = &class_ktype;
 	cp->class = cls;
-	cls->p = cp;
 
 	error = kset_register(&cp->subsys);
 	if (error)
@@ -222,7 +219,6 @@ int class_register(struct class *cls)
 
 err_out:
 	kfree(cp);
-	cls->p = NULL;
 	return error;
 }
 EXPORT_SYMBOL_GPL(class_register);
diff --git a/include/linux/device/class.h b/include/linux/device/class.h
index 9cb5db0588c8..f7aad64e256a 100644
--- a/include/linux/device/class.h
+++ b/include/linux/device/class.h
@@ -71,8 +71,6 @@ struct class {
 	void (*get_ownership)(const struct device *dev, kuid_t *uid, kgid_t *gid);
 
 	const struct dev_pm_ops *pm;
-
-	struct subsys_private *p;
 };
 
 struct class_dev_iter {
-- 
2.40.0

