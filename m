Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856AB642824
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 13:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbiLEMMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 07:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbiLEMMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 07:12:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48ECB63A0
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 04:12:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D926861033
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 12:12:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F0CC433B5;
        Mon,  5 Dec 2022 12:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670242334;
        bh=Zfzn7t/aoLl1bnoeeef2orf49auREGHo/fAXlzjp3fE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LE2UwKATTCTKngMKl28GW95O3hhK7O8/wg87DUl8PrvwJodYpoH/vZzrhuTCY62kU
         9aLcccALdPnOm9o3cNxAFF7ldsTnJtYRD0feSVrTR0x7wjqiSOoGNA69RG5Bq2z9er
         Vmy+MKImTcMUwtkWf1zQTrSfQCGtcOrVjmLKajAY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 2/4] device.h: move kobj_to_dev() to use container_of_const()
Date:   Mon,  5 Dec 2022 13:12:04 +0100
Message-Id: <20221205121206.166576-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221205121206.166576-1-gregkh@linuxfoundation.org>
References: <20221205121206.166576-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1718; i=gregkh@linuxfoundation.org; h=from:subject; bh=Zfzn7t/aoLl1bnoeeef2orf49auREGHo/fAXlzjp3fE=; b=owGbwMvMwCRo6H6F97bub03G02pJDMm9D0SnT/oy535sY9iJtwVZ/CdLTH/3R9hk7Mibwn1lU1Db vwNqHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjCRuGCGeeZ2B1cZTPVLvZ/S9v9Qdc oRadliMYb5JbJPCxPnKwkxbJn4K6tZfoP61z0JAA==
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
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2: - respin with changed container_of_const() parameters

 include/linux/device.h | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index 84ae52de6746..8d172d06b8c1 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -680,26 +680,7 @@ struct device_link {
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
+#define kobj_to_dev(__kobj)	container_of_const(__kobj, struct device, kobj)
 
 /**
  * device_iommu_mapped - Returns true when the device DMA is translated
-- 
2.38.1

