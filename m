Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4316C0F71
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjCTKmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjCTKmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:42:24 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C451D26CC9;
        Mon, 20 Mar 2023 03:40:31 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id k2so11926352pll.8;
        Mon, 20 Mar 2023 03:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679308810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ytodzSMqKI+g6vziElNMEkt2Uz4MK0qBsUvh5kc4oY0=;
        b=aVBcSvaWtaFyKL45eHS55ASyUBgV5hhFSlWXe/FsfV8IvzxFyee8V/j4n+ZXr0cA8h
         ZVO2KBURAWTx2sUgqY4G8Ljf25jjf0Y6HIDXcyB7YvRQGkw0Sh5T1+SvoFSwmWjobvks
         QdM8Sp+gEDAYzFGmYlS6aUYGI3/nbVRQ5KRxBhe/Z/XPBb7JjsonC28RDfnFDjMX73cb
         CXMPSorHzThl8TuhJ0P5QdTG6RvDljh+uBZOSaKN5lHngSq8Kv9/V9jo8hCbVN18KvlG
         6eT4AVsfw9ulFNRBoqJxRYRzmQO657hP6slEvoeZWBff7wJzglbmd/KaG7ZAZRrd88JH
         dH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679308810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ytodzSMqKI+g6vziElNMEkt2Uz4MK0qBsUvh5kc4oY0=;
        b=LNyoPqbq8mpUAVlFIgJ5aZEFi7/+dhpyzkhsAy/Lpl36euktrsuu1Ly67kiVZYRxKj
         4dTwqXR3NYRXUtGVkiF6JqWPQJu46FLXWd+4jCsI0qdVvVf8Bai+6zc4h0GDt/kaGbvw
         aIBziinUV1RHL56vSDm8wTkvUNvxbxfNsfjtYBQy4OvBjo4j2ouTGtwBfJxUOy7R68Om
         gjgqKtxSSIwcsrwTWr4p9bxd/Mncd/0/XWpLOlcQ1+i/K5XofYWh372EkX87H6DcGB2S
         WWb+eUz1N6cSoVLTJb27a1MrPO/+6LTfGsnD2M5UECCMQ/8kyy3lyJs/iKCCh0uXWmru
         yMCw==
X-Gm-Message-State: AO0yUKUqEVahlWpqxXiY28y8p3b61iCF0k+/E2Cj9cLEqCV0crG2q6EJ
        3Seq1vP6CmAWs97sFNhj/sT0kLY4OpI=
X-Google-Smtp-Source: AK7set9p7RaTki583fnEIoXwiT2hgRfy0b/tvJDJntOFblX1CVmcZ4gFnxZPOBptOMTfENV0EHIrrw==
X-Received: by 2002:a05:6a20:4321:b0:cd:1367:3b69 with SMTP id h33-20020a056a20432100b000cd13673b69mr19206208pzk.17.1679308810517;
        Mon, 20 Mar 2023 03:40:10 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. (94.130.220.35.bc.googleusercontent.com. [35.220.130.94])
        by smtp.gmail.com with ESMTPSA id e17-20020a63ee11000000b00478c48cf73csm5922535pgi.82.2023.03.20.03.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 03:40:10 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH v4 0/4] Devicetree support for Loongson-1 clock
Date:   Mon, 20 Mar 2023 18:39:59 +0800
Message-Id: <20230320104003.407844-1-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removes the old Loongson-1 clock driver and related code
mainly because of no DT support and outdated implementation.

Then, re-implement it to solve the above issues,
along with the devicetree binding document.

Changelog
V3 -> V4: Fix the build error of missing linux/module.h
          Add Reviewed-by tag from Krzysztof Kozlowski
V2 -> V3: Add 'reg' property into the 'required' field
          Delete the unnecessary property 'clock-names'
          Use the same license as binding document for the header file.
          Add MODULE_AUTHOR and MODULE_DESCRIPTION info
          Add patch "MIPS: loongson32: Update the clock initialization" into this series
	  Add Acked-by tag from Stephen Boyd and Thomas Bogendoerfer
V1 -> V2: Change to one clock controller (suggested by Krzysztof Kozlowski)
          Add clock-related dt-binding header file
          Fix the warning of dt_binding_check
          Split the driver removal to a separate patch
          Implement one clock controller instead of single clocks
          (suggested by Krzysztof Kozlowski)

Keguang Zhang (4):
  dt-bindings: clock: Add Loongson-1 clock
  clk: loongson1: Remove the outdated driver
  clk: loongson1: Re-implement the clock driver
  MIPS: loongson32: Update the clock initialization

 .../bindings/clock/loongson,ls1x-clk.yaml     |  45 +++
 .../include/asm/mach-loongson32/platform.h    |   1 -
 arch/mips/loongson32/common/time.c            |   3 +-
 drivers/clk/Makefile                          |   2 +-
 drivers/clk/clk-loongson1.c                   | 302 ++++++++++++++++++
 drivers/clk/loongson1/Makefile                |   4 -
 drivers/clk/loongson1/clk-loongson1b.c        | 118 -------
 drivers/clk/loongson1/clk-loongson1c.c        |  95 ------
 drivers/clk/loongson1/clk.c                   |  41 ---
 drivers/clk/loongson1/clk.h                   |  15 -
 include/dt-bindings/clock/loongson,ls1x-clk.h |  19 ++
 11 files changed, 369 insertions(+), 276 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/loongson,ls1x-clk.yaml
 create mode 100644 drivers/clk/clk-loongson1.c
 delete mode 100644 drivers/clk/loongson1/Makefile
 delete mode 100644 drivers/clk/loongson1/clk-loongson1b.c
 delete mode 100644 drivers/clk/loongson1/clk-loongson1c.c
 delete mode 100644 drivers/clk/loongson1/clk.c
 delete mode 100644 drivers/clk/loongson1/clk.h
 create mode 100644 include/dt-bindings/clock/loongson,ls1x-clk.h


base-commit: d8bb7bcf754c39de7347b746766ed45932e787d1
-- 
2.34.1

