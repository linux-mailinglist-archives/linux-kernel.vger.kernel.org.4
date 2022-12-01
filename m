Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1705863EED8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 12:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbiLALF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 06:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbiLALEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 06:04:45 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF44AA85ED
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 03:04:38 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id ud5so3336090ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 03:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XaU/omMH3+8RvsiY397Oi1fc3o66/RFALVdNOkAe6vA=;
        b=Bi/QWJSkFQWGeJYobcxt+XbSF/QNjoWybX4BquCD/eV20lCerj08wCTBtZeaLTJyE4
         FI3XHUV0g9541YwfooD6lulPNOsbZiKLyJytDVikhTDjiYieO75v+4bhtlxjdWv/DrBs
         LsZGLol2mDQKkajQ6gmIpbeLuLWPxyn9gE4CJDYE52yImFfsufVqlswtVL7YxmcZIz1I
         ooTBu6CI0rJfaEIIXkpASSZZW/sIAhq/9SODz/74uiNMzshfsY1R5owkrI0IiRPtEfqN
         yJiF1PHxNWwIDCWXdGBkXuN47QMxsljfAoRzh2ueK0Z/Th9B+C5peywoMwI+qyB65vNm
         WYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XaU/omMH3+8RvsiY397Oi1fc3o66/RFALVdNOkAe6vA=;
        b=UbXEmQdPdPz0PciYG4ElpIoOEIIC14ZI7K3H+8sLW/t6RXPyG8jtA8aiSG8fXrK2iK
         k47AS2XacYs3I2RCsTThJlgeMiZYB5uhtS/HVY1EaNPQZJ7ZNeIpqtNhqn53YZSjxJY/
         Wh6KdzlakR5NYVnvSW2g4oEIKHrHSNfqlMS7VGCDk7Los3BpwBVovlyOLBqjffc5gHB4
         ahqnbizvvzGLe2t1apNDvbTJdU9ZYdRMRpyTSXpThmnYbtdzgycfd0mb9GkaUYAy4bs1
         /aOAw12+sUdkUqf/S/4n7k28FbMB2p2gxBVPv2Txxl7l8LICTKFvPfYqkqzYK3RegHzO
         /hBw==
X-Gm-Message-State: ANoB5pkQdwfdFcENFJzvJvIpAyzUeXqjZ3d5Z+b1ZvfnbjHlrn6cAHwZ
        IL09QbmVobP7MaLZ00tSVIYDBA==
X-Google-Smtp-Source: AA0mqf6Hj4VoKYt6iEazle5k5ingyGDgJwTpcIAaHK73x/WNAMPoaZuP/ZVDmBX41MH4I0Z8N2D6fA==
X-Received: by 2002:a17:907:206c:b0:7be:492d:2344 with SMTP id qp12-20020a170907206c00b007be492d2344mr19710596ejb.585.1669892677429;
        Thu, 01 Dec 2022 03:04:37 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id f26-20020a056402161a00b00463a83ce063sm1576424edv.96.2022.12.01.03.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 03:04:36 -0800 (PST)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH 2/5] drbd: split polymorph printk to its own file
Date:   Thu,  1 Dec 2022 12:03:47 +0100
Message-Id: <20221201110349.1282687-3-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221201110349.1282687-1-christoph.boehmwalder@linbit.com>
References: <20221201110349.1282687-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_int.h              | 68 +-------------------
 drivers/block/drbd/drbd_polymorph_printk.h | 72 ++++++++++++++++++++++
 2 files changed, 73 insertions(+), 67 deletions(-)
 create mode 100644 drivers/block/drbd/drbd_polymorph_printk.h

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index ea92df778c66..1734a7f8a096 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -37,6 +37,7 @@
 #include "drbd_strings.h"
 #include "drbd_state.h"
 #include "drbd_protocol.h"
+#include "drbd_polymorph_printk.h"
 
 #ifdef __CHECKER__
 # define __protected_by(x)       __attribute__((require_context(x,1,999,"rdwr")))
@@ -75,73 +76,6 @@ extern int drbd_proc_details;
 struct drbd_device;
 struct drbd_connection;
 
-#define __drbd_printk_device(level, device, fmt, args...) \
-	dev_printk(level, disk_to_dev((device)->vdisk), fmt, ## args)
-#define __drbd_printk_peer_device(level, peer_device, fmt, args...) \
-	dev_printk(level, disk_to_dev((peer_device)->device->vdisk), fmt, ## args)
-#define __drbd_printk_resource(level, resource, fmt, args...) \
-	printk(level "drbd %s: " fmt, (resource)->name, ## args)
-#define __drbd_printk_connection(level, connection, fmt, args...) \
-	printk(level "drbd %s: " fmt, (connection)->resource->name, ## args)
-
-void drbd_printk_with_wrong_object_type(void);
-
-#define __drbd_printk_if_same_type(obj, type, func, level, fmt, args...) \
-	(__builtin_types_compatible_p(typeof(obj), type) || \
-	 __builtin_types_compatible_p(typeof(obj), const type)), \
-	func(level, (const type)(obj), fmt, ## args)
-
-#define drbd_printk(level, obj, fmt, args...) \
-	__builtin_choose_expr( \
-	  __drbd_printk_if_same_type(obj, struct drbd_device *, \
-			     __drbd_printk_device, level, fmt, ## args), \
-	  __builtin_choose_expr( \
-	    __drbd_printk_if_same_type(obj, struct drbd_resource *, \
-			       __drbd_printk_resource, level, fmt, ## args), \
-	    __builtin_choose_expr( \
-	      __drbd_printk_if_same_type(obj, struct drbd_connection *, \
-				 __drbd_printk_connection, level, fmt, ## args), \
-	      __builtin_choose_expr( \
-		__drbd_printk_if_same_type(obj, struct drbd_peer_device *, \
-				 __drbd_printk_peer_device, level, fmt, ## args), \
-		drbd_printk_with_wrong_object_type()))))
-
-#define drbd_dbg(obj, fmt, args...) \
-	drbd_printk(KERN_DEBUG, obj, fmt, ## args)
-#define drbd_alert(obj, fmt, args...) \
-	drbd_printk(KERN_ALERT, obj, fmt, ## args)
-#define drbd_err(obj, fmt, args...) \
-	drbd_printk(KERN_ERR, obj, fmt, ## args)
-#define drbd_warn(obj, fmt, args...) \
-	drbd_printk(KERN_WARNING, obj, fmt, ## args)
-#define drbd_info(obj, fmt, args...) \
-	drbd_printk(KERN_INFO, obj, fmt, ## args)
-#define drbd_emerg(obj, fmt, args...) \
-	drbd_printk(KERN_EMERG, obj, fmt, ## args)
-
-#define dynamic_drbd_dbg(device, fmt, args...) \
-	dynamic_dev_dbg(disk_to_dev(device->vdisk), fmt, ## args)
-
-#define D_ASSERT(x, exp)							\
-	do {									\
-		if (!(exp))							\
-			drbd_err(x, "ASSERTION %s FAILED in %s\n",		\
-				 #exp, __func__);				\
-	} while (0)
-
-/**
- * expect  -  Make an assertion
- *
- * Unlike the assert macro, this macro returns a boolean result.
- */
-#define expect(exp) ({								\
-		bool _bool = (exp);						\
-		if (!_bool)							\
-			drbd_err(device, "ASSERTION %s FAILED in %s\n",		\
-			        #exp, __func__);				\
-		_bool;								\
-		})
-
 /* Defines to control fault insertion */
 enum {
 	DRBD_FAULT_MD_WR = 0,	/* meta data write */
diff --git a/drivers/block/drbd/drbd_polymorph_printk.h b/drivers/block/drbd/drbd_polymorph_printk.h
new file mode 100644
index 000000000000..13cc1b311e16
--- /dev/null
+++ b/drivers/block/drbd/drbd_polymorph_printk.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef DRBD_POLYMORPH_PRINTK_H
+#define DRBD_POLYMORPH_PRINTK_H
+
+#define __drbd_printk_device(level, device, fmt, args...) \
+	dev_printk(level, disk_to_dev((device)->vdisk), fmt, ## args)
+#define __drbd_printk_peer_device(level, peer_device, fmt, args...) \
+	dev_printk(level, disk_to_dev((peer_device)->device->vdisk), fmt, ## args)
+#define __drbd_printk_resource(level, resource, fmt, args...) \
+	printk(level "drbd %s: " fmt, (resource)->name, ## args)
+#define __drbd_printk_connection(level, connection, fmt, args...) \
+	printk(level "drbd %s: " fmt, (connection)->resource->name, ## args)
+
+void drbd_printk_with_wrong_object_type(void);
+
+#define __drbd_printk_if_same_type(obj, type, func, level, fmt, args...) \
+	(__builtin_types_compatible_p(typeof(obj), type) || \
+	 __builtin_types_compatible_p(typeof(obj), const type)), \
+	func(level, (const type)(obj), fmt, ## args)
+
+#define drbd_printk(level, obj, fmt, args...) \
+	__builtin_choose_expr( \
+	  __drbd_printk_if_same_type(obj, struct drbd_device *, \
+			     __drbd_printk_device, level, fmt, ## args), \
+	  __builtin_choose_expr( \
+	    __drbd_printk_if_same_type(obj, struct drbd_resource *, \
+			       __drbd_printk_resource, level, fmt, ## args), \
+	    __builtin_choose_expr( \
+	      __drbd_printk_if_same_type(obj, struct drbd_connection *, \
+				 __drbd_printk_connection, level, fmt, ## args), \
+	      __builtin_choose_expr( \
+		__drbd_printk_if_same_type(obj, struct drbd_peer_device *, \
+				 __drbd_printk_peer_device, level, fmt, ## args), \
+		drbd_printk_with_wrong_object_type()))))
+
+#define drbd_dbg(obj, fmt, args...) \
+	drbd_printk(KERN_DEBUG, obj, fmt, ## args)
+#define drbd_alert(obj, fmt, args...) \
+	drbd_printk(KERN_ALERT, obj, fmt, ## args)
+#define drbd_err(obj, fmt, args...) \
+	drbd_printk(KERN_ERR, obj, fmt, ## args)
+#define drbd_warn(obj, fmt, args...) \
+	drbd_printk(KERN_WARNING, obj, fmt, ## args)
+#define drbd_info(obj, fmt, args...) \
+	drbd_printk(KERN_INFO, obj, fmt, ## args)
+#define drbd_emerg(obj, fmt, args...) \
+	drbd_printk(KERN_EMERG, obj, fmt, ## args)
+
+#define dynamic_drbd_dbg(device, fmt, args...) \
+	dynamic_dev_dbg(disk_to_dev(device->vdisk), fmt, ## args)
+
+#define D_ASSERT(x, exp)							\
+	do {									\
+		if (!(exp))							\
+			drbd_err(x, "ASSERTION %s FAILED in %s\n",		\
+				#exp, __func__);				\
+	} while (0)
+
+/**
+ * expect  -  Make an assertion
+ *
+ * Unlike the assert macro, this macro returns a boolean result.
+ */
+#define expect(exp) ({								\
+		bool _bool = (exp);						\
+		if (!_bool)							\
+			drbd_err(device, "ASSERTION %s FAILED in %s\n",		\
+			        #exp, __func__);				\
+		_bool;								\
+		})
+
+#endif
-- 
2.38.1

