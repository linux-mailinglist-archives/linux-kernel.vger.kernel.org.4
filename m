Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB44608FAE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 23:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiJVVNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 17:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiJVVN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 17:13:29 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA9E80497;
        Sat, 22 Oct 2022 14:13:26 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id b12so18143932edd.6;
        Sat, 22 Oct 2022 14:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMcPWSUmJnWN6Xepe9O23Js1qxdW09hzjNuw8smzgps=;
        b=Juwv+t1RTD/CMonD6c03dxDghAH5fYtIui194P1sOuPDqUipKVcMtYq5xsIHFnFu/S
         9PuKQH+IEKm9pjZCdY5rKHFMux6oZ6jGSl/kLkoOPzGiCObsf8o8V/BIs4ImZJ24157x
         vCJ4/stysEk6t20lEO+Guu/3orvGzmm07igbOeQdiKL4A/gMqz8qTwo/gO00Xc+5hgnY
         D+/QqytyJcYHxhBW/nZccJUnnNV3z2H4Zzo2XIG5Z0M9/WfLUgZfnTa6297r6BzOL5J0
         75kjjA5hJtnpm2S/eHxSYDOqznebiuBAghHKBcvY38HOpjFsUNzasVI9q7LASA5P552b
         gExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sMcPWSUmJnWN6Xepe9O23Js1qxdW09hzjNuw8smzgps=;
        b=D7ovd6hZv6ecopDN87AxzAtSEIRROEJ4ZnBq3Htyyvq/Z/URyuIVbZAjA/GMVdCyrl
         jmchuw41vOvvtvSoA9WdpdzHt7VzVI1SYG040mU38lWf8J2pSgLvH8fG1YgWch/yD2Bv
         pXEidRJpn1x9EZUGxb08k62EIp/Uqy+vM/yVT8iXAsN/uMPwgLGA0apC5Dsh68ExJHjX
         UfkSeqHzt/RyvUpygUQgzzYKEFYQhgPQ9exd2e6EOQq0qtZFHhUFZcaIrS07omGh6ECp
         iH+e+Qx+6Iuzx8onT6EyaWi/SGX0IbPKIDZNqmOop9DMl/kFEFepgoRXaCHFIGl4D/HP
         HFYQ==
X-Gm-Message-State: ACrzQf2hAt8jCHBAy8WPMBywUpy+54kUldRy4y43/lAkCMxa8aTQVmee
        Xy4U7oMINmK5yCebKX60Nl4=
X-Google-Smtp-Source: AMsMyM5Qf2ADuVBQDHAFHzbyHZ+OeqC55sfOOOezRBA6Gp3Wz7C2lnCHShhxvyaoPqr5xTnfUEk34w==
X-Received: by 2002:a50:ed03:0:b0:461:9f73:b8d9 with SMTP id j3-20020a50ed03000000b004619f73b8d9mr857808eds.140.1666473205425;
        Sat, 22 Oct 2022 14:13:25 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id la5-20020a170907780500b0077f20a722dfsm13382584ejc.165.2022.10.22.14.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 14:13:25 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Mikhail Zhilkin <csharper2005@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V3 2/2] mtd: core: set ROOT_DEV for partitions marked as rootfs in DT
Date:   Sat, 22 Oct 2022 23:13:18 +0200
Message-Id: <20221022211318.32009-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221022211318.32009-1-zajec5@gmail.com>
References: <20221022211318.32009-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

This adds support for "linux,rootfs" binding that is used to mark flash
partition containing rootfs. It's useful for devices using device tree
that don't have bootloader passing root info in cmdline.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
V2: Use "linux,rootfs" as more accurate. Thanks Rob.
V3: Add IS_BUILTIN(CONFIG_MTD) check to avoid
    ERROR: modpost: "ROOT_DEV" [drivers/mtd/mtd.ko] undefined!
---
 drivers/mtd/mtdcore.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 20fcedc3021e..f70a5e66843b 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -28,6 +28,7 @@
 #include <linux/leds.h>
 #include <linux/debugfs.h>
 #include <linux/nvmem-provider.h>
+#include <linux/root_dev.h>
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
@@ -735,6 +736,17 @@ int add_mtd_device(struct mtd_info *mtd)
 		not->add(mtd);
 
 	mutex_unlock(&mtd_table_mutex);
+
+	if (of_find_property(mtd_get_of_node(mtd), "linux,rootfs", NULL)) {
+		if (IS_BUILTIN(CONFIG_MTD)) {
+			pr_info("mtd: setting mtd%d (%s) as root device\n", mtd->index, mtd->name);
+			ROOT_DEV = MKDEV(MTD_BLOCK_MAJOR, mtd->index);
+		} else {
+			pr_warn("mtd: can't set mtd%d (%s) as root device - mtd must be builtin\n",
+				mtd->index, mtd->name);
+		}
+	}
+
 	/* We _know_ we aren't being removed, because
 	   our caller is still holding us here. So none
 	   of this try_ nonsense, and no bitching about it
-- 
2.34.1

