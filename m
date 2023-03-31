Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5628F6D1C81
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbjCaJei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbjCaJeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:34:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B55F1EFE1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:33:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBCFC6264F
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 09:33:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE935C433EF;
        Fri, 31 Mar 2023 09:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680255218;
        bh=wv/9juY+EqUubKOluUfFYi8Ig7tVyvAhOaUNWFGQD1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OCvvcjW8xtKXhuAVeyIdBSC/oH1IIjwsHCZyMPSXcfgFg0F28z1BWM4jNyIfvaGsg
         4VeHBn0l6er0sO3/9OlrF9gKgkG3h4pV3r+8H0/vvpXhDrxWR4v0zqvzv4Lo4LHmtp
         f/AvCSZwB6XDyUDqBuPoi0V5ikwKjJuoX5eNvKpw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 5/7] driver core: class: remove dev_kobj from struct class
Date:   Fri, 31 Mar 2023 11:33:16 +0200
Message-Id: <20230331093318.82288-5-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230331093318.82288-1-gregkh@linuxfoundation.org>
References: <20230331093318.82288-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2167; i=gregkh@linuxfoundation.org; h=from:subject; bh=wv/9juY+EqUubKOluUfFYi8Ig7tVyvAhOaUNWFGQD1c=; b=owGbwMvMwCRo6H6F97bub03G02pJDClqK+6K3rJhErvoJp35YF7pXk2pdWmLZ7l1cjDFOgXFc YedtTfuiGVhEGRikBVTZPmyjefo/opDil6Gtqdh5rAygQxh4OIUgIkUvWOYK3/68P0cxRkChkXl /6b99LCZPOOZFsM87UbBK2bTj9s5hzzo4np+zVCKyVwdAA==
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

The dev_kobj field in struct class is now only written to, but never
read from, so it can be removed as it is useless.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/genhd.c                | 1 -
 drivers/base/class.c         | 4 ----
 include/linux/device/class.h | 2 --
 3 files changed, 7 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index e1e1230b1b9f..af7208a37c53 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -899,7 +899,6 @@ static int __init genhd_device_init(void)
 {
 	int error;
 
-	block_class.dev_kobj = sysfs_dev_block_kobj;
 	error = class_register(&block_class);
 	if (unlikely(error))
 		return error;
diff --git a/drivers/base/class.c b/drivers/base/class.c
index fcfb295363cc..06b96d6faa19 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -197,10 +197,6 @@ int class_register(struct class *cls)
 		return error;
 	}
 
-	/* set the default /sys/dev directory for devices of this class */
-	if (!cls->dev_kobj)
-		cls->dev_kobj = sysfs_dev_char_kobj;
-
 	cp->subsys.kobj.kset = class_kset;
 	cp->subsys.kobj.ktype = &class_ktype;
 	cp->class = cls;
diff --git a/include/linux/device/class.h b/include/linux/device/class.h
index f7aad64e256a..e946642c314e 100644
--- a/include/linux/device/class.h
+++ b/include/linux/device/class.h
@@ -27,7 +27,6 @@ struct fwnode_handle;
  * @name:	Name of the class.
  * @class_groups: Default attributes of this class.
  * @dev_groups:	Default attributes of the devices that belong to the class.
- * @dev_kobj:	The kobject that represents this class and links it into the hierarchy.
  * @dev_uevent:	Called when a device is added, removed from this class, or a
  *		few other things that generate uevents to add the environment
  *		variables.
@@ -55,7 +54,6 @@ struct class {
 
 	const struct attribute_group	**class_groups;
 	const struct attribute_group	**dev_groups;
-	struct kobject			*dev_kobj;
 
 	int (*dev_uevent)(const struct device *dev, struct kobj_uevent_env *env);
 	char *(*devnode)(const struct device *dev, umode_t *mode);
-- 
2.40.0

