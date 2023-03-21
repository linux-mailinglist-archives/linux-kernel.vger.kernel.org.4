Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFD66C3022
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 12:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjCULTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 07:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjCULS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 07:18:59 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837D76E8C;
        Tue, 21 Mar 2023 04:18:57 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id j13so15234559pjd.1;
        Tue, 21 Mar 2023 04:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679397536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=crzPjTxknRdOXq95xWzETVn6ypoUoC3HVW6Fk2yIB3s=;
        b=Q49LKPhsZXsLCu4fSjOwQqx/qXz3Fl/yD8EyF/gAnvqTtMjvtcAJcVjIcCgXje2q9I
         I5ZLsdR2BZVMgHq1kv+g2oGG8xP/yMT3Sq8SH9FKYdSWRLrdXcklC32Epz7ube0qsZr8
         g6xnLSJ81Z7Mjpuw7617pK+2j3yNi8xuj2pPBkg6hFNcUvte0IbWXfAn/8r+NdlBv9bm
         a9zDLNn6X+ugSn1tsFCZDqug/UMbc3R7hRsTQtmqDz9tA/+O6jXu52fLEEf8IPfMPSlF
         oM5N8FDP4v21EeUmST74fEajKUo5iohmGUFmNtK8cOycT09Qz/GQe+BZCjQfV5S+bmht
         Gu1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679397536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=crzPjTxknRdOXq95xWzETVn6ypoUoC3HVW6Fk2yIB3s=;
        b=z1yuUIb1kjQ6vXDJWRaqpBR1hB4QQMwfg40+kad0VREF2ZEixVwS0AQgqhpbfXAdfy
         5ldCK2JgjT/vqCQVB7HY16g/B0mgG9PygLasa7+l/uy/6tGZyE2Dy4UYWsTeXsus4tCw
         5/l83SSmEEWKZYdflR6nh2J74vbQvzvNZAGY6dvUDohUgEjXmePlO3HKVlpFfB9mEI0p
         u0phqZgVMMJZrR3fu4uE7RzGf1qLpr8kdQm4ndOxZ7LHhBybrx1ip5f2SKZXAH+jyJvZ
         ZMQn2QotXNe+cU9CNvaJBr8W9x9yAksUGbWibm3S/418faP8YYxwSlAw2KNih8npa5ZL
         vXZA==
X-Gm-Message-State: AO0yUKW+qj85t3iFqTyrUHPnIQ+nVpiJUpiAonYD843ARdNQgu7sSARx
        0fqUqVVdtUJD4y0sh771oYTWrn2vjcM=
X-Google-Smtp-Source: AK7set8eRQcn0UpdZkEytI+g9PpbF8hWG2aw1hKmD8gcHXvNvTzTGNoIerT5c3Qj/KSfOs1lfEN2Fg==
X-Received: by 2002:a05:6a20:4904:b0:d6:f3dd:5a88 with SMTP id ft4-20020a056a20490400b000d6f3dd5a88mr1544865pzb.5.1679397536687;
        Tue, 21 Mar 2023 04:18:56 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. (94.130.220.35.bc.googleusercontent.com. [35.220.130.94])
        by smtp.gmail.com with ESMTPSA id c4-20020aa78804000000b005dd65169628sm8238838pfo.144.2023.03.21.04.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 04:18:56 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH v5 0/4] Devicetree support for Loongson-1 clock
Date:   Tue, 21 Mar 2023 19:18:13 +0800
Message-Id: <20230321111817.71756-1-keguang.zhang@gmail.com>
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
V4 -> V5: Include the necessary header files
          Add error handling for ls1x_clk_init()
          Remove MODULE_AUTHOR and MODULE_DESCRIPTION
          Some fixes and cleanups
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
 drivers/clk/clk-loongson1.c                   | 303 ++++++++++++++++++
 drivers/clk/loongson1/Makefile                |   4 -
 drivers/clk/loongson1/clk-loongson1b.c        | 118 -------
 drivers/clk/loongson1/clk-loongson1c.c        |  95 ------
 drivers/clk/loongson1/clk.c                   |  41 ---
 drivers/clk/loongson1/clk.h                   |  15 -
 include/dt-bindings/clock/loongson,ls1x-clk.h |  19 ++
 11 files changed, 370 insertions(+), 276 deletions(-)
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

