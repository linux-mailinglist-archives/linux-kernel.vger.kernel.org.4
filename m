Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01185FFEA8
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 12:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiJPKk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 06:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiJPKkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 06:40:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F0137F9A
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 03:40:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94C7560B20
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 10:40:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D24EC433C1;
        Sun, 16 Oct 2022 10:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665916841;
        bh=e0P2NFf3gxuHj6cGe5/EsaIYMZCrodGLfYaOSNYuXrU=;
        h=From:To:Cc:Subject:Date:From;
        b=z8tC+p31miYKSR87ubnPmuXV52cp6ttPKPdEBJ93vsvAuGzIoHW8sBm5RZU9S13Nr
         Y1mv991c7jlZsTIJdwhkMtp7OS2wsftqVI6+17cLX5H1NxsDYEV2A5Dg1irCKFcS16
         Q7i1rrQyp6Gghd8kYbe936GNtap/GDtFHDz0OST0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v2] driver core: allow kobj_to_dev() to take a const pointer
Date:   Sun, 16 Oct 2022 12:41:26 +0200
Message-Id: <20221016104126.1259809-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2094; i=gregkh@linuxfoundation.org; h=from:subject; bh=e0P2NFf3gxuHj6cGe5/EsaIYMZCrodGLfYaOSNYuXrU=; b=owGbwMvMwCRo6H6F97bub03G02pJDMne9y+85V0cufbR9h6OHMH9rJNuGcq8nlTn1ZK4W8JMOiM/ /V1FRywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAExEeTLDgs1Tf17/8fKmxwaZinNr5y w5If53HzfDPCVP/nqBz3ckN+9kW7aXYbeTfd1vbQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a const * to a kobject is passed to kobj_to_dev(), we want to return
back a const * to a device as the driver core shouldn't be modifying a
constant structure.  But when dealing with container_of() the pointer
const attribute is cast away, so we need to manually handle this by
determining the type of the pointer passed in to know the type of the
pointer to pass out.

Luckily _Generic can do this type of magic, and as the kernel now
supports C11 it is availble to us to handle this type of build-time type
detection.

Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2 - use _Generic() to make this type safe as pointed out by Sakari

 include/linux/device.h | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index 424b55df0272..023ea50b1916 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -680,11 +680,27 @@ struct device_link {
 	bool supplier_preactivated; /* Owned by consumer probe. */
 };
 
-static inline struct device *kobj_to_dev(struct kobject *kobj)
+static inline struct device *__kobj_to_dev(struct kobject *kobj)
 {
 	return container_of(kobj, struct device, kobj);
 }
 
+static inline const struct device *__kobj_to_dev_const(const struct kobject *kobj)
+{
+	return container_of(kobj, const struct device, kobj);
+}
+
+/*
+ * container_of() will happily take a const * and spit back a non-const * as it
+ * is just doing pointer math.  But we want to be a bit more careful in the
+ * driver code, so manually force any const * of a kobject to also be a const *
+ * to a device.
+ */
+#define kobj_to_dev(kobj)					\
+	_Generic((kobj),					\
+		 const struct kobject *: __kobj_to_dev_const,	\
+		 struct kobject *: __kobj_to_dev)(kobj)
+
 /**
  * device_iommu_mapped - Returns true when the device DMA is translated
  *			 by an IOMMU
-- 
2.38.0

