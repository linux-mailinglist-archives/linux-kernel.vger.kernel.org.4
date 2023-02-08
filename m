Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE8068ED94
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 12:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjBHLO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 06:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjBHLOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 06:14:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D6125287
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 03:14:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7A6761580
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 11:14:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01F0C433EF;
        Wed,  8 Feb 2023 11:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675854854;
        bh=T/Gau1Y3toa9EdKaEOCfzmg5Z825+EFIEF/6VNE7kyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yA0nLXYQj+fx3znJk9ftO1Ji9w4vEd5UFEUhpCdSfIP4xSgQ5orsG5SFaOy6MQaPq
         QshulD59hguDCEbhAvjTSc4/jMjZrcnTwsHgatUrAB+poxpPGTl75b9EfCbSqAGElg
         lzcDbu+G5ih0liOuwn6revOKXNwfUL1O6GbsNAYU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 19/21] driver core: bus: constify bus_get_kset()
Date:   Wed,  8 Feb 2023 12:13:28 +0100
Message-Id: <20230208111330.439504-20-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208111330.439504-1-gregkh@linuxfoundation.org>
References: <20230208111330.439504-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1197; i=gregkh@linuxfoundation.org; h=from:subject; bh=T/Gau1Y3toa9EdKaEOCfzmg5Z825+EFIEF/6VNE7kyI=; b=owGbwMvMwCRo6H6F97bub03G02pJDMmPm2/Gyp+L/H8iY8dqY+WOU3Ma9GZdNdwvV1l9MmvHM2eb DwHRHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjCRlZ4MCzpbXbJnfJ40+Wli1NSJFn pt/J5lXxgWrL2gvUb5S1HNpbm/fnStNzj4PvTmTAA=
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

The bus_get_kset() function should be taking a const * to bus_type, not
just a * so fix that up.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/bus.c         | 2 +-
 include/linux/device/bus.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index e6043a2d9feb..815638bf63db 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -987,7 +987,7 @@ void bus_notify(struct device *dev, enum bus_notifier_event value)
 	subsys_put(sp);
 }
 
-struct kset *bus_get_kset(struct bus_type *bus)
+struct kset *bus_get_kset(const struct bus_type *bus)
 {
 	struct subsys_private *sp = bus_to_subsys(bus);
 	struct kset *kset;
diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index c0a034ff59b7..425d79d6cf69 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -281,6 +281,6 @@ enum bus_notifier_event {
 	BUS_NOTIFY_DRIVER_NOT_BOUND,
 };
 
-extern struct kset *bus_get_kset(struct bus_type *bus);
+extern struct kset *bus_get_kset(const struct bus_type *bus);
 
 #endif
-- 
2.39.1

