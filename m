Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE36665A45
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 12:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238134AbjAKLci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 06:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbjAKLb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 06:31:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B466AE6B;
        Wed, 11 Jan 2023 03:31:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 647D561C52;
        Wed, 11 Jan 2023 11:31:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB18C433EF;
        Wed, 11 Jan 2023 11:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673436684;
        bh=pM+8n3r7RlbZn8/vOlXhyjyToBZb91WLLHBBqD470gk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mfu+dPBTJLWWzZi1+oiqMyofu84JKE5/CwaXEV/175ufzEC0ZX0dke3j4Fg9JYu33
         FyXY5k+WRRxfa8FmOYzfQA5sZAlH2YpU9HA6bVwryQ1TWufxu4ifJOtLXvcbZZxg9i
         ve+5pHGNuhDibmJTyqyI+tB0EXCQscc/iJafnBMo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v2 09/16] platform/x86: wmi: move dev_to_wblock() and dev_to_wdev to use container_of_const()
Date:   Wed, 11 Jan 2023 12:30:11 +0100
Message-Id: <20230111113018.459199-10-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111113018.459199-1-gregkh@linuxfoundation.org>
References: <20230111113018.459199-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1435; i=gregkh@linuxfoundation.org; h=from:subject; bh=pM+8n3r7RlbZn8/vOlXhyjyToBZb91WLLHBBqD470gk=; b=owGbwMvMwCRo6H6F97bub03G02pJDMn75p5o6T/EzfL4f/ZDcd78ffPFLFzmX7r0wmzz1P7wPT8X nlZf3RHLwiDIxCArpsjyZRvP0f0VhxS9DG1Pw8xhZQIZwsDFKQATWePNMD/0iFnByeRPbjwlRUwnwr pO/mHYt59hnuWBB8387LNn8rLdut6+8uQBGTE+cwA=
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

The driver core is changing to pass some pointers as const, so move the
dev_to_wdev() and dev_to_wblock() functions to use container_of_const()
to handle this change.

Both of these functions now properly keep the const-ness of the pointer
passed into it, while as before it could be lost.

Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Mark Gross <markgross@kernel.org>
Cc: platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/wmi.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 5ffc00480aef..46d1edc08f20 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -693,15 +693,8 @@ char *wmi_get_acpi_device_uid(const char *guid_string)
 }
 EXPORT_SYMBOL_GPL(wmi_get_acpi_device_uid);
 
-static struct wmi_block *dev_to_wblock(struct device *dev)
-{
-	return container_of(dev, struct wmi_block, dev.dev);
-}
-
-static struct wmi_device *dev_to_wdev(struct device *dev)
-{
-	return container_of(dev, struct wmi_device, dev);
-}
+#define dev_to_wblock(__dev)	container_of_const(__dev, struct wmi_block, dev.dev)
+#define dev_to_wdev(__dev)	container_of_const(__dev, struct wmi_device, dev)
 
 static inline struct wmi_driver *drv_to_wdrv(struct device_driver *drv)
 {
-- 
2.39.0

