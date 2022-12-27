Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99B1656803
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 08:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbiL0HzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 02:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbiL0HzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 02:55:06 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F906147
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 23:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1672127688; bh=giLygN6VCt7V445nQatslkp77AOYXtWjJUE7E0bEqc0=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=QCqXgq8OvC0nS2bvkqSJGiSC4vJEpFoCCALoQUcVCT4D3XEaiDtb1L8tJGJKo9bHo
         0wVRz/R+tSsQ6WUVRx4ievKOIoP4Lu5e6PBAYCTxWlJYcxB8v5UReEZRb0q8O5ro3G
         ZLqMs3FLEz9Cheb7v1fV9WXMRCBL5GQ8egm0c11k=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Tue, 27 Dec 2022 08:54:48 +0100 (CET)
X-EA-Auth: Y/txN7h7M1NSBRb/aAVjjQNqoV1iyiWxffr+VZOusP9tx6BTq8pNJEqpfWcIfiLuIBYbzBtgFVghFHIsVPbvkC8b7+YujL3P
Date:   Tue, 27 Dec 2022 13:24:39 +0530
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
Subject: [PATCH] drm/i915/display: Avoid full proxy f_ops for DRRS debug
 attributes
Message-ID: <Y6qkv/YVsUQ6kpYp@qemulion>
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



