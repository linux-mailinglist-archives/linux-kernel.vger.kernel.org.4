Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7E55B35F0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 13:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbiIILBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 07:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbiIILAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 07:00:41 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FBD7285E
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 04:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662721205; x=1694257205;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fusilmdSQD+FIBKYeUukiHJrxKRQ3B5pPSTTQeO8rTk=;
  b=BNK0hnGy6vNtAmHTWdoKX4tqBQ/jQX6fpX2qvrmAyvp7hGMRXuaV5uln
   u6HPlhhRC/731IkSNCdp96WlkXZ5O1RfBcqUXH7F2VHnt6QFnT6Gvqf7m
   DvbMOSX2uYkzBVB6RrEwzQA4DCjXELyXHTLqt+JDTXGhJ70wQW/bQDN7f
   VPRABQ3J5pv0v5ztPvyOJJMCKJHz2zNE4vjNzis/i6Nir5ROnn06+A0Qm
   VY03wkFcHfDKPDHEBYhOK5OA/UVCWqR9huhoJONsR9jqefdPTibKKmDCh
   BmH5WQW/yAAC3IPrgBW6pdzxaUUj1a5CxnUZFSN1mr6RznBehfjzhVRQQ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="297449584"
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="297449584"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 04:00:03 -0700
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="704370438"
Received: from clbarnes-mobl.amr.corp.intel.com (HELO paris.amr.corp.intel.com) ([10.254.42.92])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 04:00:00 -0700
From:   Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        mchehab@kernel.org, chris@chris-wilson.co.uk,
        matthew.auld@intel.com, thomas.hellstrom@linux.intel.com,
        jani.nikula@intel.com, nirmoy.das@intel.com, airlied@redhat.com,
        daniel@ffwll.ch, andi.shyti@linux.intel.com,
        andrzej.hajda@intel.com, keescook@chromium.org,
        mauro.chehab@linux.intel.com, linux@rasmusvillemoes.dk,
        vitor@massaru.org, dlatypov@google.com, ndesaulniers@google.com
Subject: [PATCH v10 7/9] drm/i915: Check if the size is too big while creating shmem file
Date:   Fri,  9 Sep 2022 19:59:11 +0900
Message-Id: <20220909105913.752049-8-gwan-gyeong.mun@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220909105913.752049-1-gwan-gyeong.mun@intel.com>
References: <20220909105913.752049-1-gwan-gyeong.mun@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __shmem_file_setup() function returns -EINVAL if size is greater than
MAX_LFS_FILESIZE. To handle the same error as other code that returns
-E2BIG when the size is too large, it add a code that returns -E2BIG when
the size is larger than the size that can be handled.

v4: If BITS_PER_LONG is 32, size > MAX_LFS_FILESIZE is always false, so it
    checks only when BITS_PER_LONG is 64.

Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Reviewed-by: Nirmoy Das <nirmoy.das@intel.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index 339b0a9cf2d0..ca30060e34ab 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -541,6 +541,20 @@ static int __create_shmem(struct drm_i915_private *i915,
 
 	drm_gem_private_object_init(&i915->drm, obj, size);
 
+	/* XXX: The __shmem_file_setup() function returns -EINVAL if size is
+	 * greater than MAX_LFS_FILESIZE.
+	 * To handle the same error as other code that returns -E2BIG when
+	 * the size is too large, we add a code that returns -E2BIG when the
+	 * size is larger than the size that can be handled.
+	 * If BITS_PER_LONG is 32, size > MAX_LFS_FILESIZE is always false,
+	 * so we only needs to check when BITS_PER_LONG is 64.
+	 * If BITS_PER_LONG is 32, E2BIG checks are processed when
+	 * i915_gem_object_size_2big() is called before init_object() callback
+	 * is called.
+	 */
+	if (BITS_PER_LONG == 64 && size > MAX_LFS_FILESIZE)
+		return -E2BIG;
+
 	if (i915->mm.gemfs)
 		filp = shmem_file_setup_with_mnt(i915->mm.gemfs, "i915", size,
 						 flags);
-- 
2.37.1

