Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876BB663B1A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 09:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjAJIcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 03:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbjAJIcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 03:32:50 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD954915C;
        Tue, 10 Jan 2023 00:32:49 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id f3so7728091pgc.2;
        Tue, 10 Jan 2023 00:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJ/v0pFfGvRs3zyXE24+cF6mCJewg5X+XGBEKPnV2CI=;
        b=WPR2v5fheduYSJiBQxrVo5qTgujdxcxL7ORJorYz7h6tbfQy0HP1i5zFKeQ/+H3cP2
         menpkORMbtOJx4istwVMzZtmwn1Z42iCe4wi2a4Gueu40pBPpjmtdRr4j3QpZfTQM30Z
         Ui5aqZtXT6TPpTNjzwj/pmfspFTDifjEGA83H+MvMWjejJNSXWLE+ced7exUbbZ4rhnf
         aqCQ9jtBR4FN8JG61Q5Abn+R70Kp5FMk01dICqdfWDJMyOqustgHQkUrxnqBnRGbc0Dm
         I5oa1i/yUZsfTTC4qBbry3fv/meYH/bZ6tWl+Xn7DsiUkD6ZpLgHq0YHJv39nbNfMWkE
         vZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJ/v0pFfGvRs3zyXE24+cF6mCJewg5X+XGBEKPnV2CI=;
        b=aIbRWa7WIU+Vt7o1sNaN49pYkhbzpBMAhU9SRCUylRN6OhK2s4SdqyIrs9SXfsTuJH
         fBN+2968KYh+T+IRCaAuacOdTp/wuZpFxosSDnEGbCWAjO5qbTxIMew5T+BdeqA3wope
         /zHWWGrGfgQ1hM89kzugDMg1saBvgQ+sLwc/6A7gXe1MC/+pk6GpoY0jRhaLY+RYLHZ9
         UFz8Tfgtg1t5xwjCWac539dfyK1UofFGOr3Bbcv1FUp9SZcw0W8ikw2XfAGgkh+ZpRwc
         r7Ae4IUxAeu+WJGmEssVbWfS7cBz1tdluVoBItw9EiRmSNqGDuQJeq8ie9bVcXP5ey/3
         pZKw==
X-Gm-Message-State: AFqh2ko5Y4uxQqOXPW+2U5OJX1xZecrJTPzZhX4sXnSGm4khWW9GsHPW
        qkyVhN5P5DDk9Z1wPzoavNk=
X-Google-Smtp-Source: AMrXdXu+hHR68hXixfc3ZQpC3Oj7EAgo2UK2shNrYDW+vTHbQBVXzRZFO8OgSppGWc6wO78kSEQSMw==
X-Received: by 2002:aa7:8043:0:b0:573:487d:e852 with SMTP id y3-20020aa78043000000b00573487de852mr76820952pfm.4.1673339569264;
        Tue, 10 Jan 2023 00:32:49 -0800 (PST)
Received: from localhost.localdomain ([180.217.149.10])
        by smtp.gmail.com with ESMTPSA id z3-20020a626503000000b005871b73e27dsm5064950pfb.33.2023.01.10.00.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 00:32:48 -0800 (PST)
From:   Jim Liu <jim.t90615@gmail.com>
To:     JJLIU0@nuvoton.com, KWLIU@nuvoton.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Jim Liu <jim.t90615@gmail.com>
Subject: [PATCH v4 0/3] Add Nuvoton NPCM SGPIO feature
Date:   Tue, 10 Jan 2023 16:32:35 +0800
Message-Id: <20230110083238.19230-1-jim.t90615@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This SGPIO controller is for NUVOTON NPCM7xx and NPCM8xx SoC.
Nuvoton NPCM SGPIO module is combine serial to parallel IC (HC595)
and parallel to serial IC (HC165), and use APB3 clock to control it.
This interface has 4 pins  (D_out , D_in, S_CLK, LDSH).
NPCM7xx/NPCM8xx have two sgpio module each module can support up
to 64 output pins,and up to 64 input pin, the pin is only for gpi or gpo.
GPIO pins have sequential, First half is gpo and second half is gpi.

The datasheet can reference HC165 and HC595.

Jim Liu (3):
  gpio: nuvoton: Add Nuvoton NPCM sgpio driver
  arm: dts: nuvoton: npcm: Add sgpio feature
  dt-bindings: gpio: add NPCM sgpio driver bindings

 .../bindings/gpio/nuvoton,sgpio.yaml          |  92 +++
 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi |  30 +
 .../dts/nuvoton/nuvoton-common-npcm8xx.dtsi   |  30 +
 drivers/gpio/Kconfig                          |   8 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-npcm-sgpio.c                | 647 ++++++++++++++++++
 6 files changed, 808 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml
 create mode 100644 drivers/gpio/gpio-npcm-sgpio.c

-- 
2.17.1

