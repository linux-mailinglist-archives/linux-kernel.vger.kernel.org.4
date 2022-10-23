Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5433D6092C2
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 14:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiJWMkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 08:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiJWMkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 08:40:33 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F335A8A5;
        Sun, 23 Oct 2022 05:40:23 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id l14so4619734wrw.2;
        Sun, 23 Oct 2022 05:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TgtNDe5KQoRIR4ytWNhwphdmoRHtZzeV9+b0aG5AW4A=;
        b=psHrtTqniebHfWvu4oCI0bkO1b4ZtpoKlx6b+XSZQKAipjmWiht2s0B/hlA7GnHC9j
         pclir6seiUukDBhRz2nKHYPzQSSBgsFF3syW7WPbbIEEkPnlUPipj1JkNMtuQqGOsEKV
         o8xrWo22nKM3JWIQqU9O+KhAeSsUq+VcJrdFoYZrFglmPCXIkeGEdX6PEUTQy2BThQnq
         lI5zdc1izZd7CSW51XJsvQ4eLar8VLVjKKCWGhkdLPLNvGlENEXyFE12B3D7ti1G5lPw
         uTfQvi0T6k/j6ZuOEsonttfhSY+hR89fScb7EKF8Lw6J1GEloRNUp0MU6wnKrTNDSVAv
         znLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TgtNDe5KQoRIR4ytWNhwphdmoRHtZzeV9+b0aG5AW4A=;
        b=4tngsLfN3nvKVLbtxMMewhsQ62Rk4GRUhmzz/Gc2LVZgF1PDAI/jwOvyNxkoS0vrWT
         oYKoccarDBP7Voz3nMeBUxjULLLOiBvpDO2yUBXLGn8LOI3AG0UTzoicIE+eQIZ2P5rw
         cxr8MRcugy7pm9m68gwFqqij0c57CeN0MIQIkFWZMNEp0nWs6yKyHFFx9J4rKJM2glJC
         fTqSqWKTrqLrdrYb2bvljhzzbSK6CIxvvhMz4tHVzpnrKwLoLjM/zTKrmhYBuEXhRkmi
         1svT8pu0S34fKuCoyDeyLwjCbucuC9pWpYk+XCsXalEqPdP+dxAvr2FpNQW6Jo1NE3ts
         JhhQ==
X-Gm-Message-State: ACrzQf28VkGjnUylCzsmWG66yyf5laKp7u6xBr1i+fTTD/xh/LumL7rn
        /JxOYd/xFY5uQ0SB7EIP1X4=
X-Google-Smtp-Source: AMsMyM4dKNHM6DPhoObgq3vjVpIRblo3/ccaa5MQldiQqHPOFobjlJjz0wPght7bb0+lcDd4z2jUeg==
X-Received: by 2002:a5d:5942:0:b0:225:7425:4e39 with SMTP id e2-20020a5d5942000000b0022574254e39mr17583593wri.566.1666528822078;
        Sun, 23 Oct 2022 05:40:22 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-133-19-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.19.133])
        by smtp.gmail.com with ESMTPSA id p5-20020a1c5445000000b003c71358a42dsm6286497wmi.18.2022.10.23.05.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 05:40:21 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v3 0/3] Add Ingenic JZ4755 CGU driver
Date:   Sun, 23 Oct 2022 15:39:41 +0300
Message-Id: <20221023123944.4103876-1-lis8215@gmail.com>
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

This patch series adds a new JZ4755 machine type and the
Clock Generation Unit (CGU) driver for the JZ4755 SoC.

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

