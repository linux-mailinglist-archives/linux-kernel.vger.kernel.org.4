Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3CB61017C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 21:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236540AbiJ0TUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 15:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236484AbiJ0TUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 15:20:34 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2A861DBC;
        Thu, 27 Oct 2022 12:20:32 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id sc25so7442468ejc.12;
        Thu, 27 Oct 2022 12:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hTXTxpRXShFbPiHM7S8wpDbDvWGlQSU0q78VfQI6CFQ=;
        b=HVr8+jxyRsKTwpQYugPekXWCngvNMSZ2rTMe3KmF782GymOKjtP1tYsmLraAJJ5V2M
         9kLCHXZjF/Ojt4zbuFMs0CU8BzKLSQy50pnLZt1z4ZnuFgWBJvbJvxZHmccPjr/5YxCZ
         pDaFJm32HRP/LjEPjQy+qozrmN+U7LoxbFUvFd6LgP6HFg3Zrva5njAD6mngg1NLDUg5
         n9C/hCQuT8ya3W25710rMYhiwWG4Ia5i1iZZMn7xarMVDrEEAVcuXLzrua+qRlhayRzk
         bt0Rsl67734ANq9YmtdNDMw2n7TQgOwcdoyPB5LIiC4w2ekWcZTYx9gmET8WQlwjX9ui
         etqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hTXTxpRXShFbPiHM7S8wpDbDvWGlQSU0q78VfQI6CFQ=;
        b=09OkekWk1aV4qZ/E6nR4vDlZJ2K+ko0gPNwd4S2yYA7+ya7L012VDcLYEh0o8u9TA3
         c3HWwFtZA0We9AljYNrjjBppxwe0mxs4y/hiavQnAr5UA/yTHGv1n8G2izE4nHz6FFfn
         cmvPQQ5u00KcCxv5B4wLRZuK+tpmRcxUJXLslpsyIF+UTETxkvkWI/JQPL1xzKm8L5L3
         5H8BCtb6Cwe3SYAy0PXozmuHkKi8DNVo95qyLD91XXzwsnCBKKkISxPH1vDsJeK2KDfN
         GZFrNkMp97D7yNj/9fAPCQ9ICmMgiyFY+cBQB04FrnvWTlaVnAIOXn/xCeugYGyQtDjn
         w/0g==
X-Gm-Message-State: ACrzQf1Xy1+4HokowoTOqh/PtRdkjCQ6X7PEthzo+heGHvDRjo9/dmav
        W5EZFGEWaWt/2LZiswftofG+t1CtJHqkRA==
X-Google-Smtp-Source: AMsMyM4+oXQfh5BPLCV1xdqtc2ibogdTjAMdL1470yyUB7Njeh/AJ8S+Wbe5+wn3wnb2TXERcY2K5g==
X-Received: by 2002:a17:907:7ba4:b0:78e:281d:91ef with SMTP id ne36-20020a1709077ba400b0078e281d91efmr44165876ejc.288.1666898431231;
        Thu, 27 Oct 2022 12:20:31 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-238-32-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.32.238])
        by smtp.gmail.com with ESMTPSA id w18-20020a1709067c9200b007acc5a42e77sm1187006ejo.88.2022.10.27.12.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 12:20:30 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v6 0/3] Add Ingenic JZ4755 CGU driver
Date:   Thu, 27 Oct 2022 22:20:20 +0300
Message-Id: <20221027192024.484320-1-lis8215@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a Clock Generation Unit (CGU)
driver for the JZ4755 SoC.

v6:
 - polish parent clock declarations
 - reparent "not sure" BCH clock to H1CLK
 - ack collected
v5:
 - reword commit msg for documentation
 - reword cover letter
v4:
 - absent commit msg fixed
 - +/- ack
v3:
 - MACH_JZ4755 creation removed
 - AIC clock parent fixed
 - EXT/512 clock clarified (tested)
 - dt header license refined
v2:
 - CGU patches moved into its own patchset
 - dual license for dt-bindings header
 - Krzysztof's ack picked up
v1:
 - adds support for the whole JZ4755

Siarhei Volkau (3):
  dt-bindings: ingenic: Add support for the JZ4755 CGU
  dt-bindings: clock: Add Ingenic JZ4755 CGU header
  clk: Add Ingenic JZ4755 CGU driver

 .../bindings/clock/ingenic,cgu.yaml           |   2 +
 drivers/clk/ingenic/Kconfig                   |  10 +
 drivers/clk/ingenic/Makefile                  |   1 +
 drivers/clk/ingenic/jz4755-cgu.c              | 346 ++++++++++++++++++
 .../dt-bindings/clock/ingenic,jz4755-cgu.h    |  49 +++
 5 files changed, 408 insertions(+)
 create mode 100644 drivers/clk/ingenic/jz4755-cgu.c
 create mode 100644 include/dt-bindings/clock/ingenic,jz4755-cgu.h

-- 
2.36.1

