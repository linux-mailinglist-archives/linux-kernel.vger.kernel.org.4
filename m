Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92BD06C5160
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 17:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjCVQ6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 12:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjCVQ6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 12:58:11 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2431716A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 09:58:10 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7938320012;
        Wed, 22 Mar 2023 16:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1679504289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NwGFCbZSoqGsZ7G/hAD6P/+MSzXVxeFCZOQ7R1WJyko=;
        b=RgP3X2dB2tYp3ATPhT+w1AzWTbMO7BhURoilAvptfZEfFw019qL/K0r5CcvZXmiOKGEHh1
        pqGp7MQnxe+nLuj26Msb6SGhu9HZMe4QXYstpe5QMiIQDPqjLoXVV6HCZb233eJTYVyaIa
        H3Hx2xTRjl5nYW6il2kz0TXhfK4Zs8Crq6E59s2BLvSijWwLvO39dB26HzuhFCpklucaN3
        VIxd8b5lTwPbmZ2xNwj7oZZF9mpTUJJnihI+adOBcikg0TgcyME4xzfYbomO/UeAuzkrHe
        1sr3Fej+8mw4yOiYEYF8WW+YdvSQM5UBjnNa6+qaMZJcpP3FFgO0l5cpYp6u2w==
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
Subject: [PATCH v2 3/4] nvmem: layouts: onie-tlv: Use module_nvmem_layout_driver()
Date:   Wed, 22 Mar 2023 17:58:03 +0100
Message-Id: <20230322165804.2240285-4-miquel.raynal@bootlin.com>
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
 drivers/nvmem/layouts/onie-tlv.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/nvmem/layouts/onie-tlv.c b/drivers/nvmem/layouts/onie-tlv.c
index d45b7301a69d..661093de33b4 100644
--- a/drivers/nvmem/layouts/onie-tlv.c
+++ b/drivers/nvmem/layouts/onie-tlv.c
@@ -237,19 +237,7 @@ static struct nvmem_layout onie_tlv_layout = {
 	.of_match_table = onie_tlv_of_match_table,
 	.add_cells = onie_tlv_parse_table,
 };
-
-static int __init onie_tlv_init(void)
-{
-	return nvmem_layout_register(&onie_tlv_layout);
-}
-
-static void __exit onie_tlv_exit(void)
-{
-	nvmem_layout_unregister(&onie_tlv_layout);
-}
-
-module_init(onie_tlv_init);
-module_exit(onie_tlv_exit);
+module_nvmem_layout_driver(onie_tlv_layout);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Miquel Raynal <miquel.raynal@bootlin.com>");
-- 
2.34.1

