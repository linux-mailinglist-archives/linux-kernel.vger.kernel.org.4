Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487837058AD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 22:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjEPUWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 16:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjEPUVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 16:21:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862819034;
        Tue, 16 May 2023 13:21:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0440663620;
        Tue, 16 May 2023 20:21:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ABAAC433EF;
        Tue, 16 May 2023 20:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684268498;
        bh=bIicD6gRU90W8lIoeCPzUX3DM76ZJNapL2GUNon+oYc=;
        h=From:To:Cc:Subject:Date:From;
        b=ZmqwHBJQbGjxtCnjYVmgoNPMHvdH3Sk8FKUccNpdIPHjNwR1R6jeSZuWBTf5c/8CB
         gfdIWCqrVH9j1En9uWb9amUM2zyHPtmNNrdviVXyraoUXVMkU+WG2eYhjRnoyGgqJD
         xT8zoZYYhRKDnmC9tr7zLyo7S8sWOq7T0rZSRLYOi/5twWbh3ddNw4MAVM/RzezIzl
         MUFSJeg0qdydkXR0AYJHygwU7tIc1dHNWSm13r5i/9NrkPQw+rTdKIeQrOoCPNjqUm
         AMJhDZWQ2f/GN/Fl1nuQk+q7ZLk7dOChocIVEVPxMm7RZc67LGi+JuU7zRfJpd2LP3
         GPCGmELN8gOGQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-mips@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: rawnand: ingenic: fix empty stub helper definitions
Date:   Tue, 16 May 2023 22:21:24 +0200
Message-Id: <20230516202133.559488-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

A few functions provide an empty interface definition when
CONFIG_MTD_NAND_INGENIC_ECC is disabled, but they are accidentally
defined as global functions in the header:

drivers/mtd/nand/raw/ingenic/ingenic_ecc.h:39:5: error: no previous prototype for 'ingenic_ecc_calculate'
drivers/mtd/nand/raw/ingenic/ingenic_ecc.h:46:5: error: no previous prototype for 'ingenic_ecc_correct'
drivers/mtd/nand/raw/ingenic/ingenic_ecc.h:53:6: error: no previous prototype for 'ingenic_ecc_release'
drivers/mtd/nand/raw/ingenic/ingenic_ecc.h:57:21: error: no previous prototype for 'of_ingenic_ecc_get'

Turn them into 'static inline' definitions instead.

Fixes: 15de8c6efd0e ("mtd: rawnand: ingenic: Separate top-level and SoC specific code")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mtd/nand/raw/ingenic/ingenic_ecc.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/ingenic/ingenic_ecc.h b/drivers/mtd/nand/raw/ingenic/ingenic_ecc.h
index 2cda439b5e11..017868f59f22 100644
--- a/drivers/mtd/nand/raw/ingenic/ingenic_ecc.h
+++ b/drivers/mtd/nand/raw/ingenic/ingenic_ecc.h
@@ -36,25 +36,25 @@ int ingenic_ecc_correct(struct ingenic_ecc *ecc,
 void ingenic_ecc_release(struct ingenic_ecc *ecc);
 struct ingenic_ecc *of_ingenic_ecc_get(struct device_node *np);
 #else /* CONFIG_MTD_NAND_INGENIC_ECC */
-int ingenic_ecc_calculate(struct ingenic_ecc *ecc,
+static inline int ingenic_ecc_calculate(struct ingenic_ecc *ecc,
 			  struct ingenic_ecc_params *params,
 			  const u8 *buf, u8 *ecc_code)
 {
 	return -ENODEV;
 }
 
-int ingenic_ecc_correct(struct ingenic_ecc *ecc,
+static inline int ingenic_ecc_correct(struct ingenic_ecc *ecc,
 			struct ingenic_ecc_params *params, u8 *buf,
 			u8 *ecc_code)
 {
 	return -ENODEV;
 }
 
-void ingenic_ecc_release(struct ingenic_ecc *ecc)
+static inline void ingenic_ecc_release(struct ingenic_ecc *ecc)
 {
 }
 
-struct ingenic_ecc *of_ingenic_ecc_get(struct device_node *np)
+static inline struct ingenic_ecc *of_ingenic_ecc_get(struct device_node *np)
 {
 	return ERR_PTR(-ENODEV);
 }
-- 
2.39.2

