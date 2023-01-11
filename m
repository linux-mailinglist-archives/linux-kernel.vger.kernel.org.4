Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23AA665A3B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 12:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236789AbjAKLcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 06:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbjAKLbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 06:31:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F11BB4A6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 03:31:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC2FEB819EF
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 11:31:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E7CFC433F1;
        Wed, 11 Jan 2023 11:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673436668;
        bh=1vqW6DznMRgbPw/+04VEBpy62SL5hHVRbzL2+kYgjlg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0bHQTNZWATOTIKhHpxas2zGuwKFhEEtdCziVt7Dha9I/cPf90pkHFa1KfaFUXQpIG
         p0WKno6PX/SjuLGYbtxZIfbdJofh0ffuoHNvcdP9VyNBji/Y7bLCBZXOB0zcwpBFse
         KAalUDkWGTr4hVEX3Zq4/7io5AODAYNnwDup5+fI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        linux1394-devel@lists.sourceforge.net
Subject: [PATCH v2 04/16] firewire: move fw_device() and fw_unit() to use container_of_const()
Date:   Wed, 11 Jan 2023 12:30:06 +0100
Message-Id: <20230111113018.459199-5-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111113018.459199-1-gregkh@linuxfoundation.org>
References: <20230111113018.459199-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1932; i=gregkh@linuxfoundation.org; h=from:subject; bh=1vqW6DznMRgbPw/+04VEBpy62SL5hHVRbzL2+kYgjlg=; b=owGbwMvMwCRo6H6F97bub03G02pJDMn75h6/+DvosLuUcdHFB+uc9q9K+mzoksivbP/s24YNW3dF 71/U0xHLwiDIxCArpsjyZRvP0f0VhxS9DG1Pw8xhZQIZwsDFKQATiVBlmGehUVxx6dnKjVutlk7Uvz Q9XrvP7yfDXKlIxQqlYB6ut5z9Z3dorK6ysC90BwA=
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

The driver core is changing to pass some pointers as const, so move
fw_device() and fw_unit() functions to use container_of_const() to
handle this change.

fw_device() and fw_unit() now properly keeps the const-ness of the
pointer passed into it, while as before it could be lost.

This also required turning fw_parent_device() into a macro to preserve
the const-ness of the pointer passed into it if necessary.

Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux1394-devel@lists.sourceforge.net
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/firewire.h | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/include/linux/firewire.h b/include/linux/firewire.h
index 980019053e54..03ac31ada5e6 100644
--- a/include/linux/firewire.h
+++ b/include/linux/firewire.h
@@ -208,10 +208,7 @@ struct fw_device {
 	struct fw_attribute_group attribute_group;
 };
 
-static inline struct fw_device *fw_device(struct device *dev)
-{
-	return container_of(dev, struct fw_device, device);
-}
+#define fw_device(dev)	container_of_const(dev, struct fw_device, device)
 
 static inline int fw_device_is_shutdown(struct fw_device *device)
 {
@@ -229,10 +226,7 @@ struct fw_unit {
 	struct fw_attribute_group attribute_group;
 };
 
-static inline struct fw_unit *fw_unit(struct device *dev)
-{
-	return container_of(dev, struct fw_unit, device);
-}
+#define fw_unit(dev)	container_of_const(dev, struct fw_unit, device)
 
 static inline struct fw_unit *fw_unit_get(struct fw_unit *unit)
 {
@@ -246,10 +240,7 @@ static inline void fw_unit_put(struct fw_unit *unit)
 	put_device(&unit->device);
 }
 
-static inline struct fw_device *fw_parent_device(struct fw_unit *unit)
-{
-	return fw_device(unit->device.parent);
-}
+#define fw_parent_device(unit)	fw_device(unit->device.parent)
 
 struct ieee1394_device_id;
 
-- 
2.39.0

