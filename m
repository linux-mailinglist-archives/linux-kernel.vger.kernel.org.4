Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F1863AEF9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 18:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbiK1Rfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 12:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbiK1Rfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 12:35:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EAB24971
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:35:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B2D7612D0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 17:35:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E604C433D6;
        Mon, 28 Nov 2022 17:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669656943;
        bh=gCQQIVDuLlgnkd/wMx8t1XoFRlWkAu6H8eCpOzaxNTY=;
        h=From:To:Cc:Subject:Date:From;
        b=Q8jadwcyItgqNSVdGgWn4dD6mnSLk0RjTC3JneC33GrMjo7Ld4ScWAuOffBZCufYy
         qIq/TA7M6X2jz8kZj4T2tK5KsDbnuPOooxzKv/JOIj7V31GsL6qSMBa/Ca+nYXZRBj
         fzdWxqG4pkqSrtAMzZMTa5zjnULNBNw0ynKbEglE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] driver core: fix up some missing class.devnode() conversions.
Date:   Mon, 28 Nov 2022 18:35:39 +0100
Message-Id: <20221128173539.3112234-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2449; i=gregkh@linuxfoundation.org; h=from:subject; bh=gCQQIVDuLlgnkd/wMx8t1XoFRlWkAu6H8eCpOzaxNTY=; b=owGbwMvMwCRo6H6F97bub03G02pJDMktHzPtTGNUnO41nU+2WdRstsJTXGKd1H6lJvX3Yd/EInji lb91xLIwCDIxyIopsnzZxnN0f8UhRS9D29Mwc1iZQIYwcHEKwEReujEs2C2uVdn0duUV12hRgf6U94 scetZHMsyzl/n8xOqf2BvTsjVFN6Za+FarVDYCAA==
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

In commit ff62b8e6588f ("driver core: make struct class.devnode() take a
const *") the ->devnode callback changed the pointer to be const, but a
few instances of PowerPC drivers were not caught for some reason.

Fix this up by changing the pointers to be const.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Frederic Barrat <fbarrat@linux.ibm.com>
Cc: Andrew Donnellan <ajd@linux.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@lists.ozlabs.org
Fixes: ff62b8e6588f ("driver core: make struct class.devnode() take a const *")
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/platforms/book3s/vas-api.c | 2 +-
 drivers/misc/cxl/file.c                 | 2 +-
 drivers/misc/ocxl/file.c                | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/book3s/vas-api.c b/arch/powerpc/platforms/book3s/vas-api.c
index 40f5ae5e1238..eb5bed333750 100644
--- a/arch/powerpc/platforms/book3s/vas-api.c
+++ b/arch/powerpc/platforms/book3s/vas-api.c
@@ -53,7 +53,7 @@ struct coproc_instance {
 	struct vas_window *txwin;
 };
 
-static char *coproc_devnode(struct device *dev, umode_t *mode)
+static char *coproc_devnode(const struct device *dev, umode_t *mode)
 {
 	return kasprintf(GFP_KERNEL, "crypto/%s", dev_name(dev));
 }
diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
index 3dbdce96fae0..5878329b011a 100644
--- a/drivers/misc/cxl/file.c
+++ b/drivers/misc/cxl/file.c
@@ -546,7 +546,7 @@ static const struct file_operations afu_master_fops = {
 };
 
 
-static char *cxl_devnode(struct device *dev, umode_t *mode)
+static char *cxl_devnode(const struct device *dev, umode_t *mode)
 {
 	if (cpu_has_feature(CPU_FTR_HVMODE) &&
 	    CXL_DEVT_IS_CARD(dev->devt)) {
diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c
index d46dba2df5a1..d96be36405a0 100644
--- a/drivers/misc/ocxl/file.c
+++ b/drivers/misc/ocxl/file.c
@@ -581,7 +581,7 @@ void ocxl_file_unregister_afu(struct ocxl_afu *afu)
 	device_unregister(&info->dev);
 }
 
-static char *ocxl_devnode(struct device *dev, umode_t *mode)
+static char *ocxl_devnode(const struct device *dev, umode_t *mode)
 {
 	return kasprintf(GFP_KERNEL, "ocxl/%s", dev_name(dev));
 }
-- 
2.38.1

