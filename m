Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D75B66579F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238708AbjAKJgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbjAKJey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:34:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F61F120A8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:33:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0C6C61B19
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 09:33:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00A8C433D2;
        Wed, 11 Jan 2023 09:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673429613;
        bh=FR67UhswNG3QQsrxEFVbf2J5y7PVFWFRXJRJAYU9reQ=;
        h=From:To:Cc:Subject:Date:From;
        b=niWlvKyj14Pj2jqAOqXHpp3bZGkaHA/Sg9i79uII+wTB8zowpDLSK/beOv/t9drIA
         55Fv1VJJAydjtU0Ixuh0kyyU5XUDCEvkEkKtdpHlfbIYWiV8PQkGSkQNqcwDAYYG2u
         2Tix88jqzliQgV7FyznNfh4uCp6r192zcP6tHIzk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] driver core: change to_subsys_private() to use container_of_const()
Date:   Wed, 11 Jan 2023 10:33:27 +0100
Message-Id: <20230111093327.3955063-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1496; i=gregkh@linuxfoundation.org; h=from:subject; bh=FR67UhswNG3QQsrxEFVbf2J5y7PVFWFRXJRJAYU9reQ=; b=owGbwMvMwCRo6H6F97bub03G02pJDMn7mtITO9jXPFphO/3M75uz826tPDx58tW0oMRw/uZ49nfP DD+mdMSyMAgyMciKKbJ82cZzdH/FIUUvQ9vTMHNYmUCGMHBxCsBETKMY5vu2rvfQ/HUu6crJY2nsvF PFN244r8YwP+T8HZGMj9q7Z6+56Gx+/OFtN6nkKAA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro to_subsys_private() needs to switch to using
container_of_const() as it turned out to being incorrectly casting a
const pointer to a non-const one.  Make this change and fix up the one
offending user to be correctly handling a const pointer properly.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/base.h  | 2 +-
 drivers/base/class.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 2e08258ce82e..3d1da1027206 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -53,7 +53,7 @@ struct subsys_private {
 	struct kset glue_dirs;
 	struct class *class;
 };
-#define to_subsys_private(obj) container_of(obj, struct subsys_private, subsys.kobj)
+#define to_subsys_private(obj) container_of_const(obj, struct subsys_private, subsys.kobj)
 
 struct driver_private {
 	struct kobject kobj;
diff --git a/drivers/base/class.c b/drivers/base/class.c
index 86ec554cfe60..3366da9c3ff6 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -64,7 +64,7 @@ static void class_release(struct kobject *kobj)
 
 static const struct kobj_ns_type_operations *class_child_ns_type(const struct kobject *kobj)
 {
-	struct subsys_private *cp = to_subsys_private(kobj);
+	const struct subsys_private *cp = to_subsys_private(kobj);
 	struct class *class = cp->class;
 
 	return class->ns_type;
-- 
2.39.0

