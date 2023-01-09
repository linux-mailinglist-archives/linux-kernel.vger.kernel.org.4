Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57580662DE4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 19:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237517AbjAISBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 13:01:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237572AbjAIR74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:59:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AD713E10
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 09:58:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C1A5612BF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 17:58:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38A10C433D2;
        Mon,  9 Jan 2023 17:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673287102;
        bh=AexwsmhXVQEq31HnkDFo33IyNbJHubvtlXOHswUN7nA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gFtu9gFRNcWqbjD10WF4dZhJ2O+lNzlVu0Q0eKclYm+urew/lRVVf6Vd4qfUp765F
         MgsNeycfFzfzpj/nuWFpQrIsLYIwT1+69PY4nM0kfkqWaV93NXD6U+4V5zLzuuGui4
         /SuId0FAWHGF96iTZRPgKPSnMGwJQsDJkRz6HDtM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 3/6] driver core: make subsys_dev_iter_init() static
Date:   Mon,  9 Jan 2023 18:58:07 +0100
Message-Id: <20230109175810.2965448-3-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230109175810.2965448-1-gregkh@linuxfoundation.org>
References: <20230109175810.2965448-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1904; i=gregkh@linuxfoundation.org; h=from:subject; bh=AexwsmhXVQEq31HnkDFo33IyNbJHubvtlXOHswUN7nA=; b=owGbwMvMwCRo6H6F97bub03G02pJDMl7QjcuPmMxq++qZ0nOb83Kcq7z7k5f9ZzZvV+tko/9wrr8 1edHHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjAReWGGeXYibMaPQty/vJmXfqR+fn bhA7ktsxnm1wTLPjqdm2ZUalySIje925fh/rkWAA==
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

No one outside of drivers/base/bus.c calls this function so make it
static and remove the exported symbol.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/bus.c         | 5 ++---
 include/linux/device/bus.h | 4 ----
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 45aa8d996f0a..a375305a11dd 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -953,8 +953,8 @@ EXPORT_SYMBOL_GPL(bus_sort_breadthfirst);
  * otherwise if it is NULL, the iteration starts at the beginning of
  * the list.
  */
-void subsys_dev_iter_init(struct subsys_dev_iter *iter, struct bus_type *subsys,
-			  struct device *start, const struct device_type *type)
+static void subsys_dev_iter_init(struct subsys_dev_iter *iter, struct bus_type *subsys,
+				 struct device *start, const struct device_type *type)
 {
 	struct klist_node *start_knode = NULL;
 
@@ -963,7 +963,6 @@ void subsys_dev_iter_init(struct subsys_dev_iter *iter, struct bus_type *subsys,
 	klist_iter_init_node(&subsys->p->klist_devices, &iter->ki, start_knode);
 	iter->type = type;
 }
-EXPORT_SYMBOL_GPL(subsys_dev_iter_init);
 
 /**
  * subsys_dev_iter_next - iterate to the next device
diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index d865440d8c02..a1da2f8647af 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -154,10 +154,6 @@ struct subsys_dev_iter {
 	struct klist_iter		ki;
 	const struct device_type	*type;
 };
-void subsys_dev_iter_init(struct subsys_dev_iter *iter,
-			 struct bus_type *subsys,
-			 struct device *start,
-			 const struct device_type *type);
 struct device *subsys_dev_iter_next(struct subsys_dev_iter *iter);
 void subsys_dev_iter_exit(struct subsys_dev_iter *iter);
 
-- 
2.39.0

