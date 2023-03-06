Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF856AC005
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 13:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjCFM6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 07:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjCFM62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 07:58:28 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BD223137
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 04:58:21 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 3E19C166A;
        Mon,  6 Mar 2023 13:58:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1678107500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VjUKX8vcOHRxfuq1rLlQX2Q888LcQ64xmxe+6S+e/IE=;
        b=remoxRjffuVdFV7RP3A/DnTRNbgpNuzcP3/5Mg9FRfPXhjxTQZ50iPuDU7OZnQcfHyZ7zO
        9E7JrxIJIKD7pqQim7XtEAG+cO3qoXl3QzBIxSExnODOS2nuzneBbUL8Z35SobE49Eik7+
        ry9Ino+B/stNJLhVunGZmd6t+JJVAsfqqefv6K/tixr06EYzbzuwfxvqI1yvBHI/Zlhgtz
        Y6uNyLjCduevVlEnmfGrCoib/8UiZ+qK+YiMSRDCcaDCp75kLJBg4ltLf0zjAeSKb5oK4B
        dIdBBn5Zk4La6lL4Lj/8CTrMQVvXmJ9P970akTIj2U3/eVVBg5pyf1r23rvDWQ==
From:   Michael Walle <michael@walle.cc>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 4/4] mtd: core: prepare mtd_otp_nvmem_add() to handle -EPROBE_DEFER
Date:   Mon,  6 Mar 2023 13:58:05 +0100
Message-Id: <20230306125805.678668-4-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230306125805.678668-1-michael@walle.cc>
References: <20230306125805.678668-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/mtd/mtdcore.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index d6675bf03557..4f9bd78bc6f9 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -952,8 +952,8 @@ static int mtd_otp_nvmem_add(struct mtd_info *mtd)
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
@@ -970,7 +970,6 @@ static int mtd_otp_nvmem_add(struct mtd_info *mtd)
 			nvmem = mtd_otp_nvmem_register(mtd, "factory-otp", size,
 						       mtd_nvmem_fact_otp_reg_read);
 			if (IS_ERR(nvmem)) {
-				dev_err(dev, "Failed to register OTP NVMEM device\n");
 				err = PTR_ERR(nvmem);
 				goto err;
 			}
@@ -982,7 +981,7 @@ static int mtd_otp_nvmem_add(struct mtd_info *mtd)
 
 err:
 	nvmem_unregister(mtd->otp_user_nvmem);
-	return err;
+	return dev_err_probe(dev, err, "Failed to register OTP NVMEM device\n");
 }
 
 /**
-- 
2.30.2

