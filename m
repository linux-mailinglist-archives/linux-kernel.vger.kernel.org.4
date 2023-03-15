Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D286BACED
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 11:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjCOKDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 06:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjCOKDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 06:03:12 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1C93C30
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 03:01:48 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C5E94240017;
        Wed, 15 Mar 2023 10:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678874506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NwGFCbZSoqGsZ7G/hAD6P/+MSzXVxeFCZOQ7R1WJyko=;
        b=hRZWVl+cemyALVywZ7FAy4etTmVvT+lGYLpREwYln9ATVv6SCGk+Jytfo+oU9MUsGMymwS
        FQEOIMKtFnTrLJ9VYSErRsur+o6O4CkUUWNo4USf/c4UQsa7uCnC95HpnUB/KydV0roAso
        Kg+ljwQ88styGW9KfENQcF1nX+/4g8yb1RN0uJyMiaB+FFfi+M/pfpRgTr02HcOkeDzd0k
        +m1f2RDxlZ+8RHYNhcm4Q2feoATNb661aDNMieI9ngG9roOGReU7t0OfDFOeuCknIwu4EW
        rFq5836FPQ8xkynNL7bpGS0kkfSQqz67o5RZYKxgpmsjvUH56BAAs29SwKd/Yg==
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
Subject: [PATCH 3/4] nvmem: layouts: onie-tlv: Use module_nvmem_layout_driver()
Date:   Wed, 15 Mar 2023 11:00:17 +0100
Message-Id: <20230315100018.1660071-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230315100018.1660071-1-miquel.raynal@bootlin.com>
References: <20230315100018.1660071-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

