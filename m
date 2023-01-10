Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476E1664670
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 17:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbjAJQpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 11:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234356AbjAJQos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 11:44:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E575A8BA;
        Tue, 10 Jan 2023 08:44:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BC15617E5;
        Tue, 10 Jan 2023 16:44:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B925C433D2;
        Tue, 10 Jan 2023 16:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673369086;
        bh=5pn8lNPzgrol7P8MBSuD7FbH2Rhpic8YeqNAugxASls=;
        h=Date:From:To:Cc:Subject:From;
        b=HI7JpEwkuf+RJ2R7d+YsfTHRQBGCakNFWm+7b1d30HrcAcAh1p9QQmP4YXO1RXiml
         jR/gZjcdi/S9lCp1mHKWz9UF2qvAVC4MSw7eNLX+BkvbyA1wcr1atcLXBzCwcIoORY
         6h9q2+C44XQ3YaGjgfU4qo9TQZCDFd4dXTELHiQ6v/cGxAJsqpdaidEv5Cn8CyHjiJ
         I9WGQy4F4ioTx1C+EhjYsc706rSMm4+I94FDxs0q/DNlBDhJSKef9pmowT1f/jCRSb
         pqCoJAx0aXoNfcXkf0XuF7ax9lsSySCsjp9NXhzt1zMB6KyuLS05r49mUYB5IL/PXu
         wcTeCnt2+yo/A==
Date:   Tue, 10 Jan 2023 10:44:53 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] drm/i915/guc: Replace zero-length arrays with
 flexible-array members
Message-ID: <Y72WBTUmh9r1lvKN@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zero-length arrays are deprecated[1] and we are moving towards
adopting C99 flexible-array members, instead. So, replace zero-length
arrays in a couple of structures (three, actually) with flex-array
members.

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
routines on memcpy() and help us make progress towards globally
enabling -fstrict-flex-arrays=3 [2].

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays [1]
Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [2]
Link: https://github.com/KSPP/linux/issues/78
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/i915/gt/uc/guc_capture_fwif.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/uc/guc_capture_fwif.h b/drivers/gpu/drm/i915/gt/uc/guc_capture_fwif.h
index 3624abfd22d1..9d589c28f40f 100644
--- a/drivers/gpu/drm/i915/gt/uc/guc_capture_fwif.h
+++ b/drivers/gpu/drm/i915/gt/uc/guc_capture_fwif.h
@@ -73,7 +73,7 @@ struct guc_debug_capture_list_header {
 
 struct guc_debug_capture_list {
 	struct guc_debug_capture_list_header header;
-	struct guc_mmio_reg regs[0];
+	struct guc_mmio_reg regs[];
 } __packed;
 
 /**
@@ -125,7 +125,7 @@ struct guc_state_capture_header_t {
 
 struct guc_state_capture_t {
 	struct guc_state_capture_header_t header;
-	struct guc_mmio_reg mmio_entries[0];
+	struct guc_mmio_reg mmio_entries[];
 } __packed;
 
 enum guc_capture_group_types {
@@ -145,7 +145,7 @@ struct guc_state_capture_group_header_t {
 /* this is the top level structure where an error-capture dump starts */
 struct guc_state_capture_group_t {
 	struct guc_state_capture_group_header_t grp_header;
-	struct guc_state_capture_t capture_entries[0];
+	struct guc_state_capture_t capture_entries[];
 } __packed;
 
 /**
-- 
2.34.1

