Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F5C6B8038
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjCMSTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjCMSTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:19:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CFE4DBFD
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 11:19:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3400E6144F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 18:19:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45544C4339B;
        Mon, 13 Mar 2023 18:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678731540;
        bh=Ao8E7I6q4IqhdrrchnK3hfPSFJkT9ZPSxEvWAhBtTUY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mbv0P7nwVw7bKDKzaPcuGuQV4E5mgJq77e469LDVKQELNfp48353TI+KPMdGJdfeK
         YLhcZIBXdwGkTNcEYc5ON8Gk7AgXBR448Z/nyTcmWU6VHNATvZ6s95y81ANyko3lY1
         xmDo0JGBCdMFbQd1umUUjNp81+3svDSjW067g5is=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 11/12] driver core: device: mark struct class in struct device as constant
Date:   Mon, 13 Mar 2023 19:18:42 +0100
Message-Id: <20230313181843.1207845-11-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313181843.1207845-1-gregkh@linuxfoundation.org>
References: <20230313181843.1207845-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2552; i=gregkh@linuxfoundation.org; h=from:subject; bh=Ao8E7I6q4IqhdrrchnK3hfPSFJkT9ZPSxEvWAhBtTUY=; b=owGbwMvMwCRo6H6F97bub03G02pJDCn8mcy3r21bfEqx5LLMlZ93XQ+ds7l1Pt3ma4nMNt9Fx kyL1u7f2BHLwiDIxCArpsjyZRvP0f0VhxS9DG1Pw8xhZQIZwsDFKQATmajCMFf2/+2gZotdk9f9 P67Ht1N8ms1X03MM83SXNrMclr/IGtjhw/x8rrhXkEVcDgA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pointer to a struct class in a struct device should never be used to
change anything in that class.  So mark it as constant to enforce this
requirement.

This requires a few minor changes to some internal driver core functions
to enforce the const * being used here now.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/core.c    | 10 +++++-----
 include/linux/device.h |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index f3b7040ef9b6..0970db630839 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2820,7 +2820,7 @@ EXPORT_SYMBOL_GPL(devm_device_add_groups);
 
 static int device_add_attrs(struct device *dev)
 {
-	struct class *class = dev->class;
+	const struct class *class = dev->class;
 	const struct device_type *type = dev->type;
 	int error;
 
@@ -2887,7 +2887,7 @@ static int device_add_attrs(struct device *dev)
 
 static void device_remove_attrs(struct device *dev)
 {
-	struct class *class = dev->class;
+	const struct class *class = dev->class;
 	const struct device_type *type = dev->type;
 
 	if (dev->physical_location) {
@@ -3120,7 +3120,7 @@ struct kobject *virtual_device_parent(struct device *dev)
 
 struct class_dir {
 	struct kobject kobj;
-	struct class *class;
+	const struct class *class;
 };
 
 #define to_class_dir(obj) container_of(obj, struct class_dir, kobj)
@@ -3145,7 +3145,7 @@ static const struct kobj_type class_dir_ktype = {
 };
 
 static struct kobject *
-class_dir_create_and_add(struct class *class, struct kobject *parent_kobj)
+class_dir_create_and_add(const struct class *class, struct kobject *parent_kobj)
 {
 	struct class_dir *dir;
 	int retval;
@@ -4580,7 +4580,7 @@ static int device_attrs_change_owner(struct device *dev, kuid_t kuid,
 				     kgid_t kgid)
 {
 	struct kobject *kobj = &dev->kobj;
-	struct class *class = dev->class;
+	const struct class *class = dev->class;
 	const struct device_type *type = dev->type;
 	int error;
 
diff --git a/include/linux/device.h b/include/linux/device.h
index c0c02a00fe87..f97a793c6683 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -629,7 +629,7 @@ struct device {
 	spinlock_t		devres_lock;
 	struct list_head	devres_head;
 
-	struct class		*class;
+	const struct class	*class;
 	const struct attribute_group **groups;	/* optional groups */
 
 	void	(*release)(struct device *dev);
-- 
2.39.2

