Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15B364EE9E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 17:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbiLPQJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 11:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiLPQJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 11:09:01 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD8547330
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 08:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1671206874; bh=pbGpvULOholZvb5olInn+Fl6NBfMf3MM3SbvamW2d28=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=XnU/moSq/6f6jqdAYoQ9DRaqqQH5af54Tv3y/qlQdHoPi6U1UYeZghrG8suLor2r/
         kM6KA4s30gVkYVklrcIQidIbtgMPYiGXBubJEv9i2Cvk8cHqkJB3sryrxHnq2zA9Mo
         UH5BollB15U0L3WPyrYTezQnpeKueuegGMMOlNNw=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Fri, 16 Dec 2022 17:07:54 +0100 (CET)
X-EA-Auth: r6MeKYUR9fyZA/V6ZIIId1y+j07mHDm4LIWLgWKlymZezNqlTBjuWAOPObWQ9e34wUQtjuxU6yiuhxCu1INPd50jxqFtKREG
Date:   Fri, 16 Dec 2022 21:37:47 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>, drv@mailo.com
Subject: [PATCH] drm/i915/gvt: Replace DEFINE_SIMPLE_ATTRIBUTE by
 DEFINE_DEBUGFS_ATTRIBUTE
Message-ID: <Y5yX01RC4B22j5w8@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DEFINE_DEBUGFS_ATTRIBUTE macro has implementation for protecting the
read/write file operations from removal race conditions. This further
enables using debugfs_create_file_unsafe() function since there is no need
for a proxy file operations struct for protection. Hence replace the
DEFINE_SIMPLE_ATTRIBUTE macro by DEFINE_DEBUGFS_ATTRIBUTE and the
debugfs_create_file() by the lightweight debugfs_create_file_unsafe()
versions.

This issue was identified using the coccinelle debugfs_simple_attr.cocci
semantic patch.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
Please note: The changes are compile tested only.

 drivers/gpu/drm/i915/gvt/debugfs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/debugfs.c b/drivers/gpu/drm/i915/gvt/debugfs.c
index 9f1c209d9251..a45a43c35a6b 100644
--- a/drivers/gpu/drm/i915/gvt/debugfs.c
+++ b/drivers/gpu/drm/i915/gvt/debugfs.c
@@ -147,9 +147,9 @@ vgpu_scan_nonprivbb_set(void *data, u64 val)
 	return 0;
 }

-DEFINE_SIMPLE_ATTRIBUTE(vgpu_scan_nonprivbb_fops,
-			vgpu_scan_nonprivbb_get, vgpu_scan_nonprivbb_set,
-			"0x%llx\n");
+DEFINE_DEBUGFS_ATTRIBUTE(vgpu_scan_nonprivbb_fops,
+			 vgpu_scan_nonprivbb_get, vgpu_scan_nonprivbb_set,
+			 "0x%llx\n");

 /**
  * intel_gvt_debugfs_add_vgpu - register debugfs entries for a vGPU
@@ -165,8 +165,8 @@ void intel_gvt_debugfs_add_vgpu(struct intel_vgpu *vgpu)
 	debugfs_create_bool("active", 0444, vgpu->debugfs, &vgpu->active);
 	debugfs_create_file("mmio_diff", 0444, vgpu->debugfs, vgpu,
 			    &vgpu_mmio_diff_fops);
-	debugfs_create_file("scan_nonprivbb", 0644, vgpu->debugfs, vgpu,
-			    &vgpu_scan_nonprivbb_fops);
+	debugfs_create_file_unsafe("scan_nonprivbb", 0644, vgpu->debugfs, vgpu,
+				   &vgpu_scan_nonprivbb_fops);
 }

 /**
--
2.34.1



