Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74957656818
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 09:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiL0IBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 03:01:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiL0IBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 03:01:19 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44628114F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 00:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1672128061; bh=L7owGmbT1ZxgBvi6fbS8mXVWDglqw6W6df4BA5PYtMM=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=QxVY8yjoKzb0OTh6OmIxWa+uJk9lbvdtIva6tG/qKJiCZplp9WSDt6le7+JUI+CnL
         FFs4xPIeVx42lFD3oov338vMc6A6DtGnSXp5zpDA6+RSIJwgiz4vs1aQTtwSZRT700
         3PUVumlKzgM2VxuTq1ewiY3ZdkGCGj7dzhY+i73k=
Received: by b-5.in.mailobj.net [192.168.90.15] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Tue, 27 Dec 2022 09:01:01 +0100 (CET)
X-EA-Auth: 055MqznYGGdxPOOuTU1LvLH5vLFB+IXYkeGlM26BeEaHaWLHphe/AO32mkbpjHKL2tQxrFN4WIgzNiFSMaanFHsHZ6uFhWf9
Date:   Tue, 27 Dec 2022 13:30:53 +0530
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
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH] drm/i915/fbc: Avoid full proxy f_ops for FBC debug attributes
Message-ID: <Y6qmNW6cOHjGwn03@qemulion>
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

This Change is reported by the debugfs_simple_attr.cocci Coccinelle
semantic patch.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/gpu/drm/i915/display/intel_fbc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_fbc.c b/drivers/gpu/drm/i915/display/intel_fbc.c
index b5ee5ea0d010..4b481e2f908b 100644
--- a/drivers/gpu/drm/i915/display/intel_fbc.c
+++ b/drivers/gpu/drm/i915/display/intel_fbc.c
@@ -1809,10 +1809,10 @@ static int intel_fbc_debugfs_false_color_set(void *data, u64 val)
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
@@ -1821,8 +1821,8 @@ static void intel_fbc_debugfs_add(struct intel_fbc *fbc,
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



