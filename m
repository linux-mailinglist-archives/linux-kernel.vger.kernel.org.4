Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2E16909E1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 14:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjBIN2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 08:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjBIN2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 08:28:07 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CA61353E;
        Thu,  9 Feb 2023 05:28:06 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id e10-20020a17090a630a00b0022bedd66e6dso6156153pjj.1;
        Thu, 09 Feb 2023 05:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fKJeIkQPmPvNELUnpuNCjkP+d7TniKcEEa9IYeFIV9A=;
        b=Un5fpHvY6EVneqRDvudHbShvDyHSipODAdhzSaRq60zxsxA1oMo0x9Gx6QpAEIOYDI
         iXA8MlLZvpsJBxaROHLOJJgeGARx0Z35vedemaWhNUCx9hiKoN7FL0MUbCwCbGs5uzlm
         zwiMzxtSycRdh07+ss3ECr98PSw9ZCtATDDFW0DyNJkxHo/G8yuiYpI2+EjRQoK6YcmA
         vezAwQiYVGPYZOEsmY4f9gQnUDl5KkcUaoHzHS9cUt5ut8NRJXLkl5H4+jphd1riV3Eu
         qi9LP69gH3MTINMoRn0jKfbB1PeqRDC2tfLBcGPBKCBBcqsYnUedzhUQCYDxpXVBgkHm
         4f0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fKJeIkQPmPvNELUnpuNCjkP+d7TniKcEEa9IYeFIV9A=;
        b=cxRgsc1hV3otfCDA2wGOWEsQ8iQy488iH2Bf4J6GdSdTlFeJUeZW5VCmb17il9wCYr
         qUQP0emeMDc5ORbvLCajIDwsip4eMCvH1s7QfChiimO84MceOG8jpmwZnqF3kafguSOF
         UIw0PH9C0H7Fn3/cmcm7QLM8Li59b6XN5Q10lppMjIlLH/Vhuj8ImhXt7pofxWK5mW+n
         V1xhKXiskYdjAy/NWDIeVDHkTSrliDiWJYq6z17yGWRX7/4Rv3b7kK9Lh2qSer3OzLjc
         tK9vBiFSXTv280DMH7dUyloZd3gFlY/ozgRcEfl/vW3SHIbka0mQApi2YD+zVHE12bAn
         eF6A==
X-Gm-Message-State: AO0yUKUxmcJCPRnz1I7OYU7Zyn9E4Zz3nwy5vbcoQwVbMqqsn4BzP5LQ
        XwevDwRz5gAD4e/eybb7foEBHhr2MdmfXw==
X-Google-Smtp-Source: AK7set+T6Ls486DuRpDWFZHI1qWa7oWBjY6q/v3XGIe/sUcyK/8SpxbKZFaWHcasq96wZLLZko23vg==
X-Received: by 2002:a17:902:f355:b0:198:f0f2:81e1 with SMTP id q21-20020a170902f35500b00198f0f281e1mr8461200ple.27.1675949286092;
        Thu, 09 Feb 2023 05:28:06 -0800 (PST)
Received: from kelvin-ThinkPad-L14-Gen-1.. (ec2-18-163-35-77.ap-east-1.compute.amazonaws.com. [18.163.35.77])
        by smtp.gmail.com with ESMTPSA id v12-20020a1709029a0c00b0019339f3368asm1493972plp.3.2023.02.09.05.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 05:28:05 -0800 (PST)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH V2 0/3] Devicetree support for Loongson-1 clock
Date:   Thu,  9 Feb 2023 21:26:11 +0800
Message-Id: <20230209132614.1079198-1-keguang.zhang@gmail.com>
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

Removes the old Loongson-1 clock driver mainly because of
no DT support and outdated implementation.
Then, re-implement it to solve the above issues,
along with the devicetree binding document.

Keguang Zhang (3):
  dt-bindings: clock: Add Loongson-1 clock
  clk: loongson1: Remove the outdated driver
  clk: loongson1: Re-implement the clock driver

 .../bindings/clock/loongson,ls1x-clk.yaml     |  49 +++
 drivers/clk/Makefile                          |   2 +-
 drivers/clk/clk-loongson1.c                   | 298 ++++++++++++++++++
 drivers/clk/loongson1/Makefile                |   4 -
 drivers/clk/loongson1/clk-loongson1b.c        | 118 -------
 drivers/clk/loongson1/clk-loongson1c.c        |  95 ------
 drivers/clk/loongson1/clk.c                   |  41 ---
 drivers/clk/loongson1/clk.h                   |  15 -
 include/dt-bindings/clock/loongson,ls1x-clk.h |  19 ++
 9 files changed, 367 insertions(+), 274 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/loongson,ls1x-clk.yaml
 create mode 100644 drivers/clk/clk-loongson1.c
 delete mode 100644 drivers/clk/loongson1/Makefile
 delete mode 100644 drivers/clk/loongson1/clk-loongson1b.c
 delete mode 100644 drivers/clk/loongson1/clk-loongson1c.c
 delete mode 100644 drivers/clk/loongson1/clk.c
 delete mode 100644 drivers/clk/loongson1/clk.h
 create mode 100644 include/dt-bindings/clock/loongson,ls1x-clk.h


base-commit: 623880b500338017e010d76f31a41f0c0fe5c8ab
-- 
2.34.1

