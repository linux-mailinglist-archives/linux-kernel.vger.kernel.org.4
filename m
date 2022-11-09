Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08E6622D31
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 15:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiKIOJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 09:09:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbiKIOJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 09:09:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840CB1902D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 06:07:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F8896157D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 14:07:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF66EC433C1;
        Wed,  9 Nov 2022 14:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668002841;
        bh=N9WGpsrrLuQDnUvF/F19PJvYOzFYkc2INPp4w7vxZzs=;
        h=From:To:Cc:Subject:Date:From;
        b=c67RbILpRGAOYjzJOe3Yc/TRQImcufiAUoPOmrKN3Nqlks6NBqZxEiZH23Aa7DIwg
         jP8c+dGVThtRrYjUf2XDVUe1YuA0hiIoB2ZIw8ygbO9idppCeL2F4n/a5btvjtSAzX
         quOLZ4Nt6lFp3S9r4Mr/0IkMwf0HdU9vR5+6s6sE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 1/2] driver core: remove devm_device_remove_groups()
Date:   Wed,  9 Nov 2022 15:07:10 +0100
Message-Id: <20221109140711.105222-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1961; i=gregkh@linuxfoundation.org; h=from:subject; bh=N9WGpsrrLuQDnUvF/F19PJvYOzFYkc2INPp4w7vxZzs=; b=owGbwMvMwCRo6H6F97bub03G02pJDMnZW3hvHJVUCyx45y0ak7vVKZP3dH2zJCPz/sz6BJc0nZvO PIs6YlkYBJkYZMUUWb5s4zm6v+KQopeh7WmYOaxMIEMYuDgFYCKd2xjmx6XLbIiMXskXu7Mo/f+EY1 rtry/OZ1iw8UnPjpbNS54qzpndM+ulxQO5OGYLAA==
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
 drivers/base/core.c    | 17 -----------------
 include/linux/device.h |  2 --
 2 files changed, 19 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index d02501933467..6137de5073b1 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2693,23 +2693,6 @@ int devm_device_add_groups(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_device_add_groups);
 
-/**
- * devm_device_remove_groups - remove a list of managed groups
- *
- * @dev:	The device for the groups to be removed from
- * @groups:	NULL terminated list of groups to be removed
- *
- * If groups is not NULL, remove the specified groups from the device.
- */
-void devm_device_remove_groups(struct device *dev,
-			       const struct attribute_group **groups)
-{
-	WARN_ON(devres_release(dev, devm_attr_groups_remove,
-			       devm_attr_group_match,
-			       /* cast away const */ (void *)groups));
-}
-EXPORT_SYMBOL_GPL(devm_device_remove_groups);
-
 static int device_add_attrs(struct device *dev)
 {
 	struct class *class = dev->class;
diff --git a/include/linux/device.h b/include/linux/device.h
index 023ea50b1916..4efc607c008c 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1062,8 +1062,6 @@ static inline void device_remove_group(struct device *dev,
 
 int __must_check devm_device_add_groups(struct device *dev,
 					const struct attribute_group **groups);
-void devm_device_remove_groups(struct device *dev,
-			       const struct attribute_group **groups);
 int __must_check devm_device_add_group(struct device *dev,
 				       const struct attribute_group *grp);
 void devm_device_remove_group(struct device *dev,
-- 
2.38.1

