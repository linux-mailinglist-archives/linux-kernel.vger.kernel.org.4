Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8ED662DEB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 19:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235146AbjAISA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 13:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237586AbjAIR75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:59:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AD914D32
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 09:58:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 947446118C
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 17:58:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B30FC433D2;
        Mon,  9 Jan 2023 17:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673287108;
        bh=+rI8BJUgXMR23K7j+ZjrV8N++uXKYqvXjYfLE+9lV1w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NELM2bxbnm2T7KTU8O4VecpZOumn66qv5lFol+hr0r5qWMzyYfUz7B+vke66Ngcs4
         0PPV4CzOIH+suM1cmyF4VBynC5RoSI27+Mxf2PiMihLbeWitzfSjU3IR+lUcj05CmI
         UBqBMwsuBSxGOujyB5VXeU19GNKF0m9rbj5eODuU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 5/6] driver core: make subsys_dev_iter_exit() static
Date:   Mon,  9 Jan 2023 18:58:09 +0100
Message-Id: <20230109175810.2965448-5-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230109175810.2965448-1-gregkh@linuxfoundation.org>
References: <20230109175810.2965448-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1536; i=gregkh@linuxfoundation.org; h=from:subject; bh=+rI8BJUgXMR23K7j+ZjrV8N++uXKYqvXjYfLE+9lV1w=; b=owGbwMvMwCRo6H6F97bub03G02pJDMl7Qjcxz34htOjSrbl9dxdX2lRGvcp6fYVBZ8GcOJaHEskr FnAKdcSyMAgyMciKKbJ82cZzdH/FIUUvQ9vTMHNYmUCGMHBxCsBEpl5jmB+ZJcC6L7izJO3PtB8Lts 80jYxLNmSYHzNB4wNb9zXGDyK7tfXkRZQvZMRMBAA=
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

The function subsys_dev_iter_exit() is not used outside of
drivers/base/bus.c so make it static to that file and remove the global
export.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/bus.c         | 3 +--
 include/linux/device/bus.h | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 4be73f58d0ad..e0fe07872a74 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -998,11 +998,10 @@ static struct device *subsys_dev_iter_next(struct subsys_dev_iter *iter)
  * Finish an iteration.  Always call this function after iteration is
  * complete whether the iteration ran till the end or not.
  */
-void subsys_dev_iter_exit(struct subsys_dev_iter *iter)
+static void subsys_dev_iter_exit(struct subsys_dev_iter *iter)
 {
 	klist_iter_exit(&iter->ki);
 }
-EXPORT_SYMBOL_GPL(subsys_dev_iter_exit);
 
 int subsys_interface_register(struct subsys_interface *sif)
 {
diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index 5a7590bc7913..ffa562f2d975 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -154,7 +154,6 @@ struct subsys_dev_iter {
 	struct klist_iter		ki;
 	const struct device_type	*type;
 };
-void subsys_dev_iter_exit(struct subsys_dev_iter *iter);
 
 int bus_for_each_dev(struct bus_type *bus, struct device *start, void *data,
 		     int (*fn)(struct device *dev, void *data));
-- 
2.39.0

