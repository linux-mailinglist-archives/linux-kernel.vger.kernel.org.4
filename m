Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4318163F857
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 20:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbiLATcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 14:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbiLATbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 14:31:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBF693819
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 11:31:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13D37620B3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 19:31:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27437C433C1;
        Thu,  1 Dec 2022 19:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669923068;
        bh=wKjnp7nD3iYnQu8wtXx6xvDXbEm6kF9CEXAmhVTc11w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gpp9BKQO1O1OKPrpkHpXIkVrfGXL+Sa9TSP/ckiKH+G+WbsXE+vwUgEWnDIFueEbF
         6SL2WoNew08FW9JX2lVaJ6DoXnj6BFVnhqBNnD6HP43MYyx8pIbaWoEj7A52C8rniw
         aKj9zzpQm6EMQdqJEoZKur7MRpDv32R/K/31MUZ8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 3/4] usb.h: take advantage of container_of_const()
Date:   Thu,  1 Dec 2022 20:30:56 +0100
Message-Id: <20221201193057.1195255-3-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221201193057.1195255-1-gregkh@linuxfoundation.org>
References: <20221201193057.1195255-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2576; i=gregkh@linuxfoundation.org; h=from:subject; bh=wKjnp7nD3iYnQu8wtXx6xvDXbEm6kF9CEXAmhVTc11w=; b=owGbwMvMwCRo6H6F97bub03G02pJDMmdDB+mSh/e18b9+dOL0JWTu1VCduc7LHgUeaJo4sYDm3c6 NYukdcSyMAgyMciKKbJ82cZzdH/FIUUvQ9vTMHNYmUCGMHBxCsBESpgYFpz/sDrY3qVlU11Mun2nIn 9A/7R9zQwLZlZUtc7fcLlQ7b3z3s9f4v1nBUg5AgA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of rolling our own const-checking logic in to_usb_interface()
and to_usb_device() use the newly added container_of_const() instead,
making the logic much simpler overall.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/usb.h | 44 ++++----------------------------------------
 1 file changed, 4 insertions(+), 40 deletions(-)

diff --git a/include/linux/usb.h b/include/linux/usb.h
index 4b463a5e4ba2..cd5637c950ae 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -259,26 +259,8 @@ struct usb_interface {
 	struct work_struct reset_ws;	/* for resets in atomic context */
 };
 
-static inline struct usb_interface *__to_usb_interface(struct device *d)
-{
-	return container_of(d, struct usb_interface, dev);
-}
-
-static inline const struct usb_interface *__to_usb_interface_const(const struct device *d)
-{
-	return container_of(d, struct usb_interface, dev);
-}
-
-/*
- * container_of() will happily take a const * and spit back a non-const * as it
- * is just doing pointer math.  But we want to be a bit more careful in the USB
- * driver code, so manually force any const * of a device to also be a const *
- * to a usb_device.
- */
-#define to_usb_interface(dev)						\
-	_Generic((dev),							\
-		 const struct device *: __to_usb_interface_const,	\
-		 struct device *: __to_usb_interface)(dev)
+#define to_usb_interface(__dev)	\
+	container_of_const(struct device, __dev, struct usb_interface, dev)
 
 static inline void *usb_get_intfdata(struct usb_interface *intf)
 {
@@ -730,26 +712,8 @@ struct usb_device {
 	unsigned use_generic_driver:1;
 };
 
-static inline struct usb_device *__to_usb_device(struct device *d)
-{
-	return container_of(d, struct usb_device, dev);
-}
-
-static inline const struct usb_device *__to_usb_device_const(const struct device *d)
-{
-	return container_of(d, struct usb_device, dev);
-}
-
-/*
- * container_of() will happily take a const * and spit back a non-const * as it
- * is just doing pointer math.  But we want to be a bit more careful in the USB
- * driver code, so manually force any const * of a device to also be a const *
- * to a usb_device.
- */
-#define to_usb_device(dev)					\
-	_Generic((dev),						\
-		 const struct device *: __to_usb_device_const,	\
-		 struct device *: __to_usb_device)(dev)
+#define to_usb_device(__dev)	\
+	container_of_const(struct device, __dev, struct usb_device, dev)
 
 static inline struct usb_device *__intf_to_usbdev(struct usb_interface *intf)
 {
-- 
2.38.1

