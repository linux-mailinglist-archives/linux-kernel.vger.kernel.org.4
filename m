Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0DD2631D3F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 10:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbiKUJrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 04:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiKUJrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 04:47:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0304976ED;
        Mon, 21 Nov 2022 01:47:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6042F60FA5;
        Mon, 21 Nov 2022 09:47:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA49C433C1;
        Mon, 21 Nov 2022 09:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669024033;
        bh=gmfaWGBSorIYw4Zwv5/28r4h97AtvcQ5z5+f8XvcvKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IsXkM6S0Q5gHIt2WC6JfP9kkxoBLjduIwsWgNBO0HsHmrrISN3lUCKmLbWiPkPLOy
         rJay10xnOPbXzmUlOFsA5FYTt7IfxffQgYSjJPJ2eCRB7KOhuevM42OjseGKo8EtjN
         UjjwP5VXWOBHM6w2bNjrZ36JTuMxJbE6X4dGO9u4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Subject: [PATCH 5/5] driver core: pass a const * into of_device_uevent()
Date:   Mon, 21 Nov 2022 10:46:49 +0100
Message-Id: <20221121094649.1556002-5-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221121094649.1556002-1-gregkh@linuxfoundation.org>
References: <20221121094649.1556002-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2328; i=gregkh@linuxfoundation.org; h=from:subject; bh=gmfaWGBSorIYw4Zwv5/28r4h97AtvcQ5z5+f8XvcvKs=; b=owGbwMvMwCRo6H6F97bub03G02pJDMnVnpx5T7Ju3t5s9dnoy+EDZYYtHicKhRtu9wXwN18qPOXX z1jeEcvCIMjEICumyPJlG8/R/RWHFL0MbU/DzGFlAhnCwMUpABOZvpphwZKtfN5/Q9rbAlzYmwLnSX YdtXt+lWEOF2vo6utq0m8Lbm5r3poysetq8mRLAA==
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

of_device_uevent() does not modify the struct device * passed into it,
so make it a const * to enforce this.  Also the documentation for the
function was really wrong so fix that up at the same time.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/of/device.c       | 6 +++---
 include/linux/of_device.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 8cefe5a7d04e..c674a13c3055 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -332,10 +332,10 @@ EXPORT_SYMBOL_GPL(of_device_modalias);
 
 /**
  * of_device_uevent - Display OF related uevent information
- * @dev:	Device to apply DMA configuration
- * @env:	Kernel object's userspace event reference
+ * @dev:	Device to display the uevent information for
+ * @env:	Kernel object's userspace event reference to fill up
  */
-void of_device_uevent(struct device *dev, struct kobj_uevent_env *env)
+void of_device_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
 	const char *compat, *type;
 	struct alias_prop *app;
diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index 1a803e4335d3..ab7d557d541d 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -35,7 +35,7 @@ extern const void *of_device_get_match_data(const struct device *dev);
 extern ssize_t of_device_modalias(struct device *dev, char *str, ssize_t len);
 extern int of_device_request_module(struct device *dev);
 
-extern void of_device_uevent(struct device *dev, struct kobj_uevent_env *env);
+extern void of_device_uevent(const struct device *dev, struct kobj_uevent_env *env);
 extern int of_device_uevent_modalias(struct device *dev, struct kobj_uevent_env *env);
 
 static inline struct device_node *of_cpu_device_node_get(int cpu)
@@ -64,7 +64,7 @@ static inline int of_driver_match_device(struct device *dev,
 	return 0;
 }
 
-static inline void of_device_uevent(struct device *dev,
+static inline void of_device_uevent(const struct device *dev,
 			struct kobj_uevent_env *env) { }
 
 static inline const void *of_device_get_match_data(const struct device *dev)
-- 
2.38.1

