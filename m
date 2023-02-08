Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4FE768ED8B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 12:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjBHLON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 06:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjBHLN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 06:13:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45A1252A4
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 03:13:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62A8761156
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 11:13:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702EFC433EF;
        Wed,  8 Feb 2023 11:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675854836;
        bh=LMftmsNT9WQmQkGCTmoc3x+umeDLzNUWfcY25S5rOlg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h2d6QuMcOkG5vzLgxVR/9N9RylaIeEKl/bN/eHrBl06VNTyrpGx2kKaF4tYd2MMYJ
         /TbJkK1+bBiMBeHcswJpEeipw69067V6jx4KXiTDKrLIPqHVrNXIjXGA3DBEd5x+08
         adzWUNZPoboBmRU0wv0J1OyFGsBOBo7qLJie62SA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 13/21] driver core: bus: clean up bus_sort_breadthfirst()
Date:   Wed,  8 Feb 2023 12:13:22 +0100
Message-Id: <20230208111330.439504-14-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208111330.439504-1-gregkh@linuxfoundation.org>
References: <20230208111330.439504-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1797; i=gregkh@linuxfoundation.org; h=from:subject; bh=LMftmsNT9WQmQkGCTmoc3x+umeDLzNUWfcY25S5rOlg=; b=owGbwMvMwCRo6H6F97bub03G02pJDMmPm29sXFWgMVODe0+LS1yTXt7CmttzRZytevQa5LjW7TpU z3K1I5aFQZCJQVZMkeXLNp6j+ysOKXoZ2p6GmcPKBDKEgYtTACZSk82wYNbatgn/y1TnZhXUrwkqFN H39FQsZ5jNGnYmLmH7dt+L79c5X4sW+JA4W/wUAA==
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

Convert the bus_sort_breadthfirst() function to use bus_to_subsys() and
not use the back-pointer to the private structure.

This also allows us to get rid of bus_get_device_klist() which was only
being used by this one internal function.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/bus.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index c007524151d2..87e21aafe6e6 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -1006,11 +1006,6 @@ struct kset *bus_get_kset(struct bus_type *bus)
 }
 EXPORT_SYMBOL_GPL(bus_get_kset);
 
-static struct klist *bus_get_device_klist(struct bus_type *bus)
-{
-	return &bus->p->klist_devices;
-}
-
 /*
  * Yes, this forcibly breaks the klist abstraction temporarily.  It
  * just wants to sort the klist, not change reference counts and
@@ -1042,13 +1037,16 @@ void bus_sort_breadthfirst(struct bus_type *bus,
 			   int (*compare)(const struct device *a,
 					  const struct device *b))
 {
+	struct subsys_private *sp = bus_to_subsys(bus);
 	LIST_HEAD(sorted_devices);
 	struct klist_node *n, *tmp;
 	struct device_private *dev_prv;
 	struct device *dev;
 	struct klist *device_klist;
 
-	device_klist = bus_get_device_klist(bus);
+	if (!sp)
+		return;
+	device_klist = &sp->klist_devices;
 
 	spin_lock(&device_klist->k_lock);
 	list_for_each_entry_safe(n, tmp, &device_klist->k_list, n_node) {
@@ -1058,6 +1056,7 @@ void bus_sort_breadthfirst(struct bus_type *bus,
 	}
 	list_splice(&sorted_devices, &device_klist->k_list);
 	spin_unlock(&device_klist->k_lock);
+	subsys_put(sp);
 }
 EXPORT_SYMBOL_GPL(bus_sort_breadthfirst);
 
-- 
2.39.1

