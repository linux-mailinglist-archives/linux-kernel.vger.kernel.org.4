Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A259667BCCF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236517AbjAYUiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236471AbjAYUiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:38:10 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB4113DD2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:38:03 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id g16so20165ilr.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HRoCN0BIE/LRokbtsolRSKTKnukq0u/TXUOu2z2LhM=;
        b=c2nSWGPCIw0GlohJLWjbaOV/JLwwC3BuyMQoCDhCjopL0mcSu9XOQZcA9ZWW41iOdU
         m2dBXF4DObtB2eyBxWdBs11v+r1ooffrjDwLGx+TxDRKD13nfsLmuUsQX5vvVa4VlvJf
         kC1VsITwfSrzfgAK/qsHBI6TOpJciSPHKLW1Fl7IVPjsx1ntJvutGhqVLG5tfH/aMw3g
         TB41eUq0d6cJ/TuOpyMZCld9gN/sTXfSlJfJlaKv0+KtbD/dP75+bfD+twHrICnIqOyb
         6oUKeAhi0MWGNsDtvP0SsulnvzNup0Y56eJQvYhY2VRMvXWRbSpglUtNz5kRM0Hp6vYs
         cKww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9HRoCN0BIE/LRokbtsolRSKTKnukq0u/TXUOu2z2LhM=;
        b=SOpcoWdbenA/8HCqhAlzsFqGNfDO/hdcMUPdMlmiwcht44wFpwSc2D6iYsy2SOiEvb
         XUPIMvsvvNiqXMxPPWBI0uGzysiuR91tjC5cAXWPnzx781q7Kmr4VWXtNh0EH3MSNVD4
         vcOfl6aqDLdECCn7KN4EoRW9/ar9V5LQeRFEbFLyDeHbCsXHQRJlloFYo7O7F2e2YBbp
         y1s7x8WJ6ubHEP3Db1Z2XMZR0409qjCGF3XYj8kkvH9KI7Ks2VhY0V7t+EWqzlLmPoP7
         nAfxvoUdl9+qwB1FhThIbFdimNPgSDrqiCEaB9zGG757qpWSDc5Lo3kAA3m8AAYwi3K8
         D5Ww==
X-Gm-Message-State: AO0yUKWyxtw+DxvmX3Ha5iOJMtIvKq+MHni0tNTgiqumQTM20sn2sGan
        9IX+Y6qCR53RUztzc2Jn1gwLoMyWG+A=
X-Google-Smtp-Source: AK7set8Zkk8thpQ24RIvB5bW/uJjdwoj2cwGGMNg3TF6cP86ahbLUErdIOkJ7NQNgefPGAZ1bvWiyQ==
X-Received: by 2002:a92:c266:0:b0:310:9c6d:e7dd with SMTP id h6-20020a92c266000000b003109c6de7ddmr4482113ild.28.1674679082783;
        Wed, 25 Jan 2023 12:38:02 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id y11-20020a056e02128b00b00310a599fd43sm665104ilq.46.2023.01.25.12.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 12:38:02 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jani.nikula@intel.com, ville.syrjala@linux.intel.com,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v3 05/19] dyndbg: split param_set_dyndbg_classes to inner/outer fns
Date:   Wed, 25 Jan 2023 13:37:29 -0700
Message-Id: <20230125203743.564009-6-jim.cromie@gmail.com>
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

Inner fn adds mod_name param, allowing caller to guarantee that only
one module is affected by a prdbgs update.  Outer fn preserves
kernel_param interface, passing NULL to inner fn.

no functional change.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 943e0597ecd4..0a5efc735b36 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -707,18 +707,9 @@ static int param_set_dyndbg_classnames(const char *instr, const struct kernel_pa
 	return 0;
 }
 
-/**
- * param_set_dyndbg_classes - class FOO >control
- * @instr: string echo>d to sysfs, input depends on map_type
- * @kp:    kp->arg has state: bits/lvl, map, map_type
- *
- * Enable/disable prdbgs by their class, as given in the arguments to
- * DECLARE_DYNDBG_CLASSMAP.  For LEVEL map-types, enforce relative
- * levels by bitpos.
- *
- * Returns: 0 or <0 if error.
- */
-int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
+static int param_set_dyndbg_module_classes(const char *instr,
+					   const struct kernel_param *kp,
+					   const char *modnm)
 {
 	const struct ddebug_class_param *dcp = kp->arg;
 	const struct ddebug_class_map *map = dcp->map;
@@ -755,8 +746,8 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
 				KP_NAME(kp), inrep, CLASSMAP_BITMASK(map->length));
 			inrep &= CLASSMAP_BITMASK(map->length);
 		}
-		v2pr_info("bits:%lx > %s\n", inrep, KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &inrep, dcp->bits, NULL);
+		v2pr_info("bits:0x%lx > %s.%s\n", inrep, modnm ?: "*", KP_NAME(kp));
+		totct += ddebug_apply_class_bitmap(dcp, &inrep, dcp->bits, modnm);
 		*dcp->bits = inrep;
 		break;
 	case DD_CLASS_TYPE_LEVEL_NUM:
@@ -769,7 +760,7 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
 		old_bits = CLASSMAP_BITMASK(*dcp->lvl);
 		new_bits = CLASSMAP_BITMASK(inrep);
 		v2pr_info("lvl:%ld bits:0x%lx > %s\n", inrep, new_bits, KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits, NULL);
+		totct += ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits, modnm);
 		*dcp->lvl = inrep;
 		break;
 	default:
@@ -778,6 +769,21 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
 	vpr_info("%s: total matches: %d\n", KP_NAME(kp), totct);
 	return 0;
 }
+/**
+ * param_set_dyndbg_classes - class FOO >control
+ * @instr: string echo>d to sysfs, input depends on map_type
+ * @kp:    kp->arg has state: bits/lvl, map, map_type
+ *
+ * Enable/disable prdbgs by their class, as given in the arguments to
+ * DECLARE_DYNDBG_CLASSMAP.  For LEVEL map-types, enforce relative
+ * levels by bitpos.
+ *
+ * Returns: 0 or <0 if error.
+ */
+int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
+{
+	return param_set_dyndbg_module_classes(instr, kp, NULL);
+}
 EXPORT_SYMBOL(param_set_dyndbg_classes);
 
 /**
-- 
2.39.1

