Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406B6737983
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 05:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjFUDQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 23:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjFUDQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 23:16:13 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A771717;
        Tue, 20 Jun 2023 20:16:12 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b5422163f4so35111445ad.2;
        Tue, 20 Jun 2023 20:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687317372; x=1689909372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7nB6R0ouDG8zHyz3+Z8AEZ2eoEA3QO4GpFCpSBeZ10g=;
        b=iCO3ku+Uhm6rlxOnDEhVNOLzuI4wQF4xrBGC+dvhpnMwUtSbewBEWazsqWS4pg3gTb
         xKWj4eO3LtyZxjaxEOgUrHqu/oS29qzD40oBn9L0Lq2rVZfV/9RUP0u5M2u1xK9AURqb
         rBdWju/6G9Gpyn5RAJrD1QpIiy7HDpgFx+km7MUgd+2ezcKxGYZV92sVS2IQUGSoXQFT
         swwWLWVUbQQJEB//eYUPhKozDoqqh5bXbxDjtnnVAg6lfIc553Cy5SBMlMi5wM8JBA1p
         Cdg+9t3lEe9dkWMDudaDGpCDIE3RJic0DU+tDi/CZ4XBfRZq9R3jePj18RlMrThCng4N
         MVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687317372; x=1689909372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7nB6R0ouDG8zHyz3+Z8AEZ2eoEA3QO4GpFCpSBeZ10g=;
        b=jSrdyaVyijkN3/6/H4aexM8box2s3SqaQ9pFq9t4t/Y5MH48Som8dDLd5mnfwaw8at
         8mpsconyzTmHBqpSwHRgcUZo03GZAv+EVElktQN5iACRftqJVBKt3/UKucvMHSX6mdzl
         RqJOkhf29/RUXP3Xg3MvYWNmBB3fHMV2td5xBKy1LuCIxCkIgrxGItqdn/zstjVsZj46
         CcBkSbgyh98rgDfT58QDSwjiAF487riyFgrl9Xnzz8J8bPLSh0Q4Ln8wgAGWpSZuKHwS
         oumeb7kTQfkLYZ9yqh5JwfB5d5atmSxX656vHkr9PJQNPlT60At2B9s/2qfuuob4KeP5
         X1eg==
X-Gm-Message-State: AC+VfDzuaWdtBjrGWU4aNfZUhWPH7xKz38B27EVf+yi3RCG9RQqQYOiq
        +YOknlIbJ/o0LpqyjgH2lu0=
X-Google-Smtp-Source: ACHHUZ4UcsTpEvDFFd3DyltwlAJiswPaNd58ZXIHCY/uOaxB0kW+EmvrOngR2fOsSwWb49PYi6r/Lg==
X-Received: by 2002:a17:902:ea0f:b0:1b6:6b03:10cd with SMTP id s15-20020a170902ea0f00b001b66b0310cdmr6482846plg.67.1687317371780;
        Tue, 20 Jun 2023 20:16:11 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id w13-20020a170902d3cd00b001b01fc7337csm2257747plb.247.2023.06.20.20.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 20:16:11 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, soc@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, schung@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH v2 0/2] clk: nuvoton: Use clk_parent_data instead and add a header file
Date:   Wed, 21 Jun 2023 03:16:03 +0000
Message-Id: <20230621031605.234149-1-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Huang <ychuang3@nuvoton.com>

This set of patches addresses some of the issues that were identified in
the ma35d1 clock driver.

1. The external functions referenced between the .c files in this driver
   should not be declared within the .c files themselves. Instead, a shared
   .h file should be created to reference them.

2. For the declaration of parent clocks, use struct clk_parent_data instead
   of a string. Due to the change in the passed arguments, replace the usage
   of devm_clk_hw_register_mux() with clk_hw_register_mux_parent_data() for
   all cases.

v2:
  - In v1, all these modifications were included in a single patch, which is
    not ideal. In v2, there were no changes made to the patch content itself,
    but the different modification topics were separated into two individual
    patches 


Jacky Huang (2):
  clk: nuvoton: Add clk-ma35d1.h for driver extern functions
  clk: nuvoton: Use clk_parent_data instead of string for parent clock

 drivers/clk/nuvoton/clk-ma35d1-divider.c |   7 +-
 drivers/clk/nuvoton/clk-ma35d1-pll.c     |   5 +-
 drivers/clk/nuvoton/clk-ma35d1.c         | 737 +++++++++++++----------
 drivers/clk/nuvoton/clk-ma35d1.h         |  18 +
 4 files changed, 447 insertions(+), 320 deletions(-)
 create mode 100644 drivers/clk/nuvoton/clk-ma35d1.h

-- 
2.34.1

