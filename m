Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490726C7AC8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 10:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjCXJI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 05:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbjCXJIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 05:08:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42ECB59C9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 02:08:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCA84629C9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 09:08:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6269C4339B;
        Fri, 24 Mar 2023 09:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679648899;
        bh=75VgEUusjpyyPrc25gEBtohFIWCJvQPmRGpXQUpk4N8=;
        h=From:To:Cc:Subject:Date:From;
        b=Je/O+s9aWE0fr4le82h+MNhr1Jj1pJ6pH/oBJ7O76nAjmHndSK3ipXmlI8E6ZXNW2
         +q2syWNq0r+udmI3HJGGBKpW8UGAhrA1sjGjKkD5W/w+L7CZ91XENGpB2fl2cDevCa
         tK2c7WOyQhmC0upm+K0nNNGOlODm28DPdKNgV8AY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] driver core: bus: move documentation for lock_key to proper location.
Date:   Fri, 24 Mar 2023 10:08:14 +0100
Message-Id: <20230324090814.386654-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1770; i=gregkh@linuxfoundation.org; h=from:subject; bh=75VgEUusjpyyPrc25gEBtohFIWCJvQPmRGpXQUpk4N8=; b=owGbwMvMwCRo6H6F97bub03G02pJDCmyGbUnIrMXPyk/cLfmtdsB5nUCrCdq1m26/Yk3ffrRc v0jS0yDOmJZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAifhsZ5tlsk0n8OW/B7JOn 9RauWm/EybzC4ATD/LqJlyerKHCkzos+znt/ZkOayIkJ8wE=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 37e98d9bedb5 ("driver core: bus: move lock_class_key into
dynamic structure"), the lock_key variable moved out of struct bus_type
and into struct subsys_private, yet the documentation for it did not
move.  Fix that up and place the documentation comment in the correct
location.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Fixes: 37e98d9bedb5 ("driver core: bus: move lock_class_key into dynamic structure")
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/base.h        | 1 +
 include/linux/device/bus.h | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 09c6682d16b5..5cca43a124ba 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -33,6 +33,7 @@
  *              avoid namespace conflicts
  * @class - pointer back to the struct class that this structure is associated
  *          with.
+ * @lock_key:	Lock class key for use by the lock validator
  *
  * This structure is the one that is the actual kobject allowing struct
  * bus_type/class to be statically allocated safely.  Nothing outside of the
diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index b517b82d4723..05a0c4992a49 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -65,7 +65,6 @@ struct fwnode_handle;
  * @iommu_ops:  IOMMU specific operations for this bus, used to attach IOMMU
  *              driver implementations to a bus and allow the driver to do
  *              bus-specific setup
- * @lock_key:	Lock class key for use by the lock validator
  * @need_parent_lock:	When probing or removing a device on this bus, the
  *			device core should lock the device's parent.
  *
-- 
2.40.0

