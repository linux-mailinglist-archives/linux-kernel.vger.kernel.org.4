Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD8D63EEDB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 12:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiLALGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 06:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiLALE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 06:04:58 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6EA2EF73
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 03:04:45 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id gu23so3284081ejb.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 03:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0WAfE8hdL0tzZKi1T6BWiR0fFBWp0nrSqUr8ssQ6oc=;
        b=34Ouz4yrei+9t69KvvxT9OE4cIyQ0P4LIkEfr03kYZs2igX3ARO1y3LZOtgcke7jAg
         p17+JZlm+xNEUt9puEqlYbUrb/kE5rFxzGYYF0c0nbDvc9jh7yoPYxI3KWIHCxs6NwTl
         qkFK9KgMjral0QhhlOLb0DeUBTUeeGD9OTJsbbh0zTsgBpZNeOM9KTEs7jucUaffFeL1
         UdLrlpwQQfkaqFp4Nfl4X4bGKNw4HJ4nQawmHsOTMwgjJ2VBYr9KQ3bjw3/Z3tGmhPFJ
         JD6yZ9qfkU5XjZJrCClSZ+jMq3dlcWl5iYyJZwx7Z5gF7qGRhASbqX/0d7rQ9iqYfPpA
         d5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V0WAfE8hdL0tzZKi1T6BWiR0fFBWp0nrSqUr8ssQ6oc=;
        b=hlbC3lUASOnTdCh+n3svb1WgA50n+TATFr9e9MMSS04Rd5Xdse5u8vLycbiWpcygV9
         FeKToxtJGWwDtfNUTLsKFp8MVZ6THagMWvz6YNDCLY0zJvpqyjmR2I1N8ZIoV9Lqjd1R
         rQHzqnB+y53uYVYkIpP7BFNmj50L95+0zZn3pTfvnniRNTfBI50vjV1y5gKBvpsBvFD5
         jT2c+MvFubWpCC1N+M1cD9eRDFueTiooZqkAylSt7EBhyaymuLkN7ADcgOnqHAQGDsDB
         Gz2UzUUPe+qUFINADW1J1Rv/sfBriPjtmaWfzLbgewM7afv+2LsGmR6t7tca+txBWLcT
         N8TQ==
X-Gm-Message-State: ANoB5pm/WlKtFFE47X4lokNGQ+QAV8zgmKIgkPxym+gU3whDXZR1x6BP
        8/LC+8eXtP+KgsSZHJ05ku7MdybUWv3EVIqj
X-Google-Smtp-Source: AA0mqf5mqXKOCdSBu5pZd2wcPPL+fX/DdvJaIOZuRS03+iY5zLivXponH87Swwbh61ZqTbU4+gXaJQ==
X-Received: by 2002:a17:906:bb06:b0:7ba:708f:2a03 with SMTP id jz6-20020a170906bb0600b007ba708f2a03mr32707279ejb.167.1669892684054;
        Thu, 01 Dec 2022 03:04:44 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id f26-20020a056402161a00b00463a83ce063sm1576424edv.96.2022.12.01.03.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 03:04:43 -0800 (PST)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH 3/5] drbd: introduce dynamic debug
Date:   Thu,  1 Dec 2022 12:03:48 +0100
Message-Id: <20221201110349.1282687-4-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221201110349.1282687-1-christoph.boehmwalder@linbit.com>
References: <20221201110349.1282687-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Incorporate as many out-of-tree changes as possible without changing the
genl API.

Over the years, we restructured this several times, and also changed the
log format.

One breaking change is that DRBD 9 gained "implicit options", like a
connection name. This cannot be replayed here without changing the API,
so save it for later.

Originally-from: Andreas Gruenbacher <agruen@linbit.com>
Originally-from: Philipp Reisner <philipp.reisner@linbit.com>
Originally-from: Lars Ellenberg <lars.ellenberg@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_polymorph_printk.h | 133 +++++++++++++++------
 1 file changed, 97 insertions(+), 36 deletions(-)

diff --git a/drivers/block/drbd/drbd_polymorph_printk.h b/drivers/block/drbd/drbd_polymorph_printk.h
index 13cc1b311e16..46cda9dd9af8 100644
--- a/drivers/block/drbd/drbd_polymorph_printk.h
+++ b/drivers/block/drbd/drbd_polymorph_printk.h
@@ -2,52 +2,113 @@
 #ifndef DRBD_POLYMORPH_PRINTK_H
 #define DRBD_POLYMORPH_PRINTK_H
 
-#define __drbd_printk_device(level, device, fmt, args...) \
-	dev_printk(level, disk_to_dev((device)->vdisk), fmt, ## args)
-#define __drbd_printk_peer_device(level, peer_device, fmt, args...) \
-	dev_printk(level, disk_to_dev((peer_device)->device->vdisk), fmt, ## args)
-#define __drbd_printk_resource(level, resource, fmt, args...) \
-	printk(level "drbd %s: " fmt, (resource)->name, ## args)
-#define __drbd_printk_connection(level, connection, fmt, args...) \
-	printk(level "drbd %s: " fmt, (connection)->resource->name, ## args)
+#if !defined(CONFIG_DYNAMIC_DEBUG)
+#undef DEFINE_DYNAMIC_DEBUG_METADATA
+#undef __dynamic_pr_debug
+#undef DYNAMIC_DEBUG_BRANCH
+#define DEFINE_DYNAMIC_DEBUG_METADATA(D, F) const char *D = F; ((void)D)
+#define __dynamic_pr_debug(D, F, args...) do { (void)(D); if (0) printk(F, ## args); } while (0)
+#define DYNAMIC_DEBUG_BRANCH(D) false
+#endif
+
+
+#define __drbd_printk_drbd_device_prep(device)			\
+	const struct drbd_device *__d = (device);		\
+	const struct drbd_resource *__r = __d->resource
+#define __drbd_printk_drbd_device_fmt(fmt)	"drbd %s/%u drbd%u: " fmt
+#define __drbd_printk_drbd_device_args()	__r->name, __d->vnr, __d->minor
+#define __drbd_printk_drbd_device_unprep()
+
+#define __drbd_printk_drbd_peer_device_prep(peer_device)	\
+	const struct drbd_device *__d;				\
+	const struct drbd_resource *__r;			\
+	__d = (peer_device)->device;				\
+	__r = __d->resource
+#define __drbd_printk_drbd_peer_device_fmt(fmt) \
+	"drbd %s/%u drbd%u: " fmt
+#define __drbd_printk_drbd_peer_device_args() \
+	__r->name, __d->vnr, __d->minor
+#define __drbd_printk_drbd_peer_device_unprep()
+
+#define __drbd_printk_drbd_resource_prep(resource) \
+	const struct drbd_resource *__r = resource
+#define __drbd_printk_drbd_resource_fmt(fmt) "drbd %s: " fmt
+#define __drbd_printk_drbd_resource_args()	__r->name
+#define __drbd_printk_drbd_resource_unprep(resource)
+
+#define __drbd_printk_drbd_connection_prep(connection)		\
+	const struct drbd_connection *__c = (connection);	\
+	const struct drbd_resource *__r = __c->resource
+#define __drbd_printk_drbd_connection_fmt(fmt)			\
+	"drbd %s: " fmt
+#define __drbd_printk_drbd_connection_args()			\
+	__r->name
+#define __drbd_printk_drbd_connection_unprep()
 
 void drbd_printk_with_wrong_object_type(void);
+void drbd_dyn_dbg_with_wrong_object_type(void);
 
-#define __drbd_printk_if_same_type(obj, type, func, level, fmt, args...) \
-	(__builtin_types_compatible_p(typeof(obj), type) || \
-	 __builtin_types_compatible_p(typeof(obj), const type)), \
-	func(level, (const type)(obj), fmt, ## args)
+#define __drbd_printk_choose_cond(obj, struct_name) \
+	(__builtin_types_compatible_p(typeof(obj), struct struct_name *) || \
+	 __builtin_types_compatible_p(typeof(obj), const struct struct_name *))
+#define __drbd_printk_if_same_type(obj, struct_name, level, fmt, args...) \
+	__drbd_printk_choose_cond(obj, struct_name), \
+({ \
+	__drbd_printk_ ## struct_name ## _prep((const struct struct_name *)(obj)); \
+	printk(level __drbd_printk_ ## struct_name ## _fmt(fmt), \
+		__drbd_printk_ ## struct_name ## _args(), ## args); \
+	__drbd_printk_ ## struct_name ## _unprep(); \
+})
 
 #define drbd_printk(level, obj, fmt, args...) \
 	__builtin_choose_expr( \
-	  __drbd_printk_if_same_type(obj, struct drbd_device *, \
-			     __drbd_printk_device, level, fmt, ## args), \
+	  __drbd_printk_if_same_type(obj, drbd_device, level, fmt, ## args), \
 	  __builtin_choose_expr( \
-	    __drbd_printk_if_same_type(obj, struct drbd_resource *, \
-			       __drbd_printk_resource, level, fmt, ## args), \
+	    __drbd_printk_if_same_type(obj, drbd_resource, level, fmt, ## args), \
 	    __builtin_choose_expr( \
-	      __drbd_printk_if_same_type(obj, struct drbd_connection *, \
-				 __drbd_printk_connection, level, fmt, ## args), \
+	      __drbd_printk_if_same_type(obj, drbd_connection, level, fmt, ## args), \
 	      __builtin_choose_expr( \
-		__drbd_printk_if_same_type(obj, struct drbd_peer_device *, \
-				 __drbd_printk_peer_device, level, fmt, ## args), \
+		__drbd_printk_if_same_type(obj, drbd_peer_device, level, fmt, ## args), \
 		drbd_printk_with_wrong_object_type()))))
 
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
+#define __drbd_dyn_dbg_if_same_type(obj, struct_name, fmt, args...) \
+	__drbd_printk_choose_cond(obj, struct_name), \
+({ \
+	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);		\
+	if (DYNAMIC_DEBUG_BRANCH(descriptor)) {			\
+		__drbd_printk_ ## struct_name ## _prep((const struct struct_name *)(obj)); \
+		__dynamic_pr_debug(&descriptor, __drbd_printk_ ## struct_name ## _fmt(fmt), \
+			__drbd_printk_ ## struct_name ## _args(), ## args); \
+		__drbd_printk_ ## struct_name ## _unprep();	\
+	}							\
+})
+
+#define dynamic_drbd_dbg(obj, fmt, args...) \
+	__builtin_choose_expr( \
+	  __drbd_dyn_dbg_if_same_type(obj, drbd_device, fmt, ## args), \
+	  __builtin_choose_expr( \
+	    __drbd_dyn_dbg_if_same_type(obj, drbd_resource, fmt, ## args), \
+	    __builtin_choose_expr( \
+	      __drbd_dyn_dbg_if_same_type(obj, drbd_connection, fmt, ## args), \
+	      __builtin_choose_expr( \
+		__drbd_dyn_dbg_if_same_type(obj, drbd_peer_device, fmt, ## args), \
+		drbd_dyn_dbg_with_wrong_object_type()))))
+
+#define drbd_emerg(device, fmt, args...) \
+	drbd_printk(KERN_EMERG, device, fmt, ## args)
+#define drbd_alert(device, fmt, args...) \
+	drbd_printk(KERN_ALERT, device, fmt, ## args)
+#define drbd_crit(device, fmt, args...) \
+	drbd_printk(KERN_CRIT, device, fmt, ## args)
+#define drbd_err(device, fmt, args...) \
+	drbd_printk(KERN_ERR, device, fmt, ## args)
+#define drbd_warn(device, fmt, args...) \
+	drbd_printk(KERN_WARNING, device, fmt, ## args)
+#define drbd_notice(device, fmt, args...) \
+	drbd_printk(KERN_NOTICE, device, fmt, ## args)
+#define drbd_info(device, fmt, args...) \
+	drbd_printk(KERN_INFO, device, fmt, ## args)
+
 
 #define D_ASSERT(x, exp)							\
 	do {									\
@@ -65,7 +126,7 @@ void drbd_printk_with_wrong_object_type(void);
 		bool _bool = (exp);						\
 		if (!_bool)							\
 			drbd_err(device, "ASSERTION %s FAILED in %s\n",		\
-			        #exp, __func__);				\
+				#exp, __func__);				\
 		_bool;								\
 		})
 
-- 
2.38.1

