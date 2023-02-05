Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8C068B12D
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 19:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjBESLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 13:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjBESLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 13:11:47 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37A21717B
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 10:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675620706; x=1707156706;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yTjnbKpGMVcECZTzY6FB808WfcV0N8+6Eb4IlYgwXDU=;
  b=FQU1mMOVW/4Z3P8tSlmz6i456fYqItcRbIKdNXLFfRcDF3yoNyLbIjL2
   EBeFAbVtU8O4Qhye0n42P0lTD/0QO/r2lv5PIFWPyLbYbijrFThZbubnk
   +8UCIsk3zpZ6Cc9utt4bf2aHfB3GFeG6MCt0DvFfNKRkCj7rSfQIai7TG
   tbwZiq2UQ1+QrcXJcBoyR7OJqsbWONlw3L2yYnv60MrH8Nu35yp+phGGb
   r3qC3CLCGzXYB9C1+On8zFm+xqkB7KJGTPdmtqGK69Uwa9Ce0SlKMBb+Y
   FQpjhZAaeA0HWFx+RDPQfHKPjmlmBSDQuAcBtLIdy3oynR7khNYUn8vF/
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="326762225"
X-IronPort-AV: E=Sophos;i="5.97,275,1669104000"; 
   d="scan'208";a="326762225"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2023 10:11:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="666286300"
X-IronPort-AV: E=Sophos;i="5.97,275,1669104000"; 
   d="scan'208";a="666286300"
Received: from twinkler-lnx.jer.intel.com ([10.12.87.42])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2023 10:11:44 -0800
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next v2 1/2] drm/i915/mtl: Define GSC Proxy component interface
Date:   Sun,  5 Feb 2023 20:11:31 +0200
Message-Id: <20230205181132.191064-2-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230205181132.191064-1-tomas.winkler@intel.com>
References: <20230205181132.191064-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

GSC Proxy component is used for communication between the
Intel graphics driver and MEI driver.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
V2: This patch was missing in the first series.

 MAINTAINERS                                |  1 +
 include/drm/i915_component.h               |  3 +-
 include/drm/i915_gsc_proxy_mei_interface.h | 36 ++++++++++++++++++++++
 3 files changed, 39 insertions(+), 1 deletion(-)
 create mode 100644 include/drm/i915_gsc_proxy_mei_interface.h

diff --git a/MAINTAINERS b/MAINTAINERS
index c81bbb771678..2c432b4d8506 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10570,6 +10570,7 @@ S:	Supported
 F:	Documentation/driver-api/mei/*
 F:	drivers/misc/mei/
 F:	drivers/watchdog/mei_wdt.c
+F:	include/drm/i915_gsc_proxy_mei_interface.h
 F:	include/linux/mei_aux.h
 F:	include/linux/mei_cl_bus.h
 F:	include/uapi/linux/mei.h
diff --git a/include/drm/i915_component.h b/include/drm/i915_component.h
index c1e2a43d2d1e..56a84ee1c64c 100644
--- a/include/drm/i915_component.h
+++ b/include/drm/i915_component.h
@@ -29,7 +29,8 @@
 enum i915_component_type {
 	I915_COMPONENT_AUDIO = 1,
 	I915_COMPONENT_HDCP,
-	I915_COMPONENT_PXP
+	I915_COMPONENT_PXP,
+	I915_COMPONENT_GSC_PROXY,
 };
 
 /* MAX_PORT is the number of port
diff --git a/include/drm/i915_gsc_proxy_mei_interface.h b/include/drm/i915_gsc_proxy_mei_interface.h
new file mode 100644
index 000000000000..e817bb316d5c
--- /dev/null
+++ b/include/drm/i915_gsc_proxy_mei_interface.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright (c) 2022-2023 Intel Corporation
+ */
+
+#ifndef _I915_GSC_PROXY_MEI_INTERFACE_H_
+#define _I915_GSC_PROXY_MEI_INTERFACE_H_
+
+#include <linux/mutex.h>
+#include <linux/device.h>
+
+/**
+ * struct i915_gsc_proxy_component_ops - ops for GSC Proxy services.
+ * @owner: Module providing the ops
+ * @send: sends data through GSC proxy
+ * @recv: receives data through GSC proxy
+ */
+struct i915_gsc_proxy_component_ops {
+	struct module *owner;
+
+	int (*send)(struct device *dev, const void *buf, size_t size);
+	int (*recv)(struct device *dev, void *buf, size_t size);
+};
+
+/**
+ * struct i915_gsc_proxy_component - Used for communication between i915 and
+ * MEI drivers for GSC proxy services
+ * @mei_dev: device that provide the GSC proxy service.
+ * @ops: Ops implemented by GSC proxy driver, used by i915 driver.
+ */
+struct i915_gsc_proxy_component {
+	struct device *mei_dev;
+	const struct i915_gsc_proxy_component_ops *ops;
+};
+
+#endif /* _I915_GSC_PROXY_MEI_INTERFACE_H_ */
-- 
2.39.1

