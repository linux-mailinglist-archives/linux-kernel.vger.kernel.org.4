Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0D363F859
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 20:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbiLATbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 14:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbiLATbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 14:31:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AD9CC64C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 11:31:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57B7E620EE
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 19:31:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A90BC433C1;
        Thu,  1 Dec 2022 19:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669923060;
        bh=erhHHZEx/rNuL8eWXQPG5W2MTr4Qm2YQBMEiKXUCRv4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B0sfgfm+Jq7THSRVetijY0+GxGvwbOoDx8txQGfGkRCGw3u28F1wh5cywTnCZ/WUP
         LqM7c9AdOkrSimUjICQrsGnt9ViXq0+5fbVKUCwuoT+zlw5FEynHpzEgjlb61Lr0RN
         tYU/tN0zpdRQcYtmh0BAqk9cJiaeTi0zkii8LMUQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 2/4] device.h: move kobj_to_dev() to use container_of_const()
Date:   Thu,  1 Dec 2022 20:30:55 +0100
Message-Id: <20221201193057.1195255-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221201193057.1195255-1-gregkh@linuxfoundation.org>
References: <20221201193057.1195255-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1669; i=gregkh@linuxfoundation.org; h=from:subject; bh=erhHHZEx/rNuL8eWXQPG5W2MTr4Qm2YQBMEiKXUCRv4=; b=owGbwMvMwCRo6H6F97bub03G02pJDMmdDB/275GN2WvhoHVazsojZ/+hM3cOtgSmBv8z6E6cNV+v IDe8I5aFQZCJQVZMkeXLNp6j+ysOKXoZ2p6GmcPKBDKEgYtTACaSIs6wYHsH81WP50ptM6cIlCxQ81 SRu+IrxzA/OiF38rw/P87vfZPVExzqKdjHcMUTAA==
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

Instead of rolling our own const-checking logic, use the newly
introduced container_of_const() to handle it all for us automatically.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/device.h | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index 84ae52de6746..8ad2cd21b335 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -680,26 +680,8 @@ struct device_link {
 	bool supplier_preactivated; /* Owned by consumer probe. */
 };
 
-static inline struct device *__kobj_to_dev(struct kobject *kobj)
-{
-	return container_of(kobj, struct device, kobj);
-}
-
-static inline const struct device *__kobj_to_dev_const(const struct kobject *kobj)
-{
-	return container_of(kobj, const struct device, kobj);
-}
-
-/*
- * container_of() will happily take a const * and spit back a non-const * as it
- * is just doing pointer math.  But we want to be a bit more careful in the
- * driver code, so manually force any const * of a kobject to also be a const *
- * to a device.
- */
-#define kobj_to_dev(kobj)					\
-	_Generic((kobj),					\
-		 const struct kobject *: __kobj_to_dev_const,	\
-		 struct kobject *: __kobj_to_dev)(kobj)
+#define kobj_to_dev(__kobj)	\
+	container_of_const(struct kobject, __kobj, struct device, kobj)
 
 /**
  * device_iommu_mapped - Returns true when the device DMA is translated
-- 
2.38.1

