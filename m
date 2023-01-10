Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448EA664AB8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 19:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239376AbjAJSf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 13:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239567AbjAJSeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 13:34:09 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5FAA2AB8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 10:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1673375390; bh=miL+U54u+zbwiY1zJpyFrSycjgOcARyuIyOdsIcqAwg=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=BYQiFU30yqi3X9Qb4kRZ8o9LFNNvhMCAUgZ/MCb1uHXjZGWjvqwhsovnaKEOyrOdk
         4Ed8rhTJtcn6oZXKpfH81pQmyeSqcnfapPAFm/fxpI2d/D0fJN55wyPq+gTwe6pjoP
         7nIiumflzQDbVCQGmxksKZWRJR3j1Yc+FD9iw0IQ=
Received: by b-4.in.mailobj.net [192.168.90.14] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Tue, 10 Jan 2023 19:29:49 +0100 (CET)
X-EA-Auth: 2yCuNAG5h3cTxbwR5VlwuO7IDCj5y64ot8HtV0N6YfFg/GXhAXaQHiEkliEtmYzUP0x8v2nBHL0uNeYy54P+K5wul7dZ2llz
Date:   Tue, 10 Jan 2023 23:59:44 +0530
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
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: [PATCH 1/2] drm/i915/gvt: Avoid full proxy f_ops for scan_nonprivbb
 debug attributes
Message-ID: <f0741e940ec911fba0c1375dd2750b9db94928b2.1673375066.git.drv@mailo.com>
References: <cover.1673375066.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1673375066.git.drv@mailo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using DEFINE_SIMPLE_ATTRIBUTE macro with the debugfs_create_file()
function adds the overhead of introducing a proxy file operation
functions to wrap the original read/write inside file removal protection
functions. This adds significant overhead in terms of introducing and
managing the proxy factory file operations structure and function
wrapping at runtime.
As a replacement, a combination of DEFINE_DEBUGFS_ATTRIBUTE macro paired
with debugfs_create_file_unsafe() is suggested to be used instead.  The
DEFINE_DEBUGFS_ATTRIBUTE utilises debugfs_file_get() and
debugfs_file_put() wrappers to protect the original read and write
function calls for the debug attributes. There is no need for any
runtime proxy file operations to be managed by the debugfs core.
Following coccicheck make command helped identify this change:

make coccicheck M=drivers/gpu/drm/i915/ MODE=patch COCCI=./scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/gpu/drm/i915/gvt/debugfs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/debugfs.c b/drivers/gpu/drm/i915/gvt/debugfs.c
index 0616b73175f3..03f081c3d9a4 100644
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
 
 static int vgpu_status_get(void *data, u64 *val)
 {
@@ -180,8 +180,8 @@ void intel_gvt_debugfs_add_vgpu(struct intel_vgpu *vgpu)
 
 	debugfs_create_file("mmio_diff", 0444, vgpu->debugfs, vgpu,
 			    &vgpu_mmio_diff_fops);
-	debugfs_create_file("scan_nonprivbb", 0644, vgpu->debugfs, vgpu,
-			    &vgpu_scan_nonprivbb_fops);
+	debugfs_create_file_unsafe("scan_nonprivbb", 0644, vgpu->debugfs, vgpu,
+				   &vgpu_scan_nonprivbb_fops);
 	debugfs_create_file("status", 0644, vgpu->debugfs, vgpu,
 			    &vgpu_status_fops);
 }
-- 
2.34.1



