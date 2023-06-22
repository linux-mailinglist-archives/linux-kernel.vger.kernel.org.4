Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C69739857
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 09:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjFVHpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 03:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjFVHp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 03:45:27 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFE3199E
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 00:45:26 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f6283d0d84so9463161e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 00:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687419924; x=1690011924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e2G6Ue8V4mRrKRwqehC5x19V+QhPz8CK/6cX5tEJLKo=;
        b=ZcFyvFScRGUXITKWgPViPmDQicGubfs1vxVvXMns5+Qyf3/shHpYw6yqxPCjZ+/ydW
         ou1m8UB4FFNDasObzLBEKJOI26e4ZQi2mrkJX/5+93OaiP/c9ESejqjBEaxJS5Wdas+J
         4XvYDKGYGz95XYRjcI9t0b7o9TGB77rduZQOZ43hVO8EXmmNFSxvGbXq7DDgLtmqZsAm
         UuiQ1WDKHtEP9sMaXbr7DIZ/VYr+zsxhTZ492jx7SQlc7vOfPSsn6fKq7/durcWKePGU
         vqhXpWCxtxp0DgJmB/pSuiSy+x8WmLp3pLWjMNPCnJ1DYY62T48UL6StjId2uNDTCS+h
         /twA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687419924; x=1690011924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e2G6Ue8V4mRrKRwqehC5x19V+QhPz8CK/6cX5tEJLKo=;
        b=ibnjhEdxcfKYWSIK+BWf2xj7Rf69QxeNfB4OVFUURMT+uPCES1PUDw2JdkmyBgSbzI
         YAhaZurxcMG5pZUbL5sv3BUJLqw7gEFNAlCxE/uKGPbe90rmqduvDIUwZFm2PQkOov2E
         R9nmxDLKp9rHSb9Lf2duE8dfZi6kKTjfhvPItnHq67jmQIuOoeQRZso0Gotp89SProKn
         OPvCGUSPcE+RDENocKt4pKL+bz/+BH4pAaLng7LiPz/3DB1FVGee/2jH+Tv2+DQUXKnb
         4kZNo0O0RW5PmfhcISXEsyhBdRd+z6pthr1Qvtr1UpdeeTtyBYdSSqpsgV2D8e6tk7ZP
         3Bfw==
X-Gm-Message-State: AC+VfDy0fhsm8slAXgh18rSLEMFeBHKqbh9QqufkPvTJ424aNirIuBcb
        9NZSQH+QuDn1kdFvco0rGA7/fMCIACpj1Qb6mbo=
X-Google-Smtp-Source: ACHHUZ4m5DkLY5dTb2o2vBj1uxRz4AA9uyGvYBqoIVOitPvrbciR4ZIJo1FkNX9tGlDk7nKza45OxQ==
X-Received: by 2002:a05:6512:32af:b0:4f8:6e1a:b552 with SMTP id q15-20020a05651232af00b004f86e1ab552mr7966033lfe.28.1687419924420;
        Thu, 22 Jun 2023 00:45:24 -0700 (PDT)
Received: from Fecusia.lan (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id y11-20020a19750b000000b004f4cabba7desm1037465lfe.74.2023.06.22.00.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 00:45:24 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH] misc/genalloc: Name subpools by of_node_full_name()
Date:   Thu, 22 Jun 2023 09:45:20 +0200
Message-Id: <20230622074520.3058027-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A previous commit tried to come up with more generic subpool
names, but this isn't quite working: the node name was used
elsewhere to match pools to consumers which regressed the
nVidia Tegra 2/3 video decoder.

Revert back to an earlier approach using of_node_full_name()
instead of just the name to make sure the pool name is more
unique, and change both sites using this in the kernel.

It is not perfect since two SRAM nodes could have the same
subpool name but it makes the situation better than before.

Reported-by: Dmitry Osipenko <digetx@gmail.com>
Fixes: 21e5a2d10c8f ("misc: sram: Generate unique names for subpools")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/misc/sram.c | 2 +-
 lib/genalloc.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/sram.c b/drivers/misc/sram.c
index 5757adf418b1..61209739dc43 100644
--- a/drivers/misc/sram.c
+++ b/drivers/misc/sram.c
@@ -236,7 +236,7 @@ static int sram_reserve_regions(struct sram_dev *sram, struct resource *res)
 			}
 			if (!label)
 				block->label = devm_kasprintf(sram->dev, GFP_KERNEL,
-							      "%s", dev_name(sram->dev));
+							      "%s", of_node_full_name(child));
 			else
 				block->label = devm_kstrdup(sram->dev,
 							    label, GFP_KERNEL);
diff --git a/lib/genalloc.c b/lib/genalloc.c
index 0c883d6fbd44..6c644f954bc5 100644
--- a/lib/genalloc.c
+++ b/lib/genalloc.c
@@ -895,7 +895,7 @@ struct gen_pool *of_gen_pool_get(struct device_node *np,
 
 		of_property_read_string(np_pool, "label", &name);
 		if (!name)
-			name = np_pool->name;
+			name = of_node_full_name(np_pool);
 	}
 	if (pdev)
 		pool = gen_pool_get(&pdev->dev, name);
-- 
2.34.1

