Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56FB6044D4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiJSMQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbiJSMPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:15:55 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C73B22B0E;
        Wed, 19 Oct 2022 04:51:56 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id m15so24819436edb.13;
        Wed, 19 Oct 2022 04:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yTGwtjY7Qx3UHK834yfCMHLL0TaAs+yVt4csz4H7rFw=;
        b=OtokJ3G5ZiLF/OC4iEJMusA6NeuqVEVdAZ9v0gKZ8M5SVAINXZqwJnLLxNhUZUgn8R
         Q7gUdiErZk0QhUbU84FHgDdN+NzKzliyYGENPzQm0dU8dRuZrN4SxXvFchaXy4nCYdz+
         9m8rfs2Wr8KKCpoURG3k9LjtOE1djHUFfUWmOGsjHt90WSAMwlXlepZVemcfXbkZV882
         j1JEIpQJk7vhe8E/4jkP7JzjmN5G4sHQ+WWbRkhH6rjTLvP+rBW440/lpRqjboaxwzsm
         78L82AZScEuO4G8Pu7+oje4nyPKYFi1KhoQQibGXkee3QvlrxpWsuo1+dkPwB0MXStJt
         3blA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yTGwtjY7Qx3UHK834yfCMHLL0TaAs+yVt4csz4H7rFw=;
        b=mR05cQJSKmBYtbYk/RCBD8IXOBoXa7qBk3SJU7OUNTA+3jvvLS+RxweIiulI52k/KL
         02QDNe5oHalHaQMDbXzKEbA+TlIrv6ZZaOZdo0wOjhtH+64szR5THzR1gBkCZv28bLXo
         7TfBYB1hSMM+NRntN9mUmIEP+t7Nn79Ld+T+DSB0wgeb1Fg/7cM5bPIf9xLjiSnO63Oi
         h+61yxQTDzYThRygXq2wrsCL5qG7nu1azqZt6IirVx8JbjJm8Ut1AmpjdI/t0DkhQEGy
         tH/9zJaeXEb/nyKv4PHN3fa1uokRgF/KnvCtgIXMVpp9505RAVFt3xYu03TxGvD2YCMp
         zpGQ==
X-Gm-Message-State: ACrzQf1FoPZ47+InYEoI+sihES/XmvxDvwCH4VMG3cG6d1CfcF+4mOox
        juj6j6q7jVYPZCP0w73WXPk=
X-Google-Smtp-Source: AMsMyM5hxDnxb0AZmFD6fuLcsa3sjqXIPikwrHU3jQN0KPwiAZQ1Myq20sNxembhfYBGhptsB46FRw==
X-Received: by 2002:a05:6402:3709:b0:459:279e:fdc6 with SMTP id ek9-20020a056402370900b00459279efdc6mr7180563edb.338.1666180247042;
        Wed, 19 Oct 2022 04:50:47 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id dk24-20020a0564021d9800b0045b910b0542sm10377884edb.15.2022.10.19.04.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 04:50:46 -0700 (PDT)
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
Subject: [PATCH 2/2] mtd: core: set ROOT_DEV for partitions marked as root devices in DT
Date:   Wed, 19 Oct 2022 13:50:41 +0200
Message-Id: <20221019115041.31805-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221019114855.31639-1-zajec5@gmail.com>
References: <20221019114855.31639-1-zajec5@gmail.com>
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

This adds support for "linux,root-device" binding that is used to mark
root device MTD partition. It's useful for devices using device tree
that don't have bootloader passing root info in cmdline.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
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

