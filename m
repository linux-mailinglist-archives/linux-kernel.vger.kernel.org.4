Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D605B3A68
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbiIIOCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 10:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbiIIOBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:01:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6895A3469;
        Fri,  9 Sep 2022 07:00:38 -0700 (PDT)
Date:   Fri, 09 Sep 2022 14:00:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662732036;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jFlcBXEp7sIljUiwMOfLafUGr2rNlCE2sdK1fZRJj60=;
        b=w1VRIhhGmnYc2gDKxwxVP2qxgxki7mhZWYLl295TkWPfrEqeBFNIXDOITnwR8OsLNn5Qno
        Qu6MIXNFsHyhLPCVs6Ppxpymvp08/kQZf/Mveeb55yIb/HJkPm/zcuOsfBT4qIgtKgn9sC
        S9nHlbRRqWCNYm+IfIH8i07FVFzDylKOpPyAR3ayAjXhdxama4dtJzZRfLX3Ae3MJW9FKq
        +DmkyMBiH9r1dacTPDmMkXHX9y2XChAvWDl9hzoO+ItqHmhVKmFt9KrjVFTllnBW0w0TD+
        uhrYsKLpBHrQd/v7P+DT5RV7h7XxtCjtAwo56Zbfdb7d2wKG1yIeM++rbN/c3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662732036;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jFlcBXEp7sIljUiwMOfLafUGr2rNlCE2sdK1fZRJj60=;
        b=y9HtZ9U+HaZUyRet40THyBJaJgVTZSv01ezVHExR6rm3h33DYIjlCs/UY2PXqv6apDNlp+
        Hjtxp6C6KDfk0lBw==
From:   "tip-bot2 for Christoph Hellwig" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/psi] devres: remove devm_ioremap_np
Cc:     Christoph Hellwig <hch@lst.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220822061424.151819-1-hch@lst.de>
References: <20220822061424.151819-1-hch@lst.de>
MIME-Version: 1.0
Message-ID: <166273203553.401.17063915348417685051.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/psi branch of tip:

Commit-ID:     3954cf4338becb1f140bb6fa4f5e9a42f2529b86
Gitweb:        https://git.kernel.org/tip/3954cf4338becb1f140bb6fa4f5e9a42f2529b86
Author:        Christoph Hellwig <hch@lst.de>
AuthorDate:    Mon, 22 Aug 2022 08:14:24 +02:00
Committer:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CommitterDate: Thu, 01 Sep 2022 18:04:43 +02:00

devres: remove devm_ioremap_np

devm_ioremap_np has never been used anywhere since it was added in early
2021, so remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20220822061424.151819-1-hch@lst.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/driver-api/driver-model/devres.rst |  1 +-
 include/linux/io.h                               |  2 +--
 lib/devres.c                                     | 15 +---------------
 3 files changed, 18 deletions(-)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index 5527294..2af6c9c 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -310,7 +310,6 @@ IOMAP
   devm_ioremap()
   devm_ioremap_uc()
   devm_ioremap_wc()
-  devm_ioremap_np()
   devm_ioremap_resource() : checks resource, requests memory region, ioremaps
   devm_ioremap_resource_wc()
   devm_platform_ioremap_resource() : calls devm_ioremap_resource() for platform device
diff --git a/include/linux/io.h b/include/linux/io.h
index 5fc8003..308f4f0 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -59,8 +59,6 @@ void __iomem *devm_ioremap_uc(struct device *dev, resource_size_t offset,
 				   resource_size_t size);
 void __iomem *devm_ioremap_wc(struct device *dev, resource_size_t offset,
 				   resource_size_t size);
-void __iomem *devm_ioremap_np(struct device *dev, resource_size_t offset,
-				   resource_size_t size);
 void devm_iounmap(struct device *dev, void __iomem *addr);
 int check_signature(const volatile void __iomem *io_addr,
 			const unsigned char *signature, int length);
diff --git a/lib/devres.c b/lib/devres.c
index 55eb07e..6baf439 100644
--- a/lib/devres.c
+++ b/lib/devres.c
@@ -104,21 +104,6 @@ void __iomem *devm_ioremap_wc(struct device *dev, resource_size_t offset,
 EXPORT_SYMBOL(devm_ioremap_wc);
 
 /**
- * devm_ioremap_np - Managed ioremap_np()
- * @dev: Generic device to remap IO address for
- * @offset: Resource address to map
- * @size: Size of map
- *
- * Managed ioremap_np().  Map is automatically unmapped on driver detach.
- */
-void __iomem *devm_ioremap_np(struct device *dev, resource_size_t offset,
-			      resource_size_t size)
-{
-	return __devm_ioremap(dev, offset, size, DEVM_IOREMAP_NP);
-}
-EXPORT_SYMBOL(devm_ioremap_np);
-
-/**
  * devm_iounmap - Managed iounmap()
  * @dev: Generic device to unmap for
  * @addr: Address to unmap
