Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11EF68ED96
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 12:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjBHLPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 06:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjBHLOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 06:14:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E191725287
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 03:14:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DEE361491
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 11:14:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9435CC433D2;
        Wed,  8 Feb 2023 11:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675854861;
        bh=GvFijIBn90h98leK5sXJ9ygGvQHZQz+yMN3VbsMyDaU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZqY8FOf/9eFNEmO26vtRlfxXDpB42dNDfXFdfbB9wjSQ5KTK/R3YFgXwnEV6Jj0o9
         P7/HoxIKRnJhuLxs2MWrPcibnV2wE5pTOGEyrr3Lt0yRmKTmR1c6if7k4tMqhHNQcI
         cFzozfiak5eJX0zLIKeT4IIzhLRIjdKuPdLDjawc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 21/21] driver core: bus: constify bus_unregister()
Date:   Wed,  8 Feb 2023 12:13:30 +0100
Message-Id: <20230208111330.439504-22-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208111330.439504-1-gregkh@linuxfoundation.org>
References: <20230208111330.439504-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1319; i=gregkh@linuxfoundation.org; h=from:subject; bh=GvFijIBn90h98leK5sXJ9ygGvQHZQz+yMN3VbsMyDaU=; b=owGbwMvMwCRo6H6F97bub03G02pJDMmPm2/teaZgmzN/V/p77drFT3RnnbkkYtnllizi7HGq3rCC aWdVRywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAExkmQnDgnmFzzp3Pd+oc9bX4mhIno p4cKzFDYb5fp+M374vMp9w6Xn61X7u2xYK0aEbAA==
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

The bus_unregister() function can now take a const * to bus_type, not
just a * so fix that up.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/bus.c         | 2 +-
 include/linux/device/bus.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index a7aada8817ce..4c85d264113a 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -925,7 +925,7 @@ EXPORT_SYMBOL_GPL(bus_register);
  * Unregister the child subsystems and the bus itself.
  * Finally, we call bus_put() to release the refcount
  */
-void bus_unregister(struct bus_type *bus)
+void bus_unregister(const struct bus_type *bus)
 {
 	struct subsys_private *sp = bus_to_subsys(bus);
 	struct kobject *bus_kobj;
diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index 425d79d6cf69..31be18608f83 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -114,7 +114,7 @@ struct bus_type {
 
 extern int __must_check bus_register(struct bus_type *bus);
 
-extern void bus_unregister(struct bus_type *bus);
+extern void bus_unregister(const struct bus_type *bus);
 
 extern int __must_check bus_rescan_devices(struct bus_type *bus);
 
-- 
2.39.1

