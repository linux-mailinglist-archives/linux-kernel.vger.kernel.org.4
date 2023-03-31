Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BC86D1C84
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbjCaJeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbjCaJeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:34:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0101DF83
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:33:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64662B82DC7
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 09:33:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D18C433EF;
        Fri, 31 Mar 2023 09:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680255221;
        bh=33lnSUxnErAsDK9U63Sy6HNzuJEGFsalNiocLSuqpEw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CVROJi0NV3/sK6ygfoObALOLCmpl81uHPeFG4Gdwtb0yBM885q9Bw5MWbHy+xfdf4
         3mLkdvqHBv/bthoE0fsLmQGY4sswEVealasv+5Cz4qW9zeLBZS3r9StgZdvFLG+zq1
         y4kej51wjWmRIDc/Tcq26CAyDSLuK6694w00HjMg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 6/7] driver core: make sysfs_dev_block_kobj static
Date:   Fri, 31 Mar 2023 11:33:17 +0200
Message-Id: <20230331093318.82288-6-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230331093318.82288-1-gregkh@linuxfoundation.org>
References: <20230331093318.82288-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1451; i=gregkh@linuxfoundation.org; h=from:subject; bh=33lnSUxnErAsDK9U63Sy6HNzuJEGFsalNiocLSuqpEw=; b=owGbwMvMwCRo6H6F97bub03G02pJDClqK+7KPRXaM1/TzCdj6u+bPhVnFknUKC9ZEh791D5kr Vf58guSHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjCRG6EM8xQOneF8fH/GW1/t kkttF5pORW0XiGKY71Wze+XWY7W5kr/Lb88987A51dsgFAA=
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

Nothing outside of drivers/base/core.c uses sysfs_dev_block_kobj, so
make it static and document what it is used for so we remember it the
next time we touch it 15 years from now.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/core.c          | 4 +++-
 include/linux/device/class.h | 2 --
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index dbc2ba6dfffc..cf6f41c2060c 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2256,7 +2256,9 @@ int (*platform_notify)(struct device *dev) = NULL;
 int (*platform_notify_remove)(struct device *dev) = NULL;
 static struct kobject *dev_kobj;
 struct kobject *sysfs_dev_char_kobj;
-struct kobject *sysfs_dev_block_kobj;
+
+/* /sys/dev/block */
+static struct kobject *sysfs_dev_block_kobj;
 
 static DEFINE_MUTEX(device_hotplug_lock);
 
diff --git a/include/linux/device/class.h b/include/linux/device/class.h
index e946642c314e..7e4a1a6329f4 100644
--- a/include/linux/device/class.h
+++ b/include/linux/device/class.h
@@ -76,8 +76,6 @@ struct class_dev_iter {
 	const struct device_type	*type;
 };
 
-extern struct kobject *sysfs_dev_block_kobj;
-
 int __must_check class_register(struct class *class);
 void class_unregister(const struct class *class);
 bool class_is_registered(const struct class *class);
-- 
2.40.0

