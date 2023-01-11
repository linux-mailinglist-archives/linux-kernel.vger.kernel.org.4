Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C42665A3C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 12:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237970AbjAKLcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 06:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbjAKLb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 06:31:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D428795AA
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 03:31:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7050061C50
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 11:31:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 614B9C433EF;
        Wed, 11 Jan 2023 11:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673436678;
        bh=u0VY5UwoT2+QL9Z3Dz17VePvzzJgSFHl9JCzw67dyL8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nz5K2gpAFAyrqyOSVSux5kKvWuiO9t6VXo21tG4KCohZVpkVPAQ3/UvfAnA62G36m
         sSj86HDetffFNjIp9ZNRFbafyHfq57OLK5airjkXW7PkPJ8wSs+YCxT4ZC8jr8XCNj
         OTUlCToAaIXetkyBFcOPz6eaknANgIBjAlojrRe4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Won Chung <wonchung@google.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 07/16] driver core: device_get_devnode() should take a const *
Date:   Wed, 11 Jan 2023 12:30:09 +0100
Message-Id: <20230111113018.459199-8-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111113018.459199-1-gregkh@linuxfoundation.org>
References: <20230111113018.459199-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2530; i=gregkh@linuxfoundation.org; h=from:subject; bh=u0VY5UwoT2+QL9Z3Dz17VePvzzJgSFHl9JCzw67dyL8=; b=owGbwMvMwCRo6H6F97bub03G02pJDMn75p44vv235FOPa6d5plXpWzfci+p49WJGz/enaxZrmfbe 2/lApiOWhUGQiUFWTJHlyzaeo/srDil6GdqehpnDygQyhIGLUwAm0mfJMFdmTRNz4MmU+0fy731m/V r/nN2fOYhhfqiKw5tnfBXRf9V2rz+yKPr+9dPHDQA=
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

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Won Chung <wonchung@google.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
index 318861000b83..90aaf308c259 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -907,8 +907,6 @@ int device_rename(struct device *dev, const char *new_name);
 int device_move(struct device *dev, struct device *new_parent,
 		enum dpm_order dpm_order);
 int device_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid);
-const char *device_get_devnode(struct device *dev, umode_t *mode, kuid_t *uid,
-			       kgid_t *gid, const char **tmp);
 int device_is_dependent(struct device *dev, void *target);
 
 static inline bool device_supports_offline(struct device *dev)
-- 
2.39.0

