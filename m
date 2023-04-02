Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAF86D39A0
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 19:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbjDBR7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 13:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbjDBR7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 13:59:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51C0E049
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 10:59:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 86EDFB80F2B
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 17:59:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C46C433D2;
        Sun,  2 Apr 2023 17:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680458352;
        bh=pRhq4yGE+rRCid5ll0m5GDPBM3XxuF3voRhflViLux0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bbtMeHcfM0Z8nMH6TfPb7pUT0IAvzwnYkc/+3f1tk1/E+o0fiP/+Ygzd8HGNXde6O
         VCp8KkzexSCfY8YU+GoKXyMLV++tmDaDPBV6ICoKPWOJ/v6HR31cLfoDRyHyVdrc1+
         T92NcIpTi2KcHZ/M6TqwBkBd2Imo0HUG3IKJ3ucw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 3/5] driver core: class: mark the struct class in struct class_interface constant
Date:   Sun,  2 Apr 2023 19:58:48 +0200
Message-Id: <2023040249-handball-gruffly-5da7@gregkh>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <2023040244-duffel-pushpin-f738@gregkh>
References: <2023040244-duffel-pushpin-f738@gregkh>
MIME-Version: 1.0
Lines:  39
X-Developer-Signature: v=1; a=openpgp-sha256; l=1425; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=pRhq4yGE+rRCid5ll0m5GDPBM3XxuF3voRhflViLux0=; b=owGbwMvMwCRo6H6F97bub03G02pJDCmahyKVbSf+KTPUceK4smmDfp/1PlXdOalLAudEp1bJx Dz2N7HviGVhEGRikBVTZPmyjefo/opDil6Gtqdh5rAygQxh4OIUgIlEvGCYX2uWq3NAK6b3USub cNalq9Jt9fGCDPMzFgr1PWVeFSF7/PDTxVtU79cU/b0HAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct class pointer in struct class_interface is never modified, so
mark it as const so that no one accidentally tries to modify it in the
future.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/class.c         | 2 +-
 include/linux/device/class.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/class.c b/drivers/base/class.c
index 05bce79d3d19..ad8b9f163fd2 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -498,7 +498,7 @@ EXPORT_SYMBOL_GPL(class_interface_register);
 void class_interface_unregister(struct class_interface *class_intf)
 {
 	struct subsys_private *sp;
-	struct class *parent = class_intf->class;
+	const struct class *parent = class_intf->class;
 	struct class_dev_iter iter;
 	struct device *dev;
 
diff --git a/include/linux/device/class.h b/include/linux/device/class.h
index 4bf46f9bbb56..53287aa105b8 100644
--- a/include/linux/device/class.h
+++ b/include/linux/device/class.h
@@ -217,7 +217,7 @@ ssize_t show_class_attr_string(const struct class *class, const struct class_att
 
 struct class_interface {
 	struct list_head	node;
-	struct class		*class;
+	const struct class	*class;
 
 	int (*add_dev)		(struct device *, struct class_interface *);
 	void (*remove_dev)	(struct device *, struct class_interface *);
-- 
2.40.0

