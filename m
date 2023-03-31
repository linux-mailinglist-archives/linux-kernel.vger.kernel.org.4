Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEEC6D1C85
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbjCaJer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbjCaJeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:34:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE951E721
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:33:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58CA26267C
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 09:33:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B224C4339B;
        Fri, 31 Mar 2023 09:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680255223;
        bh=Zs88aniaG2xrRdlt5Cwe66oCTU15EGFax/mMSpnsOZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LpxUaUG/3JrIhMOzAYddDpZYiB+fPUIIHnyig2PhisW/55oJaZHY+z9jvDjx9EveW
         pGanx9iyvjmeIJuma9JMCPlLO5MAZ/3rUAlU7TvE/wI7uUK3pKZiaPEdSWuC1inEAo
         jkh0clvA84ACyEwB6ttrDCj9J2eNcbfjEri8t28o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 7/7] driver core: make sysfs_dev_char_kobj static
Date:   Fri, 31 Mar 2023 11:33:18 +0200
Message-Id: <20230331093318.82288-7-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230331093318.82288-1-gregkh@linuxfoundation.org>
References: <20230331093318.82288-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1584; i=gregkh@linuxfoundation.org; h=from:subject; bh=Zs88aniaG2xrRdlt5Cwe66oCTU15EGFax/mMSpnsOZw=; b=owGbwMvMwCRo6H6F97bub03G02pJDClqK+7tTepben3mB93pbJ4FK9In77no+qkxsu66vLl+V fkr9ZlTOmJZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAi3rcZ5udXeF9YpT9x6elI Fa6U9X6CfwrjVBnme024uPbbjczD9zJ8aidktW318g0JBAA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing outside of drivers/base/core.c uses sysfs_dev_char_kobj, so
make it static and document what it is used for so we remember it the
next time we touch it 15 years from now.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/base.h | 3 ---
 drivers/base/core.c | 4 +++-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 4660e1159ee0..e96f3343fd7c 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -191,9 +191,6 @@ const char *device_get_devnode(const struct device *dev, umode_t *mode,
 extern struct kset *devices_kset;
 void devices_kset_move_last(struct device *dev);
 
-/* /sys/dev/char directory */
-extern struct kobject *sysfs_dev_char_kobj;
-
 #if defined(CONFIG_MODULES) && defined(CONFIG_SYSFS)
 void module_add_driver(struct module *mod, struct device_driver *drv);
 void module_remove_driver(struct device_driver *drv);
diff --git a/drivers/base/core.c b/drivers/base/core.c
index cf6f41c2060c..47e16c088e77 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2255,7 +2255,9 @@ static void fw_devlink_link_device(struct device *dev)
 int (*platform_notify)(struct device *dev) = NULL;
 int (*platform_notify_remove)(struct device *dev) = NULL;
 static struct kobject *dev_kobj;
-struct kobject *sysfs_dev_char_kobj;
+
+/* /sys/dev/char */
+static struct kobject *sysfs_dev_char_kobj;
 
 /* /sys/dev/block */
 static struct kobject *sysfs_dev_block_kobj;
-- 
2.40.0

