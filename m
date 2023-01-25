Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC7E67BD13
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236571AbjAYUjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236561AbjAYUig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:38:36 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BEF5CFEE
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:38:15 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id g15so17021ild.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovP7PFmgMqyQc9NY9GDFYVGSSu2k59LVEuwQJZ5PPI4=;
        b=MMDswgzXpzaUDYApMdu+BtPWTHUd/wN+emcwjG+zcUIdFl9SiOVeZ86yWHDOgABF/d
         GgL0K10meMOXrPXZugi33rB0CtZFjqvcrbWSnqK8M6z+/HUN78Xh5S1PWDIL1vrL2udJ
         Dd5mLXA7JkpNQFLk16uBcDB10VNfjdPPPjqTYszPdiL+mTYEfT0Qm5mXsPaK7g7e5qOG
         cWw/j65HAUXZ0GZ222r+iRyZnjSD8xml81LbgevL2o1uQQy8VPGDbdsU12HTVw5sgA1O
         TprOL59rGZSJFyx5ej5HDyk80fLvFLSV8W6VCeBAvG8FDc5tfeJ4vhjy1WG0c0Z0Y5Bs
         z2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ovP7PFmgMqyQc9NY9GDFYVGSSu2k59LVEuwQJZ5PPI4=;
        b=GjGbfMbzHEF+xrW+qF5UJ6O5ohxStzFMC2dfPvP6pA7/u3KUFGoHsC4AihPAGik/a9
         fhdX6SIU3fTNyX/LAm8sSs33wQlDj5aw3p3/6Jv5w0P43yHw8CEm1cTAmy5OyFvNzo+W
         5PG2Upjwr0LnSA+W7kwjTzoppitKvnr0d8ArGei5Rhs0Tqg+IyEzU64yBUTG0SlqEXS/
         MSge1RNnHh1ZIeBYrTr/FXGQbm2EtSeEyVOBV4HkfZWOrwVFFBlsmEGIE8BBitzUUEei
         hr2nrpJkXzDFOwMhU4LkSP71jbQp9Wih7ZFlXczpEZALoRyD1bFV0IXpO72pMBZy+g40
         eK+g==
X-Gm-Message-State: AFqh2kr9sBxkFq/5EYkpisPBb/u3DxgoP7r8akFOPHv6wmbWJpZoRFWN
        UgiuPwQ7zdFhXcPBraCzXWjCY5aS5AI=
X-Google-Smtp-Source: AMrXdXuGRJJhY6PgU4R2atsAMxDJdEEymErRS55yv/fMGBzNaylMz260TGjuYbSnbFCDSzzjc5R4tg==
X-Received: by 2002:a92:503:0:b0:30d:b40b:6e4 with SMTP id q3-20020a920503000000b0030db40b06e4mr23273807ile.31.1674679094482;
        Wed, 25 Jan 2023 12:38:14 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id y11-20020a056e02128b00b00310a599fd43sm665104ilq.46.2023.01.25.12.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 12:38:14 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jani.nikula@intel.com, ville.syrjala@linux.intel.com,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v3 16/19] test-dyndbg: rename DD_SYS_WRAP to DYNDBG_CLASSMAP_PARAM
Date:   Wed, 25 Jan 2023 13:37:40 -0700
Message-Id: <20230125203743.564009-17-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230125203743.564009-1-jim.cromie@gmail.com>
References: <20230125203743.564009-1-jim.cromie@gmail.com>
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

Original name was a punt; but the macro is maybe general enough to put
in the API later.  Rename and improve the macro towards that end.

Also tweak internal name constructed in the macro, to add a '_'
between the name components.  This changes the .i file only.

no functional change.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/test_dynamic_debug.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index 8c005c17f2db..ff1e70ae060e 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -44,14 +44,15 @@ module_param_cb(do_prints, &param_ops_do_prints, NULL, 0600);
  * Additionally, here:
  * - tie together sysname, mapname, bitsname, flagsname
  */
-#define DD_SYS_WRAP(_model, _flags)					\
+#define DYNDBG_CLASSMAP_PARAM(_model, _flags)				\
 	static unsigned long bits_##_model;				\
-	static struct ddebug_class_param _flags##_model = {		\
+	static struct ddebug_class_param _flags##_##_model = {		\
 		.bits = &bits_##_model,					\
 		.flags = #_flags,					\
 		.map = &map_##_model,					\
 	};								\
-	module_param_cb(_flags##_##_model, &param_ops_dyndbg_classes, &_flags##_model, 0600)
+	module_param_cb(_flags##_##_model, &param_ops_dyndbg_classes,	\
+			&_flags##_##_model, 0600)
 
 /*
  * dynamic-debug imitates drm.debug's use of enums (DRM_UT_CORE etc)
@@ -113,23 +114,23 @@ DYNDBG_CLASSMAP_DEFINE(map_disjoint_bits, DD_CLASS_TYPE_DISJOINT_BITS,
 		       D2_LEASE,
 		       D2_DP,
 		       D2_DRMRES);
-DD_SYS_WRAP(disjoint_bits, p);
-DD_SYS_WRAP(disjoint_bits, T);
+DYNDBG_CLASSMAP_PARAM(disjoint_bits, p);
+DYNDBG_CLASSMAP_PARAM(disjoint_bits, T);
 
 DYNDBG_CLASSMAP_DEFINE(map_disjoint_names, DD_CLASS_TYPE_DISJOINT_NAMES,
 		       LOW, MID, HI);
-DD_SYS_WRAP(disjoint_names, p);
-DD_SYS_WRAP(disjoint_names, T);
+DYNDBG_CLASSMAP_PARAM(disjoint_names, p);
+DYNDBG_CLASSMAP_PARAM(disjoint_names, T);
 
 DYNDBG_CLASSMAP_DEFINE(map_level_num, DD_CLASS_TYPE_LEVEL_NUM,
 		       V0, V1, V2, V3, V4, V5, V6, V7);
-DD_SYS_WRAP(level_num, p);
-DD_SYS_WRAP(level_num, T);
+DYNDBG_CLASSMAP_PARAM(level_num, p);
+DYNDBG_CLASSMAP_PARAM(level_num, T);
 
 DYNDBG_CLASSMAP_DEFINE(map_level_names, DD_CLASS_TYPE_LEVEL_NAMES,
 		       L0, L1, L2, L3, L4, L5, L6, L7);
-DD_SYS_WRAP(level_names, p);
-DD_SYS_WRAP(level_names, T);
+DYNDBG_CLASSMAP_PARAM(level_names, p);
+DYNDBG_CLASSMAP_PARAM(level_names, T);
 
 #endif /* TEST_DYNAMIC_DEBUG_SUBMOD */
 
-- 
2.39.1

