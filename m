Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEB666954B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 12:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241432AbjAMLPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 06:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239679AbjAMLNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:13:06 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB13A5C1C7;
        Fri, 13 Jan 2023 03:10:50 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id 20so10504432pfu.13;
        Fri, 13 Jan 2023 03:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jqiLRE9h/fekKbJDmUy9t3EeJ+WTeQsUaiDr7CJjX90=;
        b=L4fJ71iaxbvPAX7vFbFgYrkDfOgL55S8aFPY0Pw7dQktBZYUvXtC3+eX8aMGhc8QAg
         YZIIzsPu+BVrpCejeLFXdoKu4v20SbSt5LhumRjBF1e/0+9oA1q6mWS1xo2i188UfNo2
         gkdDnY5fYPen/iPtrxL/LZzLFt+TdjdNsD8rxy/ASD+/UAZp3ooilR7mJYD+UbX7WmDb
         Wsmq0OSj0cefmXYIlykjbYwMFgbYVHGpkuJlFMPcmWrTrIn9vLKf3rJKowkgsSzC06OB
         W+m1PKHYugBBbhgWV5S5GRjKosnK0GbOp+/M1I6taEg8jIzOObDToSxjOdjtExCwhZ1v
         P3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jqiLRE9h/fekKbJDmUy9t3EeJ+WTeQsUaiDr7CJjX90=;
        b=dfpCK7xGJpAX9r8587VtncxWSTMqFU8EhNMFVmEIFLDIXFozLq1gahL0/qMBlBvdX7
         PsSL0ypiKoFMm50ylSH/rnATovps1QT1vwYbRrAmNmretgAEQE2NRHxZjToW145JdzQn
         mR2Mf6Mw1pV5Y1VAkpf4I9oXZm0vxLXw/tOtbksr+0W6i1JV5iJW4EqCrHLYN5hWHaCY
         EMbKFVCJJTag6gx8/t7tq4tJhNKBfxfkjEs3fjhFb752fIsnj0an23lCMYmWYxb+p7ti
         T6tZyKhD0lyYP9W7vdGPlUn0l/M9hyTUxq1DJp9v5IW3nA0JKtVcVJSVK5ENQWDGmKiO
         AAvg==
X-Gm-Message-State: AFqh2kqDDDvUoL7neguPd7EnzElqwaNV3bkKTnoHevbMu2vsBrHb2cSU
        LkV0PPuUzlnRAYaVSpnKLCYPUjH3I1aCKxN0
X-Google-Smtp-Source: AMrXdXs+lHN+WnuOFCl7Dj6tqaQC4Q0yCMDe2a9LKsyLA3199pbRURp9GgW2cD4No57iCRDtWscUvg==
X-Received: by 2002:a05:6a00:4c94:b0:58b:b9ce:cd88 with SMTP id eb20-20020a056a004c9400b0058bb9cecd88mr1705706pfb.20.1673608250034;
        Fri, 13 Jan 2023 03:10:50 -0800 (PST)
Received: from kelvin-ThinkPad-L14-Gen-1.. (ec2-18-163-35-77.ap-east-1.compute.amazonaws.com. [18.163.35.77])
        by smtp.gmail.com with ESMTPSA id x189-20020a6263c6000000b00576259507c0sm13410597pfb.100.2023.01.13.03.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 03:10:49 -0800 (PST)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH 0/2] Devicetree support for Loongson-1 clock
Date:   Fri, 13 Jan 2023 19:07:36 +0800
Message-Id: <20230113110738.1505973-1-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds devicetree support for Loongson-1 clock,
including the devicetree binding and the driver.

Keguang Zhang (2):
  dt-bindings: clock: Add binding for Loongson-1 clock driver
  clk: loongson1: Refactor to add devicetree support

 .../bindings/clock/loongson,ls1x-clk.yaml     |  81 ++++
 drivers/clk/Makefile                          |   2 +-
 drivers/clk/clk-loongson1.c                   | 348 ++++++++++++++++++
 drivers/clk/loongson1/Makefile                |   4 -
 drivers/clk/loongson1/clk-loongson1b.c        | 118 ------
 drivers/clk/loongson1/clk-loongson1c.c        |  95 -----
 drivers/clk/loongson1/clk.c                   |  41 ---
 drivers/clk/loongson1/clk.h                   |  15 -
 8 files changed, 430 insertions(+), 274 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/loongson,ls1x-clk.yaml
 create mode 100644 drivers/clk/clk-loongson1.c
 delete mode 100644 drivers/clk/loongson1/Makefile
 delete mode 100644 drivers/clk/loongson1/clk-loongson1b.c
 delete mode 100644 drivers/clk/loongson1/clk-loongson1c.c
 delete mode 100644 drivers/clk/loongson1/clk.c
 delete mode 100644 drivers/clk/loongson1/clk.h


base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
-- 
2.34.1

