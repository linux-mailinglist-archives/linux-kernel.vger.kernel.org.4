Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B71873BA27
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjFWO2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbjFWO2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:28:35 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED682697
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687530511; x=1719066511;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OMKOEe6vxOIvkUlJ4fPr7hFiy8k9LqukaDfPjPUN088=;
  b=dr/K+4M8Xt+DlJqhZs1VnkX7GZQZe227Fy+BsnUF/XXN2tPuMQf1WYAL
   8HAOyS7jtHik+Et7nFQVV6IydaxMU8B6ohU+t08cm6ltMQjtn7+pVJRKv
   aKDMnQCS1aBuk9OU/9HQsRibMAvavKO5CfSag4NEDncR4VNnkP6nSdObW
   QzYSmMGJoW/Mut4/0UtzzOqcKvcgV/j+QLI4bFxKfffgC/OKirpcnzOMX
   Nl4GPwhKdY1+xKB/JX4gRRmO5s+V2uQUG59XUsu0KrpKR7i+s5llCWR+j
   k1BN781PoZz0jofhwU/yCT5dWchPN4Dq6+aucvN2ettriC5V0jhHtfd0e
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="358265762"
X-IronPort-AV: E=Sophos;i="6.01,152,1684825200"; 
   d="scan'208";a="358265762"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 07:28:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="715340305"
X-IronPort-AV: E=Sophos;i="6.01,152,1684825200"; 
   d="scan'208";a="715340305"
Received: from dankowsk-mobl.ger.corp.intel.com (HELO localhost) ([10.249.147.61])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 07:28:29 -0700
From:   Iwona Winiarska <iwona.winiarska@intel.com>
To:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zev Weiss <zev@bewilderbeest.net>,
        Iwona Winiarska <iwona.winiarska@intel.com>
Subject: [PATCH] peci: Constify struct peci_controller_ops
Date:   Fri, 23 Jun 2023 16:28:05 +0200
Message-Id: <20230623142805.577612-1-iwona.winiarska@intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zev Weiss <zev@bewilderbeest.net>

As with most ops structs, we never modify it at runtime, and keeping
function pointers in read-only memory is generally a good thing
security-wise.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
Link: https://lore.kernel.org/r/20230327224315.11135-1-zev@bewilderbeest.net
Reviewed-by: Iwona Winiarska <iwona.winiarska@intel.com>
Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
---
 drivers/peci/controller/peci-aspeed.c | 2 +-
 drivers/peci/core.c                   | 4 ++--
 include/linux/peci.h                  | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/peci/controller/peci-aspeed.c b/drivers/peci/controller/peci-aspeed.c
index 731c5d8f75c6..7fdc25afcf2f 100644
--- a/drivers/peci/controller/peci-aspeed.c
+++ b/drivers/peci/controller/peci-aspeed.c
@@ -468,7 +468,7 @@ static void aspeed_peci_property_setup(struct aspeed_peci *priv)
 				      ASPEED_PECI_CMD_TIMEOUT_MS_DEFAULT, &priv->cmd_timeout_ms);
 }
 
-static struct peci_controller_ops aspeed_ops = {
+static const struct peci_controller_ops aspeed_ops = {
 	.xfer = aspeed_peci_xfer,
 };
 
diff --git a/drivers/peci/core.c b/drivers/peci/core.c
index 9c8cf07e51c7..0f83a9c6093b 100644
--- a/drivers/peci/core.c
+++ b/drivers/peci/core.c
@@ -44,7 +44,7 @@ int peci_controller_scan_devices(struct peci_controller *controller)
 }
 
 static struct peci_controller *peci_controller_alloc(struct device *dev,
-						     struct peci_controller_ops *ops)
+						     const struct peci_controller_ops *ops)
 {
 	struct peci_controller *controller;
 	int ret;
@@ -113,7 +113,7 @@ static void unregister_controller(void *_controller)
  * Return: Pointer to the newly allocated controller or ERR_PTR() in case of failure.
  */
 struct peci_controller *devm_peci_controller_add(struct device *dev,
-						 struct peci_controller_ops *ops)
+						 const struct peci_controller_ops *ops)
 {
 	struct peci_controller *controller;
 	int ret;
diff --git a/include/linux/peci.h b/include/linux/peci.h
index 06e6ef935297..9b3d36aff431 100644
--- a/include/linux/peci.h
+++ b/include/linux/peci.h
@@ -42,13 +42,13 @@ struct peci_controller_ops {
  */
 struct peci_controller {
 	struct device dev;
-	struct peci_controller_ops *ops;
+	const struct peci_controller_ops *ops;
 	struct mutex bus_lock; /* held for the duration of xfer */
 	u8 id;
 };
 
 struct peci_controller *devm_peci_controller_add(struct device *parent,
-						 struct peci_controller_ops *ops);
+						 const struct peci_controller_ops *ops);
 
 static inline struct peci_controller *to_peci_controller(void *d)
 {
-- 
2.40.1

