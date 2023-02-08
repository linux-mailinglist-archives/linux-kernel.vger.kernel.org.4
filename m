Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CB468EDA1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 12:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjBHLOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 06:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjBHLOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 06:14:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B02241C2
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 03:14:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E991E6162D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 11:14:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 009D5C433D2;
        Wed,  8 Feb 2023 11:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675854851;
        bh=USqXI1BLX58QBCywv7hi7/+sR7nE+ghRZg0Vc8aHKGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X/yPJn5c3IGJApVFTGbKk4hewPdijdSpqZFtbHRxG7ULDPthWZShSQsA+JeSZ9i7L
         MHJ3j8aEUyRhWPv0o+HVQd712swvlniSHml5ur1bFu6eTiktcCZZO864vADp5ijxfO
         KRRausvHe3nS4t59NWH8k/LZGqb7NHPxVwM5oaJ0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 18/21] driver core: bus: constify bus_register/unregister_notifier()
Date:   Wed,  8 Feb 2023 12:13:27 +0100
Message-Id: <20230208111330.439504-19-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208111330.439504-1-gregkh@linuxfoundation.org>
References: <20230208111330.439504-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1870; i=gregkh@linuxfoundation.org; h=from:subject; bh=USqXI1BLX58QBCywv7hi7/+sR7nE+ghRZg0Vc8aHKGI=; b=owGbwMvMwCRo6H6F97bub03G02pJDMmPm2/eX8CpZc+kK6WqM1vvxqmJws9ta8wKDd/dElR89nJt Y5BjRywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAExkxQKG+alz3893U4mK38++xt77iM DVI6F/dBnmZ3gnt8gdzs6333s+2ONypvW/gs5IAA==
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

The bus_register_notifier() and bus_unregister_notifier() functions
should be taking a const * to bus_type, not just a * so fix that up.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/bus.c         | 4 ++--
 include/linux/device/bus.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 76cfe9cbf3bd..e6043a2d9feb 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -949,7 +949,7 @@ void bus_unregister(struct bus_type *bus)
 }
 EXPORT_SYMBOL_GPL(bus_unregister);
 
-int bus_register_notifier(struct bus_type *bus, struct notifier_block *nb)
+int bus_register_notifier(const struct bus_type *bus, struct notifier_block *nb)
 {
 	struct subsys_private *sp = bus_to_subsys(bus);
 	int retval;
@@ -963,7 +963,7 @@ int bus_register_notifier(struct bus_type *bus, struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(bus_register_notifier);
 
-int bus_unregister_notifier(struct bus_type *bus, struct notifier_block *nb)
+int bus_unregister_notifier(const struct bus_type *bus, struct notifier_block *nb)
 {
 	struct subsys_private *sp = bus_to_subsys(bus);
 	int retval;
diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index 22bf63469275..c0a034ff59b7 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -246,9 +246,9 @@ void bus_sort_breadthfirst(struct bus_type *bus,
  */
 struct notifier_block;
 
-extern int bus_register_notifier(struct bus_type *bus,
+extern int bus_register_notifier(const struct bus_type *bus,
 				 struct notifier_block *nb);
-extern int bus_unregister_notifier(struct bus_type *bus,
+extern int bus_unregister_notifier(const struct bus_type *bus,
 				   struct notifier_block *nb);
 
 /**
-- 
2.39.1

