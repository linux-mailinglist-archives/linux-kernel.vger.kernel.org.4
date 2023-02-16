Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E40169899E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 02:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjBPBFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 20:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBPBFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 20:05:38 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989313D914
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 17:05:36 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1676509534;
        bh=IVBAbq+p3hoTXWJlTZmLI/40oSSDdV0kZu4KVH+IXTU=;
        h=From:Date:Subject:To:Cc:From;
        b=KZVerghpYl9EniP5JD5JDJPwaYLf0qJbVq/OwA8lTrs48a6VquniofrHaf/nsMg40
         on7rRTjKRDEq5Ba+udGj0aaFuuQ027fqXPOoOL4rn5HWOBZmSW7V2Ws6AYWdMpmlnk
         8NDg8yai1NgjZtZwm6VGUZj8xe9/X2kfrZNcOdRQ=
Date:   Thu, 16 Feb 2023 01:05:30 +0000
Subject: [PATCH] drm/i915: Make kobj_type structures constant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230216-kobj_type-i915-v1-1-ca65c9b93518@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAFmB7WMC/x2NUQqDMBAFryL73YBJMKhXkVKycaurEiWp0iLe3
 aWfM4/hnZApMWVoixMSHZx5jQL6UUAYfRxIcS8MpjS2NNqpecXp9fltMjS6UnXtkDBYp00DEqH
 PpDD5GEbJ4r4sIrdEb/7+X7rndd3pJkikdQAAAA==
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676509531; l=1627;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=IVBAbq+p3hoTXWJlTZmLI/40oSSDdV0kZu4KVH+IXTU=;
 b=aIk/xPnRJGbvs8WW/pbryE5nyXYrxV32q9QWxWXyvNiJdzUCmtbetX0pMdJrPwLDPXagAALvt
 gskrXgwRwvcDKdJ4nHFUnGBIb3I57Pg+AdOpk3dVby4wF8bw30972kY
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
the driver core allows the usage of const struct kobj_type.

Take advantage of this to constify the structure definitions to prevent
modification at runtime.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/gpu/drm/i915/gt/intel_gt_sysfs.c | 2 +-
 drivers/gpu/drm/i915/gt/sysfs_engines.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_gt_sysfs.c b/drivers/gpu/drm/i915/gt/intel_gt_sysfs.c
index 9486dd3bed99..df15b17caf89 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_sysfs.c
+++ b/drivers/gpu/drm/i915/gt/intel_gt_sysfs.c
@@ -71,7 +71,7 @@ static void kobj_gt_release(struct kobject *kobj)
 {
 }
 
-static struct kobj_type kobj_gt_type = {
+static const struct kobj_type kobj_gt_type = {
 	.release = kobj_gt_release,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.default_groups = id_groups,
diff --git a/drivers/gpu/drm/i915/gt/sysfs_engines.c b/drivers/gpu/drm/i915/gt/sysfs_engines.c
index f2d9858d827c..b5e0fe5dbf6c 100644
--- a/drivers/gpu/drm/i915/gt/sysfs_engines.c
+++ b/drivers/gpu/drm/i915/gt/sysfs_engines.c
@@ -421,7 +421,7 @@ static void kobj_engine_release(struct kobject *kobj)
 	kfree(kobj);
 }
 
-static struct kobj_type kobj_engine_type = {
+static const struct kobj_type kobj_engine_type = {
 	.release = kobj_engine_release,
 	.sysfs_ops = &kobj_sysfs_ops
 };

---
base-commit: 033c40a89f55525139fd5b6342281b09b97d05bf
change-id: 20230216-kobj_type-i915-886bebc36129

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

