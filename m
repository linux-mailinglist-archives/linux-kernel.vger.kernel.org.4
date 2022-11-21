Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5324631D3A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 10:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbiKUJrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 04:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbiKUJrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 04:47:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857EDE08D;
        Mon, 21 Nov 2022 01:47:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24AB960F93;
        Mon, 21 Nov 2022 09:47:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F77C433D6;
        Mon, 21 Nov 2022 09:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669024019;
        bh=VQZYBH1bhf90ko3Gyb0TeinDWhHpYreu0f9unIS25Zw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LP5Bcu/o6ov0sKBaLpR4FOMpj0KiyS6oh9p0I60JpynrFARptBhfmho4EJPJ4/m8m
         8P/d6EM/AqaaQLCXJhqPIcFWHodFvsubWuvWx28DPgaLvAZqckMNaKwqG6/tHpp2k2
         NhwnVwWHQ5eSkDwvMZ+zEr7bgrLiNVmVBz09kxJI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
Subject: [PATCH 3/5] kobject: kset_uevent_ops: make filter() callback take a const *
Date:   Mon, 21 Nov 2022 10:46:47 +0100
Message-Id: <20221121094649.1556002-3-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221121094649.1556002-1-gregkh@linuxfoundation.org>
References: <20221121094649.1556002-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3268; i=gregkh@linuxfoundation.org; h=from:subject; bh=VQZYBH1bhf90ko3Gyb0TeinDWhHpYreu0f9unIS25Zw=; b=owGbwMvMwCRo6H6F97bub03G02pJDMnVnpyPX3yeVMM/57Desw3BLcVtK7dElz68+Jj/h3hLmCLD i9stHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjAR2ViGBcs28T5zS33/Xe98772MPX fXBXVIsjIsaPjXGMjtXphX9MSuufH7/2k3/JI6AQ==
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

The filter() callback in struct kset_uevent_ops does not modify the
kobject passed into it, so make the pointer const to enforce this
restriction.  When doing so, fix up all existing filter() callbacks to
have the correct signature to preserve the build.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linaro-mm-sig@lists.linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/bus.c                    | 2 +-
 drivers/base/core.c                   | 4 ++--
 drivers/dma-buf/dma-buf-sysfs-stats.c | 2 +-
 include/linux/kobject.h               | 2 +-
 kernel/params.c                       | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 7ca47e5b3c1f..4ec6dbab73be 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -163,7 +163,7 @@ static struct kobj_type bus_ktype = {
 	.release	= bus_release,
 };
 
-static int bus_uevent_filter(struct kobject *kobj)
+static int bus_uevent_filter(const struct kobject *kobj)
 {
 	const struct kobj_type *ktype = get_ktype(kobj);
 
diff --git a/drivers/base/core.c b/drivers/base/core.c
index a79b99ecf4d8..005a2b092f3e 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2362,12 +2362,12 @@ static struct kobj_type device_ktype = {
 };
 
 
-static int dev_uevent_filter(struct kobject *kobj)
+static int dev_uevent_filter(const struct kobject *kobj)
 {
 	const struct kobj_type *ktype = get_ktype(kobj);
 
 	if (ktype == &device_ktype) {
-		struct device *dev = kobj_to_dev(kobj);
+		const struct device *dev = kobj_to_dev(kobj);
 		if (dev->bus)
 			return 1;
 		if (dev->class)
diff --git a/drivers/dma-buf/dma-buf-sysfs-stats.c b/drivers/dma-buf/dma-buf-sysfs-stats.c
index 2bba0babcb62..f69d68122b9b 100644
--- a/drivers/dma-buf/dma-buf-sysfs-stats.c
+++ b/drivers/dma-buf/dma-buf-sysfs-stats.c
@@ -132,7 +132,7 @@ void dma_buf_stats_teardown(struct dma_buf *dmabuf)
 
 
 /* Statistics files do not need to send uevents. */
-static int dmabuf_sysfs_uevent_filter(struct kobject *kobj)
+static int dmabuf_sysfs_uevent_filter(const struct kobject *kobj)
 {
 	return 0;
 }
diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index 5a2d58e10bf5..640f59d4b3de 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -135,7 +135,7 @@ struct kobj_uevent_env {
 };
 
 struct kset_uevent_ops {
-	int (* const filter)(struct kobject *kobj);
+	int (* const filter)(const struct kobject *kobj);
 	const char *(* const name)(struct kobject *kobj);
 	int (* const uevent)(struct kobject *kobj, struct kobj_uevent_env *env);
 };
diff --git a/kernel/params.c b/kernel/params.c
index 5b92310425c5..d2237209ceda 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -926,7 +926,7 @@ static const struct sysfs_ops module_sysfs_ops = {
 	.store = module_attr_store,
 };
 
-static int uevent_filter(struct kobject *kobj)
+static int uevent_filter(const struct kobject *kobj)
 {
 	const struct kobj_type *ktype = get_ktype(kobj);
 
-- 
2.38.1

