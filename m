Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB05C635CE5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 13:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237089AbiKWM1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 07:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237078AbiKWM0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 07:26:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8A761BB9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 04:25:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 534D861C58
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 12:25:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A4AC433B5;
        Wed, 23 Nov 2022 12:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669206350;
        bh=Y2hWZN4MqMeO65hNd5mMhexY6L2mauv8s0WA0ygqM3U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ec5fMGJF0n9mfQKxQA9IBJvHbtiYdYw7iRsF4kk3Yx4TOTYRPF4t07VEXg9qaWgC1
         c47uvrcCh+MBmwFPEvjTli7S0tIntGp98Tz0NE5Nq1kL6EiCSU+xBhTQGiS0R9IISC
         jteSNotwaqOrhKlRiaPJublQUNk+Bq6j9ByNjc50=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Won Chung <wonchung@google.com>
Subject: [PATCH 5/5] driver core: device_get_devnode() should take a const *
Date:   Wed, 23 Nov 2022 13:25:23 +0100
Message-Id: <20221123122523.1332370-5-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221123122523.1332370-1-gregkh@linuxfoundation.org>
References: <20221123122523.1332370-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2551; i=gregkh@linuxfoundation.org; h=from:subject; bh=Y2hWZN4MqMeO65hNd5mMhexY6L2mauv8s0WA0ygqM3U=; b=owGbwMvMwCRo6H6F97bub03G02pJDMl1gsZu8TcMrn187L97nUqJnMi7xV9f7cop+DqLneFHduJa r+bYjlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZjIrcUM87QmN1pMZtOQmJPtWn3vSp hA1lHPhwzz7Jwu3L+re8Rv7TNnhTbhi67TvjU/AwA=
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

device_get_devnode() should take a constant * to struct device as it
does not modify it in any way, so modify the function definition to do
this and move it out of device.h as it does not need to be exposed to
the whole kernel tree.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Won Chung <wonchung@google.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/base.h    | 2 ++
 drivers/base/core.c    | 2 +-
 include/linux/device.h | 2 --
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 7d4803c03d3e..a8a119c36bdc 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -158,6 +158,8 @@ extern void device_block_probing(void);
 extern void device_unblock_probing(void);
 extern void deferred_probe_extend_timeout(void);
 extern void driver_deferred_probe_trigger(void);
+const char *device_get_devnode(const struct device *dev, umode_t *mode,
+			       kuid_t *uid, kgid_t *gid, const char **tmp);
 
 /* /sys/devices directory */
 extern struct kset *devices_kset;
diff --git a/drivers/base/core.c b/drivers/base/core.c
index a3e14143ec0c..72ec54a8a4e1 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3739,7 +3739,7 @@ static struct device *next_device(struct klist_iter *i)
  * a name. This memory is returned in tmp and needs to be
  * freed by the caller.
  */
-const char *device_get_devnode(struct device *dev,
+const char *device_get_devnode(const struct device *dev,
 			       umode_t *mode, kuid_t *uid, kgid_t *gid,
 			       const char **tmp)
 {
diff --git a/include/linux/device.h b/include/linux/device.h
index 4ad1280713e6..e4498389e866 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -927,8 +927,6 @@ int device_rename(struct device *dev, const char *new_name);
 int device_move(struct device *dev, struct device *new_parent,
 		enum dpm_order dpm_order);
 int device_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid);
-const char *device_get_devnode(struct device *dev, umode_t *mode, kuid_t *uid,
-			       kgid_t *gid, const char **tmp);
 int device_is_dependent(struct device *dev, void *target);
 
 static inline bool device_supports_offline(struct device *dev)
-- 
2.38.1

