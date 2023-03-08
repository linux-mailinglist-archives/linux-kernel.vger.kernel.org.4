Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F9A6B00D8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 09:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjCHIWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 03:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjCHIVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 03:21:22 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660B3144AF
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 00:20:53 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id A73E216FE;
        Wed,  8 Mar 2023 09:20:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1678263632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ktfcqSBRe8eRK5A5gzbgUANLuCVChHFFCI/4vtIw9Fw=;
        b=Z8xfJu6e78pT1XFtaYdWug4JDZB8LYDQj0qyNdu9780y1EN7Z/O9wigVQ0VR07GfTzM1Q5
        wFdBO7Q+0X8DzEbai2KJusBhyyGVU7Ikai4M8417Vm00dFkOhhHlrpNFjVVu6enyNQYz2P
        y3YShXURejpkbG+Xc7dUWobXW62+5wEJSVkZLn+5t3FMa91V8B7uKuzEAr5I30iwbQMNNF
        yOzj5NQ0NWOBUf4tT4OBoBJ7SK+cDMxwjJ5LJB8GNfSFG0UvlKOPYiTDsnZXNDnIWMUunz
        XroHmi+w1bpARuCpoio/PtboD11Prcfx5fPB8L70F8IIQEH4KuFbdVG1rpjEHg==
From:   Michael Walle <michael@walle.cc>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 4/4] mtd: core: prepare mtd_otp_nvmem_add() to handle -EPROBE_DEFER
Date:   Wed,  8 Mar 2023 09:20:21 +0100
Message-Id: <20230308082021.870459-4-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230308082021.870459-1-michael@walle.cc>
References: <20230308082021.870459-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NVMEM soon will get the ability for nvmem layouts and these might
not be ready when nvmem_register() is called and thus it might
return -EPROBE_DEFER. Don't print the error message in this case.

Signed-off-by: Michael Walle <michael@walle.cc>
---
v2:
 - none

 drivers/mtd/mtdcore.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 0bc9676fe029..83a22566a8ce 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -953,8 +953,8 @@ static int mtd_otp_nvmem_add(struct mtd_info *mtd)
 			nvmem = mtd_otp_nvmem_register(mtd, "user-otp", size,
 						       mtd_nvmem_user_otp_reg_read);
 			if (IS_ERR(nvmem)) {
-				dev_err(dev, "Failed to register OTP NVMEM device\n");
-				return PTR_ERR(nvmem);
+				err = PTR_ERR(nvmem);
+				goto err;
 			}
 			mtd->otp_user_nvmem = nvmem;
 		}
@@ -971,7 +971,6 @@ static int mtd_otp_nvmem_add(struct mtd_info *mtd)
 			nvmem = mtd_otp_nvmem_register(mtd, "factory-otp", size,
 						       mtd_nvmem_fact_otp_reg_read);
 			if (IS_ERR(nvmem)) {
-				dev_err(dev, "Failed to register OTP NVMEM device\n");
 				err = PTR_ERR(nvmem);
 				goto err;
 			}
@@ -983,7 +982,7 @@ static int mtd_otp_nvmem_add(struct mtd_info *mtd)
 
 err:
 	nvmem_unregister(mtd->otp_user_nvmem);
-	return err;
+	return dev_err_probe(dev, err, "Failed to register OTP NVMEM device\n");
 }
 
 /**
-- 
2.30.2

