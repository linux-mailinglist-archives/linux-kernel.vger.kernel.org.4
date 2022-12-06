Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C563643A09
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 01:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbiLFAf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 19:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbiLFAfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 19:35:04 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F511F63D
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 16:35:03 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id q13so5870330ild.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 16:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJ568tMl5tu5GTE254ozTUCkh3Xs8QKiXFoO4fr9GPo=;
        b=S5xze5Qr4aVFfNaIp9n0Swc94hLL0LEmKhMidEUkXblMa/8Uy8+lhT8dddD1FJ8D/4
         CXu7qBUEbKmerjRAlIhEEr3EuIiqC/mCHDQjIL5H/pEbo1gT3G/z2rz783ZhLF0faJfO
         OqB+46kVsilfxhw7BzPXvaxYABpkWdYxV/S00HZipC68RseXmYFuK7zSMaHFfgx69wd2
         H5qbM11zVLS/5XkYCtHh8jd3Hkpx5A24MikwFVS9ShGLESIitDL3wM6DDbTPCt7fesGE
         9GsK5m6e0BeI4Dh8wH6x2QHQCk2LmF2trfSIK+jHWcvEx9auoqG7YjJUffM2/snWxrr1
         IPHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UJ568tMl5tu5GTE254ozTUCkh3Xs8QKiXFoO4fr9GPo=;
        b=nyU1v1pAEedsGZrSloxVqWjYckJAmlJ5girePcZ1MaLUyygy/an6ZJE4v3gzqRMVu1
         Nd7IuKz7ox8PWJaoq5Iou6tQeDjpsaqPh6iZdNCXDBxRZXlUdOsUomsUCxEtXX3Mz5AK
         CCvDw90oks4pFIwqjSSnkZ4WGNyYpUlfS3Gu/R9Gfq+1Zti1ZWqOifbppbgFmdUp2YKY
         Nl68FQKayUqgT10LP/2vURMkAQd/sohnGaCU/AtlhcRzgohQWXg719iVLvMbNDxRWS/9
         LD00r78OH+q1zB7/PB2jGfgqGhKzwzve7nULNWFeVjRV9Zmr/FUptBZLhxu1ho5ljFiu
         4jOA==
X-Gm-Message-State: ANoB5pkmjGnyWoT8Bdozb3lvdxyIFAfrzwRqwxE7kVQ3j4cozmfD0psk
        wTTPdB/VXp8VrA2RuW+anpwkqwAjvSuOaw==
X-Google-Smtp-Source: AA0mqf6y7DvBAOkp57mDG3lb4KX/SQveVZ24T6Go4CBWw85oDVco5kbfCcSoL1T21j7E7L1yLambYg==
X-Received: by 2002:a05:6e02:caf:b0:303:325d:2a61 with SMTP id 15-20020a056e020caf00b00303325d2a61mr10420156ilg.146.1670286902144;
        Mon, 05 Dec 2022 16:35:02 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id x3-20020a056602160300b006bba42f7822sm6408213iow.52.2022.12.05.16.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 16:35:01 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jani.nikula@intel.com, ville.syrjala@linux.intel.com,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        jbaron@akamai.com, gregkh@linuxfoundation.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH 05/17] dyndbg: make ddebug_apply_class_bitmap more selective
Date:   Mon,  5 Dec 2022 17:34:12 -0700
Message-Id: <20221206003424.592078-6-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221206003424.592078-1-jim.cromie@gmail.com>
References: <20221206003424.592078-1-jim.cromie@gmail.com>
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
all modules, make it more selective, by adding query_module param.

The fn now calls ddebug_exec_queries(query, NULL), where NULL is
query_modname wildcard ("*" does the same).  So just expose the
parameter, and alter users to explicitly pass the wildcard value.

This allows its more selective use later; for propagating drm.debug
settings to dependent modules when/just-after they load.  Doing this
propagation with "*" is fine, but would match with all previously
loaded modules, creating more dynamic_debug.verbose=3 logging
activity.

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
 lib/dynamic_debug.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index fd5296dbb40f..5d609ff0d559 100644
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
@@ -617,7 +618,7 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 		snprintf(query, QUERY_SIZE, "class %s %c%s", map->class_names[bi],
 			 test_bit(bi, new_bits) ? '+' : '-', dcp->flags);
 
-		ct = ddebug_exec_queries(query, NULL);
+		ct = ddebug_exec_queries(query, query_modname);
 		matches += ct;
 
 		v2pr_info("bit_%d: %d matches on class: %s -> 0x%lx\n", bi,
@@ -678,7 +679,7 @@ static int param_set_dyndbg_classnames(const char *instr, const struct kernel_pa
 				continue;
 			}
 			curr_bits ^= BIT(cls_id);
-			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, dcp->bits);
+			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, dcp->bits, NULL);
 			*dcp->bits = curr_bits;
 			v2pr_info("%s: changed bit %d:%s\n", KP_NAME(kp), cls_id,
 				  map->class_names[cls_id]);
@@ -688,7 +689,7 @@ static int param_set_dyndbg_classnames(const char *instr, const struct kernel_pa
 			old_bits = CLASSMAP_BITMASK(*dcp->lvl);
 			curr_bits = CLASSMAP_BITMASK(cls_id + (wanted ? 1 : 0 ));
 
-			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, &old_bits);
+			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, &old_bits, NULL);
 			*dcp->lvl = (cls_id + (wanted ? 1 : 0));
 			v2pr_info("%s: changed bit-%d: \"%s\" %lx->%lx\n", KP_NAME(kp), cls_id,
 				  map->class_names[cls_id], old_bits, curr_bits);
@@ -751,7 +752,7 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
 			inrep &= CLASSMAP_BITMASK(map->length);
 		}
 		v2pr_info("bits:%lx > %s\n", inrep, KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &inrep, dcp->bits);
+		totct += ddebug_apply_class_bitmap(dcp, &inrep, dcp->bits, NULL);
 		*dcp->bits = inrep;
 		break;
 	case DD_CLASS_TYPE_LEVEL_NUM:
@@ -764,7 +765,7 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
 		old_bits = CLASSMAP_BITMASK(*dcp->lvl);
 		new_bits = CLASSMAP_BITMASK(inrep);
 		v2pr_info("lvl:%ld bits:0x%lx > %s\n", inrep, new_bits, KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits);
+		totct += ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits, NULL);
 		*dcp->lvl = inrep;
 		break;
 	default:
-- 
2.38.1

