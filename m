Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3118C66A362
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 20:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjAMTct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 14:32:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjAMTbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 14:31:06 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED237D1D7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:31:00 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id m15so11250104ilq.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwY51vCw5d2KWkq9unQZFSxtB1BKyvHEDbc8ZQVYmz0=;
        b=CxnhZR5Y4ZqJM1g634VwuFdLi5atSc7D5VIBKBW4dLrTEiW4v7UroCjNzfjavsTB6l
         czTKGH/1v/EQ4SPhDpqRz3aXY/1yQyiIf0yzIQ0ufjpJ5SU++Qo0pB1XlJS1iu49H7aO
         JHgVBJlPWzjp4+bvJxR9fIRii0Gs4XI4Zo0bUf06hwsH0rcNREFeup9n0mHKJwLTUDlF
         j8lC5BrgL1iXoAMypRD80MVctJKsGsdsR4KplNoM7d/1WsIz8LbIVS0OgTKNyRuDMX49
         C/dyfePZmrS56rgdN3I51NH9pjQVxpPbavtNokoj2eTPuzhSUqVYpYAlbdIKZ+IS5pkA
         Q4Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lwY51vCw5d2KWkq9unQZFSxtB1BKyvHEDbc8ZQVYmz0=;
        b=QepgC+SRy2U3RGParL1W/7MAItd+0nSlinbPoMQDoityq6ZSojffN/CJoswSBnLxx5
         HE3Nlygnoiu8j9O06JBGJqKTQfX6h4c0uKZtLF2ykvhiAmV9wKBWcYR2nAwdKe5Fnmw5
         C08eV45Kzl8nH96jvRBuPi4vj/N7DznMYRO+Tbu0XMoQQjBz9JiY3s+gB2Q+qmha9ZCm
         YrQn1HtbmfFNiGhUHZ5Hq+BU0CiGRQSVBmeCGW70+7lxZifnx2PNEL+o+lrlBISuft/n
         GAgCsHJcTijcISf0/Og3fWUWVuEDTSGwgJDnfoGPEeu6MkrUnuS9YmfaWOKIr11i10Y6
         aCFg==
X-Gm-Message-State: AFqh2kqNHNJhCKqBJ+XNngv6BjGnk7an/tIf3z26jHQ+veTIl5gl0/Gv
        q/uX7d278HoQQUMsjPxPkTsth7YpAycyxA==
X-Google-Smtp-Source: AMrXdXuepQxNSSHHm82kCfNKgO7OiaA997T8L5znxd8j+HTMb8MJP9lC3JyWYsL9Fkv+3uS13K2KjQ==
X-Received: by 2002:a92:c6d0:0:b0:303:9287:3af7 with SMTP id v16-20020a92c6d0000000b0030392873af7mr60731571ilm.4.1673638260085;
        Fri, 13 Jan 2023 11:31:00 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e32-20020a026d60000000b0039e583abceasm6497289jaf.68.2023.01.13.11.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 11:30:59 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jani.nikula@intel.com, ville.syrjala@linux.intel.com,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        jbaron@akamai.com, gregkh@linuxfoundation.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 16/20] test-dyndbg: rename DD_SYS_WRAP to DYNDBG_CLASSMAP_PARAM
Date:   Fri, 13 Jan 2023 12:30:12 -0700
Message-Id: <20230113193016.749791-17-jim.cromie@gmail.com>
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
index 39d4f63cade1..45e123b29a9b 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -44,14 +44,15 @@ module_param_cb(do_prints, &param_ops_do_prints, NULL, 0600);
  * Additionally, here:
  * - tie together sysname, mapname, bitsname, flagsname
  */
-#define DD_SYS_WRAP(_model, _flags)					\
+#define DYNDBG_CLASSMAP_PARAM(_model, _flags)					\
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
  * dynamic-debug imitates drm.debug model's use of enums (DRM_UT_CORE
@@ -112,23 +113,23 @@ DYNDBG_CLASSMAP_DEFINE(map_disjoint_bits, DD_CLASS_TYPE_DISJOINT_BITS,
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
2.39.0

