Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965055FFEAA
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 12:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiJPKlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 06:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiJPKlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 06:41:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527B839BA7;
        Sun, 16 Oct 2022 03:41:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB54F60B18;
        Sun, 16 Oct 2022 10:41:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDDA8C433C1;
        Sun, 16 Oct 2022 10:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665916873;
        bh=+QQ0hxm37qhkO10M29qkWeIY40wxMMYdhhcDwBRWzkI=;
        h=From:To:Cc:Subject:Date:From;
        b=Auj0BjgFpC4z55x1oUQx+lpTV44hSTzcJs56mPNM3+1ylvQGI1n35fah0ZRAlWKe2
         LUUHtMGxM650LPR/Yfs6dzyRbL5Rm9/wdqjsNdi9BvOPpt+k2wAR7d+6l0D2BJd0gd
         BMyJ2tVj1pRmOM/wLFsHc4/KrQalvpBHBPJfxCmA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] USB: allow some usb functions to take a const pointer.
Date:   Sun, 16 Oct 2022 12:41:55 +0200
Message-Id: <20221016104155.1260201-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3295; i=gregkh@linuxfoundation.org; h=from:subject; bh=+QQ0hxm37qhkO10M29qkWeIY40wxMMYdhhcDwBRWzkI=; b=owGbwMvMwCRo6H6F97bub03G02pJDMne9z/n6n+vjpuyeZfqtCcr289bvNH09LKZE2oYyam4UP1Y hN3FjlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZhIYyrDfM8zt/9OrWlKM5j4uP3uph k7Xu9Nq2FYsEnjAU8+X8mjXeE9ba9f+l94strWDAA=
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

The functions to_usb_interface(), to_usb_device, and
interface_to_usbdev() sometimes would like to take a const * and return
a const * back.  As we are doing pointer math, a call to container_of()
loses the const-ness of a pointer, so use a _Generic() macro to pick the
proper inline function to call instead.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/usb.h | 55 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 52 insertions(+), 3 deletions(-)

diff --git a/include/linux/usb.h b/include/linux/usb.h
index 9ff1ad4dfad1..3a55131e0ad4 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -258,7 +258,27 @@ struct usb_interface {
 	struct device *usb_dev;
 	struct work_struct reset_ws;	/* for resets in atomic context */
 };
-#define	to_usb_interface(d) container_of(d, struct usb_interface, dev)
+
+static inline struct usb_interface *__to_usb_interface(struct device *d)
+{
+	return container_of(d, struct usb_interface, dev);
+}
+
+static inline const struct usb_interface *__to_usb_interface_const(const struct device *d)
+{
+	return container_of(d, struct usb_interface, dev);
+}
+
+/*
+ * container_of() will happily take a const * and spit back a non-const * as it
+ * is just doing pointer math.  But we want to be a bit more careful in the USB
+ * driver code, so manually force any const * of a device to also be a const *
+ * to a usb_device.
+ */
+#define to_usb_interface(dev)						\
+	_Generic((dev),							\
+		 const struct device *: __to_usb_interface_const,	\
+		 struct device *: __to_usb_interface)(dev)
 
 static inline void *usb_get_intfdata(struct usb_interface *intf)
 {
@@ -709,12 +729,41 @@ struct usb_device {
 	u16 hub_delay;
 	unsigned use_generic_driver:1;
 };
-#define	to_usb_device(d) container_of(d, struct usb_device, dev)
 
-static inline struct usb_device *interface_to_usbdev(struct usb_interface *intf)
+static inline struct usb_device *__to_usb_device(struct device *d)
+{
+	return container_of(d, struct usb_device, dev);
+}
+
+static inline const struct usb_device *__to_usb_device_const(const struct device *d)
+{
+	return container_of(d, struct usb_device, dev);
+}
+
+/*
+ * container_of() will happily take a const * and spit back a non-const * as it
+ * is just doing pointer math.  But we want to be a bit more careful in the USB
+ * driver code, so manually force any const * of a device to also be a const *
+ * to a usb_device.
+ */
+#define to_usb_device(dev)					\
+	_Generic((dev),						\
+		 const struct device *: __to_usb_device_const,	\
+		 struct device *: __to_usb_device)(dev)
+
+static inline struct usb_device *__intf_to_usbdev(struct usb_interface *intf)
 {
 	return to_usb_device(intf->dev.parent);
 }
+static inline const struct usb_device *__intf_to_usbdev_const(const struct usb_interface *intf)
+{
+	return to_usb_device((const struct device *)intf->dev.parent);
+}
+
+#define interface_to_usbdev(intf)					\
+	_Generic((intf),						\
+		 const struct usb_interface *: __intf_to_usbdev_const,	\
+		 struct usb_interface *: __intf_to_usbdev)(intf)
 
 extern struct usb_device *usb_get_dev(struct usb_device *dev);
 extern void usb_put_dev(struct usb_device *dev);
-- 
2.38.0

