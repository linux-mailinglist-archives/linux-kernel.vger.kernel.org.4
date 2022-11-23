Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9EED635B9A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 12:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237363AbiKWLZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 06:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237379AbiKWLYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 06:24:32 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B4BF5A1E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 03:24:24 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id x5so24849221wrt.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 03:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b9alsbr8LXN9/Ce1A3UmngFG+xxycHeYjWz0tStEptI=;
        b=qG38gT7cDar0bBFc9LaB2ehRjEmcZdd1oUbSuzjEaJnu9bmcFlFi4TVeT72IpLjAgm
         Xl/WeD4q0pWopnb+W4XcYUaZyWMMr+J++nLdUA81gpZTAKRaU6lQKhrrV9EjkITWZSRB
         Q+Qgi7hpOtQB+45WIUsPwWIVmeF9sCKF8DzCfhbFIfSZUIyOEnI1nZPDkfrbGxg6Ndxj
         A0Dfb7n5LOHHU5A1b39rut+IwMtiY5tiPN1tUXoGVt7kfGdnzpLbf6T9g6Y0TSjE57eU
         i2n+k/j67mvEP8qt0e0kJlCuomKqv7KBozTisQgXgqj0qiFTYEfqVCOBVbQrdT3Zyvom
         X52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b9alsbr8LXN9/Ce1A3UmngFG+xxycHeYjWz0tStEptI=;
        b=RYDKTPMhg1W0d5gqa6STAm8hrTxERdjB0E+6xjqJmrbhhQwfb9nFnrMUwpbIlsP9Le
         r7+8lRAXfdPB9n2uMDpoGgtyhpEt480O6aiMhMGXxlQP2ElE4i+16GwMbMxcetPt+oZZ
         Imj+DhPtmKM75jhXmvxpeJfvl8o0JV0qt5eQ5vnpPQcDSMpQJMXmU8mEuNP0pscfIT3D
         22u74AMmzCCZjPKVZ9XPn5zvhAFQDQsEDfuxOpbEFCFZIH+7y/OJ83AYd4BT8n0F3FNm
         6XvbZR3fk1K6al2RsykKB8pWQEmeaST50UbYvkfIRsG5rDuw5xmAKNQGkGWsfvke2vOu
         mBvA==
X-Gm-Message-State: ANoB5pkiVBILezqsHu3uy402rERt19m9nCFiC4CLYCc+AooE1uOfFTg1
        cCLIrMyTmN53yTutwCXbCzYrPw==
X-Google-Smtp-Source: AA0mqf67H5199ydlGHRMp1g06fK3AiVMjWs0U4FpXpylBAozHOOymxClqVwNDaATOFP4bIy12yqSsg==
X-Received: by 2002:adf:f142:0:b0:241:71fc:3b3d with SMTP id y2-20020adff142000000b0024171fc3b3dmr17167719wro.268.1669202663234;
        Wed, 23 Nov 2022 03:24:23 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:ae74:d94f:4677:3378])
        by smtp.gmail.com with ESMTPSA id jb2-20020a05600c54e200b003c21ba7d7d6sm1881741wmb.44.2022.11.23.03.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 03:24:22 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] fs: configfs: remove mentions of committable items
Date:   Wed, 23 Nov 2022 12:24:16 +0100
Message-Id: <20221123112416.1838597-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

A proposition of implementation of committable items has been rejected
due to the gpio-sim module being the only user and configfs not getting
much development in general. In that case, let's remove the notion
of committable items from docs and headers.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 Documentation/filesystems/configfs.rst | 48 --------------------------
 include/linux/configfs.h               |  3 --
 2 files changed, 51 deletions(-)

diff --git a/Documentation/filesystems/configfs.rst b/Documentation/filesystems/configfs.rst
index 1d3d6f4a82a9..8c9342ed6d25 100644
--- a/Documentation/filesystems/configfs.rst
+++ b/Documentation/filesystems/configfs.rst
@@ -289,7 +289,6 @@ config_item_type::
 						 const char *name);
 		struct config_group *(*make_group)(struct config_group *group,
 						   const char *name);
-		int (*commit_item)(struct config_item *item);
 		void (*disconnect_notify)(struct config_group *group,
 					  struct config_item *item);
 		void (*drop_item)(struct config_group *group,
@@ -486,50 +485,3 @@ up.  Here, the heartbeat code calls configfs_depend_item().  If it
 succeeds, then heartbeat knows the region is safe to give to ocfs2.
 If it fails, it was being torn down anyway, and heartbeat can gracefully
 pass up an error.
-
-Committable Items
-=================
-
-Note:
-     Committable items are currently unimplemented.
-
-Some config_items cannot have a valid initial state.  That is, no
-default values can be specified for the item's attributes such that the
-item can do its work.  Userspace must configure one or more attributes,
-after which the subsystem can start whatever entity this item
-represents.
-
-Consider the FakeNBD device from above.  Without a target address *and*
-a target device, the subsystem has no idea what block device to import.
-The simple example assumes that the subsystem merely waits until all the
-appropriate attributes are configured, and then connects.  This will,
-indeed, work, but now every attribute store must check if the attributes
-are initialized.  Every attribute store must fire off the connection if
-that condition is met.
-
-Far better would be an explicit action notifying the subsystem that the
-config_item is ready to go.  More importantly, an explicit action allows
-the subsystem to provide feedback as to whether the attributes are
-initialized in a way that makes sense.  configfs provides this as
-committable items.
-
-configfs still uses only normal filesystem operations.  An item is
-committed via rename(2).  The item is moved from a directory where it
-can be modified to a directory where it cannot.
-
-Any group that provides the ct_group_ops->commit_item() method has
-committable items.  When this group appears in configfs, mkdir(2) will
-not work directly in the group.  Instead, the group will have two
-subdirectories: "live" and "pending".  The "live" directory does not
-support mkdir(2) or rmdir(2) either.  It only allows rename(2).  The
-"pending" directory does allow mkdir(2) and rmdir(2).  An item is
-created in the "pending" directory.  Its attributes can be modified at
-will.  Userspace commits the item by renaming it into the "live"
-directory.  At this point, the subsystem receives the ->commit_item()
-callback.  If all required attributes are filled to satisfaction, the
-method returns zero and the item is moved to the "live" directory.
-
-As rmdir(2) does not work in the "live" directory, an item must be
-shutdown, or "uncommitted".  Again, this is done via rename(2), this
-time from the "live" directory back to the "pending" one.  The subsystem
-is notified by the ct_group_ops->uncommit_object() method.
diff --git a/include/linux/configfs.h b/include/linux/configfs.h
index 97cfd13bae51..2606711adb18 100644
--- a/include/linux/configfs.h
+++ b/include/linux/configfs.h
@@ -204,8 +204,6 @@ static struct configfs_bin_attribute _pfx##attr_##_name = {	\
  * group children.  default_groups may coexist alongsize make_group() or
  * make_item(), but if the group wishes to have only default_groups
  * children (disallowing mkdir(2)), it need not provide either function.
- * If the group has commit(), it supports pending and committed (active)
- * items.
  */
 struct configfs_item_operations {
 	void (*release)(struct config_item *);
@@ -216,7 +214,6 @@ struct configfs_item_operations {
 struct configfs_group_operations {
 	struct config_item *(*make_item)(struct config_group *group, const char *name);
 	struct config_group *(*make_group)(struct config_group *group, const char *name);
-	int (*commit_item)(struct config_item *item);
 	void (*disconnect_notify)(struct config_group *group, struct config_item *item);
 	void (*drop_item)(struct config_group *group, struct config_item *item);
 };
-- 
2.37.2

