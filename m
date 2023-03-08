Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02966B0D1A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 16:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjCHPko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 10:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbjCHPkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:40:13 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C576238667
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 07:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678289991; x=1709825991;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Se/biot0lVFjHYoy6HUt2Ws+mFr0uN1AGnXhhRrqKoQ=;
  b=ifRZDgduRD7frqZ+g68XDawNtJbLPkzR8BvZFhHMvMMvaoHdXUNyE96j
   8PpL68NuKDPYiOfMF2os9kqA3hJWWOraIFYnqFLcxBqUWj0ZZjMFPdVG0
   5pSWNkqKQWbQestNRibo89Ks4Vs1M1Xi0EcUstYZgA9hJU16q2iAcwjR7
   bW3zLp6QA9rjAbOhcLTxZHXOnr/qC8gWCaWPz/BLcVU259YGGuXehFdrK
   RkQLhXLT+/P/s8QiPpBotHcFswtB30Jb1gcHrNqtNFdtOAxle7KUo1iTu
   qF4xJWHYmKHmUq5h+eVle5HTq0fkZXh3lue26BBDz8rADObHGwdVVJsFs
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="337703559"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="337703559"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 07:39:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="787160261"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="787160261"
Received: from lab-ah.igk.intel.com ([10.102.42.211])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 07:39:46 -0800
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Date:   Wed, 08 Mar 2023 16:39:04 +0100
Subject: [PATCH v5 2/4] drm/i915/display: use nop_clear_range instead of local
 function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230308-guard_error_capture-v5-2-6d1410d13540@intel.com>
References: <20230308-guard_error_capture-v5-0-6d1410d13540@intel.com>
In-Reply-To: <20230308-guard_error_capture-v5-0-6d1410d13540@intel.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Chris Wilson <chris.p.wilson@linux.intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>
X-Mailer: b4 0.11.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since nop_clear_range is visible it can be used here.

Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>
---
 drivers/gpu/drm/i915/display/intel_dpt.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dpt.c b/drivers/gpu/drm/i915/display/intel_dpt.c
index ad1a37b515fb1c..eb9d1a6cbfb9dd 100644
--- a/drivers/gpu/drm/i915/display/intel_dpt.c
+++ b/drivers/gpu/drm/i915/display/intel_dpt.c
@@ -73,11 +73,6 @@ static void dpt_insert_entries(struct i915_address_space *vm,
 		gen8_set_pte(&base[i++], pte_encode | addr);
 }
 
-static void dpt_clear_range(struct i915_address_space *vm,
-			    u64 start, u64 length)
-{
-}
-
 static void dpt_bind_vma(struct i915_address_space *vm,
 			 struct i915_vm_pt_stash *stash,
 			 struct i915_vma_resource *vma_res,
@@ -291,7 +286,7 @@ intel_dpt_create(struct intel_framebuffer *fb)
 	i915_address_space_init(vm, VM_CLASS_DPT);
 
 	vm->insert_page = dpt_insert_page;
-	vm->clear_range = dpt_clear_range;
+	vm->clear_range = nop_clear_range;
 	vm->insert_entries = dpt_insert_entries;
 	vm->cleanup = dpt_cleanup;
 

-- 
2.34.1
