Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10BD609959
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 06:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiJXEly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 00:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiJXElf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 00:41:35 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F087D422EF;
        Sun, 23 Oct 2022 21:41:34 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id g12so1479669wrs.10;
        Sun, 23 Oct 2022 21:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eorg+/Ww/9XjaDGiE3G7GADATyRcOGLQTY6DHSskd48=;
        b=QuvnFqc0iKixA40xm8USZ9WYyJCxtBTdwfF5Uk1etsEgWFoFwEb5ALUqvaWl6F02bX
         GQ63h0UcjaVgrMb4mAYw3s7473Daf6BlPxo0BV2kxzSUpsBrkhUDwaIh9GMwTkL28ryM
         Sz85SdeapZIPkGwNxbbSaZ3IeLyUK7vYmq9oLF4i/t9MKr4T15lasYe4wIvr5yU/Y6QF
         phz+aUF3V7zIodHYobwWPF8vLT+2LQOX+y/k4Qn5cNl9t8FSBDmW0iB+wJUoBT8XmBdF
         vkzQsxvOXeEmAdPpoHWfhdrgXT95bL2eYP1TrQ8Vj1oxxox/15pTo/9KuOCc7CA4JFVD
         vnJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eorg+/Ww/9XjaDGiE3G7GADATyRcOGLQTY6DHSskd48=;
        b=oVHRpdPbRiCuaOb0REEvyl8KcPW7E5r5htzeYbp/m8QZdO6TfZYXzWinztXLYrZ0YI
         NeODfBMSU6ltfJdYba1SDGvmWKNN1V2ZgO0OAIB5uyYmDXuj+ICq2ZkOmdyhLP92quZg
         RhEaHAYceDUAiOrU5wsQ4DB0x1wS+VkFsGJd9/1fYYuTjx1zTTKt5O7+UH+chWydBai4
         kZ6i2pFKMo8j4GTHp1eoutvtqV99vDy/RKbsBZpXmXmH3511aIMgdF7/FjT07mzeHpY3
         A4f2jE1Ph51lTuHZRPFHMlKUNKvw+scZiLBXLxEUqst8JZnH/BIJxVqtIcFTnHmaiHsa
         RbnQ==
X-Gm-Message-State: ACrzQf3nPuQvoamDRyvUVSiJobvrp4WtHbkIHvKKUhPtlnUK0O4BXu7M
        WTIB2aWQEwWUJDxWlhTOj3w=
X-Google-Smtp-Source: AMsMyM7L/JtlELi3aklbJQzRKOj6rIqKgn40eJOjtT5hGGN2bw7+G8bdr/AXSEcIuy4A6a8ZXurZ1g==
X-Received: by 2002:a05:6000:180b:b0:236:5985:9c4e with SMTP id m11-20020a056000180b00b0023659859c4emr8194068wrh.584.1666586493463;
        Sun, 23 Oct 2022 21:41:33 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-197-18-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.18.197])
        by smtp.gmail.com with ESMTPSA id l39-20020a05600c1d2700b003c6deb5c1edsm9856925wms.45.2022.10.23.21.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 21:41:32 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v5 0/3] Add Ingenic JZ4755 CGU driver
Date:   Mon, 24 Oct 2022 07:40:53 +0300
Message-Id: <20221024044057.4151633-1-lis8215@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a Clock Generation Unit (CGU)
driver for the JZ4755 SoC.

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

