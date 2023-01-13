Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEDA766A345
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 20:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjAMTbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 14:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjAMTar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 14:30:47 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A991387F01
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:30:46 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id x6so6615431ill.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qWKFQeFAxn+ZOh646ePMJ4LTdlatpOHry6TwdNzo/6o=;
        b=WEB/QiC1kblSr7YALV/jSJKcpvQyT+QwF75uAuHFqKiFVyfrr6ULMAMYbydn11q3hm
         TAy34JZjMpq5xguKevoGRXkAuvU0F7UTUG0c6x8jkt6c5c4vrpeTkKwPEvCTxVCj++12
         F8o0rMCsqW6UZmU9HA5CAloAMNJXcKTmpne50mvxlHK6xfXOha/3NpcP/f0rdQzu5TPX
         TndCaBh4jJFy0SYsicMpVbhCxxv+/r0JXKJtlujyFx7bZYUv//inVAhg7ex/x+gpwC/7
         pfuN+ZCYJs4oitXOS1/lfZpiOfrD43+loQU0KYn2TlORbhuNuSBa7zQ29IjB6U1OCsG6
         XM/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qWKFQeFAxn+ZOh646ePMJ4LTdlatpOHry6TwdNzo/6o=;
        b=N1Cu4HuP788WgtXWPJetnGhy3WSz6XOTRLgIQIuVLpbT/vFOxNbj8GqcK5BwoOJApj
         JtLzI0Jh7dcwgAOkzF/c1Egv68LqSQe8tLSWNrgdOIddauz3a3ajUCcerUDObxFl+KIO
         FSDXwrJyth81KyCSxVRJW4hWh8V0dopsf5Bj6u18dVY19Rvdo6ssL4vvbTbCFQs41r6o
         EFr1neulnwnsnGMxEeMlvXKT/mSkIXkGVBS4XPClNcbLn3nSLEq6vi6YyLfG2GFpdt5o
         sKMNwjgOAP8p7NnpPGTfNS/moFRGC7sCeEJWkfounbmuaHMFXQvs8nkKeezqL2bqBb/b
         dFQg==
X-Gm-Message-State: AFqh2kq8iPQWjsbtVUSDGNJoLliDiH+YMJ/vX9eDOOuygWJptj2ogFn8
        Rj0bBwFw8zuGOXxCpQPrJSdoqdJxeAg6lA==
X-Google-Smtp-Source: AMrXdXuebkiSDHExojLJ+QU/M9dNm59SYuKStqvVl5iBT60SWt95K7DwYqFDv59rrs9RtH0Kkqk27g==
X-Received: by 2002:a92:d186:0:b0:30d:b66e:e4e3 with SMTP id z6-20020a92d186000000b0030db66ee4e3mr10285677ilz.1.1673638246047;
        Fri, 13 Jan 2023 11:30:46 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e32-20020a026d60000000b0039e583abceasm6497289jaf.68.2023.01.13.11.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 11:30:45 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jani.nikula@intel.com, ville.syrjala@linux.intel.com,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        jbaron@akamai.com, gregkh@linuxfoundation.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 04/20] dyndbg: make ddebug_apply_class_bitmap more selective
Date:   Fri, 13 Jan 2023 12:30:00 -0700
Message-Id: <20230113193016.749791-5-jim.cromie@gmail.com>
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

ddebug_apply_class_bitmap() currently applies the class settings to
all modules, by calling ddebug_exec_queries(query, NULL), where NULL
is wildcard ("*" does the same).  Make it more selective, by adding
query_module param, and passing it into ddebug_exec_queries, instead
of the NULL.

This allows its more selective use later; for propagating drm.debug
settings to dependent modules when/just-after they load.  Doing this
propagation with "*" is fine, but would match with all previously
loaded modules, creating more dynamic_debug.verbose=3 logging
activity, and obscuring the actual changes.

No functional change.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---

after `modprobe i915`, heres the module dependencies,
though not all on drm.debug.

bash-5.2# lsmod
Module                  Size  Used by
i915                 3133440  0
drm_buddy              20480  1 i915
ttm                    90112  1 i915
i2c_algo_bit           16384  1 i915
video                  61440  1 i915
wmi                    32768  1 video
drm_display_helper    200704  1 i915
drm_kms_helper        208896  2 drm_display_helper,i915
drm                   606208  5 drm_kms_helper,drm_display_helper,drm_buddy,i915,ttm
cec                    57344  2 drm_display_helper,i915
---
 lib/dynamic_debug.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 823190094350..943e0597ecd4 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -600,7 +600,8 @@ static int ddebug_exec_queries(char *query, const char *modname)
 
 /* apply a new bitmap to the sys-knob's current bit-state */
 static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
-				     unsigned long *new_bits, unsigned long *old_bits)
+				     unsigned long *new_bits, unsigned long *old_bits,
+				     const char *query_modname)
 {
 #define QUERY_SIZE 128
 	char query[QUERY_SIZE];
@@ -608,7 +609,8 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 	int matches = 0;
 	int bi, ct;
 
-	v2pr_info("apply: 0x%lx to: 0x%lx\n", *new_bits, *old_bits);
+	v2pr_info("apply bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits, *old_bits,
+		  query_modname ?: "");
 
 	for (bi = 0; bi < map->length; bi++) {
 		if (test_bit(bi, new_bits) == test_bit(bi, old_bits))
@@ -617,12 +619,15 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 		snprintf(query, QUERY_SIZE, "class %s %c%s", map->class_names[bi],
 			 test_bit(bi, new_bits) ? '+' : '-', dcp->flags);
 
-		ct = ddebug_exec_queries(query, NULL);
+		ct = ddebug_exec_queries(query, query_modname);
 		matches += ct;
 
 		v2pr_info("bit_%d: %d matches on class: %s -> 0x%lx\n", bi,
 			  ct, map->class_names[bi], *new_bits);
 	}
+	v2pr_info("applied bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits, *old_bits,
+		  query_modname ?: "");
+
 	return matches;
 }
 
@@ -678,7 +683,7 @@ static int param_set_dyndbg_classnames(const char *instr, const struct kernel_pa
 				continue;
 			}
 			curr_bits ^= BIT(cls_id);
-			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, dcp->bits);
+			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, dcp->bits, NULL);
 			*dcp->bits = curr_bits;
 			v2pr_info("%s: changed bit %d:%s\n", KP_NAME(kp), cls_id,
 				  map->class_names[cls_id]);
@@ -688,7 +693,7 @@ static int param_set_dyndbg_classnames(const char *instr, const struct kernel_pa
 			old_bits = CLASSMAP_BITMASK(*dcp->lvl);
 			curr_bits = CLASSMAP_BITMASK(cls_id + (wanted ? 1 : 0 ));
 
-			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, &old_bits);
+			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, &old_bits, NULL);
 			*dcp->lvl = (cls_id + (wanted ? 1 : 0));
 			v2pr_info("%s: changed bit-%d: \"%s\" %lx->%lx\n", KP_NAME(kp), cls_id,
 				  map->class_names[cls_id], old_bits, curr_bits);
@@ -751,7 +756,7 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
 			inrep &= CLASSMAP_BITMASK(map->length);
 		}
 		v2pr_info("bits:%lx > %s\n", inrep, KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &inrep, dcp->bits);
+		totct += ddebug_apply_class_bitmap(dcp, &inrep, dcp->bits, NULL);
 		*dcp->bits = inrep;
 		break;
 	case DD_CLASS_TYPE_LEVEL_NUM:
@@ -764,7 +769,7 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
 		old_bits = CLASSMAP_BITMASK(*dcp->lvl);
 		new_bits = CLASSMAP_BITMASK(inrep);
 		v2pr_info("lvl:%ld bits:0x%lx > %s\n", inrep, new_bits, KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits);
+		totct += ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits, NULL);
 		*dcp->lvl = inrep;
 		break;
 	default:
-- 
2.39.0

