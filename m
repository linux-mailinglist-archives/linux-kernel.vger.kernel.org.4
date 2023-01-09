Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D47662DE0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 19:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236667AbjAISBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 13:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237407AbjAIR75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:59:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C943591B
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 09:58:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84202B80ED5
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 17:58:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2671C433D2;
        Mon,  9 Jan 2023 17:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673287112;
        bh=iHApBoe5CKSDLjXLkv8WWRbHo91FyhRCPegYvA0e43U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=01CUVWH6Oiwq7+kE1BfD55Nc5zBSzEzTeoZK6GczZqfBaW//ElSFOwja2FvAYS8jc
         BOwB9bkQU4rY0l8fJ5Kh+4KTV3/FFczNKR8ALVTeeN8oHwZ8xeqbZj9AnjAGjMbPVt
         Ud7ZO/G8D4BLBFKzjlURwvEMFLSjzLNPByNl/XuQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 6/6] driver core: move struct subsys_dev_iter to a local file
Date:   Mon,  9 Jan 2023 18:58:10 +0100
Message-Id: <20230109175810.2965448-6-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230109175810.2965448-1-gregkh@linuxfoundation.org>
References: <20230109175810.2965448-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1553; i=gregkh@linuxfoundation.org; h=from:subject; bh=iHApBoe5CKSDLjXLkv8WWRbHo91FyhRCPegYvA0e43U=; b=owGbwMvMwCRo6H6F97bub03G02pJDMl7QjflvPjYeOi38badEt8vc/eXbF2QyPY9+FPmOua+BJeX 7uk9HbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjCRGwoMc6X3/j8cdWTNlKtGdY2RT7 ZGRdcm/mVYMOnuUmaG7HqFnywqPFta8uf/kbq5EgA=
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

struct subsys_dev_iter is not used by any code outside of
drivers/base/bus.c so move it into that file and out of the global bus.h
file.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/bus.c         | 5 +++++
 include/linux/device/bus.h | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index e0fe07872a74..e0953656d5ac 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -941,6 +941,11 @@ void bus_sort_breadthfirst(struct bus_type *bus,
 }
 EXPORT_SYMBOL_GPL(bus_sort_breadthfirst);
 
+struct subsys_dev_iter {
+	struct klist_iter		ki;
+	const struct device_type	*type;
+};
+
 /**
  * subsys_dev_iter_init - initialize subsys device iterator
  * @iter: subsys iterator to initialize
diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index ffa562f2d975..53e3cdf18bae 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -150,11 +150,6 @@ int device_match_acpi_handle(struct device *dev, const void *handle);
 int device_match_any(struct device *dev, const void *unused);
 
 /* iterator helpers for buses */
-struct subsys_dev_iter {
-	struct klist_iter		ki;
-	const struct device_type	*type;
-};
-
 int bus_for_each_dev(struct bus_type *bus, struct device *start, void *data,
 		     int (*fn)(struct device *dev, void *data));
 struct device *bus_find_device(struct bus_type *bus, struct device *start,
-- 
2.39.0

