Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E76A6AD85E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 08:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjCGHkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 02:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjCGHkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 02:40:43 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888193B658;
        Mon,  6 Mar 2023 23:40:42 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id k10so24770334edk.13;
        Mon, 06 Mar 2023 23:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678174841;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5IpSKyXyeFe9/34ExltwmVNhqdaflxRmwhQAOMuSGk=;
        b=Ktfkc1GCbZfBCATHYdSFkaawD4zQyKTqA7JZYwaqKWhc+HVXomvDx/3o9sLo2/HqoA
         hbw/9bVUv6ukVu/0eABchQbfGBi02CJAE/66AaqRued8zleO76QN4BPpcGrMaA9W+/3i
         6rbqxMbBcn7a7He0tEGb+nv1iRPU3lg6b0vRhjWL+a4y0w0OkOXa23bKuuZJRz0vBfsE
         foZO68/I4M/+lRvofB//8HZUxQYNJaAXuvORSDQ1WDbIAofmQYHjtIhIwqMK3poBZt60
         /NeSHYogP+4tg40lsCrbnZzxLWD8Y1XHktwlwoodmVr3nf04nzlk+99pyUZMtv81SuSS
         k4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678174841;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5IpSKyXyeFe9/34ExltwmVNhqdaflxRmwhQAOMuSGk=;
        b=JMvPpznZ5bwQ50na91Hs3DtfmCNkp+1ErGKvCN4N/Hcn/a8boCAe1Lj/3j6ZJ51v1F
         l22BdIAe80yS9ovsbIPrlZvFd2tFlnWFkE268szasD2mZF3rS5XOJfcl1kXIj91s6C+v
         id+uwAlaVvslg6MAfKMs1LtPWN3NDISlqG5bum/nTIPgftblPZVOKCe+93ndfAoAZLDu
         CR9etzXpWZ4AMURWZ/t6h6l9mqqh2mkhuss2G6zd+bZwzwyF6XEcLYH9G99oU/6tSf27
         7lvOysSvS3eIp4KM8QNyGUtQiJVyuyBM9MSKTsLwiimI22wGgHlaVq4U7EdZ1ls96qEI
         N7kA==
X-Gm-Message-State: AO0yUKVypB1MqJQn7HcsteYsbPkgNGrv+ndpoJ1IRCn7Dn1ewO2mQ19M
        FuBgwQwcg/JCoVld3/qMiiVQggIe6J0p4w==
X-Google-Smtp-Source: AK7set/9jJyUKVijolFNnzdZe4RkPQrD3rXz5wZWpxUGZUr8oynFlSwBDKwxTCqglSp7mMVRbr0g5g==
X-Received: by 2002:aa7:d683:0:b0:4ac:bbb4:9772 with SMTP id d3-20020aa7d683000000b004acbbb49772mr8653860edr.40.1678174840834;
        Mon, 06 Mar 2023 23:40:40 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:a517:a52e:cdbc:e30d])
        by smtp.gmail.com with ESMTPSA id d26-20020a50f69a000000b004c0239e41d8sm6167084edn.81.2023.03.06.23.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 23:40:40 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] mtd: parsers: remove reference to config MTD_NAND_TMIO
Date:   Tue,  7 Mar 2023 08:40:38 +0100
Message-Id: <20230307074038.17391-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 568494db6809 ("mtd: remove tmio_nand driver") removes the config
MTD_NAND_TMIO and its corresponding driver.

Remove the reference in MTD_SHARPSL_PARTS to that removed config.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Arnd, please ack.
Miquel, please pick this minor non-urgent patch on top of the commit above.

 drivers/mtd/parsers/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/parsers/Kconfig b/drivers/mtd/parsers/Kconfig
index b20e0c38b517..60738edcd5d5 100644
--- a/drivers/mtd/parsers/Kconfig
+++ b/drivers/mtd/parsers/Kconfig
@@ -149,7 +149,7 @@ config MTD_PARSER_TRX
 
 config MTD_SHARPSL_PARTS
 	tristate "Sharp SL Series NAND flash partition parser"
-	depends on MTD_NAND_SHARPSL || MTD_NAND_TMIO || COMPILE_TEST
+	depends on MTD_NAND_SHARPSL || COMPILE_TEST
 	help
 	  This provides the read-only FTL logic necessary to read the partition
 	  table from the NAND flash of Sharp SL Series (Zaurus) and the MTD
-- 
2.17.1

