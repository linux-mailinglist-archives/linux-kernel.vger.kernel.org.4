Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37956CB1E9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 00:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbjC0WqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 18:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjC0WqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 18:46:15 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90FB1BE1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 15:46:14 -0700 (PDT)
Received: from hatter.bewilderbeest.net (174-21-172-149.tukw.qwest.net [174.21.172.149])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 5564E6E0;
        Mon, 27 Mar 2023 15:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1679957174;
        bh=L6bjh3nzL4FxrijRbntIGwR2Sk25I75O/1vW83a/498=;
        h=From:To:Cc:Subject:Date:From;
        b=jCYRA/ZjowslwnigucIbcVrhRDs3MlStV70ahHY9IK2AFPen/Tl02fwfd7LohvJ3F
         QjcbS7xr97W/NusH2F5kThyT4NzeL5Ebi5ewls0g//4GjSlvmE3Z9TARMQ2K8Sw7JI
         yhmsx45XSTHh84TbtgX0qTKjlg6s9PYzLyAFKikI=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Iwona Winiarska <iwona.winiarska@intel.com>
Cc:     Zev Weiss <zev@bewilderbeest.net>,
        Andrew Jeffery <andrew@aj.id.au>,
        Joel Stanley <joel@jms.id.au>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Subject: [PATCH] peci: Constify struct peci_controller_ops
Date:   Mon, 27 Mar 2023 15:43:15 -0700
Message-Id: <20230327224315.11135-1-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As with most ops structs, we never modify it at runtime, and keeping
function pointers in read-only memory is generally a good thing
security-wise.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
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
2.40.0.5.gf6e3b97ba6d2.dirty

