Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52B2613D80
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 19:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiJaSjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 14:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiJaSjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 14:39:45 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4CCDFC5;
        Mon, 31 Oct 2022 11:39:44 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id t4so7633319wmj.5;
        Mon, 31 Oct 2022 11:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yBHjiohVQzC3MeLu6Hf31z8MmLG5ht44OV/5LONulY0=;
        b=K3vICgClg23d0lx1NLXO52iRZ2zonpVOt+bHDtTukghUjoTqvsSY5Lx5n5i1ke/Jqx
         0Ex0qaav9MrOa7XbdBeL9RAFTcuZ4M8J8d+D8dXAQha7OAEO1GaHpKAg/XY7eAW1Ulcd
         /dmEPrKIs/hCVDinX8oVSN/Nq+mu20SzTa6uOpLE00t5/lBhtijSli8TH0C92rV2GeGF
         BfIdQwgoaFVAebMW5/lE8cLCFyJmklcANxZk/GwGW0TnUaYavE6HgFuvpFvzi67s5U2Z
         8KVSRFADEhJYD8hob+MYlQbqrq7kSc1rae3HC8da2mGNbV6nxs2DS/RUO0pZEMMmAGTD
         Hkdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yBHjiohVQzC3MeLu6Hf31z8MmLG5ht44OV/5LONulY0=;
        b=JuFpxqXPnLrYw3gReO9f2QGavEwzPK19qxV4sgRvDkK2bdTeUPKuPgoYyfdWTP5+Q2
         ViRSisbLzmmYL1mAPO1sU2CSfvlVlJH0w2gxbwUsN8X7nUDU3giLBIJ8dAwmbZ7YhxzQ
         QBJm6OHKha02VquQ0uYFVIy4go0uZix+DMicqG+IeeDFvqjSlnDFpUH3DX6eGYuycHag
         eC2RF6TpRfqrLVXqyRqfRXCWFQStpp/z5JR/Y6pSwhAYjmK9B3Hf4fKvPb6uNjE2gRJn
         TMp0SLBm1n8Ai0O9esVnPghmcoFXZHa6ssTiNdaPbXf1g6MfiGqMm/6Xw8bSjWBJk9TE
         7iKA==
X-Gm-Message-State: ACrzQf3I42K6ZdLPWFhs8UCX618mySbJ+IgMBXPmuJggc0tDTBnBcUfi
        jtKp72tKqNug0Gx62F50Zra5eSv10EnGGw==
X-Google-Smtp-Source: AMsMyM5z6agKtNQ3HuZP01RlmISJWHGp2cJQPMF7SXyEmir2UEZkVWOBTcj7e3krtSn60iSAYY8sEw==
X-Received: by 2002:a1c:2743:0:b0:3b3:f017:f23a with SMTP id n64-20020a1c2743000000b003b3f017f23amr20085246wmn.137.1667241583125;
        Mon, 31 Oct 2022 11:39:43 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-167-8-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.8.167])
        by smtp.gmail.com with ESMTPSA id z3-20020a05600c0a0300b003cf55844453sm9065067wmp.22.2022.10.31.11.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 11:39:42 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v7 0/1] Add Ingenic JZ4755 CGU driver
Date:   Mon, 31 Oct 2022 21:39:28 +0300
Message-Id: <20221031183930.1338009-1-lis8215@gmail.com>
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

v7:
 - drop already applied patches
 - remove unused macros'
 - add explanation why CLK_OF_DECLARE_DRIVER used
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

Siarhei Volkau (1):
  clk: Add Ingenic JZ4755 CGU driver

 drivers/clk/ingenic/Kconfig      |  10 +
 drivers/clk/ingenic/Makefile     |   1 +
 drivers/clk/ingenic/jz4755-cgu.c | 346 +++++++++++++++++++++++++++++++
 3 files changed, 357 insertions(+)
 create mode 100644 drivers/clk/ingenic/jz4755-cgu.c

-- 
2.36.1

