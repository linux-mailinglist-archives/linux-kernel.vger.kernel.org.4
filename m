Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E15C606FC2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 08:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiJUGBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 02:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJUGBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 02:01:02 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D17C1D3A47;
        Thu, 20 Oct 2022 23:01:00 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id f37so3290211lfv.8;
        Thu, 20 Oct 2022 23:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJ9xIMP9KJSnyP3kmEcAZFEOTKsj48z0+6bhrdbyYmQ=;
        b=d1Ic9JTyYswqZsEL5SydOKhL435NQPu3xf45ckQx+lh0zbljdQXq32zSHLZSdZhfGK
         0NTAOfVvX/A9wGkQREP8rf4nIZ2eIZ5dknqfY6MXMR5wSF0tSbL4i443zXJDCpCu3dM9
         LLnBbM0HkC7bE2lEC8Iy4RpSsR3VM4UbZ+Zpsx8RVHF/cPNO94o8MVbVdBkF3vhnNQwW
         mlkB2aOzr2RpA5I+GZX0sodWgJkknZuegcQYzVXIU+R998qS1zhMaoGJPt1ym+bJXFnj
         Rx7DyriZhROpSd0A7uzEvPKl8bRHVk8I3Jy7cM6KPFBLtnciJLQ99aHoQQTYutgufa8r
         Qpzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RJ9xIMP9KJSnyP3kmEcAZFEOTKsj48z0+6bhrdbyYmQ=;
        b=MUsJUVCW01sjDCRqvw0m4Ke85r6wgPvakkMyPDVpv/VPvAHV65Q1oWQjBfbVuPSC1U
         1lu4b01IRmw46vaNAhkcg4FgM8xGR4SPtVRDHt7O8UfFnskAcgRLfOyx152aDhbCILZ5
         wSgURWSUPLHNe3ZKnP0iXVmtObF3T5L4MpWLUdFqSz4q2VnsS5Tkt5rxVzxR/gJBtaeE
         V6fPc9w96e52B2zXwmEDqgTq+eBHPP2vMD9BHDO/+fx4f6ep0sd6bMY5PGWJHtk1tH0J
         ODRU7kbag79j74AH12HAdg2NxZZGAxGpEHlJrlYHtZ38Hmo+SsMtxBhVvMykRkyy5nYt
         MKtA==
X-Gm-Message-State: ACrzQf0TlujcIFkOhAGz6SJh5nPNylQgLSBNRKvdIh0z0yAsqwtzx0ln
        ymcnC5rb8S5i1mIx5BBLkzg=
X-Google-Smtp-Source: AMsMyM6B1qDtmd+KvrXozhnnD4v6SqdWdIOD/IrSleQ9kdprEflFZM9GH+ldehIYgYyV0Ptm4xo4Qg==
X-Received: by 2002:a05:6512:11e9:b0:49f:d530:9f25 with SMTP id p9-20020a05651211e900b0049fd5309f25mr6513590lfs.533.1666332058608;
        Thu, 20 Oct 2022 23:00:58 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id p6-20020ac246c6000000b0049e9122bd0esm3021950lfo.114.2022.10.20.23.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 23:00:58 -0700 (PDT)
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
Subject: [PATCH V2 2/2] mtd: core: set ROOT_DEV for partitions marked as rootfs in DT
Date:   Fri, 21 Oct 2022 08:00:51 +0200
Message-Id: <20221021060051.2508-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221021060051.2508-1-zajec5@gmail.com>
References: <20221021060051.2508-1-zajec5@gmail.com>
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
---
 drivers/mtd/mtdcore.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 07249af4f890..034b06aff660 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -28,6 +28,7 @@
 #include <linux/leds.h>
 #include <linux/debugfs.h>
 #include <linux/nvmem-provider.h>
+#include <linux/root_dev.h>
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
@@ -735,6 +736,12 @@ int add_mtd_device(struct mtd_info *mtd)
 		not->add(mtd);
 
 	mutex_unlock(&mtd_table_mutex);
+
+	if (of_find_property(mtd_get_of_node(mtd), "linux,rootfs", NULL)) {
+		pr_info("mtd: setting mtd%d (%s) as root device\n", mtd->index, mtd->name);
+		ROOT_DEV = MKDEV(MTD_BLOCK_MAJOR, mtd->index);
+	}
+
 	/* We _know_ we aren't being removed, because
 	   our caller is still holding us here. So none
 	   of this try_ nonsense, and no bitching about it
-- 
2.34.1

