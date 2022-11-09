Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B7C622D32
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 15:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbiKIOJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 09:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiKIOJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 09:09:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F72193CC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 06:07:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5DD861ACE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 14:07:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26469C433C1;
        Wed,  9 Nov 2022 14:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668002838;
        bh=PiRBtyWRcT7jjZfnnN3cmaPdUmNnlm0O8XruGa9dW+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ipoECc4lNAV5X3+DuWolYU36Vd2SJ+TE5j1rpuC7BKvPKnkxh1jFkhtVGhulQoAIN
         ztjXpj0XofonDhjIr+cNDnhoRkW2lpAXjmjTZX9ZlsXtmhDLhK1f+wUoPqMGlj4EZ5
         T6AwnQTvt18BTOxmkH+Zs2e8IN7PjQjgQW/guSJ4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 2/2] driver core: remove devm_device_remove_group()
Date:   Wed,  9 Nov 2022 15:07:11 +0100
Message-Id: <20221109140711.105222-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221109140711.105222-1-gregkh@linuxfoundation.org>
References: <20221109140711.105222-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2403; i=gregkh@linuxfoundation.org; h=from:subject; bh=PiRBtyWRcT7jjZfnnN3cmaPdUmNnlm0O8XruGa9dW+o=; b=owGbwMvMwCRo6H6F97bub03G02pJDMnZW/iFF55SWCzsvrFo5kQNdemZQS8WJKUIbT4gmXcutzlk mdnFjlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZjImt8MC7rKN/nlyPwUvup1oDqW5+ 9/kyKNRwwLjhxWv+OeovZPhK/Fauuq26f0Tyh0AAA=
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

There is no in-kernel user of this function, so it is not needed anymore
and can be removed.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/core.c    | 22 ----------------------
 include/linux/device.h |  2 --
 2 files changed, 24 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 6137de5073b1..a7a18d44542c 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2585,11 +2585,6 @@ union device_attr_group_devres {
 	const struct attribute_group **groups;
 };
 
-static int devm_attr_group_match(struct device *dev, void *res, void *data)
-{
-	return ((union device_attr_group_devres *)res)->group == data;
-}
-
 static void devm_attr_group_remove(struct device *dev, void *res)
 {
 	union device_attr_group_devres *devres = res;
@@ -2640,23 +2635,6 @@ int devm_device_add_group(struct device *dev, const struct attribute_group *grp)
 }
 EXPORT_SYMBOL_GPL(devm_device_add_group);
 
-/**
- * devm_device_remove_group: remove a managed group from a device
- * @dev:	device to remove the group from
- * @grp:	group to remove
- *
- * This function removes a group of attributes from a device. The attributes
- * previously have to have been created for this group, otherwise it will fail.
- */
-void devm_device_remove_group(struct device *dev,
-			      const struct attribute_group *grp)
-{
-	WARN_ON(devres_release(dev, devm_attr_group_remove,
-			       devm_attr_group_match,
-			       /* cast away const */ (void *)grp));
-}
-EXPORT_SYMBOL_GPL(devm_device_remove_group);
-
 /**
  * devm_device_add_groups - create a bunch of managed attribute groups
  * @dev:	The device to create the group for
diff --git a/include/linux/device.h b/include/linux/device.h
index 4efc607c008c..84ae52de6746 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1064,8 +1064,6 @@ int __must_check devm_device_add_groups(struct device *dev,
 					const struct attribute_group **groups);
 int __must_check devm_device_add_group(struct device *dev,
 				       const struct attribute_group *grp);
-void devm_device_remove_group(struct device *dev,
-			      const struct attribute_group *grp);
 
 /*
  * Platform "fixup" functions - allow the platform to have their say
-- 
2.38.1

