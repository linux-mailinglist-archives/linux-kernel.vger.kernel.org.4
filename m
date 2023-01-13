Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442A666A364
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 20:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjAMTc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 14:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjAMTbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 14:31:08 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FCC7D242
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:31:03 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id j1so2654675iob.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=laxP0cqPnvjzU/NVL1/q3C0zcn02Ez3sXy575b6QzqM=;
        b=XXSx22eBM6VnY8ejlGtEMdfoZjJ3OiTi64CMb06ipUrdEJmLwhadms05YP+ol2KXV2
         Ddy+diEX5ev4IyecNZvWF7QOGNcUrCK02QBT1Ep2bNonkDZwFIqI3dA/M9I5YNGmpQDK
         V4NnhFoRPOoNBVgkyJ1VDKj2kIuyInF8x09o+O4Omb/O0iO9W92Bh0y+iAI4ieBokskM
         GlZbrqKCuYCQ/RqHLiR90yg2nNAi/XByAO93xN84Jl+PiMrZkmCV5LG0B+HVE7FSSaXA
         HCJ4DjRGMYLRvb/Kzc8M+FrPZaxNf7VGB9950Swjb/4dHy5Mfa6AhiaU92lfRN8yryaf
         nRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=laxP0cqPnvjzU/NVL1/q3C0zcn02Ez3sXy575b6QzqM=;
        b=kbp/OXFYEXHeug/x/KcChDA7kqFGjWn0bS/ACgwrHVoYYAwiFP4ZHTd2zcgKio6ML3
         PI9CRoKZJqRauAEbOoLa2BGPn3AEwH+pwJFhFczFSgFeK/H8EZ+iG3WaBy1Z8FkB/Vbn
         xyJ0AWxj2Z7WThbvNecb+49ZU5eINEfDg7TR3Esfh1L6hD3s+qYd8yzOgIPdL/a9Ky3c
         gasiNbvDLOMe6tGezW5VoV9N2Vd7UdhyrDv3ku+ICCTQ/v5qkA/567LTOeujV9vIp4TY
         OS1Rn3rh63emi3dcdLyAJVO2YNycPAxwQmoJ/RhGQK8/KDfxliBDfYC7Om39wH47FuDF
         s+gQ==
X-Gm-Message-State: AFqh2krVii57W2XjmpDxlERguKoQVQ7M+xc+VmB4DEXw1B1r5ssJnfbZ
        EolfCLEXHoSfDb7JUJGUch4pNfFkBFRm9Q==
X-Google-Smtp-Source: AMrXdXvySgqyyHiwPQgzdqFJMy9XZkUn/CSiJF+4a7KIIBwdYMgf6mxSxnMSXWGNu6PaWP7AR3g3CQ==
X-Received: by 2002:a05:6602:87:b0:704:57c7:e440 with SMTP id h7-20020a056602008700b0070457c7e440mr6700670iob.5.1673638262108;
        Fri, 13 Jan 2023 11:31:02 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e32-20020a026d60000000b0039e583abceasm6497289jaf.68.2023.01.13.11.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 11:31:01 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jani.nikula@intel.com, ville.syrjala@linux.intel.com,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        jbaron@akamai.com, gregkh@linuxfoundation.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 18/20] test-dyndbg: tune sub-module behavior
Date:   Fri, 13 Jan 2023 12:30:14 -0700
Message-Id: <20230113193016.749791-19-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230113193016.749791-1-jim.cromie@gmail.com>
References: <20230113193016.749791-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lib/test_dynamic_debug.c is used to build 2 modules:
test_dynamic_debug.ko and test_dynamic_debug_submod.ko

Define DEBUG only in the main module, not in the submod.  Its purpose
is to insure that prdbgs are enabled by default, so that a modprobe
without params actually logs something, showing that compile-time
enablement works.  This doesn't need to be repeated in the submodule.

Rather, the submodule's purpose is to prove that classmaps defined and
exported from a parent module are propagated to submodules, setting
their class'd debugs accordingly.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/test_dynamic_debug.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index 9e66c5a7e138..94fe3b3438d0 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -6,13 +6,13 @@
  *      Jim Cromie	<jim.cromie@gmail.com>
  */
 
-#if defined(TEST_DYNAMIC_DEBUG_SUBMOD)
-  #define pr_fmt(fmt) "test_dd_submod: " fmt
-#else
+#if !defined(TEST_DYNAMIC_DEBUG_SUBMOD)
   #define pr_fmt(fmt) "test_dd: " fmt
+  #define DEBUG	/* enable all prdbgs (plain & class'd) at compiletime */
+#else
+  #define pr_fmt(fmt) "test_dd_submod: " fmt
 #endif
 
-#define DEBUG /* enable all prdbgs (plain & class'd) at compiletime */
 
 #include <linux/module.h>
 
-- 
2.39.0

