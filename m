Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC29609375
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 15:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiJWNOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 09:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbiJWNOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 09:14:33 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3211278226;
        Sun, 23 Oct 2022 06:14:02 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id bk15so11638393wrb.13;
        Sun, 23 Oct 2022 06:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ihtp7aNzBMRdNMm525JtTaoUZMMTaF6Jg0N4a3uc3jU=;
        b=JI99yuTt88QtbxiWCLSYQyGXKYlDYGMgbzRDhbofBBP2bRUbwB1wER8y8xsEKliQwh
         6C7S/EZu+Gjemg5xcHJeGt2L7r7DZddk0GAAxRJakRw7hK3adIR8JiVk+beCW409dtNA
         RITR0OKswZOJ+gJAeZR+uoR9D8hFbEq4aCAAooRpBcboVxUbHxs+rMsG+tDoeyNx5PuD
         GyZQGdNiHRnn+M7bELtcVv8aFmJhFjgWXbyRzxV1l50uOD/zP8qKT8+ZkHs3Qn9gZA8f
         FyML4HYWwFk3IZmc6MiSX/hojsKoHi+i0oQgeRXvzFVk9og2tlDc/R3UHEg+nKi++4Sh
         0Epg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ihtp7aNzBMRdNMm525JtTaoUZMMTaF6Jg0N4a3uc3jU=;
        b=NIPs5NRL65ApEdb+OrBpheg1e3vneg5LuYB28A9xqFpWTiHxWGjzZhtNnsXOikkD5X
         /uh1DzMg1pzOpmaZ8+YezySB50VmaruHgcMO4njOOWCS2/UwnDF349TutTnFMQ7CtmF5
         9p/tPOduinKk5urGlzJ8Ne3TIjX0LzCKrwtZyQZk02QMFwuRsdBHPbUX969IL6X6qqia
         ubXlmmXKzeeP4JhjMgsDRcckcWLgiGQhLyczBuHVSsmSZdeogXBVIPx0sdFk5nv5+dVz
         fR8vtaAV9j+WS6buBcgTeV7uO9jjkmT2MoKbe6Ux5fhKNM6VoHoGqJgO4bWz0cdzdy2P
         9H7g==
X-Gm-Message-State: ACrzQf3d3B+AIIAiYMZoVc8svYcN4U5bzimE0vMGl7cz47nYQ1+0PvB1
        nu1z52afwy37rXJDCv7Xy1aRdWpTQR2qSg==
X-Google-Smtp-Source: AMsMyM7dq+Ycr0zGigFTYUp5BR4J3icXTst/6m4glGnOPB8FVN5RbvqKTfxgS/hvxt+hDKW5X8EbfA==
X-Received: by 2002:a5d:66c1:0:b0:236:5d1f:146c with SMTP id k1-20020a5d66c1000000b002365d1f146cmr5110003wrw.530.1666530835661;
        Sun, 23 Oct 2022 06:13:55 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-133-19-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.19.133])
        by smtp.gmail.com with ESMTPSA id l24-20020a1c7918000000b003b50428cf66sm8302475wme.33.2022.10.23.06.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 06:13:55 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v4 0/3] Add Ingenic JZ4755 CGU driver
Date:   Sun, 23 Oct 2022 16:13:28 +0300
Message-Id: <20221023131331.4107782-1-lis8215@gmail.com>
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

