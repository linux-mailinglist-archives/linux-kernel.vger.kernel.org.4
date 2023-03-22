Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00916C515E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 17:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjCVQ6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 12:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjCVQ6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 12:58:10 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8183216896
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 09:58:09 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6622F20009;
        Wed, 22 Mar 2023 16:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1679504288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jt9qgapM8J5DKazv/oWWgNBLPyduMWHrHscsdhszKMY=;
        b=RrBp+8AnozFWRI7Ebsi2JnY9XFrK357oc/ZwHII6pBd62JgMCW013M2PDzhT4RQRAplu3P
        Ne1WDN/m2fyO7SVUV9rnFc+xP8PHUZJqImVsH6cVqrVkddneIcxTN1iyFh0LLzdYG9Nh20
        R1HmBcHPFGIFMXEo23QKkfSPMdXDNOE4KrJ9QuflYgbv4WPHzk8DpVV8Zktk9Mwn4fDeCe
        qhmdZ2Uq2VqFAc4xglVe7rfrr3NMzCWAHqVaQROtIzQnAIaeRRAzNXVTHi/9TwuQYBM1d8
        1zPbMMLXPsMPKsGS4hjtRL0gcHnWL5ecwDmSwQhMnq7HjkMfX6BlFsBwTK4Hjg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Michael Walle <michael@walle.cc>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 2/4] nvmem: layouts: sl28vpd: Use module_nvmem_layout_driver()
Date:   Wed, 22 Mar 2023 17:58:02 +0100
Message-Id: <20230322165804.2240285-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230322165804.2240285-1-miquel.raynal@bootlin.com>
References: <20230322165804.2240285-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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

