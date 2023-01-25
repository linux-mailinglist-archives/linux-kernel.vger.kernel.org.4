Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3805867BD14
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235858AbjAYUjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236569AbjAYUiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:38:46 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572385E512
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:38:16 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id f8so12705ilj.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVl+HnEN+v0wIxiGTzNKn42qnV5EhpwvJd73YIzQ2wo=;
        b=IMpgUVnDUOYBdwOs7bcqbaDGzsgkMjf4UUiGkvJo+mgk1fMWICHH/gxINumJ6rKM1J
         tVhgMss0X3b9ABU1U73Wt1lfekDkcCVIWmdGNepY5MwtuSq7Kk2NOKNVAdfKwBCckO03
         A8LBZh70TSs4MJZN35D5PBH3jwzwGoOWHBH7bEUDD67yZ3RJAt9WmjOV347nsH9xOU7O
         wLHp3yGxGjPLV/+kr5EPBbr9AM0cQSTQ4c5r0mYz8kWA1XOljmB9FUh9R+rbdMcEZJ/D
         CUkt0NrwJVrJlek1ZavtN3VL/L4MIz2G9J8IjjUNxU27kb8nf17mg78w7vRJCZZfSpH/
         r6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XVl+HnEN+v0wIxiGTzNKn42qnV5EhpwvJd73YIzQ2wo=;
        b=r/6l96qZzbO7fHUTzNt7B5KHoT7szux6wX2T5P+jbLc9XvBkubx7z3VukkjfeaA4AQ
         a8Wzhp7q686LwLQvub23sKCBoM6OLDmwnOj+H/JVXei+bIzV27BCqV+o4gM7sYRDTfrO
         2aIeY+WUbX+35vC+BM+norbvoRycvUes0+RzvV3bKUcQx/v3k/dwg3vQmAVWzMzArflu
         +gr5H4ycXTEVXlJRUAyUeUcUm69UV35qE8grDWPu8OxxVpZ841U6AyzsfxA0lI2KC/dt
         o/PFtoiNOIwp84NekxkxedoPQyHZJ9+V56B393s+WkAlBLC4aKXwkmb7G8TBaB+3F3S+
         GPAA==
X-Gm-Message-State: AFqh2kqGoPFPpf+wao0EV0bMvXDG4sQwR5Sm4U4MLCdl2T9VlGhGepkw
        4Hbuqp+fiqqamjucqxGKKzI74VKqjHE=
X-Google-Smtp-Source: AMrXdXssIhDZ6YkcdjXT6Rn0LjRYjWgQ9PPO1ngV+ocC8+5A0CqhOWrLj9OLnLvXLGAah5Uk5Sl2yQ==
X-Received: by 2002:a92:d48c:0:b0:30e:e8d3:a5ff with SMTP id p12-20020a92d48c000000b0030ee8d3a5ffmr30054140ilg.27.1674679095367;
        Wed, 25 Jan 2023 12:38:15 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id y11-20020a056e02128b00b00310a599fd43sm665104ilq.46.2023.01.25.12.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 12:38:15 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jani.nikula@intel.com, ville.syrjala@linux.intel.com,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v3 17/19] test-dyndbg: disable WIP dyndbg-trace params
Date:   Wed, 25 Jan 2023 13:37:41 -0700
Message-Id: <20230125203743.564009-18-jim.cromie@gmail.com>
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
index ff1e70ae060e..6b7bd35c3e15 100644
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
  * dynamic-debug imitates drm.debug's use of enums (DRM_UT_CORE etc)
  * to define its classes/categories.  dyndbg allows class-id's 0..62,
@@ -115,22 +123,22 @@ DYNDBG_CLASSMAP_DEFINE(map_disjoint_bits, DD_CLASS_TYPE_DISJOINT_BITS,
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
2.39.1

