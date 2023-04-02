Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA5F6D399F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 19:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjDBR7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 13:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDBR7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 13:59:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EF54EFD
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 10:59:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78B7C612D5
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 17:59:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D01AC433EF;
        Sun,  2 Apr 2023 17:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680458341;
        bh=vIGPghN8n4UlZStHEt+zl72sd282xSKb+oj0ziHP0ss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R1Utxy/tIZEnQB5zUl3huvAQDaSOzhk0AJxG0zfxjNSeBNcf/6st6aWIn8yhRsdsu
         UepwoX3LQBxn3bL7hY7eAsDIHRKgzELc1JBvTS7qmtmuz+qBkCqWeAkH0ZeeM8UdRK
         x/1G9jouRybWq3fkbXKKtUMaXRj+tNsvD4Aidmgw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/5] driver core: class: mark class_release() as taking a const *
Date:   Sun,  2 Apr 2023 19:58:46 +0200
Message-Id: <2023040248-outrage-obsolete-5a9a@gregkh>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <2023040244-duffel-pushpin-f738@gregkh>
References: <2023040244-duffel-pushpin-f738@gregkh>
MIME-Version: 1.0
Lines:  55
X-Developer-Signature: v=1; a=openpgp-sha256; l=2057; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=vIGPghN8n4UlZStHEt+zl72sd282xSKb+oj0ziHP0ss=; b=owGbwMvMwCRo6H6F97bub03G02pJDCmahyLktco4fL7xvLjB1FUSu/TuffcEvQ0tEm9W9LN8C 6zKnFbYEcvCIMjEICumyPJlG8/R/RWHFL0MbU/DzGFlAhnCwMUpABOZu4ZhwYxHG4q3+FZ8W6n8 02L6O7P9B+Zt8GdYsHN2/qKF+5zFP+/d2PFy0ezVrNZT7wIA
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct class callback, class_release(), is only called in 2 places,
the pcmcia cardservices code, and in the class driver core code.  Both
places it is safe to mark the structure as a const *, to allow us to
in the future mark all struct class usages as constant and move into
read-only memory.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/class.c         | 2 +-
 drivers/pcmcia/cs.c          | 2 +-
 include/linux/device/class.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/class.c b/drivers/base/class.c
index 65502bd7d5c5..53fc7052340c 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -235,7 +235,7 @@ void class_unregister(const struct class *cls)
 }
 EXPORT_SYMBOL_GPL(class_unregister);
 
-static void class_create_release(struct class *cls)
+static void class_create_release(const struct class *cls)
 {
 	pr_debug("%s called for %s\n", __func__, cls->name);
 	kfree(cls);
diff --git a/drivers/pcmcia/cs.c b/drivers/pcmcia/cs.c
index e3224e49c43f..5658745c398f 100644
--- a/drivers/pcmcia/cs.c
+++ b/drivers/pcmcia/cs.c
@@ -824,7 +824,7 @@ static int pcmcia_socket_uevent(const struct device *dev,
 
 static struct completion pcmcia_unload;
 
-static void pcmcia_release_socket_class(struct class *data)
+static void pcmcia_release_socket_class(const struct class *data)
 {
 	complete(&pcmcia_unload);
 }
diff --git a/include/linux/device/class.h b/include/linux/device/class.h
index 7e4a1a6329f4..f3c418fa129a 100644
--- a/include/linux/device/class.h
+++ b/include/linux/device/class.h
@@ -58,7 +58,7 @@ struct class {
 	int (*dev_uevent)(const struct device *dev, struct kobj_uevent_env *env);
 	char *(*devnode)(const struct device *dev, umode_t *mode);
 
-	void (*class_release)(struct class *class);
+	void (*class_release)(const struct class *class);
 	void (*dev_release)(struct device *dev);
 
 	int (*shutdown_pre)(struct device *dev);
-- 
2.40.0

