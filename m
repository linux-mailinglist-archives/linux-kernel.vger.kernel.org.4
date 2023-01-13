Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858BC66A363
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 20:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjAMTcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 14:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjAMTbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 14:31:07 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32B77D1F8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:31:01 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id u8so11259521ilg.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sXtZaooZ45JiB4b6dTyLmd0EG5FQixGlgDB25zw6+E4=;
        b=WilaoJVI3YuxchGiCcrK3zBv9B+yXVCKf7HtcgZ7GEGn+bZVJADzIBemXqTfws+FsU
         yX8BOLN/2Y9uvpkAW/0tHxItxH2t9f54BIJMd+bEO4h/I2ShfDrNsf4bgbeVJOLta0T5
         4iKxs16V2MhWJf90+7+ewR6vNwB9maVvQRPiVPq3wH0AwkKr8AJnu9nsNWYwAqNBHWA1
         Wsa39pOO57OQlA4skLoav1ADNWoWY0ibbAT2U5FGEBLefrVCFDZIweFkd5Bkh7gnq7qt
         zOKnwm4MMk8U4BIEPj2fIEKFaO5X3YBs6lmZf9S5iGIUwZFsocRElG6WlWFvXLXNCuCW
         VPSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sXtZaooZ45JiB4b6dTyLmd0EG5FQixGlgDB25zw6+E4=;
        b=Pq49j26AF/VDFiaq1iMEh08vmf/l6GpYM6ue/PBjXnms4wW2+4jIZdDOQrc1rHVO3z
         sFUNB3RXngNuXn3DSKEAGQOwGSb4YCtAwwhI3Rb5437pxx4wNW2yK+OgZ1IXN+pwCl9Y
         iK/obQesvKRL7dMyLt37aFblacutKZW0YiUt3U9NxD7nuMKe0qF98TZWcyNgPm1iiqGq
         lLUmct8SSCxAxxJ500mYBpockx1FpAgX39HWSPndhC+cszETcN8xiD0rtnyHlnUvbnb3
         SFv6Dmj3ovMIrZQNYlcSPXFmfVJ5kNJ0uELLg8QaRV7ypYxHCyDZqHE4vbVUm4z49ChF
         oXeQ==
X-Gm-Message-State: AFqh2koo4kZw7VB9iu2ATYQFaIODh27PQ3bD5k86KOoUrnOwmsptIzGt
        vJ5CrsCxUZoaERyIctPjgZWJq0J5fchl2w==
X-Google-Smtp-Source: AMrXdXsrMaDJ+qnbKaUj7ZlrxW3dvJ4frh8HAEVmIwYKqJASSo9Im4/1fW4l0and/BelKRWmXYmbfw==
X-Received: by 2002:a92:d8cb:0:b0:30e:ebc9:f19d with SMTP id l11-20020a92d8cb000000b0030eebc9f19dmr274283ilo.25.1673638261006;
        Fri, 13 Jan 2023 11:31:01 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e32-20020a026d60000000b0039e583abceasm6497289jaf.68.2023.01.13.11.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 11:31:00 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jani.nikula@intel.com, ville.syrjala@linux.intel.com,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        jbaron@akamai.com, gregkh@linuxfoundation.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 17/20] test-dyndbg: disable WIP dyndbg-trace params
Date:   Fri, 13 Jan 2023 12:30:13 -0700
Message-Id: <20230113193016.749791-18-jim.cromie@gmail.com>
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

The dyndbg-to-trace feature is WIP, and not in mainline, so the
presence of the interface to use/test it is unhelpful/confusing.

So define DYNDBG_CLASSMAP_PARAM_T() as DYNDBG_CLASSMAP_PARAM() or
blank, depending upon ifdef DYDBG_TRACE, and update 4 params
controlling the T-flag to use it.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/test_dynamic_debug.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index 45e123b29a9b..9e66c5a7e138 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -54,6 +54,14 @@ module_param_cb(do_prints, &param_ops_do_prints, NULL, 0600);
 	module_param_cb(_flags##_##_model, &param_ops_dyndbg_classes,	\
 			&_flags##_##_model, 0600)
 
+/* TBD */
+#ifdef DYNDBG_TRACE
+#define DYNDBG_CLASSMAP_PARAM_T(_model, _flags)	\
+	DYNDBG_CLASSMAP_PARAM(_model, _flags)
+#else
+#define DYNDBG_CLASSMAP_PARAM_T(_model, _flags)
+#endif
+
 /*
  * dynamic-debug imitates drm.debug model's use of enums (DRM_UT_CORE
  * etc) to define it's classes/categories.  dyndbg allows class-id's
@@ -114,22 +122,22 @@ DYNDBG_CLASSMAP_DEFINE(map_disjoint_bits, DD_CLASS_TYPE_DISJOINT_BITS,
 		       D2_DP,
 		       D2_DRMRES);
 DYNDBG_CLASSMAP_PARAM(disjoint_bits, p);
-DYNDBG_CLASSMAP_PARAM(disjoint_bits, T);
+DYNDBG_CLASSMAP_PARAM_T(disjoint_bits, T);
 
 DYNDBG_CLASSMAP_DEFINE(map_disjoint_names, DD_CLASS_TYPE_DISJOINT_NAMES,
 		       LOW, MID, HI);
 DYNDBG_CLASSMAP_PARAM(disjoint_names, p);
-DYNDBG_CLASSMAP_PARAM(disjoint_names, T);
+DYNDBG_CLASSMAP_PARAM_T(disjoint_names, T);
 
 DYNDBG_CLASSMAP_DEFINE(map_level_num, DD_CLASS_TYPE_LEVEL_NUM,
 		       V0, V1, V2, V3, V4, V5, V6, V7);
 DYNDBG_CLASSMAP_PARAM(level_num, p);
-DYNDBG_CLASSMAP_PARAM(level_num, T);
+DYNDBG_CLASSMAP_PARAM_T(level_num, T);
 
 DYNDBG_CLASSMAP_DEFINE(map_level_names, DD_CLASS_TYPE_LEVEL_NAMES,
 		       L0, L1, L2, L3, L4, L5, L6, L7);
 DYNDBG_CLASSMAP_PARAM(level_names, p);
-DYNDBG_CLASSMAP_PARAM(level_names, T);
+DYNDBG_CLASSMAP_PARAM_T(level_names, T);
 
 #endif /* TEST_DYNAMIC_DEBUG_SUBMOD */
 
-- 
2.39.0

