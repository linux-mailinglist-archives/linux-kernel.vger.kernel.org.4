Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601956BFBC1
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 18:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjCRROV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 13:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjCRROS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 13:14:18 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82876149AA;
        Sat, 18 Mar 2023 10:14:16 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id z42so8119502ljq.13;
        Sat, 18 Mar 2023 10:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679159655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=78t4Gb8Yu+T0jud32VqLBv00huqUTII4Y3HDon4R8gA=;
        b=oPP/nfFO1Sd8LBwgrIVKfT0hFGeBU0w1rxnUCMETf98bw043tRqnuJm4srgBJdue5C
         4dIhquqzzCqmvYgYHMSzzCJI5DHeqLozu0yqahD/YOMjMkZwHtV2v8iA1z1j5/0dWM6q
         EprRqs3vTw9L6lMl+DwY7Kl7onPfpoLfpfUP5N1atUxIjnVBWEL0FPLfqC6b3T9Z4T6P
         Xs+1ctpdXq6W4HE21Mf9elSQZtgQYfnePr4/zHHGYMP834r44VDbvth9Hn39IcWTCW6/
         5azVZAgCJ04JuEA/8Y9RrMN/ISNgRyYHIbhbCgVWyh9/XfGyQbEFSX3pywJkwF8nzb4j
         hFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679159655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=78t4Gb8Yu+T0jud32VqLBv00huqUTII4Y3HDon4R8gA=;
        b=vI6H0Cra/DVXp07xEepv/vi1zZEa8p37iyx4vMt5cYgXWxODmrCNKOyxQVWk2FM/Us
         GrJoRQg7tqaTGS1ZtmgsB1FAzGlu4Es8K8j0wXeeO/2N/smFLAmBgExJYUoYcPOOpXIn
         n6dyGF8SVU070ZOhG00K8AJG/aJ9FRBuetpvhpfdICZ8XWGA1Bf3qAG7opNtkQqrBAuj
         pt01gRwNuw9vJFiKvhqIac3aP4/4Eib799bVeUWRZdS4q7PT5rtIiNVMZUPWTf8ob3Zg
         ffsW7sXG3A8BvCoTA/QEBNI3fX7p78q6xVY4NnDhSpIF1wMwZPrMkTUplpQfa5Mi1EQu
         z6LA==
X-Gm-Message-State: AO0yUKWJC/ouYS4KmhU6r3fuc8Vkw8HYxpqqcYRn7R6dyNVV9UzfDQHN
        rq6HCY8sd1yHhc6EdXadqOg=
X-Google-Smtp-Source: AK7set9vm1kIBp2fvAvJ+Wyla2iE/3SWk1c3zwPjJ33Mj0VSwul0XYBD8qfWhLckUd1ANLuRaEt83g==
X-Received: by 2002:a2e:9bc4:0:b0:29a:95d8:3e04 with SMTP id w4-20020a2e9bc4000000b0029a95d83e04mr2090020ljj.50.1679159654640;
        Sat, 18 Mar 2023 10:14:14 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id r9-20020a2e80c9000000b0029573844d03sm929221ljg.109.2023.03.18.10.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 10:14:13 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Walle <michael@walle.cc>, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, u-boot@lists.denx.de,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2 0/3] nvmem: support post read for U-Boot's "ethaddr"
Date:   Sat, 18 Mar 2023 18:13:53 +0100
Message-Id: <20230318171356.29515-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
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

This change is required for NVMEM consumers to get expected MAC address
from U-Boot env data variable "ethaddr".

To address some previous concerns:
1. Yes, U-Boot env binding & driver should be converted to NVMEM layout
2. My priority is to get working MAC rather than fancy DT syntax
3. I AM going to convert U-Boot env into layout later
4. This work DOESN'T conflict with layout migration
5. This code WILL stay during / after layout migration

My brain limitations don't allow me to handle everything at once, please
let's review what I already have here.

Rafał Miłecki (3):
  dt-bindings: nvmem: u-boot,env: add MAC's #nvmem-cell-cells
  nvmem: core: support specifying both: cell raw data & post read
    lengths
  nvmem: u-boot-env: post-process "ethaddr" env variable

 .../devicetree/bindings/nvmem/u-boot,env.yaml |  7 ++++-
 drivers/nvmem/Kconfig                         |  1 +
 drivers/nvmem/core.c                          | 11 +++++---
 drivers/nvmem/u-boot-env.c                    | 26 +++++++++++++++++++
 include/linux/nvmem-provider.h                |  2 ++
 5 files changed, 42 insertions(+), 5 deletions(-)

-- 
2.34.1

