Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF97464E088
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 19:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiLOSTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 13:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbiLOSTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 13:19:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC1248746;
        Thu, 15 Dec 2022 10:19:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2A23B81C1F;
        Thu, 15 Dec 2022 18:19:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67BEDC433D2;
        Thu, 15 Dec 2022 18:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671128339;
        bh=78tX3t6kUkY6BMXVJo5OYZXMdsWwwpj5lrEjbZ2nP5k=;
        h=From:To:Cc:Subject:Date:From;
        b=FskV9TVhDGw/J3zgBg0l/b33IrEveHitlVioGB/zPpBgsy+Rqi5GUybZXmQB+EPT/
         MGo8+xWqRtpyI5EJpJmAtwbcP+WWKjKJ5cSKfRNS/R0OWeVhnOcscgK5+W9/ge/k8c
         FKckAFwV/A/vWObAeBKHTZy9+oOuvoKKM9+Hj9SV4KyvMdkLC0q+hJVKVupUS0ghpO
         8SYIt57hOCe7GOq141BQiwSW7Qe4IHyTnga7w5Jw4L4dvfUyKqR+gOMUFhC1njhh07
         eZachBoK9k5ZPm+Xzt2DuLkOqMv3HluGy7fcPsPtb3q+kiMG+Nuy4OJDH5Im01BQOU
         zYj2RdwEuXUyQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PM: runtime: Simplify __rpm_get_callback()
Date:   Thu, 15 Dec 2022 12:18:48 -0600
Message-Id: <20221215181848.129326-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Simplify __rpm_get_callback() slightly by returning as soon as the return
value is known.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/base/power/runtime.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 50e726b6c2cf..7171ed0668f3 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -20,8 +20,7 @@ typedef int (*pm_callback_t)(struct device *);
 
 static pm_callback_t __rpm_get_callback(struct device *dev, size_t cb_offset)
 {
-	pm_callback_t cb;
-	const struct dev_pm_ops *ops;
+	const struct dev_pm_ops *ops = NULL;
 
 	if (dev->pm_domain)
 		ops = &dev->pm_domain->ops;
@@ -31,18 +30,14 @@ static pm_callback_t __rpm_get_callback(struct device *dev, size_t cb_offset)
 		ops = dev->class->pm;
 	else if (dev->bus && dev->bus->pm)
 		ops = dev->bus->pm;
-	else
-		ops = NULL;
 
 	if (ops)
-		cb = *(pm_callback_t *)((void *)ops + cb_offset);
-	else
-		cb = NULL;
+		return *(pm_callback_t *)((void *)ops + cb_offset);
 
-	if (!cb && dev->driver && dev->driver->pm)
-		cb = *(pm_callback_t *)((void *)dev->driver->pm + cb_offset);
+	if (dev->driver && dev->driver->pm)
+		return *(pm_callback_t *)((void *)dev->driver->pm + cb_offset);
 
-	return cb;
+	return NULL;
 }
 
 #define RPM_GET_CALLBACK(dev, callback) \
-- 
2.25.1

