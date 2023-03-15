Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627ED6BACEC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 11:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjCOKDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 06:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbjCOKDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 06:03:03 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA13FB744
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 03:01:43 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E73A9240011;
        Wed, 15 Mar 2023 10:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678874501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jt9qgapM8J5DKazv/oWWgNBLPyduMWHrHscsdhszKMY=;
        b=QEJSqsnoSJ+269GXUhQjsEnllspJdika/YcF8pLZT6HGJNwtoOQW2P56DGh8xsH2bZ/9s/
        FxQOG/nuvRO8c4CDCeRtWVmHjGk2hcqtGkuw79SFFcZRmb6y0f69hsk+iS8igKN/rYy1sq
        EXDqLo2gTjBg/T1AZXqLmwmLc4rXorhcv4SpUYTSbib2WTCdNFBRSL3myVjraMX1zCPfVZ
        kv8bE/I6mpsYEZuxy4JzQCcWsUMLFZWCGaAupqM9yFSX+qdnvtdKYBcE/prkaEhbWuOpt3
        /52djAPVy/Os+78FLGVI7f0rKanznUI/P3HGZsm+9Bp2hueT0dZB/oKr+JJ50Q==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
Cc:     Michael Walle <michael@walle.cc>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 2/4] nvmem: layouts: sl28vpd: Use module_nvmem_layout_driver()
Date:   Wed, 15 Mar 2023 11:00:16 +0100
Message-Id: <20230315100018.1660071-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230315100018.1660071-1-miquel.raynal@bootlin.com>
References: <20230315100018.1660071-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stop open-coding the module init/exit functions. Use the
module_nvmem_layout_driver() instead.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/nvmem/layouts/sl28vpd.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/nvmem/layouts/sl28vpd.c b/drivers/nvmem/layouts/sl28vpd.c
index 9370e41bad73..9cc1715c2fd5 100644
--- a/drivers/nvmem/layouts/sl28vpd.c
+++ b/drivers/nvmem/layouts/sl28vpd.c
@@ -146,19 +146,7 @@ struct nvmem_layout sl28vpd_layout = {
 	.of_match_table = sl28vpd_of_match_table,
 	.add_cells = sl28vpd_add_cells,
 };
-
-static int __init sl28vpd_init(void)
-{
-	return nvmem_layout_register(&sl28vpd_layout);
-}
-
-static void __exit sl28vpd_exit(void)
-{
-	nvmem_layout_unregister(&sl28vpd_layout);
-}
-
-module_init(sl28vpd_init);
-module_exit(sl28vpd_exit);
+module_nvmem_layout_driver(sl28vpd_layout);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Michael Walle <michael@walle.cc>");
-- 
2.34.1

