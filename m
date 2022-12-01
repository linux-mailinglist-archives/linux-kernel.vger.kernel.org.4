Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC26B63F858
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 20:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbiLATcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 14:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbiLATbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 14:31:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1BD93830
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 11:31:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24628620E1
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 19:31:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B5B0C433C1;
        Thu,  1 Dec 2022 19:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669923071;
        bh=OMW+Gu7JfxCVUZFbHY9r5VymmfM1mQc182DIRG/A8sg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mTLDKIMtGyP0PvHrBSkiLBaZiNG/i99DC7J/IiuUMbv1Kfx5khSB9raWuJdthRacK
         fh/7OlGO5pgze9DJUaYlw/q7xr3Ru5ex/C/O++2Mq6xkNv7wezeoRLZYa9PkQuO1YF
         FJmzbImbDdbP73tN4hgXexQ8C7zOKsLdiPUU34fI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 4/4] firmware_loader: fix up to_fw_sysfs() to preserve const
Date:   Thu,  1 Dec 2022 20:30:57 +0100
Message-Id: <20221201193057.1195255-4-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221201193057.1195255-1-gregkh@linuxfoundation.org>
References: <20221201193057.1195255-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1426; i=gregkh@linuxfoundation.org; h=from:subject; bh=OMW+Gu7JfxCVUZFbHY9r5VymmfM1mQc182DIRG/A8sg=; b=owGbwMvMwCRo6H6F97bub03G02pJDMmdDB8X75fy8zMRiHB2km8SEOrWdVFb8lq+LElVc8FS8a5e R9GOWBYGQSYGWTFFli/beI7urzik6GVoexpmDisTyBAGLk4BmMgsQYYF83hnfi+sthJ2unrC6l/H3o 7pgcJaDAuOLXk/4+RXlT2Hjtt9WLuHdeO5ZGEHAA==
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

to_fw_sysfs() was changed in commit 23680f0b7d7f ("driver core: make
struct class.dev_uevent() take a const *") to pass in a const pointer
but not pass it back out to handle some changes in the driver core.
That isn't the best idea as it could cause problems if used incorrectly,
so switch to use the container_of_const() macro instead which will
preserve the const status of the pointer and enforce it by the compiler.

Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Russ Weight <russell.h.weight@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Fixes: 23680f0b7d7f ("driver core: make struct class.dev_uevent() take a const *")
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/firmware_loader/sysfs.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/base/firmware_loader/sysfs.h b/drivers/base/firmware_loader/sysfs.h
index fd0b4ad9bdbb..0f0b1f7bf335 100644
--- a/drivers/base/firmware_loader/sysfs.h
+++ b/drivers/base/firmware_loader/sysfs.h
@@ -80,11 +80,8 @@ struct fw_sysfs {
 	struct firmware *fw;
 	void *fw_upload_priv;
 };
-
-static inline struct fw_sysfs *to_fw_sysfs(const struct device *dev)
-{
-	return container_of(dev, struct fw_sysfs, dev);
-}
+#define to_fw_sysfs(__dev)	\
+	container_of_const(struct device, __dev, struct fw_sysfs, dev)
 
 void __fw_load_abort(struct fw_priv *fw_priv);
 
-- 
2.38.1

