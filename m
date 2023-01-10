Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725C8664911
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 19:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239044AbjAJSRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 13:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235559AbjAJSQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 13:16:45 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2726CE95
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 10:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1673374506; bh=46jOppxp/mRe0pQqJxxPtA8TacbOHy69iOOY75PAV2I=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=Un/LCm+JeI9n6St9MsCyhiCrFmzHYsPDJknNa7kR//l5tlYOkHZnyZOdbOaQcT6oo
         EnX2AFn/vmyQgd+hiV2mx49D8MQtdLKsWEvVB3kPqRm7AePCfSv4JNDf51/oMg8bXs
         VWRghoJhbkfGkI/9aazql0dWAOeMibjhAvWP0FBo=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Tue, 10 Jan 2023 19:15:06 +0100 (CET)
X-EA-Auth: oa3uAoiVMRg8AVocdZ39yqZX4PN6plfP/DcwLlWgrYiXZmOfEdADt0JfkGi+PE73r+I+Zow0WtJW/txY4KbL2GOt8RJypu/x
Date:   Tue, 10 Jan 2023 23:45:02 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: [PATCH v2 1/2] drm/i915/display: Avoid full proxy f_ops for DRRS
 debug attributes
Message-ID: <4f6ae3e9a1f674abd36295772e7ffd0aa3e4a30b.1673343994.git.drv@mailo.com>
References: <cover.1673343994.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1673343994.git.drv@mailo.com>
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
Changes in v2:
   - Include coccicheck make command in the patch log message for clarity.
     Suggested by Rodrigo Vivi <rodrigo.vivi@intel.com>

 drivers/gpu/drm/i915/display/intel_drrs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_drrs.c b/drivers/gpu/drm/i915/display/intel_drrs.c
index 5b9e44443814..84ba7379d6f8 100644
--- a/drivers/gpu/drm/i915/display/intel_drrs.c
+++ b/drivers/gpu/drm/i915/display/intel_drrs.c
@@ -374,16 +374,16 @@ static int intel_drrs_debugfs_ctl_set(void *data, u64 val)
 	return ret;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(intel_drrs_debugfs_ctl_fops,
-			NULL, intel_drrs_debugfs_ctl_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(intel_drrs_debugfs_ctl_fops,
+			 NULL, intel_drrs_debugfs_ctl_set, "%llu\n");
 
 void intel_drrs_crtc_debugfs_add(struct intel_crtc *crtc)
 {
 	debugfs_create_file("i915_drrs_status", 0444, crtc->base.debugfs_entry,
 			    crtc, &intel_drrs_debugfs_status_fops);
 
-	debugfs_create_file("i915_drrs_ctl", 0644, crtc->base.debugfs_entry,
-			    crtc, &intel_drrs_debugfs_ctl_fops);
+	debugfs_create_file_unsafe("i915_drrs_ctl", 0644, crtc->base.debugfs_entry,
+				    crtc, &intel_drrs_debugfs_ctl_fops);
 }
 
 static int intel_drrs_debugfs_type_show(struct seq_file *m, void *unused)
-- 
2.34.1



