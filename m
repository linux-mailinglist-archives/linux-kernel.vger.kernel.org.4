Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A70D665FC0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 16:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbjAKPwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 10:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239532AbjAKPwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 10:52:25 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75EB3475B
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 07:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1673452324; bh=QHeZldMKVWp9Cp9mxOeha2QFBOXYtsTVP8kjQEfSrZw=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=dhQ76Q5qWbdwieoX7S8a3HflKBaJR5R0TTGJXGnzA32tstm4XcijZEOvFS62J5qM5
         VaQJIcf8JLwEM0aMQYeS8QIdcD7CJm5uN1jgkn/WSHLOy0PbnPvxXEKQzPhgzUzccW
         a0baxbbbXs7geGagVcVdV/18+jQTMvgzKA4nmfMc=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Wed, 11 Jan 2023 16:52:03 +0100 (CET)
X-EA-Auth: u5jvOLR5x9//Zkc8IMR5oNVJAAF0lJRlVIyLovRtl5gS15Vj30kxR2eXf+WDRR0PXE7lTP9chqyCJpfbE+S9CoqnkWNXnn/t
Date:   Wed, 11 Jan 2023 21:21:59 +0530
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
Subject: [PATCH v3 2/2] drm/i915/fbc: Avoid full proxy f_ops for FBC debug
 attributes
Message-ID: <5d26e924ec8dea21925c77fa79a2bf2a34cef705.1673451705.git.drv@mailo.com>
References: <cover.1673451705.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1673451705.git.drv@mailo.com>
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
Changes in v3:
   - None

Changes in v2:
   - Include coccicheck make command in the patch log message for clarity.
     Suggested by Rodrigo Vivi <rodrigo.vivi@intel.com>


 drivers/gpu/drm/i915/display/intel_fbc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_fbc.c b/drivers/gpu/drm/i915/display/intel_fbc.c
index 5e69d3c11d21..c508dcf415b4 100644
--- a/drivers/gpu/drm/i915/display/intel_fbc.c
+++ b/drivers/gpu/drm/i915/display/intel_fbc.c
@@ -1807,10 +1807,10 @@ static int intel_fbc_debugfs_false_color_set(void *data, u64 val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(intel_fbc_debugfs_false_color_fops,
-			intel_fbc_debugfs_false_color_get,
-			intel_fbc_debugfs_false_color_set,
-			"%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(intel_fbc_debugfs_false_color_fops,
+			 intel_fbc_debugfs_false_color_get,
+			 intel_fbc_debugfs_false_color_set,
+			 "%llu\n");
 
 static void intel_fbc_debugfs_add(struct intel_fbc *fbc,
 				  struct dentry *parent)
@@ -1819,8 +1819,8 @@ static void intel_fbc_debugfs_add(struct intel_fbc *fbc,
 			    fbc, &intel_fbc_debugfs_status_fops);
 
 	if (fbc->funcs->set_false_color)
-		debugfs_create_file("i915_fbc_false_color", 0644, parent,
-				    fbc, &intel_fbc_debugfs_false_color_fops);
+		debugfs_create_file_unsafe("i915_fbc_false_color", 0644, parent,
+					   fbc, &intel_fbc_debugfs_false_color_fops);
 }
 
 void intel_fbc_crtc_debugfs_add(struct intel_crtc *crtc)
-- 
2.34.1



