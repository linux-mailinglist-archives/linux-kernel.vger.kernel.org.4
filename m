Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70308642826
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 13:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbiLEMM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 07:12:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbiLEMMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 07:12:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB7319C18
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 04:12:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E925B80F6F
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 12:12:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A2AC43470;
        Mon,  5 Dec 2022 12:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670242342;
        bh=9SZrB8UGF5UO8RpveDsz6024dJo5watlcepz99el74c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CImLOQs4R1LCiPKrjwRvHKMnhvb7ieagk6tV+2wC/66GnnUyw7ka/008p0RzZBYHt
         qooyHDvZVXB5yK6irSidvWzO8jNMFDBvF6kg3fKOErm6NPpcPCBt4eUW6nflQ0dOFp
         50XtonTn5RBkSzqfgKuzEdvE9O/duETCjeFR2ywU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 3/4] usb.h: take advantage of container_of_const()
Date:   Mon,  5 Dec 2022 13:12:05 +0100
Message-Id: <20221205121206.166576-3-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221205121206.166576-1-gregkh@linuxfoundation.org>
References: <20221205121206.166576-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2642; i=gregkh@linuxfoundation.org; h=from:subject; bh=9SZrB8UGF5UO8RpveDsz6024dJo5watlcepz99el74c=; b=owGbwMvMwCRo6H6F97bub03G02pJDMm9D0QtFer3O3PfF/ulZ/Tz/u+00rIbl78dO9tuEeSf62a7 SPBtRywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAEwkpZ1hvlsJo6m77+5LYacv/5vRev BmJGfsVoZ5itlO5jfq/is32M31q9kyq3X1Ty0dAA==
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

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2: - respin with changed container_of_const() parameters

 include/linux/usb.h | 42 ++----------------------------------------
 1 file changed, 2 insertions(+), 40 deletions(-)

diff --git a/include/linux/usb.h b/include/linux/usb.h
index 4b463a5e4ba2..010c681b8822 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -259,26 +259,7 @@ struct usb_interface {
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
+#define to_usb_interface(__dev)	container_of_const(__dev, struct usb_interface, dev)
 
 static inline void *usb_get_intfdata(struct usb_interface *intf)
 {
@@ -730,26 +711,7 @@ struct usb_device {
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
+#define to_usb_device(__dev)	container_of_const(__dev, struct usb_device, dev)
 
 static inline struct usb_device *__intf_to_usbdev(struct usb_interface *intf)
 {
-- 
2.38.1

